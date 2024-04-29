/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:http_communication/src/http_communication_base.dart';
import 'package:http_communication/src/http_session.dart';
import 'package:http_communication/src/http_uri.dart';

export 'src/http_communication_base.dart';
export 'src/http_session.dart';
export 'src/http_utilities.dart';
export 'src/http_status.dart';

class HttpCommunication {
  ExtronHttpSession? session;
  String host;
  String userName;
  String password;
  String permanentToken;

  HttpCommunication(this.host,
      {this.userName = "", this.password = "", this.permanentToken = ""});

  _getSession() async {
    session ??= await ExtronHttpSession.create(host,
        userName: userName, password: password, permanentToken: permanentToken);
  }

  Future<String> getAuthToken() async {
    await _getSession();
    String token = await session!.getAuthToken();
    return token;
  }

  Future<String> getListRoomJson() async {
    await _getSession();
    String jsonString = await session!.getString(HttpUri.listroomUri);
    return jsonString;
  }

  // if you download a json, the type of item is String
  // if you download a binary file, the type of item is Uint8List
  // You can save file by doing File("temp.png").writeAsBytesSync(<item>);
  Future<Uint8List> get(String uri) async {
    await _getSession();
    var item = await session!.get(uri);
    return item;
  }

  Future<String> getString(String uri) async {
    await _getSession();
    var item = await session!.getString(uri);
    return item;
  }

  Future<ListRoom> getListRoom() async {
    await _getSession();
    String jsonStr = await getListRoomJson();
    if (jsonStr.isEmpty) {
      print("Empty json string");
      throw Exception("Empty json string");
    }
    return ListRoom.fromJson(json.decode(jsonStr));
  }

  Future<void> logout() async {
    await _getSession();
    await session!.logout();
  }
}

// TODO: Export any libraries intended for clients of this package.
