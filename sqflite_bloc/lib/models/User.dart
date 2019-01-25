class User {
  int _id;
  int _userId;
  String _name;
  int _mobileNumber;

  User(this._userId,this._name, this._mobileNumber);

  User.withId(this._id, this._userId, this._mobileNumber);

  int get id => _id;

  int get userId => _userId;

  String get name => _name;

  int get mobileNumber => _mobileNumber;

  set userId(int newUserId) {
    this._userId = newUserId;
  }

  set userName(String newUserName){
    this._name = newUserName;
  }

  set mobileNumber(int newMobileNumber) {
    this._mobileNumber = newMobileNumber;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["userId"] = _userId;
    map["mobileNumber"] = _mobileNumber;
    map["name"] = _name;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._mobileNumber = map["userId"];
    this._userId = map["mobileNumber"];
    this._name = map["name"];
  }
}