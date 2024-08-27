import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
 // final LatLng initialLocation;
 // MapPage({Key? key, required this.initialLocation}) : super(key: key);
 // @override
 // _MapScreenState createState() => _MapScreenState();

   @override
   _MapPageState createState() => _MapPageState();

}


class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(-17.782356, -63.177952); // Coordenadas de ejemplo

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking Pack'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 10.0,
        ),
        // Puedes agregar marcadores y otras funcionalidades aquí
      ),
    );
  }
}


class _MapScreenState extends State<MapPage> {
  //final Completer<GoogleMapController> _controller =
  //Completer<GoogleMapController>();
  GoogleMapController? mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  void _initializeMapRenderer() {
    final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      mapsImplementation.useAndroidViewSurface = true;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _updateCamera();
  }

  void _updateCamera() {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(37.43296265331129, -122.08832357078792),
        zoom: 15.0,
      ),
    ));
  }
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(37.43296265331129, -122.08832357078792),
            zoom: 15.0,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal, // Use normal map type for simplicity
          zoomControlsEnabled: false, // Disable zoom controls if not needed
          compassEnabled: false, // Disable compass if not needed
        ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
 //   return Scaffold(
 //     appBar: AppBar(
 //       title: Text('Google Map Example'),
 //     ),
 //     body: GoogleMap(
 //       mapType: MapType.hybrid,
 //       initialCameraPosition: _kGooglePlex,
 //       onMapCreated: (GoogleMapController controller) {
 //         _controller.complete(controller);
 //       },
 //      // floatingActionButton: FloatingActionButton.extended(
 //      //   onPressed: _goToTheLake,
 //      //   label: const Text('To the lake!'),
 //      //   icon: const Icon(Icons.directions_boat),
 //      // ),
 //     ),
 //     floatingActionButton: FloatingActionButton.extended(
 //       onPressed: _goToTheLake,
 //       label: const Text('To the lake!'),
 //       icon: const Icon(Icons.directions_boat),
 //     ),
 //   );
 // }


 // Future<void> _goToTheLake() async {
 //   final GoogleMapController controller = await mapController.future;
 //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
 // }
}
