/// statusCode : 200
/// message : "success"
/// data : {...}
/// time : "2025-08-21T05:08:17.553+00:00"
/// errorMessages : null

class User {
  User({
    num? statusCode,
    String? message,
    Data? data,
    String? time,
    dynamic errorMessages,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
    _time = time;
    _errorMessages = errorMessages;
  }

  User.fromJson(dynamic json) {
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

  User copyWith({
    num? statusCode,
    String? message,
    Data? data,
    String? time,
    dynamic errorMessages,
  }) =>
      User(
        statusCode: statusCode ?? _statusCode,
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

/// ---------------- DATA ----------------
class Data {
  Data({
    List<Content>? content,
    Pageable? pageable,
    num? totalPages,
    num? totalElements,
    bool? last,
    num? size,
    num? number,
    Sort? sort,
    num? numberOfElements,
    bool? first,
    bool? empty,
  }) {
    _content = content;
    _pageable = pageable;
    _totalPages = totalPages;
    _totalElements = totalElements;
    _last = last;
    _size = size;
    _number = number;
    _sort = sort;
    _numberOfElements = numberOfElements;
    _first = first;
    _empty = empty;
  }

  Data.fromJson(dynamic json) {
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
    _pageable =
    json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    _totalPages = json['totalPages'];
    _totalElements = json['totalElements'];
    _last = json['last'];
    _size = json['size'];
    _number = json['number'];
    _sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    _numberOfElements = json['numberOfElements'];
    _first = json['first'];
    _empty = json['empty'];
  }

  List<Content>? _content;
  Pageable? _pageable;
  num? _totalPages;
  num? _totalElements;
  bool? _last;
  num? _size;
  num? _number;
  Sort? _sort;
  num? _numberOfElements;
  bool? _first;
  bool? _empty;

  Data copyWith({
    List<Content>? content,
    Pageable? pageable,
    num? totalPages,
    num? totalElements,
    bool? last,
    num? size,
    num? number,
    Sort? sort,
    num? numberOfElements,
    bool? first,
    bool? empty,
  }) =>
      Data(
        content: content ?? _content,
        pageable: pageable ?? _pageable,
        totalPages: totalPages ?? _totalPages,
        totalElements: totalElements ?? _totalElements,
        last: last ?? _last,
        size: size ?? _size,
        number: number ?? _number,
        sort: sort ?? _sort,
        numberOfElements: numberOfElements ?? _numberOfElements,
        first: first ?? _first,
        empty: empty ?? _empty,
      );

  List<Content>? get content => _content;
  Pageable? get pageable => _pageable;
  num? get totalPages => _totalPages;
  num? get totalElements => _totalElements;
  bool? get last => _last;
  num? get size => _size;
  num? get number => _number;
  Sort? get sort => _sort;
  num? get numberOfElements => _numberOfElements;
  bool? get first => _first;
  bool? get empty => _empty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    if (_pageable != null) {
      map['pageable'] = _pageable?.toJson();
    }
    map['totalPages'] = _totalPages;
    map['totalElements'] = _totalElements;
    map['last'] = _last;
    map['size'] = _size;
    map['number'] = _number;
    if (_sort != null) {
      map['sort'] = _sort?.toJson();
    }
    map['numberOfElements'] = _numberOfElements;
    map['first'] = _first;
    map['empty'] = _empty;
    return map;
  }
}

class Sort {
  Sort({
    bool? sorted,
    bool? empty,
    bool? unsorted,
  }) {
    _sorted = sorted;
    _empty = empty;
    _unsorted = unsorted;
  }

  Sort.fromJson(dynamic json) {
    _sorted = json['sorted'];
    _empty = json['empty'];
    _unsorted = json['unsorted'];
  }

  bool? _sorted;
  bool? _empty;
  bool? _unsorted;

  Sort copyWith({
    bool? sorted,
    bool? empty,
    bool? unsorted,
  }) =>
      Sort(
        sorted: sorted ?? _sorted,
        empty: empty ?? _empty,
        unsorted: unsorted ?? _unsorted,
      );

  bool? get sorted => _sorted;
  bool? get empty => _empty;
  bool? get unsorted => _unsorted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sorted'] = _sorted;
    map['empty'] = _empty;
    map['unsorted'] = _unsorted;
    return map;
  }
}

class Pageable {
  Pageable({
    Sort? sort,
    num? pageNumber,
    num? pageSize,
    num? offset,
    bool? paged,
    bool? unpaged,
  }) {
    _sort = sort;
    _pageNumber = pageNumber;
    _pageSize = pageSize;
    _offset = offset;
    _paged = paged;
    _unpaged = unpaged;
  }

  Pageable.fromJson(dynamic json) {
    _sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    _pageNumber = json['pageNumber'];
    _pageSize = json['pageSize'];
    _offset = json['offset'];
    _paged = json['paged'];
    _unpaged = json['unpaged'];
  }

  Sort? _sort;
  num? _pageNumber;
  num? _pageSize;
  num? _offset;
  bool? _paged;
  bool? _unpaged;

  Pageable copyWith({
    Sort? sort,
    num? pageNumber,
    num? pageSize,
    num? offset,
    bool? paged,
    bool? unpaged,
  }) =>
      Pageable(
        sort: sort ?? _sort,
        pageNumber: pageNumber ?? _pageNumber,
        pageSize: pageSize ?? _pageSize,
        offset: offset ?? _offset,
        paged: paged ?? _paged,
        unpaged: unpaged ?? _unpaged,
      );

  Sort? get sort => _sort;
  num? get pageNumber => _pageNumber;
  num? get pageSize => _pageSize;
  num? get offset => _offset;
  bool? get paged => _paged;
  bool? get unpaged => _unpaged;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sort != null) {
      map['sort'] = _sort?.toJson();
    }
    map['pageNumber'] = _pageNumber;
    map['pageSize'] = _pageSize;
    map['offset'] = _offset;
    map['paged'] = _paged;
    map['unpaged'] = _unpaged;
    return map;
  }
}


