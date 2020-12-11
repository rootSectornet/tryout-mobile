import 'package:SoalUjian/screen/pembahasan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class MatpelDoneScreen extends StatefulWidget {
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;

  const MatpelDoneScreen(
      {Key key, this.idtryoutdetail, this.idMatpel, this.matpel})
      : super(key: key);
  @override
  _MatpelDoneScreenState createState() => _MatpelDoneScreenState();
}

class _MatpelDoneScreenState extends State<MatpelDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Ionicons.arrow_back,
                  size: 32,
                  color: Color(0xff1f1f1f),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset("assets/img/done.png", fit: BoxFit.cover),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text("Sudah Selesai",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Color(0xff2b2b2b),
                        fontWeight: FontWeight.bold)),
              ),
              Center(
                child: Text(
                    "Kamu sudah mengerjakan semua soal di mata pelajaran ini",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0xff303030),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Color(0xff25509e),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Kerjakan Pelajaran yang Lain',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text("Atau",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Color(0xff303030),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PembahasanScreen(
                                idMatpel: widget.idMatpel,
                                idtryoutdetail: widget.idtryoutdetail,
                                matpel: widget.matpel,
                              )));
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xff25509e))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Center(
                    child: Text(
                      'Lihat Pembahasannya',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xff2b2b2b),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
