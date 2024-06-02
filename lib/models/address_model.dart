class AddressModel {
  late double latitude;
  late double longitude;
  late String fullAddress;
  late String details;

  AddressModel({
    required this.latitude,
    required this.longitude,
    required this.fullAddress,
    required this.details,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    latitude = json["latitude"];
    longitude = json["longitude"];
    fullAddress = json["full_address"];
    details = json["details"];
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "full_address": fullAddress,
      "details": details,
    };
  }
}