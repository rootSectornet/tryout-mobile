import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SoalOnline/src/resources/session.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String nama = "";
  String _valGender;
  List _listGender = ["Laki - Laki", "Perempuan"];
  String _valSekolah;
  List _listSekolah = ["SMP 192", "SMA 81"];
  final formKey = GlobalKey<FormState>();
  void getName() {
    Session.getName().then((value) {
      setState(() {
        this.nama = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.getName();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Icon(LineIcons.arrow_left),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Ubah Profile',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(1),
                          color: Colors.grey,
                          disabledColor: Colors.red,
                          onPressed: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.clear();
                            Navigator.pushNamed(context, "/");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            'Simpan',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            Expanded(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              color: Color(0xffecedf2),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 80,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff2D8EFF),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: ExactAssetImage(
                                            "assets/img/download.png",
                                          )))),
                              SizedBox(
                                width: 20,
                              ),
                              Material(
                                child: InkWell(
                                  child: Text("Perbarui Foto Profile",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      )),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text('Nama Lengkap'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              initialValue: "Tedi",
                              // onChanged: (String nama) {},
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          Text('Email'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              initialValue: "Tedi@gmail.com",
                              // onChanged: (String nama) {},
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          Text('Nomer Telepon'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: "081317718282",
                              // onChanged: (String nama) {},
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 30,
                              margin: EdgeInsets.only(
                                  top: 1, left: 16, bottom: 1, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // border: Border(
                                //   bottom: BorderSide(
                                //       width: 1, color: Color(0xff2D8EFF)),
                                // )
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Pilih Gender"),
                                  value: _valGender,
                                  items: _listGender.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valGender = value;
                                    });
                                  },
                                ),
                              )),
                          Divider(),
                          Text('Alamat'),
                          Padding(
                            padding: EdgeInsets.all(1),
                            child: TextFormField(
                              initialValue: "Jl raya kodau",
                              // onChanged: (String nama) {},
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none),
                            ),
                          ),
                          Divider(),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              // height: 30,
                              margin: EdgeInsets.only(
                                  top: 1, left: 16, bottom: 1, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                // border: Border(
                                //   bottom: BorderSide(
                                //       width: 1, color: Color(0xff2D8EFF)),
                                // )
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Pilih Sekolah tujuan"),
                                  value: _valSekolah,
                                  items: _listSekolah.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _valSekolah = value;
                                    });
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
