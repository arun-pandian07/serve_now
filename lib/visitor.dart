/// statusCode : 200
/// message : "Visitor added successfully"
/// data : null
/// time : "2025-08-30T08:12:46.754+00:00"
/// errorMessages : null

class VisitorResponse {
  num? statusCode;
  String? message;
  Visitor? data;
  String? time;
  dynamic errorMessages;

  VisitorResponse({
    this.statusCode,
    this.message,
    this.data,
    this.time,
    this.errorMessages,
  });

  VisitorResponse.fromJson(dynamic json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Visitor.fromJson(json['data']) : null;
    time = json['time'];
    errorMessages = json['errorMessages'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = statusCode;
    map['message'] = message;
    map['data'] = data?.toJson();
    map['time'] = time;
    map['errorMessages'] = errorMessages;
    return map;
  }
}

/// ✅ Actual Visitor Entity
class Visitor {
  int? visitorId;
  String? visitorUserUuid;
  String? userName;
  String? email;
  String? phoneNumber;
  bool? status;

  Visitor({
    this.visitorId,
    this.visitorUserUuid,
    this.userName,
    this.email,
    this.phoneNumber,
    this.status,
  });

  Visitor.fromJson(Map<String, dynamic> json) {
    visitorId = json['visitorId'];
    visitorUserUuid = json['visitorUserUuid'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visitorId'] = visitorId;
    map['visitorUserUuid'] = visitorUserUuid;
    map['userName'] = userName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['status'] = status;
    return map;
  }
}
