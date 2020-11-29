import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lunas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xffeeeeee),
              blurRadius: 7,
            )
          ]),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Image.asset("assets/img/paket.png",
          //     height: 40, width: 40, color: Colors.blue, fit: BoxFit.fill),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('Paket Semester 2 2020 SMP'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('Tagihan Rp.20.000'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text('Lunas',
                style: GoogleFonts.poppins(color: Colors.green, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
