import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationContoller extends GetxController
{

  Rx<CameraPosition> cameraps= CameraPosition(target: LatLng(21.0000,78.0000),zoom: 3).obs;
  Completer<GoogleMapController> _controller = Completer();

  Future mapLatLon()
  async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat.value=position.latitude;
    lon.value=position.longitude;

    changeCamera();
  }

  void changeCamera()
  {
    cameraps.value = CameraPosition(target: LatLng(21.0000,78.0000),zoom: 11);
  }



  // void onCameraMove(CameraPosition position) {
  //   lastMapPosition = LatLng(lat.value, lon.value);
  // }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  RxInt i=0.obs;
  void selectindex(int value) {
    i = value as RxInt;
    print(i);

  }
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;
  RxList<Placemark> placemarkList = <Placemark>[].obs;
  RxInt currentBottomNavigationBarIndex = 1.obs;
  RxBool isClick = false.obs;
  RxBool isClickForGo = false.obs;

}