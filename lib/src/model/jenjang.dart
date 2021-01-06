import 'package:TesUjian/src/response/jenjang.dart';

class JenjangModel {
  bool isloading = false;
  bool isSuccess = false;
  JenjangResponse jenjangResponse = new JenjangResponse();
  List<MenuJenjang> menuJenjang = [
    new MenuJenjang("SD", 1, "assets/img/menu/SD.png", 0, false),
    new MenuJenjang("SMP", 2, "assets/img/menu/SMP.png", 0, false),
    new MenuJenjang("SMA", 100, "assets/img/menu/SMA.png", 0, true),
    new MenuJenjang("SMK", 101, "assets/img/menu/SMK.png", 0, true),
    new MenuJenjang("PONDOK", 16, "assets/img/menu/PONDOK.png", 0, false),
    new MenuJenjang("PTN", 102, "assets/img/menu/Mahasiswa.png", 0, true),
    new MenuJenjang("AKUTANSI", 6, "assets/img/menu/SMK.png", 101, false),
    new MenuJenjang("PARAWISATA", 7, "assets/img/menu/SMK.png", 101, false),
    new MenuJenjang("TEKNIK", 8, "assets/img/menu/SMK.png", 101, false),
    new MenuJenjang("IPA", 3, "assets/img/menu/SMA.png", 100, false),
    new MenuJenjang("IPS", 5, "assets/img/menu/SMA.png", 100, false),
    new MenuJenjang("SHOSUM", 13, "assets/img/menu/Mahasiswa.png", 102, false),
    new MenuJenjang("SAINTEK", 14, "assets/img/menu/Mahasiswa.png", 102, false),
  ];
}

class MenuJenjang {
  final String name;
  final int id;
  final String icon;
  final int parentID;
  final bool isParent;
  MenuJenjang(this.name, this.id, this.icon, this.parentID, this.isParent);
}
