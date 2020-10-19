import 'dart:convert';

OldPhonesNumbers clientFromJson(String str) {
  final jsonData = json.decode(str);
  return OldPhonesNumbers.fromMap(jsonData);
}

String clientToJson(OldPhonesNumbers data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class OldPhonesNumbers {
  int id;
  String name;
  String phoneNumber;
  String image;

  OldPhonesNumbers(this.name, this.phoneNumber, this.image);
  Map<String, dynamic> toMap() {
    return {'name': name, 'phoneNumber': phoneNumber, 'image': image};
  }

  factory OldPhonesNumbers.fromMap(Map<String, dynamic> json) {
    return OldPhonesNumbers(
      json['name'],
      json['phoneNumber'],
      json['image'],
    );
  }
}
