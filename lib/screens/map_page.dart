import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

import '../data/models/item_pack.dart';

class MapPage extends StatefulWidget {

  const MapPage({super.key, required this.itemPack});

  final ItemPack itemPack;
 // final LatLng initialLocation;
 // MapPage({Key? key, required this.initialLocation}) : super(key: key);
 // @override
 // _MapScreenState createState() => _MapScreenState();

   @override
   _MapPageState createState() => _MapPageState();

}


class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
   LatLng _currentPosition  =  LatLng(-17.782356, -63.177952); // Coordenadas de ejemplo
  Set<Marker> _markers = {}; // Para almacenar los marcadores

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Tracking Pack' ),
        title: Text('Nro Carga: ${widget.itemPack.nro_carga}'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator()) // Mostrar loading mientras carga la ubicación
          :GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target:  _currentPosition!, //LatLng(widget.itemPack.latitud as double, widget.itemPack.longitud as double),
          zoom: 12.0,
        ),
        // Puedes agregar marcadores y otras funcionalidades aquí
        markers: _markers,
        //{
        //  Marker(
        //    markerId: MarkerId('current-location'),
        //    position: _currentPosition,
        //  ),
        //},
      ),
    );
  }



  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('El servicio de ubicación está deshabilitado.');
    }

    // Verificar permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permisos de ubicación denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permisos de ubicación denegados permanentemente.');
    }

    // Obtener la posición actual
    return await Geolocator.getCurrentPosition();
  }
  // Función para obtener la ubicación actual
  Future<void> _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);

      // Añadir marcador para la ubicación actual
      _markers.add(Marker(
        markerId: MarkerId("current_location"),
        position: _currentPosition!,
        infoWindow: InfoWindow(title: 'Tu ubicación actual'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Marcador azul para diferenciarlo
      ));

      // Añadir marcador para la ubicación seleccionada
      _markers.add(Marker(
        markerId: MarkerId('Nro Carga:'+ '${widget.itemPack.nro_carga?.toString() ?? ''}' ),
        position: LatLng(double.tryParse(widget.itemPack.latitud ?? '')  ?? -17.768421, double.tryParse(widget.itemPack.longitud ?? '')  ?? -63.204431),
        infoWindow: InfoWindow(title: widget.itemPack.detalle),
      ));
    });
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
