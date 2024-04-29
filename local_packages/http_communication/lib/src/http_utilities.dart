import 'dart:async';
import 'dart:io';

class HttpUtilities {
  //Only support https
  static bool isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute && uri.isScheme("https");
  }

  static isHostIPv4(String url) {
    Uri? uri = _trimHost(url);
    if (uri == null) {
      return false;
    }
    return RegExp(
            r"^(?<![\d.])(?:(?:[1-9]?\d|1\d\d|2[0-4]\d|25[0-5])\.){3}(?:[1-9]?\d|1\d\d|2[0-4]\d|25[0-5])(?![\d.])$")
        .hasMatch(uri.host);
  }

  static bool isLocalDomain(String url) {
    Uri? uri = _trimHost(url);
    if (uri == null) {
      return false;
    }
    return uri.host.endsWith('.localhost') ||
        uri.host.endsWith('.local') ||
        uri.host == 'localhost' ||
        uri.host == '127.0.0.1';
  }

  static Uri? _trimHost(String url) {
    url = url.trim();
    url = HttpUtilities.isHostStartWithHttp(url) ? url : "https://$url";
    return Uri.tryParse(url);
  }

  static Future<bool> isDeviceIPAddressReachable(String ipAddress) async {
    Uri? uri = _trimHost(ipAddress);
    if (uri == null) {
      return false;
    }

    try {
      if (Platform.isAndroid) {
        var result =
            await Process.run('ping', ['-c', '1', '-W', '2', uri.host]);
        return result.exitCode == 0;
      } else if (Platform.isIOS) {
        var result =
            await Process.run('ping', ['-c', '1', '-W', '2', uri.host]);
        return result.exitCode == 0;
      }
      var result = await Process.run('ping', ['-c', '1', uri.host]);
      return result.exitCode == 0;
    } catch (e) {
      return false;
    }
  }

  //Does not work for IP Address, works for domain name
  static Future<bool> isNamedHostReachable(String host) async {
    host = removeScheme(host);
    host = removeEndSlash(host);
    try {
      var value = await InternetAddress.lookup(host)
          .timeout(const Duration(seconds: 2), onTimeout: () {
        throw TimeoutException("Timeout");
      });
      return value.isNotEmpty && value[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static bool isHostStartWithHttp(String url) {
    return url.toLowerCase().startsWith("http://") ||
        url.toLowerCase().startsWith("https://");
  }

  static String removeScheme(String url) {
    if (!isHostStartWithHttp(url)) {
      return url;
    }
    return url.replaceAll(RegExp(r'^https?://'), '');
  }

  static String removeEndSlash(String url) {
    if (!isHostEndWithSlash(url)) {
      return url;
    }
    url = url.substring(0, url.length - 1);
    return removeEndSlash(url);
  }

  static bool isHostEndWithSlash(String url) {
    return url.endsWith("/");
  }
}
