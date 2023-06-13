import 'package:essivi/view/splash.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Essivi());
}

class Essivi extends StatelessWidget {
  const Essivi({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashView());
  }
}
