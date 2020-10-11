class PhonesNumbers {
  String name;
  String phone;
  String image;
  PhonesNumbers.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.phone = json['phone'];
    this.image = json['image'];
  }

  /* String get name => _name;

  set name(String value) {
    _name = value;
  }*/

  PhonesNumbers(this.name, this.phone, this.image);

  /*String get phone => _phone;

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  set phone(String value) {
    _phone = value;
  }*/
}
