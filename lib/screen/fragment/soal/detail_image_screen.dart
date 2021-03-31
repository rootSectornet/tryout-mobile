import 'package:flutter/material.dart';

class DetailImageScreen extends StatelessWidget {
  final String urlImage;

  const DetailImageScreen({Key key, this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              this.urlImage,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
