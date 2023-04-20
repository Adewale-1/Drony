// import 'dart:async';
// import 'dart:convert';
// import 'dart:io' show Platform;
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart' as Poly;
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:http/http.dart' as http;
//
// class MapScreen extends StatefulWidget {
//   static const String id = 'map_screen';
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController googleMapController;
//   final homeScaffoldKey = GlobalKey<ScaffoldState>();
//   final TextEditingController _destinationController = TextEditingController();
//   final TextEditingController _pickupController = TextEditingController();
//   static const CameraPosition initialCameraPosition =
//   CameraPosition(target: LatLng(0, 0), zoom: 19);
//
//   String apiKey = Platform.isAndroid
//       ? 'AIzaSyCwIGuJDJ3PUJEFjRV_WTWD58gw-ptZjsI'
//       : 'AIzaSyACrEr5zdqzt3I1ffXYgZmUKy4MzdM0fKg';
//
//   Set<Marker> markers = {};
//
//   Set<Polyline> polylines = {};
//
//   bool isButtonVisible = false;
//
//   LatLng pickupLatLng;
//   LatLng destinationLatLng;
//
//   static const platform = const MethodChannel('samples.flutter.dev/location');
//
//   Future<Map<String, double>> _getRaspberryPiLocation() async {
//     try {
//       final response =
//       await http.get(Uri.parse('http://raspberrypi.local:5000/location'));
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         return {
//           'latitude': jsonResponse['latitude'],
//           'longitude': jsonResponse['longitude'],
//         };
//       } else {
//         print('Failed to load location');
//         return null;
//       }
//     } catch (e) {
//       print("Failed to get location: '${e.message}'.");
//       return null;
//     }
//   }
//
//   void _listenForLocationUpdates() {
//     platform.setMethodCallHandler((call) async {
//       if (call.method == 'locationUpdated') {
//         final location = call.arguments as Map<String, dynamic>;
//         final latitude = location['latitude'] as double;
//         final longitude = location['longitude'] as double;
//
//         setState(() {
//           markers.removeWhere((marker) => marker.markerId.value == 'source');
//           markers.add(
//             Marker(
//               markerId: MarkerId('source'),
//               position: LatLng(latitude, longitude),
//             ),
//           );
//           googleMapController.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(latitude, longitude),
//                 zoom: 15,
//               ),
//             ),
//           );
//         });
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _listenForLocationUpdates();
//   }
//
//   Future<void> _placesAutocomplete(
//       TextEditingController controller, bool isPickup) async {
//     Prediction prediction = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: apiKey,
//       onError: onError,
//       mode: Mode.overlay,
//       language: "en",
//       strictbounds: false,
//       types: [""],
//       decoration: InputDecoration(
//         hintText: "Search",
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20.0),
//             borderSide: BorderSide(color: Colors.white)),
//       ),
//       components: [Component(Component.country, "us")],
//     );
//     displayPrediction(controller, prediction, isPickup);
//   }
//
//   void onError(PlacesAutocompleteResponse response) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(response.errorMessage)));
//   }
//
//   Future<void> _addPolyline() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<LatLng> polylineCoordinates = [];
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       apiKey,
//       Poly.PointLatLng(pickupLatLng.latitude, pickupLatLng.longitude),
//       Poly.PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
//       travelMode: Poly.TravelMode.driving,
//     );
//
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print('No polyline coordinates found');
//       return;
//     }
//
//     setState(() {
//       Polyline polyline = Polyline(
//         polylineId: PolylineId('route'),
//         color: Colors.blue,
//         points: polylineCoordinates,
//         width: 5,
//       );
//
//       polylines.clear();
//       polylines.add(polyline);
//     });
//   }
//
//   Future<void> displayPrediction(TextEditingController controller,
//       Prediction prediction, bool isPickup) async {
//     if (prediction != null) {
//       GoogleMapsPlaces places = GoogleMapsPlaces(
//         apiKey: apiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders(),
//       );
//       PlacesDetailsResponse details =
//       await places.getDetailsByPlaceId(prediction.placeId);
//       if (details != null) {
//         setState(() {
//           if (isPickup) {
//             markers.removeWhere((marker) => marker.markerId.value == 'pickup');
//             pickupLatLng = LatLng(details.result.geometry.location.lat,
//                 details.result.geometry.location.lng);
//           } else {
//             markers.removeWhere(
//                     (marker) => marker.markerId.value == 'destination');
//             destinationLatLng = LatLng(details.result.geometry.location.lat,
//                 details.result.geometry.location.lng);
//           }
//
//           markers.add(
//             Marker(
//                 position: LatLng(details.result.geometry.location.lat,
//                     details.result.geometry.location.lng),
//                 markerId: MarkerId(isPickup ? 'pickup' : 'destination'),
//                 infoWindow: InfoWindow(
//                     title: details.result.name,
//                     snippet: details.result.formattedAddress),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(isPickup
//                     ? BitmapDescriptor.hueBlue
//                     : BitmapDescriptor.hueRed)),
//           );
//           controller.text = details.result.name;
//           googleMapController.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(details.result.geometry.location.lat,
//                     details.result.geometry.location.lng),
//                 zoom: 15,
//               ),
//             ),
//           );
//           isButtonVisible = true;
//
//           // Add this line to draw the polyline when both markers are set
//           if (pickupLatLng != null && destinationLatLng != null) {
//             // _addPolyline();
//           }
//         });
//       }
//     }
//   }
//
//   Future<Position> _getCurrentLocation() async {
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     return position;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               googleMapController = controller;
//               _getCurrentLocation().then(
//                     (position) {
//                   setState(() {
//                     markers.add(
//                       Marker(
//                         markerId: MarkerId('source'),
//                         position: LatLng(position.latitude, position.longitude),
//                       ),
//                     );
//                     googleMapController.animateCamera(
//                       CameraUpdate.newCameraPosition(
//                         CameraPosition(
//                           target: LatLng(position.latitude, position.longitude),
//                           zoom: 15,
//                         ),
//                       ),
//                     );
//                   });
//                 },
//               );
//             },
//             markers: markers,
//             polylines: polylines, // Add polylines to the GoogleMap widget
//             initialCameraPosition: initialCameraPosition,
//           ),
//           Positioned(
//             top: 60,
//             right: 15,
//             left: 15,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15.0),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3))
//                 ],
//               ),
//               child: Row(
//                 children: <Widget>[
//                   IconButton(
//                     icon:
//                     Icon(Icons.flight_takeoff, color: Colors.grey.shade900),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 10.0),
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           hintText: "Pick up",
//                           hintStyle: TextStyle(
//                               fontSize: 20.0, color: Colors.grey.shade900),
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                         controller: _pickupController,
//                         onTap: () =>
//                             _placesAutocomplete(_pickupController, true),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: 120,
//             right: 15,
//             left: 15,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15.0),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3))
//                 ],
//               ),
//               child: Row(
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.location_pin, color: Colors.grey.shade900),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 10.0),
//                       child: TextFormField(
//                         style: const TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           hintText: "Current location",
//                           hintStyle: TextStyle(
//                               fontSize: 20.0, color: Colors.grey.shade900),
//                           border: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           errorBorder: InputBorder.none,
//                           disabledBorder: InputBorder.none,
//                         ),
//                         controller: _destinationController,
//                         onTap: () {
//                           _placesAutocomplete(_destinationController, false);
//                           setState(() {
//                             markers.removeWhere(
//                                     (marker) => marker.markerId.value == 'source');
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Visibility(
//             visible: isButtonVisible,
//             child: Positioned(
//               bottom: 30.0,
//               left: 20.0,
//               right: 20.0,
//               child: ElevatedButton(
//                 onPressed: () {
//                   print("This button was clicked");
// // Do something when button is pressed
//                 },
//                 child: Text('Request'),
//                 style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20))),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
