import 'package:medtest/confirm_page.dart';
import 'package:medtest/medtest/medtest_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class Location extends StatefulWidget {
  final String? formdata;
  final String? cart;
  Location({Key? key, this.formdata, this.cart}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  String locn = '';
  String latlng = '';

  Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      altitudeAccuracy: 50,
      headingAccuracy: 50,
      speedAccuracy: 0);
  List<Placemark> addrss = [];
  LatLng point = LatLng(0, 0);

  Future<void> getPos() async {
    final status = await Permission.location.request();

    _permissionStatus = status;

    if (_permissionStatus.isGranted) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      point.latitude == 0 && point.longitude == 0
          ? point = LatLng(position.latitude, position.longitude)
          : point = point;
      addrss = await placemarkFromCoordinates(point.latitude, point.longitude);
      locn = ('${addrss.first.thoroughfare}, ${addrss.first.locality}');
      latlng = LatLng(point.latitude, point.longitude).toString();
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      point.latitude == 0 && point.longitude == 0
          ? point = LatLng(position.latitude, position.longitude)
          : point = point;
      addrss = await placemarkFromCoordinates(point.latitude, point.longitude);
      locn = ('${addrss.first.thoroughfare}, ${addrss.first.locality}');
      latlng = LatLng(point.latitude, point.longitude).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    onTap: (tapPos, p) async {
                      addrss = (await placemarkFromCoordinates(
                          p.latitude, p.longitude));
                      locn =
                          '${addrss.first.thoroughfare}, ${addrss.first.locality}';
                      latlng =
                          LatLng(point.latitude, point.longitude).toString();

                      setState(() {
                        point = p;
                      });
                    },
                    center: LatLng(position.latitude, position.longitude),
                    zoom: 16.0,
                  ),
                  children: [
                    TileLayer(
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 125.0,
                          height: 125.0,
                          point: LatLng(point.latitude, point.longitude),
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          child: TextField(
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(16.0),
                              hintText:
                                  "${addrss.first.thoroughfare}, ${addrss.first.locality}",
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: DesignCourseAppTheme.nearlyBlue,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmPage(
                                      formdata: widget.formdata!,
                                      loc: locn,
                                      latlng: latlng,
                                      cart: widget.cart!)),
                            );
                          },
                          child: Card(
                            shadowColor: DesignCourseAppTheme.nearlyBlue
                                .withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  Text("Confirm Location",
                                      style: TextStyle(
                                          color:
                                              DesignCourseAppTheme.nearlyBlue,
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Scaffold(
                body: Center(
                    child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text("The error ${snapshot.error} occured"),
            )));
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.waveDots(
                      color: Colors.lightBlue,
                      size: 50,
                    ),
                    Text(
                      'Loading Your Location',
                      style: TextStyle(
                          fontSize: 16, color: DesignCourseAppTheme.darkText),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Future<void> requestPermission(Permission permission) async {}
}
