import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http_communication/src/http_uri.dart';
import 'package:http_communication/src/http_utilities.dart';
import 'package:http_communication/src/http_status.dart';

class ExtronHttpSession {
  String userName;
  String password;
  String host;
  String permanentToken;
  String token = "";
  HttpClient client;
  HttpStatus status = HttpStatus.ok;
  final _northxeSession = "NortxeSession";

  ExtronHttpSession._create(this.host,
      {this.userName = "", this.password = "", this.permanentToken = ""})
      : client = HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true) {
    host = host.trim();
    if (!HttpUtilities.isHostStartWithHttp(host)) {
      host = "https://$host";
    }

    host = HttpUtilities.removeEndSlash(host);
    userName = userName.trim();
    password = password.trim();
    permanentToken = permanentToken.trim();

    if (userName.isEmpty && password.isEmpty) {
      if (permanentToken.isEmpty) {
        status = HttpStatus.permanentTokenNotValid;
      } else {
        status = HttpStatus.ok;
      }
    } else {
      status = HttpStatus.ok;
    }
  }

  static Future<ExtronHttpSession> create(String host,
      {String userName = "",
      String password = "",
      String permanentToken = ""}) async {
    ExtronHttpSession instance = ExtronHttpSession._create(host,
        userName: userName, password: password, permanentToken: permanentToken);

    if (!HttpUtilities.isValidUrl(instance.host)) {
      instance.status = HttpStatus.notValid;
    }

    return instance;
  }

  Future<String> getString(String uriPath) async {
    Uint8List data = await get(uriPath);
    return utf8.decode(data);
  }

  Future<Uint8List> get(String uriPath) async {
    if (status != HttpStatus.ok) {
      return Uint8List(0);
    }

    if (!uriPath.startsWith("/")) {
      uriPath = "/$uriPath";
    }

    if (token.isEmpty && userName.isNotEmpty && password.isNotEmpty) {
      token = await getAuthToken();
      if (status != HttpStatus.ok) {
        return Uint8List(0);
      }

      if (token.isEmpty) {
        status = HttpStatus.userNameOrPasswordNotValid;
        return Uint8List(0);
      }
    } else {
      if (permanentToken.isEmpty) {
        status = HttpStatus.permanentTokenNotValid;
        return Uint8List(0);
      } else if (permanentToken.isNotEmpty) {
        token = permanentToken;
      }
    }
    try {
      HttpClientRequest request = await client
          .getUrl(Uri.parse("$host$uriPath"))
          .timeout(Duration(seconds: 5), onTimeout: () {
        status = HttpStatus.notReachable;
        throw TimeoutException("Timeout");
      });
      request.headers.set("cookie", "$_northxeSession=$token");
      HttpClientResponse response = await request.close();
      print(token);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return await _getData(response);
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        status = HttpStatus.userNameOrPasswordNotValid;
        return Uint8List(0);
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        status = HttpStatus.deviceNotResponding;
        return Uint8List(0);
      }
    } catch (e) {
      status = HttpStatus.notReachable;
    }
    return Uint8List(0);
  }

  Future<Uint8List> _getData(HttpClientResponse response) async {
    Uint8List data = await response.fold<Uint8List>(
        Uint8List(0),
        (previous, List<int> element) =>
            Uint8List.fromList(previous + element));
    return data;
  }

  Future<String> getAuthToken() async {
    try {
      HttpClientRequest? request = await client
          .getUrl(Uri.parse("$host${HttpUri.loginUri}"))
          .timeout(Duration(seconds: 5), onTimeout: () {
        status = HttpStatus.notReachable;
        throw TimeoutException("Timeout");
      });
      String basicAuth = base64Encode(utf8.encode('$userName:$password'));
      request.headers.set('Authorization', 'Basic $basicAuth');
      HttpClientResponse response = await request.close();
      if (response.statusCode > 400 && response.statusCode < 500) {
        status = HttpStatus.userNameOrPasswordNotValid;
        return "";
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        status = HttpStatus.deviceNotResponding;
        return "";
      }
      if (response.headers.value("set-cookie") != null) {
        var cookies = response.headers.value("set-cookie")!.split(";");
        if (cookies.isEmpty || !cookies[0].contains(_northxeSession)) {
          status = HttpStatus.notExtronDevice;
          return "";
        }
        return cookies[0].split("=")[1];
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  Future<void> logout() async {
    if (token.isNotEmpty) {
      try {
        HttpClientRequest request = await client
            .getUrl(Uri.parse("$host${HttpUri.logoutUri}"))
            .timeout(Duration(seconds: 5), onTimeout: () {
          status = HttpStatus.notReachable;
          throw TimeoutException("Timeout");
        });
        request.headers.set("cookie", token);
        HttpClientResponse response = await request.close();
        if (response.statusCode >= 200 && response.statusCode < 300) {
          status = HttpStatus.loggedOut;
        } else {
          status = HttpStatus.loggedOutFailed;
        }
      } catch (e) {
        status = HttpStatus.notReachable;
      }
    }
  }
}
