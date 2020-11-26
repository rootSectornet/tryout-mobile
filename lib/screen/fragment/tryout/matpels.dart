import 'package:SoalOnline/parent/tryout.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class TryoutMatpelsScreen extends StatefulWidget {
  @override
  _TryoutMatpelsScreenState createState() => _TryoutMatpelsScreenState();
}

class _TryoutMatpelsScreenState extends State<TryoutMatpelsScreen> {
  @override
  Widget build(BuildContext context) {
    final data = TryoutParent.of(context).tryoutModel;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        color: Color(0xffecedf2),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.tryoutDetailResponse.data.length,
        primary: true,
        itemBuilder: (BuildContext context, int index) {
          int sisa = data.tryoutDetailResponse.data[index].jumlahSoal -
              (data.tryoutDetailResponse.data[index].totalBenar +
                  data.tryoutDetailResponse.data[index].totalSalah);
          double progress = (MediaQuery.of(context).size.width /
                  data.tryoutDetailResponse.data[index].jumlahSoal) *
              5;
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${data.tryoutDetailResponse.data[index].jumlahSoal}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 38,
                                  color: Color(0xff1f1f1f),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "Soal",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12, color: Color(0xff1f1f1f)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "${data.tryoutDetailResponse.data[index].nama}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14, color: Color(0xff1f1f1f)),
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.checkmark_circle,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    "${data.tryoutDetailResponse.data[index].totalBenar}",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff2b2b2b)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.close_circle,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "${data.tryoutDetailResponse.data[index].totalSalah}",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff2b2b2b)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.remove_circle,
                                    size: 14,
                                    color: Color(0xff303030),
                                  ),
                                  Text(
                                    "$sisa",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff2b2b2b)),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Ionicons.chevron_forward,
                      size: 24,
                      color: Color(0xffe5e5e5),
                    )
                  ],
                ),
                Container(
                  width: 40,
                  margin: EdgeInsets.only(left: 10),
                  height: 3,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
