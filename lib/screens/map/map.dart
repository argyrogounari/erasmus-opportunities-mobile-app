import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:erasmusopportunitiesapp/models/volunteer.dart';
import 'package:erasmusopportunitiesapp/screens/map/preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  LatLng _center = const LatLng(47.658933, 16.181248);
  Set<Marker> markers = Set.from([]);

  Future<LatLng> getLatLong(String address) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(address);
    return LatLng(addresses.first.coordinates.latitude, addresses.first.coordinates.longitude);
  }

  Opportunity currentOpp;


  @override
  Widget build(BuildContext context) {

    final opportunities = Provider.of<List<Opportunity>>(context);
    final volunteer = Provider.of<VolunteerData>(context);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;

    }

    _onTap(Opportunity opportunity) {
      setState(() {
        currentOpp = opportunity;
      });
    }

    setMarkers(List<Opportunity> opportunitiesList) async {
      List<Marker> markersList = [];
      for (var opp in opportunitiesList) {
        //print(opp.venueAddress);
        await getLatLong(opp.venueAddress)
        .then((value) {
          markersList.add(
            Marker(
              markerId: MarkerId(opp.oid),
              position: value,
              infoWindow: InfoWindow(title: opp.title),
              onTap: () =>_onTap(opp),
            )
          );
          print(opp.venueAddress + " " + value.toString());
        })
        .catchError((error) => print('Get LatLong failed with $error')) ;
      }

      setState(() {
       markers = Set.from(markersList);
      });
    }

    Set<Marker> setMarkersWhenEmpty(List<Opportunity> opp) {
      setMarkers(opp);
      return markers;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Theme(
        data: ThemeData(
          primaryColor: Color.fromRGBO(0, 68, 149, 1),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        child: Scaffold(
          body: Stack(
            children: <Widget>[

              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 5.0,
                ),
                myLocationButtonEnabled: false,
                markers: markers.isEmpty ? setMarkersWhenEmpty(opportunities) : markers,
              ),

              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: currentOpp == null ?
                    Text('') :
                    OpportunityPreviewForMap(opportunity: currentOpp, user: volunteer,),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}


