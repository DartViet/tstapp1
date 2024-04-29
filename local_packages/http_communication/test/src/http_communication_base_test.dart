import 'dart:convert';

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

import 'package:http_communication/src/http_communication_base.dart';

void main() {
  String readJsonFile(String path) {
    File file = File(path);
    String jsonString = file.readAsStringSync();
    return jsonString;
  }

  String jsonString = readJsonFile('test/assets/room1.json');
  String jsonString2 = readJsonFile('test/assets/room2.json');

  test('ListRoom | from json | create a list room', () async {
    expect(ListRoom.fromJson(json.decode(jsonString)).schemaVersion, "1.0.1");
    expect(ListRoom.fromJson(json.decode(jsonString2)), isA<ListRoom>());
  });

  test('Room | from json | create a room', () async {
    expect(Room.fromJson(json.decode(jsonString)["Rooms"][0]).name,
        "TLP Pro 720T : 192.168.0.31");
    expect(
        Room.fromJson(json.decode(jsonString2)["Rooms"][0])
            .deployedProjectVersion,
        "0.0.1");
  });

  test('Panel | from json | create a panel', () async {
    expect(
        Panel.fromJson(json.decode(jsonString)["Rooms"][0]["Panels"][0])
            .configHostAddress,
        "192.168.0.30");

    expect(
        Panel.fromJson(json.decode(jsonString2)["Rooms"][0]["Panels"][0])
            .configFileName,
        "7f96e22e-bd75-440a-bf7f-c2c1d11d64a4/vtlpmanifest.json");
  });

  test('controller | from json | create a controller', () async {
    expect(
        Controller.fromJson(
            json.decode(jsonString)["Rooms"][0]["Panels"][0]["Controller"]),
        isA<Controller>());

    expect(
        Controller.fromJson(
            json.decode(jsonString2)["Rooms"][0]["Panels"][0]["Controller"]),
        isA<Controller>());
  });

  test('tlp | from json | create a tlp', () async {
    expect(
        TLP.fromJson(json.decode(jsonString)["Rooms"][0]["Panels"][0]["TLP"]),
        isA<TLP>());

    expect(
        TLP.fromJson(json.decode(jsonString2)["Rooms"][0]["Panels"][0]["TLP"]),
        isA<TLP>());
  });
}
