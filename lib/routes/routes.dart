import 'package:SoalOnline/screen/fragment/profile_detail_nilai.dart';
import 'package:SoalOnline/screen/fragment/profile_edit_profile.dart';
import 'package:SoalOnline/screen/fragment/profile_history.dart';
import 'package:SoalOnline/screen/fragment/profile_info_app.dart';
import 'package:SoalOnline/screen/fragment/profile_kebijakan_privacy.dart';
import 'package:SoalOnline/screen/fragment/profile_nilai.dart';
import 'package:SoalOnline/screen/fragment/profile_tagihan.dart';
import 'package:SoalOnline/screen/fragment/verifitaction.dart';
import 'package:SoalOnline/screen/profile_detail.dart';
import 'package:SoalOnline/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:SoalOnline/screen/home.dart';
import 'package:SoalOnline/screen/login.dart';
import 'package:SoalOnline/screen/landing_page.dart';

final routes = {
  '/': (BuildContext context) => new LandingScreen(),
  '/login': (BuildContext context) => new Login(),
  '/signup': (BuildContext context) => new SignUp(),
  '/verify': (BuildContext context) => new VerificationScreen(),
  '/home': (BuildContext context) => new Home(),
  '/profile_detail': (BuildContext context) => new ProfileDetail(),
  '/profile_nilai': (BuildContext context) => new ProfileNilai(),
  '/profile_detail_nilai': (BuildContext context) => new ProfileDetailNilai(),
  '/profile_edit_profile': (BuildContext context) => new EditProfile(),
  '/profile_tagihan': (BuildContext context) => new Tagihan(),
  '/profile_info_app': (BuildContext context) => new ProfileInfoApp(),
  '/profile_kebijakan_privacy': (BuildContext context) => new ProfilePrivacy(),
  '/profile_history': (BuildContext context) => new ProfileHistory(),
};
