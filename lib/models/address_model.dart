class AddressModel {
  late String country;
  late String province;
  late String city;
  late String subdistrict;
  late String details;

  AddressModel({
    required this.country,
    required this.province,
    required this.city,
    required this.subdistrict,
    required this.details,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    country = json["country"];
    province = json["province"];
    city = json["city"];
    subdistrict = json["subdistrict"];
    details = json["details"];
  }

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "province": province,
      "city": city,
      "subdistrict": subdistrict,
      "details": details,
    };
  }
}