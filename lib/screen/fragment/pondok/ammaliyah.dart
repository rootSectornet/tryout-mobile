import 'dart:async';
import 'dart:io';
// import 'package:TesUjian/screen/fragment/soal/image_list_view.dart';
// import 'package:TesUjian/screen/fragment/soal/video_list_view.dart';
// import 'package:TesUjian/screen/fragment/soal/recorded_list_view.dart';
import 'package:TesUjian/screen/fragment/soal/recorder_view.dart';
import 'package:TesUjian/screen/fragment/soal/pick_image.dart';
import 'package:TesUjian/screen/fragment/soal/pick_video.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:html/dom.dart' as htmlParser;

import 'package:TesUjian/screen/fragment/loading.dart';
import 'package:TesUjian/screen/notfound.dart';
import 'package:TesUjian/src/model/soal.dart';
import 'package:TesUjian/src/presenter/soal.dart';
import 'package:TesUjian/src/state/soal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toast/toast.dart';

class AmmaliyahScreen extends StatefulWidget {
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;
  final int jenjang;

  const AmmaliyahScreen(
      {Key key, this.idtryoutdetail, this.idMatpel, this.matpel, this.jenjang})
      : super(key: key);
  @override
  _AmmaliyahScreenState createState() =>
      _AmmaliyahScreenState(idtryoutdetail, idMatpel, matpel);
}

