class PlaceSearchModel {
  final String description;
  final String placeId;

  PlaceSearchModel({
    required this.description,
    required this.placeId,
  });

  factory PlaceSearchModel.fromJson(Map<String, dynamic> json) {
    return PlaceSearchModel(description: json["description"], placeId: json["place_id"]);
  }
}