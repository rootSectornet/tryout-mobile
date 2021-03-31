import 'package:TesUjian/src/response/provinsi.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectProvinsi extends StatefulWidget {
  final ProvinsiResponse provinsiResponse;

  const SelectProvinsi({Key key, this.provinsiResponse}) : super(key: key);
  @override
  _SelectProvinsiState createState() => _SelectProvinsiState(provinsiResponse);
}

class _SelectProvinsiState extends State<SelectProvinsi> {
  // ignore: unused_field
  ProvinsiResponse _provinsiResponse;
  _SelectProvinsiState(ProvinsiResponse provinsiResponse) {
    this._provinsiResponse = provinsiResponse;
    print(provinsiResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Provinsi"),
      ),
      body: ListView.builder(
        itemCount: this._provinsiResponse.data.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 20, right: 20),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Ionicons.school),
            title: Text("${this._provinsiResponse.data[index].name}"),
            onTap: (() {
              Navigator.pop(context, index);
            }),
          );
        },
      ),
    );
  }
}