class Content {
  Content({
    num? internalUserId,
    String? firstName,
    dynamic lastName,
    String? email,
    num? roleId,
    String? role,
    bool? status,
    dynamic profileImageUrl,
  }) {
    _internalUserId = internalUserId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _roleId = roleId;
    _role = role;
    _status = status;
    _profileImageUrl = profileImageUrl;
  }

  Content.fromJson(dynamic json) {
    _internalUserId = json['internalUserId'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _roleId = json['roleId'];
    _role = json['role'];
    _status = json['status'];
    _profileImageUrl = json['profileImageUrl'];
  }

  num? _internalUserId;
  String? _firstName;
  dynamic _lastName;
  String? _email;
  num? _roleId;
  String? _role;
  bool? _status;
  dynamic _profileImageUrl;

  Content copyWith({
    num? internalUserId,
    String? firstName,
    dynamic lastName,
    String? email,
    num? roleId,
    String? role,
    bool? status,
    dynamic profileImageUrl,
  }) =>
      Content(
        internalUserId: internalUserId ?? _internalUserId,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        roleId: roleId ?? _roleId,
        role: role ?? _role,
        status: status ?? _status,
        profileImageUrl: profileImageUrl ?? _profileImageUrl,
      );

  num? get internalUserId => _internalUserId;
  String? get firstName => _firstName;
  dynamic get lastName => _lastName;
  String? get email => _email;
  num? get roleId => _roleId;
  String? get role => _role;
  bool? get status => _status;
  dynamic get profileImageUrl => _profileImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['internalUserId'] = _internalUserId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['roleId'] = _roleId;
    map['role'] = _role;
    map['status'] = _status;
    map['profileImageUrl'] = _profileImageUrl;
    return map;
  }
}
