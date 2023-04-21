import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled20/screens/home/controller/location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationContoller locationController = Get.put(LocationContoller());

  void initState() {
    super.initState();
    locationController.mapLatLon();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> completer = Completer<GoogleMapController>();
    CameraPosition zoomLocation = CameraPosition(
      bearing: 192.8334901395799,
      target:
          LatLng(locationController.lat.value, locationController.lon.value),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
    Future<void> goToTheLocation() async {
      final GoogleMapController controller = await completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(zoomLocation));
    }

    //for bacak to the location
    CameraPosition backLocation = CameraPosition(
      target:
          LatLng(locationController.lat.value, locationController.lon.value),
      zoom: 14.4746,
    );

    Future<void> backToTheLocation() async {
      final GoogleMapController controller = await completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(backLocation));
    }

    int t1 = TimeOfDay.now().hour;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
                onTap: () {
                  openAppSettings();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.settings,
                    color: t1 > 6 && t1 < 17 ? Colors.blue : Colors.white,
                    size: 30,
                  ),
                )),
          ],
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green.shade700,
        ),
        body: Stack(
          children: [
            Obx(
              () => GoogleMap(
                  // liteModeEnabled: true,
                  // indoorViewEnabled: true,
                  // mapToolbarEnabled: true,
                  onMapCreated: locationController.onMapCreated,
                  markers: createMarker(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  mapType: locationController.isClick.isTrue
                      ? MapType.satellite
                      : MapType.normal,
                  initialCameraPosition: locationController.cameraps.value),
            ),
            // Container(
            //   margin: EdgeInsets.all(10),
            //   padding: EdgeInsets.all(4),
            //   height: 45,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadiusDirectional.circular(30),
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       CircleAvatar(
            //         backgroundImage: AssetImage("assets/images/p1.jpeg"),
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Icon(Icons.search, color: Colors.grey, size: 20),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Text(
            //         "Search here",
            //         style: TextStyle(
            //             color: Colors.grey, letterSpacing: 1, fontSize: 14),
            //       ),
            //       Spacer(),
            //       Icon(Icons.mic, color: Colors.grey),
            //       SizedBox(
            //         width: 15,
            //       ),
            //     ],
            //   ),
            // ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 500,
                // color: Colors.grey,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        locationController.isClick.value =
                            !locationController.isClick.value;
                      },
                      child: Obx(
                        () => Column(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                  child: Image.asset(
                                      locationController.isClick.isFalse
                                          ? "assets/images/def.jpg"
                                          : "assets/images/set.jpg",
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                locationController.isClick.isFalse
                                    ? "Default"
                                    : "Satellite",
                                style: TextStyle(
                                    color: t1 > 6 && t1 < 17
                                        ? Colors.blue
                                        : Colors.white,
                                    fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      // onTap: () {
                      //   homecontroller.isClickForGo.value = !homecontroller.isClickForGo.value;
                      //   goToTheLocation();
                      // },
                      onTap: () {
                        locationController.isClickForGo.value =
                            !locationController.isClickForGo.value;
                        locationController.isClickForGo.isFalse
                            ? backToTheLocation()
                            : goToTheLocation();
                      },
                      child: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Positioned(
        //   top: 550,
        //   left: 10,
        //   child: FloatingActionButton(
        //       backgroundColor: Colors.redAccent,
        //       onPressed: () async {
        //         var status = await Permission.location.status;
        //         if (status.isDenied) {
        //           Permission.location.request();
        //         }
        //       },
        //       child: Icon(Icons.location_on_outlined)),
        // ),
      ),
    );
  }

  createMarker() {
    return {
      Marker(
        markerId: MarkerId("marker 1"),
        position: LatLng(
          21.1702,
          72.8311,
        ),
        infoWindow: InfoWindow(title: "marker 1"),
        rotation: 0,
      ),
    };
  }
}
