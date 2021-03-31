import 'package:TesUjian/src/response/sekolah.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectSekolahScreen extends StatefulWidget {
  final SekolahResponse sekolahResponse;

  const SelectSekolahScreen({Key key, this.sekolahResponse}) : super(key: key);
  @override
  _SelectSekolahScreenState createState() =>
      _SelectSekolahScreenState(sekolahResponse);
}

class _SelectSekolahScreenState extends State<SelectSekolahScreen> {
  // ignore: unused_field
  SekolahResponse _sekolahResponse;
  _SelectSekolahScreenState(SekolahResponse sekolahResponse) {
    this._sekolahResponse = sekolahResponse;
    print(sekolahResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Sekolah Asalmu"),
      ),
      body: this._sekolahResponse.dataSekolah.data.length < 1
          ? Center(
              child: Text(
                'Kosong',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: this._sekolahResponse.dataSekolah.data.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Icon(Ionicons.school),
                  title: Text(
                      "${this._sekolahResponse.dataSekolah.data[index].nama}"),
                  onTap: (() {
                    Navigator.pop(context, index);
                  }),
                );
              },
            ),
    );
  }
}
