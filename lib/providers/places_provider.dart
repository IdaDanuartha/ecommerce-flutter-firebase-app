import 'package:ecommerce_firebase/models/place_search_model.dart';
import 'package:ecommerce_firebase/services/places_service.dart';
import 'package:flutter/material.dart';

class PlacesProvider with ChangeNotifier {
  final placesService = PlacesService();

  List<PlaceSearchModel> _searchResults = [];
  List<PlaceSearchModel> get searchResults => _searchResults;

  set searchResults(List<PlaceSearchModel> searchResults) {
    _searchResults = searchResults;
    notifyListeners();
  }

  searchPlaces(String search) async {
    _searchResults = await placesService.getAutoComplete(search);
    notifyListeners();
  }
}