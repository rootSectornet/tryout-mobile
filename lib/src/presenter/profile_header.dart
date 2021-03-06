import 'package:TesUjian/src/model/profile.dart';
import 'package:TesUjian/src/resources/daftarApi.dart';
import 'package:TesUjian/src/resources/profileApi.dart';
import 'package:TesUjian/src/resources/sekolahApi.dart';
import 'package:TesUjian/src/state/profile_header.dart';
import 'package:TesUjian/src/resources/session.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract class ProfileHeaderPresenterAbstract {
  set view(ProfileHeaderState view) {}
  void getData(int idMurid) {}
  void getDaftar(int idMurid) {}
  void getArea() {}
  void getSekolah() {}
  void setJenjang(int id, bool isParent, String name, BuildContext context) {}
  void setJenjangTujuan(
      int id, bool isParent, String name, BuildContext context) {}
  void save(int area, int jenjang) {}
  void saveTujuan(int area, int jenjang) {}
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
      value.dataMurid.forEach((element) {
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
  void getArea() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getArea(0).then((value) {
      this._profileModel.area = value;
      this._profileHeaderState.refreshData(this._profileModel);
    }).catchError((err) {
      this._profileHeaderState.onError(err.toString());
    });
  }

  @override
  void setJenjang(id, isParent, name, context) {
    if (isParent) {
      this._profileHeaderState.showJenjang(context, id);
    } else {
      this._profileModel.jenjangId = id;
      this._profileModel.namaJenjang = name;
      this._profileHeaderState.refreshData(this._profileModel);
      this._profileHeaderState.saveAreaJenjang(id);
    }
  }

  @override
  void setJenjangTujuan(id, isParent, name, context) {
    if (isParent) {
      this._profileHeaderState.showJenjangTujuan(context, id);
    } else {
      this._profileModel.jenjangIdTujuan = id;
      this._profileModel.namaJenjangTujuan = name;
      this._profileHeaderState.refreshData(this._profileModel);
      this._profileHeaderState.saveAreaJenjangTujuan(id);
    }
  }

  @override
  void save(area, jenjang) {
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._profileModel.sekolah = value;
      this._profileHeaderState.refreshData(this._profileModel);
      this._profileHeaderState.selectSekolah();
    }).catchError((err) {
      this._profileHeaderState.onError(err.toString());
    });
  }

  @override
  void saveTujuan(area, jenjang) {
    print(jenjang);
    print("+++++++++++");
    print(area);
    this._sekolahApi.getSekolah(area, jenjang).then((value) {
      this._profileModel.sekolah = value;
      this._profileHeaderState.refreshData(this._profileModel);
      this._profileHeaderState.selectSekolahTujuan();
    }).catchError((err) {
      this._profileHeaderState.onError(err.toString());
    });
  }

  @override
  void getSekolah() {
    // ignore: todo
    // TODO: implement getSekolah
    this._sekolahApi.getSekolah(1, 2).then((value) {
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
    Map<String, String> body = <String, String>{
      "id": id.toString(),
      "id_sekolah": asalSekolah,
      "name": nama,
      "email": email,
      "password": password,
      "phone": phone,
      "tgl_lahir": DateFormat("yyyy-MM-dd")
          .format(this._profileModel.tanggalLahir.toLocal())
          .toString(),
      "kelamin": jenisKelamin,
      "alamat": alamat,
      "id_sekolah_tujuan": tujuanSekolah,
    };
    print(body);
    this._profileApi.updateProfile(body, id.toString()).then((res) {
      this._profileHeaderState.onUpdateSuccess(res.success.toString());
      if (nama != '') {
        Session.removeName();
        print('nama lama dihapus');
        Session.setName(nama);
      }
      this._profileHeaderState.refreshData(this._profileModel);
    }).catchError((err) {
      this._profileHeaderState.onError(err.toString());
    });
  }
}
