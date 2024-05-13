class AddressModel {
  late double latitude;
  late double longitude;
  late String details;

  AddressModel({
    required this.latitude,
    required this.longitude,
    required this.details,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    details = json["details"];
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "details": details,
    };
  }
}