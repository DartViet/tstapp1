class ListRoom {
  String schemaVersion;
  List<Room> rooms;

  ListRoom({required this.schemaVersion, required this.rooms});

  ListRoom.fromJson(Map<String, dynamic> json)
      : schemaVersion = json.containsKey('SchemaVersion')
            ? json['SchemaVersion'] as String
            : "",
        rooms = json.containsKey('Rooms')
            ? (json['Rooms'] as List).map((e) => Room.fromJson(e)).toList()
            : [];

  Map<String, dynamic> toJson() => {
        'SchemaVersion': schemaVersion,
        'Rooms': rooms.map((e) => e.toJson()).toList()
      };
}

class Room {
  String type;
  bool gCPro;
  String globalConfiguratorProjectVersion;
  String globalConfiguratorVersion;
  String name;
  List<Panel> panels;
  String deploymentApplicationName;
  String deploymentApplicationVersion;
  String deployedProjectVersion;

  Room(
      {required this.type,
      required this.gCPro,
      required this.globalConfiguratorProjectVersion,
      required this.globalConfiguratorVersion,
      required this.name,
      required this.panels,
      required this.deploymentApplicationName,
      required this.deploymentApplicationVersion,
      required this.deployedProjectVersion});

  Room.fromJson(Map<String, dynamic> json)
      : type = json.containsKey('__type') ? json['__type'] as String : "",
        gCPro = json.containsKey('GCPro') ? json['GCPro'] as bool : false,
        globalConfiguratorProjectVersion =
            json.containsKey('GlobalConfiguratorProjectVersion')
                ? json['GlobalConfiguratorProjectVersion'] as String
                : "",
        globalConfiguratorVersion =
            json.containsKey('GlobalConfiguratorVersion')
                ? json['GlobalConfiguratorVersion'] as String
                : "",
        name = json.containsKey('Name') ? json['Name'] as String : "",
        panels = json.containsKey('Panels')
            ? (json['Panels'] as List).map((e) => Panel.fromJson(e)).toList()
            : [],
        deploymentApplicationName =
            json.containsKey('DeploymentApplicationName')
                ? json['DeploymentApplicationName'] as String
                : "",
        deploymentApplicationVersion =
            json.containsKey('DeploymentApplicationVersion')
                ? json['DeploymentApplicationVersion'] as String
                : "",
        deployedProjectVersion = json.containsKey('DeployedProjectVersion')
            ? json['DeployedProjectVersion'] as String
            : "";

  Map<String, dynamic> toJson() => {
        '__type': type,
        'GCPro': gCPro,
        'GlobalConfiguratorProjectVersion': globalConfiguratorProjectVersion,
        'GlobalConfiguratorVersion': globalConfiguratorVersion,
        'Name': name,
        'Panels': panels.map((e) => e.toJson()).toList(),
        'DeploymentApplicationName': deploymentApplicationName,
        'DeploymentApplicationVersion': deploymentApplicationVersion,
        'DeployedProjectVersion': deployedProjectVersion
      };
}

class Panel {
  String type;
  String configFileName;
  String configHostAddress;
  Controller controller;
  String controllerFirmware;
  String controllerModel;
  String controllerName;
  String controllerPartNumber;
  String guiDesignerProjectVersion;
  String guiDesignerVersion;
  bool ignoreControllerDetails;
  bool ignoreControllerLinkLicense;
  bool ignoreTLPDetails;
  String name;
  TLP tlp;
  String tlpFirmware;
  String tlpModel;
  String tlpPartNumber;

  Panel(
      {required this.type,
      required this.configFileName,
      required this.configHostAddress,
      required this.controller,
      required this.controllerFirmware,
      required this.controllerModel,
      required this.controllerName,
      required this.controllerPartNumber,
      required this.guiDesignerProjectVersion,
      required this.guiDesignerVersion,
      required this.ignoreControllerDetails,
      required this.ignoreControllerLinkLicense,
      required this.ignoreTLPDetails,
      required this.name,
      required this.tlp,
      required this.tlpFirmware,
      required this.tlpModel,
      required this.tlpPartNumber});

