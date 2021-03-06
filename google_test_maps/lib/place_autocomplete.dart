import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import "package:google_maps_webservice/places.dart";
// import 'package:google_api_headers/google_api_headers.dart';


void main() => runApp(MyApp());

const kGoogleApiKey = "AIzaSyCU2qNxdkqmp0chBXCFabtclmT2XYu966U";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: demo(),
      ),
    );
  }
}

class demo extends StatefulWidget {
  @override
  demoState createState() => new demoState();
}

class demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                // show input autocomplete with selected mode
                // then get the Prediction selected
                Prediction? p = await PlacesAutocomplete.show(
                    context: context, apiKey: kGoogleApiKey);
                displayPrediction(p!);
              },
              child: Text('Find address'),

            )
        )
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId!);

      var placeId = p.placeId;
      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
}