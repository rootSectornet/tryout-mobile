import 'dart:convert';
import 'dart:io';

import 'package:TesUjian/src/model/profile.dart';
import 'package:TesUjian/src/resources/daftarApi.dart';
import 'package:TesUjian/src/resources/profileApi.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/state/profile_header.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:intl/intl.dart';

abstract class ProfileHeaderPresenterAbstract {
  set view(ProfileHeaderState view) {}
  void getData(int idMurid) {}
  void getDaftar(int idMurid) {}
  void getSekolah() {}
  void updateProfile(
      int id,
      String nama,
      String email,
      String password,
      String phone,
      String jenisKelamin,
      String tglLahir,
      String alamat,
      String asalSekolah,
      String tujuanSekolah) {}
}

class ProfileHeaderPresenter implements ProfileHeaderPresenterAbstract {
  ProfileModel _profileModel = new ProfileModel();
  ProfileHeaderState _profileHeaderState;
  ProfileApi _profileApi = new ProfileApi();
  DaftarApi _daftarApi = new DaftarApi();
  SekolahApi _sekolahApi = new SekolahApi();

  @override
  // ignore: avoid_return_types_on_setters
  void set view(ProfileHeaderState view) {
    // ignore: todo
    // TODO: implement view
    this._profileHeaderState = view;
    this._profileHeaderState.refreshData(this._profileModel);
  }

  @override
  void getData(idMurid) {
    // ignore: todo
    // TODO: implement getData
    this._profileModel.isloading = true;
    this._profileHeaderState.refreshData(this._profileModel);
    this._profileApi.getProfile(idMurid).then((value) {
      value.dataMurid.dataMurids.forEach((element) {
        // List<String> time = element.waktuPengerjaan.split(" - ");
        // DateTime akhir = DateTime.parse("2020-11-20 " + time[1]);
        // DateTime awal = DateTime.parse("2020-11-20 " + time[0]);
        // var durasi = akhir.hour - awal.hour;
        String tanggal = DateFormat("d MMMM y")
            .format(DateTime.parse(element.tglLahir))
            .toString();
        this._profileModel.profiles.add(new Profile(
            id: element.id,
            nama: element.name,
            email: element.email,
            password: element.password,
            phone: element.phone,
            tglLahir: tanggal,
            tglLahirAsli: element.tglLahir,
            kelamin: element.kelamin,
            alamat: element.alamat,
            namaSekolah: element.sekolah.nama,
            idSekolah: element.idSekolah,
            picture: element.picture));
      });
      this._profileModel.isloading = false;
      this._profileHeaderState.refreshData(this._profileModel);
    }).catchError((err) {
      print(err.toString());
      this._profileModel.isloading = false;
      this._profileHeaderState.refreshData(this._profileModel);
      this._profileHeaderState.onError(err.toString());
    });
  }

  @override
  void getDaftar(idMurid) {
    this._profileModel.isloading = true;
    this._profileHeaderState.refreshData(this._profileModel);
    this._daftarApi.getDaftar(idMurid).then((value) {
      this._profileModel.daftarResponse = value;
      this._profileModel.isloading = false;
      this._profileHeaderState.refreshData(this._profileModel);
    }).catchError((err) {
      this._profileModel.isloading = false;
      this._profileHeaderState.refreshData(this._profileModel);
      this._profileHeaderState.onError(err.toString());
    });
  }

  @override
  void getSekolah() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getSekolah().then((value) {
      this._profileModel.sekolah = value;
      this._profileHeaderState.refreshData(this._profileModel);
    }).catchError((err) {
      this._profileHeaderState.onError(err.toString());
    });
  }

  @override
  void updateProfile(id, nama, email, password, phone, jenisKelamin, tglLahir,
      alamat, asalSekolah, tujuanSekolah) {
    // ignore: todo
    // TODO: implement getSekolah
    Map param = {
      'id': id,
      'id_sekolah': asalSekolah,
      'nama': nama,
      'email': email,
      'password': password,
      'phone': phone,
      'tgl_lahir': tglLahir,
      'kelamin': jenisKelamin,
      'alamat': alamat,
    };
    this._profileApi.updateProfile(json.encode(param)).then((res) {
      this._profileHeaderState.onSuccess(res.success.toString());
      this._profileHeaderState.refreshData(this._profileModel);
    }).catchError((err) {
      this._profileHeaderState.onError(err.toString());
    });
  }
}
