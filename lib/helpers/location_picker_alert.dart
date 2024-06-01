import 'package:MushMagic/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:MushMagic/themes.dart';
import 'package:provider/provider.dart';

class LocationPickerAlert extends StatefulWidget {
  const LocationPickerAlert({super.key, this.onLocationSelected});

  final Function(LatLng)? onLocationSelected;

  @override
  State<LocationPickerAlert> createState() => _LocationPickerAlertState();
}

class _LocationPickerAlertState extends State<LocationPickerAlert> {
  GoogleMapController? mapController;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print("Location permission denied");
    } else if (permission == LocationPermission.deniedForever) {
      print("Location permission denied forever");
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        print(place);
        print("Country: ${place.country}");
        print("Region: ${place.administrativeArea}");
        print("Locality: ${place.locality}");
        print("Street: ${place.street}");
        print("Postal Code: ${place.postalCode}");
        // You can use the place object to get detailed information
      }
    } catch (e) {
      print("Error in reverse geocoding: $e");
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(
          "Latitude : ${position.latitude}, Longitude : ${position.longitude}");

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });

      await _getAddressFromLatLng(_selectedLocation!);

    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    PlacesProvider placesProvider =
        Provider.of<PlacesProvider>(context, listen: false);
    print(placesProvider.searchResults.length);
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 5
            //   ),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Search Location...",
            //       hintStyle: TextStyle(
            //         height: 2
            //       ),
            //       border: InputBorder.none,
            //       prefixIcon: Icon(Icons.search),
            //     ),
            //     onChanged: (value) => PlacesProvider().searchPlaces(value),
            //   ),
            // ),
            // Stack(
            //   children: [
            //     Container(
            //       height: 200,
            //       width: double.infinity,
            //       decoration: BoxDecoration(
            //         color: Colors.black.withOpacity(.2),
            //         backgroundBlendMode: BlendMode.darken
            //       ),
            //     ),
            //     Container(
            //       height: 200,
            //       child: ListView.builder(
            //         itemCount: placesProvider.searchResults.length,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             title: Text(
            //               placesProvider.searchResults[index].description,
            //               style: primaryTextStyle,
            //             ),
            //           );
            //         },
            //       ),
            //     )
            //   ],
            // ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  mapController = controller;
                },
                onTap: (latLng) {
                  setState(() {
                    _selectedLocation = latLng;
                  });
                },
                markers: _selectedLocation != null
                    ? {
                        Marker(
                            markerId: const MarkerId('selectedLocation'),
                            position: _selectedLocation!,
                            infoWindow: InfoWindow(
                              title: 'Your Location',
                              snippet:
                                  'Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
                            ))
                      }
                    : {},
                initialCameraPosition: CameraPosition(
                    target: _selectedLocation ?? const LatLng(0, 0), zoom: 15),
                myLocationEnabled: true,
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                onPressed: () async {
                  if (_selectedLocation != null) {
                    print(
                        "Selected Location - Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation}");
                    Navigator.pop(context);
                    widget.onLocationSelected?.call(_selectedLocation!);
                  } else {
                    // handle case where no location is selected
                  }
                },
                child: Text(
                  "Select this location",
                  style: primaryTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
