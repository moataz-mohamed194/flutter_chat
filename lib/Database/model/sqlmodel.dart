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

class OldPhonesMessage {
  int id;
  String name;
  String message;
  String phoneNumber;
  String image;

  OldPhonesMessage(this.name, this.phoneNumber, this.image, this.message);
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'message': message,
      'image': image
    };
  }

  factory OldPhonesMessage.fromMap(Map<String, dynamic> json) {
    return OldPhonesMessage(
      json['name'],
      json['phoneNumber'],
      json['message'],
      json['image'],
    );
  }
}
