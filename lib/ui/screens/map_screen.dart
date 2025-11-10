import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(40.748440, -73.985664); // Cali

  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hola Google Maps')),
      body: Column(
        children: [
          SizedBox(
            height: 600,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              onLongPress: _handleLongPress,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 2.0,
                tilt: 60,
              ),
              markers: _markers,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _moveCamera(LatLng(3.452980, -76.518784));
                },
                child: Text("Ir a Cali"),
              ),
              ElevatedButton(
                onPressed: () {
                  _moveCamera(_center);
                },
                child: Text("Ir a NY"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleLongPress(LatLng pos) {
    _addMarker(pos);
  }

  void _addMarker(LatLng pos) {
    var id = MarkerId(Uuid().v4());
    setState(() {
      _markers.add(
        Marker(
          markerId: id,
          position: pos,
          onTap: () {
            print(id);
          },
          infoWindow: InfoWindow(title: "Icesi", snippet: id.value),
        ),
      );
    });
  }

  void _moveCamera(LatLng pos) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, zoom: 16.0, bearing: 0.0, tilt: 0.0),
      ),
    );
  }
}
