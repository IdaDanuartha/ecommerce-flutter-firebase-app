import 'package:ecommerce_firebase/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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

    if(permission == LocationPermission.denied) {
      print("Location permission denied");
    } else if(permission == LocationPermission.deniedForever) {
      print("Location permission denied forever");
    } else {
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("Latitude : ${position.latitude}, Longitude : ${position.longitude}");

      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                mapType: MapType.terrain,
                onMapCreated: (controller) {
                  mapController = controller;
                },
                onTap: (latLng) {
                  _selectedLocation = latLng;
                },
                markers: _selectedLocation != null
                  ? {
                    Marker(
                    markerId: const MarkerId('selectedLocation'),
                    position: _selectedLocation!,
                    infoWindow: InfoWindow(
                      title: 'Selected Location',
                      snippet: 'Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
                    )
                  )
                } : {},
                initialCameraPosition: CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 10
                ),
                myLocationEnabled: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 10,
                top: 10
              ),
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () async {
                  if(_selectedLocation != null) {
                    print("Selected Location - Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation}");
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