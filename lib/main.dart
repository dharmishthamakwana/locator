import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled20/screens/home/view/loaction_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (p0) => LocationScreen(),
      },
    ),
  );
}
