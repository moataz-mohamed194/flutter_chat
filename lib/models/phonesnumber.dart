class PhonesNumbers {
  String name;
  String phone;
  String image;
  PhonesNumbers.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.phone = json['phone'];
    this.image = json['image'];
  }

  PhonesNumbers(this.name, this.phone, this.image);
}
