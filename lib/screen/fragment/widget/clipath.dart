import 'package:flutter/cupertino.dart';

class TClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();

    path.lineTo(0, size.height - 140);

    path.quadraticBezierTo(
        size.width / 16, size.height - 60, size.width / 3, size.height - 100);
    path.quadraticBezierTo(size.width / 1.8, size.height - 130,
        size.width - (size.width / 3), size.height - 70);
    path.quadraticBezierTo(size.width - (size.width / 5), size.height,
        size.width, size.height - 45);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
