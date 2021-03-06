import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/provinsi.dart';
import 'package:TesUjian/src/response/sekolah.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectProv extends StatefulWidget {
  final ProvinsiResponse areaResponse;

  const SelectProv({Key key, this.areaResponse}) : super(key: key);
  @override
  _SelectProveState createState() => _SelectProveState(areaResponse);
}

class _SelectProveState extends State<SelectProv> {
  // ignore: unused_field
  ProvinsiResponse _areaResponse;
  _SelectProveState(ProvinsiResponse areaResponse) {
    this._areaResponse = areaResponse;
    print(areaResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Provinsi"),
      ),
      body: ListView.builder(
        itemCount: this._areaResponse.data.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Ionicons.school),
            title: Text("${this._areaResponse.data[index].name}"),
            onTap: (() {
              Navigator.pop(context, index);
            }),
          );
        },
      ),
    );
  }
}
