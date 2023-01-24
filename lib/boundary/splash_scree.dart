import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:sarbu/controller/auth_controller.dart';

import 'package:sarbu/helper/constan.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AuthController auth = AuthController();
    Future.delayed(const Duration(seconds: 3), (() => auth.check(context)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/applogo.png', scale: 2),
            const SizedBox(height: 50),
            const Text(
              "UMKM XYZ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CupertinoActivityIndicator(),
          ],
        ),
      ),
    );
  }
}
