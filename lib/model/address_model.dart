class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String _address;
  late String _latitude;
  late String _longitude;
  late String? _contactPhoneNumber;

  AddressModel ({
    id,
    required addressType,
    contactPersonName,
    required address,
    required latitude,
    required longitude,
    contactPhoneNumber
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
    _contactPhoneNumber = contactPhoneNumber;
  }
  String get addressType => _addressType;
  String get address => _address;
  String? get contactPersonName => _contactPersonName;
  String? get contactPhoneNumber => _contactPhoneNumber;
  String get latitude => _latitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json){
    _id = json["id"];
    _addressType = json["address_type"]??"";
    _contactPersonName = json["contact_person_name"]??"";
    _contactPhoneNumber = json["contact_person_number"]??"";
    _address = json["address"];
    _latitude = json["latitude"];
    _longitude = json["longtitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this._id;
    data["addressType"] = this._addressType;
    data["contactPersonName"] = this._contactPersonName;
    data["contactPhoneNumber"] = this._contactPhoneNumber;
    data["address"] = this._address;
    data["latitude"] = this._latitude;
    data["longitude"] = this._longitude;
    return data;
  }
}

