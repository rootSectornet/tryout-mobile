import 'package:flutter/material.dart';

class OverallStatModel {
  String namaPelajaran;
  int nilai;
  Color color;
  int jumlahSoal;
  int totalBenar;
  int totalSalah;
  int totalDilewati;

  OverallStatModel({
    this.namaPelajaran,
    this.nilai,
    this.color,
    this.jumlahSoal,
    this.totalBenar,
    this.totalSalah,
    this.totalDilewati,
  });
}

class OverallStatResponse {
  bool isloading = false;
  bool isSuccess = false;
  List<OverallStatModel> overallStat = new List<OverallStatModel>();
}
