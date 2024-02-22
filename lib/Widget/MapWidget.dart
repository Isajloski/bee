import 'dart:core';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Model/LocationModel.dart';
import '../navigation_bar.dart';


class MapWidget extends StatefulWidget {
  final List<LocationModel> locations;

  MapWidget({Key? key, required this.locations}) : super(key: key);

  @override
  MapState createState() => MapState();

}

class MapState extends State<MapWidget> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  int _currentIndex = 2;
  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  Future<void> _createMarkers() async {
    Set<Marker> localMarkers = {};
    for (LocationModel location in widget.locations) {
      List<geocoding.Location> locations = await geocoding.locationFromAddress(location.location);
      if (locations.isNotEmpty) {
        final LatLng position = LatLng(locations.first.latitude, locations.first.longitude);
        localMarkers.add(
          Marker(
            markerId: MarkerId('${location.name}_${location.date}_${location.time}'),
            position: position,
            infoWindow: InfoWindow(title: 'Име: ${location.name}', snippet: 'Локација: ${location.location}. Време ${location.time}'),
          ),
        );
      }
    }

    setState(() {
      markers = localMarkers;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(42.0041, 21.4134),
          // Default position, update this based on your needs
          zoom: 18.5,
        ),
        markers: markers,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

