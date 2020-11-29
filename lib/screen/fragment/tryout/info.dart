import 'package:SoalOnline/parent/tryout.dart';
import 'package:flutter/material.dart';

class TryoutInfo extends StatefulWidget {
  @override
  _TryoutInfoState createState() => _TryoutInfoState();
}

class _TryoutInfoState extends State<TryoutInfo> {
  @override
  Widget build(BuildContext context) {
    final data = TryoutParent.of(context).tryoutModel;
    int nilais = data.tryoutDetailResponse.data
        .map((item) => item.nilai)
        .reduce((value, element) => value + element);
    var nilai = nilais / data.tryoutDetailResponse.data.length;
    return Container(
      child: Text(TryoutParent.of(context).tryoutModel.idTryout.toString()),
    );
  }
}
