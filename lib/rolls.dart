/// statusCode : 200
/// message : "success"
/// data : [{"roleId":58,"roleName":"ADMIN","active":true,"userCount":0},{"roleId":81,"roleName":"Testing","active":true,"userCount":0},{"roleId":82,"roleName":"User","active":true,"userCount":0},{"roleId":83,"roleName":"Viewer","active":true,"userCount":0},{"roleId":84,"roleName":"Supervisor","active":true,"userCount":0},{"roleId":85,"roleName":"Report User","active":true,"userCount":0},{"roleId":86,"roleName":"Visitor","active":true,"userCount":0}]
/// time : "2025-08-22T14:23:31.375+00:00"
/// errorMessages : null

class Rolls {
  Rolls({
      num? statusCode, 
      String? message, 
      List<Data>? data, 
      String? time, 
      dynamic errorMessages,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _time = time;
    _errorMessages = errorMessages;
}

  Rolls.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _time = json['time'];
    _errorMessages = json['errorMessages'];
  }
  num? _statusCode;
  String? _message;
  List<Data>? _data;
  String? _time;
  dynamic _errorMessages;
Rolls copyWith({  num? statusCode,
  String? message,
  List<Data>? data,
  String? time,
  dynamic errorMessages,
}) => Rolls(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
  time: time ?? _time,
  errorMessages: errorMessages ?? _errorMessages,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  List<Data>? get data => _data;
  String? get time => _time;
  dynamic get errorMessages => _errorMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['time'] = _time;
    map['errorMessages'] = _errorMessages;
    return map;
  }

}

/// roleId : 58
/// roleName : "ADMIN"
/// active : true
/// userCount : 0

class Data {
  Data({
      num? roleId, 
      String? roleName, 
      bool? active, 
      num? userCount,}){
    _roleId = roleId;
    _roleName = roleName;
    _active = active;
    _userCount = userCount;
}

  Data.fromJson(dynamic json) {
    _roleId = json['roleId'];
    _roleName = json['roleName'];
    _active = json['active'];
    _userCount = json['userCount'];
  }
  num? _roleId;
  String? _roleName;
  bool? _active;
  num? _userCount;
Data copyWith({  num? roleId,
  String? roleName,
  bool? active,
  num? userCount,
}) => Data(  roleId: roleId ?? _roleId,
  roleName: roleName ?? _roleName,
  active: active ?? _active,
  userCount: userCount ?? _userCount,
);
  num? get roleId => _roleId;
  String? get roleName => _roleName;
  bool? get active => _active;
  num? get userCount => _userCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roleId'] = _roleId;
    map['roleName'] = _roleName;
    map['active'] = _active;
    map['userCount'] = _userCount;
    return map;
  }

}