import 'package:flutter_test/flutter_test.dart';
import 'package:http_communication/http_communication.dart';
import 'package:mocktail/mocktail.dart';

class HttpSessionMock extends Mock implements ExtronHttpSession {}

void main() {
  test('create | create session | should return ok', () async {
    ExtronHttpSession session = await ExtronHttpSession.create(
        "https://192.168.0.30",
        userName: "admin",
        password: "extron");

    expect(session.status, HttpStatus.ok);
  });

  test('create | create session | should return username password not valid',
      () async {
    ExtronHttpSession session =
        await ExtronHttpSession.create("https://192.168.0.30");

    expect(session.status, HttpStatus.permanentTokenNotValid);
  });
}
