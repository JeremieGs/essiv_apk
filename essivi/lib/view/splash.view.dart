import 'dart:async';

import 'package:essivi/utiles/global.colors.dart';
import 'package:essivi/view/login.view.dart';
import 'package:essivi/view/app.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Get.to( Login());
    });
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/image/logo.jpg',

          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        ]),
      ),
    );
  }
}
