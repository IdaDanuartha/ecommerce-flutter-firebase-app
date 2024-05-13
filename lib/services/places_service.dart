import 'package:ecommerce_firebase/models/place_search_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final googleApiKey = dotenv.env["GOOGLE_API_KEY"];

  Future<List<PlaceSearchModel>> getAutoComplete(String search) async {
    var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&key=$googleApiKey";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json["predictions"] as List;

    return jsonResults.map((place) => PlaceSearchModel.fromJson(place)).toList();
  }
}