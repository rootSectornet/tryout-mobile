import 'package:SoalOnline/screen/fragment/verifitaction.dart';
import 'package:SoalOnline/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:SoalOnline/screen/home.dart';
import 'package:SoalOnline/screen/login.dart';
import 'package:SoalOnline/screen/landing_page.dart';

final routes = {
  '/' : (BuildContext context) => new LandingScreen(),
  '/login' : (BuildContext context) => new Login(),
  '/signup' : (BuildContext context) => new SignUp(),
  '/verify' : (BuildContext context) => new VerificationScreen(),
  '/home' : (BuildContext context) => new Home(),
};