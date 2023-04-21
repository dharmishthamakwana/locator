import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled20/screens/home/controller/location_controller.dart';
import 'package:untitled20/screens/home/view/loaction_screen.dart';

class Spleshscreen extends StatefulWidget {
  const Spleshscreen({Key? key}) : super(key: key);

  @override
  State<Spleshscreen> createState() => _SpleshscreenState();
}

class _SpleshscreenState extends State<Spleshscreen> {
  @override
  Widget build(BuildContext context) {
    LocationContoller homecontroller = Get.put(LocationContoller());
    Timer(Duration(seconds: 5), () async {
      var status = await Permission.location.status;
      if (await status.isDenied) {
        status = await Permission.location.request();
        if (status.isGranted) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          homecontroller.lat.value = position.latitude;
          homecontroller.lon.value = position.longitude;
          Navigator.pushReplacementNamed(context, 'map');
        }
      } else if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        homecontroller.lat.value = position.latitude;
        homecontroller.lon.value = position.longitude;
        Get.to(LocationScreen());
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          children: [
            Spacer(),
            Image.asset(
              "assets/images/map.png",
              height: 100,
            ),
            Spacer(),
            Image.asset(
              "assets/images/gm.png",
              height: 100,
            ),
          ],
        )),
      ),
    );
  }
}
