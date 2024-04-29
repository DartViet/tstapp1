import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http_communication/http_communication.dart';
import 'package:http_communication/src/http_uri.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpSessionMock extends Mock implements ExtronHttpSession {}

String readJsonFile(String path) {
  File file = File(path);
  String jsonString = file.readAsStringSync();
  return jsonString;
}

void main() async {
  HttpCommunication hcom = HttpCommunication("https://192.168.0.30",
      permanentToken: "r.YV89mzkhNJrreSdcikgN4p5x.mk");

  HttpCommunication hcom1 = HttpCommunication("https://192.168.0.30",
      userName: "admin", password: "extron");

  Uint8List data = await hcom1.get(
          "/web/vtlp/e0e935f8-9814-487f-95bb-c16eed7e4ac5/resources/bezel/images/0.png?dc=1712674084000")
      as Uint8List;

  Uint8List data2 = await hcom.get(
          "/web/vtlp/e0e935f8-9814-487f-95bb-c16eed7e4ac5/resources/bezel/images/0.png?dc=1712674084000")
      as Uint8List;

  File("temp.png").writeAsBytesSync(data);
  File("temp1.png").writeAsBytesSync(data2);

  print("json: ${await hcom.getListRoomJson()}");

  await hcom1.logout();
  await hcom.logout();

  final session = HttpSessionMock();
  HttpCommunication? httpCommunication;
  String jsonString = readJsonFile('test/assets/room1.json');
  group("testing the Http Communication", () {
    setUp(() {
      when(() => session.userName).thenReturn("admin");
      when(() => session.password).thenReturn("extron");
      when(() => session.host).thenReturn("https://192.168.0.30");
      when(() => session.permanentToken).thenReturn("");
      when(() => session.getAuthToken()).thenAnswer((_) => Future.value(""));
      when(() => session.getString(HttpUri.listroomUri))
          .thenAnswer((_) => Future.value(jsonString));

      httpCommunication = HttpCommunication("https://192.168.0.30",
          userName: session.userName,
          password: session.password,
          permanentToken: session.permanentToken);
      httpCommunication!.session = session;
    });

    test('getAuthToken | get authentication token | should return empty string',
        () async {
      expect(await session.getAuthToken(), "");
    });

    test('getListRoomJson | get list room json | should return string',
        () async {
      expect(await httpCommunication!.getListRoomJson(), jsonString);
    });

    test('getAuthToken | try getting AuthToken | should return empty string',
        () async {
      expect(await httpCommunication!.getAuthToken(), "");
    });

    test('getListRoom | get list room | should return ListRoom', () async {
      expect(await httpCommunication!.getListRoom(), isA<ListRoom>());
    });
  });
}
