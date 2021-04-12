import 'package:flutter/material.dart';

import 'package:flutter_google_maps/flutter_google_maps.dart';

import '../widgets/app_drawer.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map-screen';
  GlobalKey<GoogleMapStateBase> _key = GlobalKey<GoogleMapStateBase>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        key: _key,
        initialZoom: 13,
        mapType: MapType.terrain,
        initialPosition: GeoCoord(28.644800, 77.216721),
        mobilePreferences: MobileMapPreferences(
          compassEnabled: true,
          trafficEnabled: true,
        ),
      ),
      drawer: AppDrawer('map'),
    );
  }
}