  Panel.fromJson(Map<String, dynamic> json)
      : type = json.containsKey('__type') ? json['__type'] as String : "",
        configFileName = json.containsKey('ConfigFileName')
            ? json['ConfigFileName'] as String
            : "",
        configHostAddress = json.containsKey('ConfigHostAddress')
            ? json['ConfigHostAddress'] as String
            : "",
        controller = json.containsKey('Controller')
            ? Controller.fromJson(json['Controller'] as Map<String, dynamic>)
            : throw Exception("Controller is required"),
        controllerFirmware = json.containsKey('ControllerFirmware')
            ? json['ControllerFirmware'] as String
            : "",
        controllerModel = json.containsKey('ControllerModel')
            ? json['ControllerModel'] as String
            : "",
        controllerName = json.containsKey('ControllerName')
            ? json['ControllerName'] as String
            : "",
        controllerPartNumber = json.containsKey('ControllerPartNumber')
            ? json['ControllerPartNumber'] as String
            : "",
        guiDesignerProjectVersion =
            json.containsKey('GUIDesignerProjectVersion')
                ? json['GUIDesignerProjectVersion'] as String
                : "",
        guiDesignerVersion = json.containsKey('GUIDesignerVersion')
            ? json['GUIDesignerVersion'] as String
            : "",
        ignoreControllerDetails = json.containsKey('IgnoreControllerDetails')
            ? json['IgnoreControllerDetails'] as bool
            : false,
        ignoreControllerLinkLicense =
            json.containsKey('IgnoreControllerLinkLicense')
                ? json['IgnoreControllerLinkLicense'] as bool
                : false,
        ignoreTLPDetails = json.containsKey('IgnoreTLPDetails')
            ? json['IgnoreTLPDetails'] as bool
            : false,
        name = json.containsKey('Name') ? json['Name'] as String : "",
        tlp = json.containsKey('TLP')
            ? TLP.fromJson(json['TLP'] as Map<String, dynamic>)
            : throw Exception("TLP is required"),
        tlpFirmware = json.containsKey('TLPFirmware')
            ? json['TLPFirmware'] as String
            : "",
        tlpModel =
            json.containsKey('TLPModel') ? json['TLPModel'] as String : "",
        tlpPartNumber = json.containsKey('TLPPartNumber')
            ? json['TLPPartNumber'] as String
            : "";

  Map<String, dynamic> toJson() => {
        '__type': type,
        'ConfigFileName': configFileName,
        'ConfigHostAddress': configHostAddress,
        'Controller': controller.toJson(),
        'ControllerFirmware': controllerFirmware,
        'ControllerModel': controllerModel,
        'ControllerName': controllerName,
        'ControllerPartNumber': controllerPartNumber,
        'GUIDesignerProjectVersion': guiDesignerProjectVersion,
        'GUIDesignerVersion': guiDesignerVersion,
        'IgnoreControllerDetails': ignoreControllerDetails,
        'IgnoreControllerLinkLicense': ignoreControllerLinkLicense,
        'IgnoreTLPDetails': ignoreTLPDetails,
        'Name': name,
        'TLP': tlp.toJson(),
        'TLPFirmware': tlpFirmware,
        'TLPModel': tlpModel,
        'TLPPartNumber': tlpPartNumber
      };
}

class Controller {
  String type;
  String address;
  int boxId;
  int subBoxId;
  int systemId;

  Controller(
      {required this.type,
      required this.address,
      required this.boxId,
      required this.subBoxId,
      required this.systemId});

  Controller.fromJson(Map<String, dynamic> json)
      : type = json.containsKey('__type') ? json['__type'] as String : "",
        address = json.containsKey('Address') ? json['Address'] as String : "",
        boxId = json.containsKey('BoxID') ? json['BoxID'] as int : -1,
        subBoxId = json.containsKey('SubBoxID') ? json['SubBoxID'] as int : -1,
        systemId = json.containsKey('SystemID') ? json['SystemID'] as int : -1;

  Map<String, dynamic> toJson() => {
        '__type': type,
        'Address': address,
        'BoxID': boxId,
        'SubBoxID': subBoxId,
        'SystemID': systemId
      };
}

class TLP {
  String type;
  String address;
  int boxId;
  int subBoxId;
  int systemId;

  TLP(
      {required this.type,
      required this.address,
      required this.boxId,
      required this.subBoxId,
      required this.systemId});

  TLP.fromJson(Map<String, dynamic> json)
      : type = json.containsKey('__type') ? json['__type'] as String : "",
        address = json.containsKey('Address') ? json['Address'] as String : "",
        boxId = json.containsKey('BoxID') ? json['BoxID'] as int : -1,
        subBoxId = json.containsKey('SubBoxID') ? json['SubBoxID'] as int : -1,
        systemId = json.containsKey('SystemID') ? json['SystemID'] as int : -1;

  Map<String, dynamic> toJson() => {
        '__type': type,
        'Address': address,
        'BoxID': boxId,
        'SubBoxID': subBoxId,
        'SystemID': systemId
      };
}
