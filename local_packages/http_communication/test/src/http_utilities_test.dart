import 'package:flutter_test/flutter_test.dart';
import 'package:http_communication/http_communication.dart';

void main() async {
  group('Test Utilities', () {
    setUp(() {
      // Additional setup goes here.
    });

    test(
        'isHostStartWithHttp | check if URL start with http(s) | should return true',
        () {
      expect(HttpUtilities.isHostStartWithHttp("http://192.168.0.3"), true);
      expect(HttpUtilities.isHostStartWithHttp("https://192.168.0.3"), true);
      expect(HttpUtilities.isHostStartWithHttp("https://abc.xyz"), true);
    });

    test(
        'isHostStartWithHttp | check if URL start with http(s) | should return false',
        () {
      expect(HttpUtilities.isHostStartWithHttp("192.168.0.3"), false);
      expect(HttpUtilities.isHostStartWithHttp("fpt://192.168.0.3"), false);
      expect(HttpUtilities.isHostStartWithHttp("something.local"), false);
    });

    test('isLocalDomain | check if URL is local domain | should return true',
        () {
      expect(HttpUtilities.isLocalDomain("localhost"), true);
      expect(HttpUtilities.isLocalDomain("somehostName.local"), true);
      expect(HttpUtilities.isLocalDomain("https://127.0.0.1"), true);
      expect(HttpUtilities.isLocalDomain("https://127.0.0.1/"), true);
    });

    test('isLocalDomain | check if URL is local domain | should return false',
        () {
      expect(HttpUtilities.isLocalDomain("abc.com"), false);
      expect(HttpUtilities.isLocalDomain("https://abc.com"), false);
    });

    test('isValidUrl | check if URL is valid | should return true', () {
      expect(HttpUtilities.isValidUrl("https://192.168.0.30"), true);
      expect(HttpUtilities.isValidUrl("https://device.local"), true);
      expect(HttpUtilities.isValidUrl("https://233.234.23.4"), true);
    });

    test('isValidUrl | check if URL is valid | should return false', () {
      expect(HttpUtilities.isValidUrl("http://192.168.0.30"), false);
      expect(HttpUtilities.isValidUrl("http://device.local"), false);
    });

    test('isHostIPv4 | check if URL is IPv4 | should return true', () {
      expect(HttpUtilities.isHostIPv4("https://192.168.0.30"), true);
      expect(HttpUtilities.isHostIPv4("https://5.3.2.3"), true);
    });

    test('isHostIPv4 | check if URL is IPv4 | should return false', () {
      expect(HttpUtilities.isHostIPv4("https://device.local"), false);
      expect(HttpUtilities.isHostIPv4("https://abc.com"), false);
    });

    test(
        'isDeviceIPAddressReachable | check if IP address is reachable | should return true',
        () async {
      expect(await HttpUtilities.isDeviceIPAddressReachable("127.0.0.1"), true);
      expect(
          await HttpUtilities.isDeviceIPAddressReachable("https://localhost"),
          true);
    });

    test(
        'isDeviceIPAddressReachable | check if IP address is reachable | should return false',
        () async {
      expect(
          await HttpUtilities.isDeviceIPAddressReachable("weirddevice.local"),
          false);
    });

    test('removeEndSlash | should return ending slash | should return correct',
        () {
      expect(
          HttpUtilities.removeEndSlash("https://19.23.43"), "https://19.23.43");
      expect(HttpUtilities.removeEndSlash("https://19.23.43/"),
          "https://19.23.43");
      expect(HttpUtilities.removeEndSlash("https://19.23.43//"),
          "https://19.23.43");
    });
  });
}
