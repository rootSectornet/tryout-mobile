import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final int idTryout;
  const CheckoutScreen({Key key, this.idTryout}) : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState(this.idTryout);
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final int idTryout;
  _CheckoutScreenState(this.idTryout) {}
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
