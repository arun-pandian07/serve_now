/// statusCode : 200
/// message : "success"
/// data : {"content":[{"visitorId":39,"email":"arun1234","phoneNumber":"912367345","userName":"arun"},{"visitorId":38,"email":"arun123","phoneNumber":"5123445463","userName":"vicee"},{"visitorId":37,"email":" v@gmail.com","phoneNumber":"512344546","userName":"vic"},{"visitorId":36,"email":" vick@gmail.com","phoneNumber":"51234","userName":"vic"},{"visitorId":34,"email":" vic@gmail.com","phoneNumber":" 1234567891","userName":" vic"}],"pageNumber":1,"pageSize":5,"totalElements":31,"totalPages":7,"numberOfElements":5,"offset":5}
/// time : "2025-09-01T14:45:32.419+00:00"
/// errorMessages : null

class Visitor1 {
  Visitor1({
      num? statusCode, 
      String? message, 
      Data? data, 
      String? time, 
      dynamic errorMessages,}){
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _time = time;
    _errorMessages = errorMessages;
}

  Visitor1.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _time = json['time'];
    _errorMessages = json['errorMessages'];
  }
  num? _statusCode;
  String? _message;
  Data? _data;
  String? _time;
  dynamic _errorMessages;
Visitor1 copyWith({  num? statusCode,
  String? message,
  Data? data,
  String? time,
  dynamic errorMessages,
}) => Visitor1(  statusCode: statusCode ?? _statusCode,
  message: message ?? _message,
  data: data ?? _data,
  time: time ?? _time,
  errorMessages: errorMessages ?? _errorMessages,
);
  num? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;
  String? get time => _time;
  dynamic get errorMessages => _errorMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['time'] = _time;
    map['errorMessages'] = _errorMessages;
    return map;
  }

}

/// content : [{"visitorId":39,"email":"arun1234","phoneNumber":"912367345","userName":"arun"},{"visitorId":38,"email":"arun123","phoneNumber":"5123445463","userName":"vicee"},{"visitorId":37,"email":" v@gmail.com","phoneNumber":"512344546","userName":"vic"},{"visitorId":36,"email":" vick@gmail.com","phoneNumber":"51234","userName":"vic"},{"visitorId":34,"email":" vic@gmail.com","phoneNumber":" 1234567891","userName":" vic"}]
/// pageNumber : 1
/// pageSize : 5
/// totalElements : 31
/// totalPages : 7
/// numberOfElements : 5
/// offset : 5

class Data {
  Data({
      List<Content>? content, 
      num? pageNumber, 
      num? pageSize, 
      num? totalElements, 
      num? totalPages, 
      num? numberOfElements, 
      num? offset,}){
    _content = content;
    _pageNumber = pageNumber;
    _pageSize = pageSize;
    _totalElements = totalElements;
    _totalPages = totalPages;
    _numberOfElements = numberOfElements;
    _offset = offset;
}

  Data.fromJson(dynamic json) {
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
    _pageNumber = json['pageNumber'];
    _pageSize = json['pageSize'];
    _totalElements = json['totalElements'];
    _totalPages = json['totalPages'];
    _numberOfElements = json['numberOfElements'];
    _offset = json['offset'];
  }
  List<Content>? _content;
  num? _pageNumber;
  num? _pageSize;
  num? _totalElements;
  num? _totalPages;
  num? _numberOfElements;
  num? _offset;
Data copyWith({  List<Content>? content,
  num? pageNumber,
  num? pageSize,
  num? totalElements,
  num? totalPages,
  num? numberOfElements,
  num? offset,
}) => Data(  content: content ?? _content,
  pageNumber: pageNumber ?? _pageNumber,
  pageSize: pageSize ?? _pageSize,
  totalElements: totalElements ?? _totalElements,
  totalPages: totalPages ?? _totalPages,
  numberOfElements: numberOfElements ?? _numberOfElements,
  offset: offset ?? _offset,
);
  List<Content>? get content => _content;
  num? get pageNumber => _pageNumber;
  num? get pageSize => _pageSize;
  num? get totalElements => _totalElements;
  num? get totalPages => _totalPages;
  num? get numberOfElements => _numberOfElements;
  num? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    map['pageNumber'] = _pageNumber;
    map['pageSize'] = _pageSize;
    map['totalElements'] = _totalElements;
    map['totalPages'] = _totalPages;
    map['numberOfElements'] = _numberOfElements;
    map['offset'] = _offset;
    return map;
  }

}

/// visitorId : 39
/// email : "arun1234"
/// phoneNumber : "912367345"
/// userName : "arun"

class Content {
  Content({
      num? visitorId, 
      String? email, 
      String? phoneNumber, 
      String? userName,}){
    _visitorId = visitorId;
    _email = email;
    _phoneNumber = phoneNumber;
    _userName = userName;
}

  Content.fromJson(dynamic json) {
    _visitorId = json['visitorId'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _userName = json['userName'];
  }
  num? _visitorId;
  String? _email;
  String? _phoneNumber;
  String? _userName;
Content copyWith({  num? visitorId,
  String? email,
  String? phoneNumber,
  String? userName,
}) => Content(  visitorId: visitorId ?? _visitorId,
  email: email ?? _email,
  phoneNumber: phoneNumber ?? _phoneNumber,
  userName: userName ?? _userName,
);
  num? get visitorId => _visitorId;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visitorId'] = _visitorId;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['userName'] = _userName;
    return map;
  }

}