class _AmmaliyahScreenState extends State<AmmaliyahScreen>
    implements SoalState {
  Directory appDirectory;
  Stream<FileSystemEntity> fileStream;
  List<String> records;
  List<String> pictures;
  List<String> videos;
  int status;
  int jepret;
  int rekam;
  int _totalDuration;
  int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  bool _isPlayingSoal = false;
  int _selectedIndex = -1;

  AudioPlayer _audioPlayerSoal = AudioPlayer();
  final int idtryoutdetail;
  final int idMatpel;
  final String matpel;
  // ignore: unused_field
  SoalModel _soalModel;
  SoalPresenter _soalPresenter;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _AmmaliyahScreenState(this.idtryoutdetail, this.idMatpel, this.matpel) {
    this._soalPresenter = new SoalPresenter();
  }

  @override
  // ignore: must_call_super
  void initState() {
    this.jepret = 0;
    print(widget.jenjang);
    this.rekam = 0;
    this._soalPresenter.view = this;
    this._soalPresenter.getSoalAmmaliyah(idMatpel);
    records = [];
    pictures = [];
    videos = [];
    getApplicationDocumentsDirectory().then((value) {
      appDirectory = value;
      appDirectory.list().listen((onData) {
        if (onData.path.endsWith(".aac")) {
          records.add(onData.path);
        }
        if (onData.path.endsWith(".jpg")) {
          pictures.add(onData.path);
        }
        if (onData.path.endsWith(".mp4")) {
          videos.add(onData.path);
        }
      }).onDone(() {
        records = records.reversed.toList();
        pictures = pictures.reversed.toList();
        videos = videos.reversed.toList();
      });
    });
  }

  @override
  void dispose() {
    fileStream = null;
    appDirectory = null;
    records = null;
    pictures = null;
    videos = null;
    super.dispose();
  }

  Future<void> deleteFileRec(String filePath) async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
        print('keapus');
        setState(() {
          this
              ._soalModel
              .tryoutSoalPondok
              .data[this._soalModel.currentIndex]
              .jawabanUser = null;
        });

        _onDeleteRec();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFileVid(String filePath) async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
        print('keapus');
        setState(() {
          this
              ._soalModel
              .tryoutSoalPondok
              .data[this._soalModel.currentIndex]
              .jawabanUser = null;
        });

        _onDeleteVid();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFilePict(String filePath) async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
        print('keapus');
        setState(() {
          this
              ._soalModel
              .tryoutSoalPondok
              .data[this._soalModel.currentIndex]
              .jawabanUser = null;
        });

        _onDeletePict();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onPlay({@required String filePath, @required int index}) async {
    AudioPlayer audioPlayer = AudioPlayer();

    if (!_isPlaying) {
      // audioPlayer.play(filePath, isLocal: true);
      audioPlayer.play(filePath, isLocal: true);
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlaying = true;
      });

      audioPlayer.onPlayerCompletion.listen((_) {
        setState(() {
          _isPlaying = false;
          _completedPercentage = 0.0;
        });
      });
      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
        });
      });
    } else {
      _audioPlayerSoal.stop();
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlayingSoal = false;
      });
    }
  }

  Future<void> _onPlaySoal(
      {@required String filePath, @required int index}) async {
    print(filePath);
    if (!_isPlayingSoal) {
      int result =
          await _audioPlayerSoal.play('http://103.41.207.247:3000/' + filePath);
      print(result);
      print('hasil audio');
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlayingSoal = true;
      });

      _audioPlayerSoal.onPlayerCompletion.listen((_) {
        setState(() {
          _isPlayingSoal = false;
          _completedPercentage = 0.0;
        });
      });
      _audioPlayerSoal.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      _audioPlayerSoal.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
        });
      });
    } else {
      _audioPlayerSoal.stop();
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlayingSoal = false;
      });
    }
  }

  _onUdahVideo() {
    this._soalModel.status = 3;
  }

  _onTakePictComplete() {
    pictures.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".jpg")) {
        pictures.add(onData.path);
      }
    }).onDone(() {
      pictures.sort();
      pictures = pictures.reversed.toList();
      setState(() {
        this._soalModel.status = 2;
        this.jepret += 1;
      });
    });
  }

  _onDeleteRec() {
    records.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".aac")) {
        records.add(onData.path);
      }
    }).onDone(() {
      records.sort();
      records = records.reversed.toList();
      setState(() {
        this
            ._soalModel
            .tryoutSoalPondok
            .data[this._soalModel.currentIndex]
            .status = 0;
      });
    });
  }

  _onDeletePict() {
    pictures.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".jpg")) {
        pictures.add(onData.path);
      }
    }).onDone(() {
      pictures.sort();
      pictures = pictures.reversed.toList();
      setState(() {
        this
            ._soalModel
            .tryoutSoalPondok
            .data[this._soalModel.currentIndex]
            .status = 0;
      });
    });
  }

  _onDeleteVid() {
    videos.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".mp4")) {
        videos.add(onData.path);
      }
    }).onDone(() {
      videos.sort();
      videos = videos.reversed.toList();
      setState(() {
        this
            ._soalModel
            .tryoutSoalPondok
            .data[this._soalModel.currentIndex]
            .status = 0;
      });
    });
  }

  _onTakeVideoComplete() {
    pictures.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".mp4")) {
        videos.add(onData.path);
      }
    }).onDone(() {
      videos.sort();
      videos = videos.reversed.toList();
      setState(() {
        this._soalModel.status = 3;
        this.rekam += 1;
      });
    });
  }

  _onRecordDuplicate() {
    Toast.show("hapus dulu file sebelumnya :)", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('kamu yakin?'),
            content: new Text('kamu mau meninggalkan halaman?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: this._soalModel.isloading
            ? Loading()
            : this._soalModel.tryoutSoalPondok.data.length == 0
                ? NotFound(
                    errors: 'Soal Belum Siap',
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.69,
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff25509e),
                              Color(0xff25509e),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _scaffoldKey.currentState.openDrawer();
                                  },
                                  child: Icon(
                                    LineIcons.bars,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                RaisedButton(
                                  padding: EdgeInsets.all(1),
                                  color: Colors.transparent,
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.white, width: 2)),
                                  child: Text(
                                    'Kumpulkan',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("$matpel",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Color(0xffffffff)),
                                )),
                            Text(
                                "${this._soalModel.tryoutSoalPondok.data.length} Soal",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 12, color: Colors.white60))),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: this
                                      ._soalModel
                                      .tryoutSoalPondok
                                      .data
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  itemExtent: 30,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(1),
                                        color: this._soalModel.currentIndex ==
                                                    itemIndex ||
                                                this
                                                        ._soalModel
                                                        .tryoutSoalPondok
                                                        .data[itemIndex]
                                                        .jawabanUser !=
                                                    null
                                            ? Colors.white
                                            : Colors.transparent,
                                        onPressed: () {
                                          this
                                              ._soalPresenter
                                              .selected(itemIndex);
                                        },
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(
                                                color: Colors.white, width: 1)),
                                        child: Text(
                                          '${itemIndex + 1}',
                                          style: GoogleFonts.poppins(
                                            color: this
                                                            ._soalModel
                                                            .currentIndex ==
                                                        itemIndex ||
                                                    this
                                                            ._soalModel
                                                            .tryoutSoalPondok
                                                            .data[itemIndex]
                                                            .jawabanUser !=
                                                        null
                                                ? Colors.black
                                                : Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          padding: EdgeInsets.all(15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Html(
                                  data: htmlParser.DocumentFragment.html(this
                                          ._soalModel
                                          .tryoutSoalPondok
                                          .data[this._soalModel.currentIndex]
                                          .soal)
                                      .text,
                                  style: {
                                    "table": Style(
                                      backgroundColor: Color.fromARGB(
                                          0x50, 0xee, 0xee, 0xee),
                                    ),
                                    "tr": Style(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    "th": Style(
                                      padding: EdgeInsets.all(6),
                                      backgroundColor: Colors.grey,
                                    ),
                                    "td": Style(
                                      padding: EdgeInsets.all(6),
                                    ),
                                    "p": Style(
                                        fontFamily: 'serif',
                                        textAlign: TextAlign.justify),
                                  },
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                widget.jenjang == 16
                                    ? Container(
                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Column(
                                                  children:
                                                      records.map((value) {
                                                    if (value.endsWith(this
                                                            ._soalModel
                                                            .tryoutSoalPondok
                                                            .data[this
                                                                ._soalModel
                                                                .currentIndex]
                                                            .idTryoutDetailSoals
                                                            .toString() +
                                                        '.aac')) {
                                                      return ExpansionTile(
                                                        title: Text(
                                                            'Rekaman soal ${value.toString()}'),
                                                        // subtitle: Text(
                                                        //     _getDateFromFilePatah(filePath: widget.records.elementAt(i))),
                                                        onExpansionChanged:
                                                            ((newState) {
                                                          if (newState) {
                                                            setState(() {
                                                              _selectedIndex =
                                                                  0;
                                                            });
                                                          }
                                                        }),
                                                        children: [
                                                          Container(
                                                            height: 100,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                LinearProgressIndicator(
                                                                  minHeight: 5,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .green),
                                                                  value: _selectedIndex ==
                                                                          0
                                                                      ? _completedPercentage
                                                                      : 0,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    IconButton(
                                                                      icon: _selectedIndex ==
                                                                              0
                                                                          ? _isPlaying
                                                                              ? Icon(Icons.pause)
                                                                              : Icon(Icons.play_arrow)
                                                                          : Icon(Icons.play_arrow),
                                                                      onPressed: () => _onPlaySoal(
                                                                          filePath: this
                                                                              ._soalModel
                                                                              .tryoutSoalPondok
                                                                              .data[this._soalModel.currentIndex]
                                                                              .jawabanUser,
                                                                          index: 0),
                                                                    ),
                                                                    IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .delete),
                                                                      onPressed:
                                                                          () =>
                                                                              deleteFileRec(value),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Container();
                                                      //Return an empty Container for non-matching case
                                                    }
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                            this
                                                        ._soalModel
                                                        .tryoutSoalPondok
                                                        .data[this
                                                            ._soalModel
                                                            .currentIndex]
                                                        .status ==
                                                    0
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      // RecorderView(
                                                      //   onSaved:
                                                      //       onSuccessRecord,
                                                      //   onDuplicate:
                                                      //       _onRecordDuplicate,
                                                      //   number: this
                                                      //       ._soalModel
                                                      //       .tryoutSoalPondok
                                                      //       .data[this
                                                      //           ._soalModel
                                                      //           .currentIndex]
                                                      //       .idTryoutDetailSoals,
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 10,
                                                      // ),
                                                      // PickImage(
                                                      //   onSaved:
                                                      //       onSuccessTakePict,
                                                      //   onDuplicate:
                                                      //       _onRecordDuplicate,
                                                      //   number: this
                                                      //       ._soalModel
                                                      //       .tryoutSoalPondok
                                                      //       .data[this
                                                      //           ._soalModel
                                                      //           .currentIndex]
                                                      //       .idTryoutDetailSoals,
                                                      //   jepret: this.jepret,
                                                      // ),
                                                      // SizedBox(
                                                      //   height: 10,
                                                      // ),
                                                      PickVideo(
                                                        onSaved:
                                                            onSuccessTakeVid,
                                                        onDuplicate:
                                                            _onRecordDuplicate,
                                                        number: this
                                                            ._soalModel
                                                            .tryoutSoalPondok
                                                            .data[this
                                                                ._soalModel
                                                                .currentIndex]
                                                            .idTryoutDetailSoals,
                                                        rekam: this.rekam,
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Center(
                                              child: InkWell(
                                                splashColor: Color(0xff7474BF),
                                                onTap: () {
                                                  print(this
                                                      ._soalModel
                                                      .tryoutSoalPondok
                                                      .data[this
                                                          ._soalModel
                                                          .currentIndex]
                                                      .jawabanUser);
                                                  this._soalPresenter.submit();
                                                  // this
                                                  //             ._soalModel
                                                  //             .status ==
                                                  //         1
                                                  //     ? this
                                                  //         ._soalPresenter
                                                  //         .jawabVoice(
                                                  //             'test')
                                                  //     : this
                                                  //                 ._soalModel
                                                  //                 .status ==
                                                  //             2
                                                  //         ? this._soalPresenter.jawabGambar(
                                                  //             pictures,
                                                  //             this
                                                  //                 ._soalModel
                                                  //                 .tryoutSoalPondok
                                                  //                 .data[this
                                                  //                     ._soalModel
                                                  //                     .currentIndex]
                                                  //                 .idTryoutDetailSoals)
                                                  //         : this._soalModel.status ==
                                                  //                 3
                                                  //             ? this._soalPresenter.jawabVideo(
                                                  //                 videos,
                                                  //                 this
                                                  //                     ._soalModel
                                                  //                     .tryoutSoalPondok
                                                  //                     .data[this
                                                  //                         ._soalModel
                                                  //                         .currentIndex]
                                                  //                     .idTryoutDetailSoals)
                                                  //             : this.onError(
                                                  //                 'Cek Dulu Soal Dan Jawabannya :)');
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  height: 35,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.4,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            offset:
                                                                Offset(0, 28),
                                                            blurRadius: 40,
                                                            spreadRadius: -12)
                                                      ],
                                                      color: Color(0xff1d63dc),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                                  child: Center(
                                                    child: Text(
                                                      'Next',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        child: Text('test'),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
        drawer: Drawer(
          child: this._soalModel.isloading ||
                  this._soalModel.tryoutSoalPondok.data == null
              ? Loading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    DrawerHeader(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("$matpel",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Color(0xffffffff)),
                                )),
                            Text(
                                "${this._soalModel.tryoutSoalPondok.data.length} Soal",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 12, color: Colors.white60))),
                            SizedBox(
                              height: 35,
                            ),
                            RaisedButton(
                              padding: EdgeInsets.all(1),
                              color: Colors.transparent,
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Colors.white, width: 2)),
                              child: Text(
                                'Kumpulkan',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff25509e),
                            Color(0xff25509e),
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            shrinkWrap: true,
                            primary: true,
                            physics: ClampingScrollPhysics(),
                            itemCount:
                                this._soalModel.tryoutSoalPondok.data.length,
                            itemBuilder: (ctx, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4),
                                child: RaisedButton(
                                  padding: EdgeInsets.all(1),
                                  color: this._soalModel.currentIndex == index
                                      ? Color(0xff25509e)
                                      : Colors.grey,
                                  onPressed: () {
                                    this._soalPresenter.selected(index);
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          color: Colors.white, width: 1)),
                                  child: Text(
                                    '${index + 1}',
                                    style: GoogleFonts.poppins(
                                      color:
                                          this._soalModel.currentIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    print(error);
    Toast.show("$error", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  void onSuccess(String success) {
    Navigator.pop(context);
  }

  @override
  void refreshData(SoalModel soalModel) {
    setState(() {
      this._soalModel = soalModel;
      this._soalModel.status = 0;
    });
  }

  // ignore: unused_element
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Batal"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Kumpulkan"),
      onPressed: () {
        // print(this._soalModel.currentIndex);
        int totalSoal = this._soalModel.currentIndex + 1;
        print(totalSoal);
        records.clear();
        appDirectory.list().listen((onData) {
          if (onData.path.endsWith(".aac")) {
            deleteFileRec(onData.path);
          }
        }).onDone(() {
          records.sort();
          records = records.reversed.toList();
          setState(() {
            this._soalModel.status = 1;
          });
        });
        Navigator.pop(context);
        if (this
                ._soalModel
                .tryoutSoalPondok
                .data[this._soalModel.currentIndex]
                .status ==
            0) {
          this._soalPresenter.kumpulkan();
        } else {
          this._soalPresenter.kumpulkanFile();
        }
        Toast.show("Soal selesai :)", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        // if (this._soalModel.tryoutSoalPondok.data.length == totalSoal) {
        // } else {
        //   Navigator.pop(context);
        // }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Kumpulkan"),
      content: Text("Kamu sudah yakin sama semua jawaban kamu?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void onSuccessRecord(String fileNya) {
    records.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".aac")) {
        records.add(onData.path);
      }
    }).onDone(() {
      records.sort();
      records = records.reversed.toList();
      setState(() {
        this._soalModel.status = 1;
      });
    });
    this._soalPresenter.jawabFile(fileNya, 1);
  }

  @override
  void onSuccessTakePict(String fileNya) {
    pictures.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".jpg")) {
        pictures.add(onData.path);
      }
    }).onDone(() {
      pictures.sort();
      pictures = pictures.reversed.toList();
      setState(() {
        this._soalModel.status = 2;
        this.jepret += 1;
      });
    });
    this._soalPresenter.jawabFile(fileNya, 2);
  }

  @override
  void onSuccessTakeVid(String fileNya) {
    videos.clear();
    appDirectory.list().listen((onData) {
      if (onData.path.endsWith(".mp4")) {
        videos.add(onData.path);
      }
    }).onDone(() {
      videos.sort();
      videos = videos.reversed.toList();
      setState(() {
        this._soalModel.status = 3;
        this.rekam += 1;
      });
    });
    this._soalPresenter.jawabFile(fileNya, 3);
  }
}
