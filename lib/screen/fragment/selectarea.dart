import 'package:TesUjian/src/response/area.dart';
import 'package:TesUjian/src/response/sekolah.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SelectArea extends StatefulWidget {
  final AreaResponse areaResponse;

  const SelectArea({Key key, this.areaResponse}) : super(key: key);
  @override
  _SelectAreaState createState() => _SelectAreaState(areaResponse);
}

class _SelectAreaState extends State<SelectArea> {
  // ignore: unused_field
  AreaResponse _areaResponse;
  _SelectAreaState(AreaResponse areaResponse) {
    this._areaResponse = areaResponse;
    print(areaResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Area"),
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
            title: Text("${this._areaResponse.data[index].area}"),
            onTap: (() {
              Navigator.pop(context, index);
            }),
          );
        },
      ),
    );
  }
}
