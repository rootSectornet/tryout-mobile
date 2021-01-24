import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RecordListView extends StatefulWidget {
  final List<String> records;
  final Function onSaved;
  final int number;
  final bool status;
  const RecordListView(
      {Key key, this.records, this.number, @required this.onSaved, this.status})
      : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  int _totalDuration;
  int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.records.map((value) {
        if (value.endsWith(widget.number.toString() + '.aac')) {
          return ExpansionTile(
            title: Text('Rekaman soal ${value.toString()}'),
            // subtitle: Text(
            //     _getDateFromFilePatah(filePath: widget.records.elementAt(i))),
            onExpansionChanged: ((newState) {
              if (newState) {
                setState(() {
                  _selectedIndex = 0;
                });
              }
            }),
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      value: _selectedIndex == 0 ? _completedPercentage : 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: _selectedIndex == 0
                              ? _isPlaying
                                  ? Icon(Icons.pause)
                                  : Icon(Icons.play_arrow)
                              : Icon(Icons.play_arrow),
                          onPressed: () => _onPlay(filePath: value, index: 0),
                        ),
                        widget.status == true
                            ? Container()
                            : IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deleteFile(value),
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
    );
  }

  // ListView.builder(
  //     itemCount: widget.records.length,
  //     shrinkWrap: true,
  //     reverse: true,
  //     itemBuilder: (BuildContext context, int i) {
  //       return ExpansionTile(
  //         title: Text('Rekaman soal ${widget.records.length - i}'),
  //         // subtitle: Text(
  //         //     _getDateFromFilePatah(filePath: widget.records.elementAt(i))),
  //         onExpansionChanged: ((newState) {
  //           if (newState) {
  //             setState(() {
  //               _selectedIndex = i;
  //             });
  //           }
  //         }),
  //         children: [
  //           Container(
  //             height: 100,
  //             padding: const EdgeInsets.all(10),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 LinearProgressIndicator(
  //                   minHeight: 5,
  //                   backgroundColor: Colors.black,
  //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
  //                   value: _selectedIndex == i ? _completedPercentage : 0,
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     IconButton(
  //                       icon: _selectedIndex == i
  //                           ? _isPlaying
  //                               ? Icon(Icons.pause)
  //                               : Icon(Icons.play_arrow)
  //                           : Icon(Icons.play_arrow),
  //                       onPressed: () => _onPlay(
  //                           filePath: widget.records.elementAt(i), index: i),
  //                     ),
  //                     IconButton(
  //                       icon: Icon(Icons.delete),
  //                       onPressed: () =>
  //                           deleteFile(widget.records.elementAt(i)),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  Future<void> deleteFile(String filePath) async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();

        widget.onSaved();
      }
    } catch (e) {
      // error in getting access to the file
    }
  }

  Future<void> _onPlay({@required String filePath, @required int index}) async {
    AudioPlayer audioPlayer = AudioPlayer();

    if (!_isPlaying) {
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
    }
  }

  // String _getDateFromFilePatah({@required String filePath}) {
  //   print(filePath);
  //   String fromEpoch = filePath.substring(
  //       filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

  //   DateTime recordedDate =
  //       DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));
  //   int year = recordedDate.year;
  //   int month = recordedDate.month;
  //   int day = recordedDate.day;

  //   return ('$year-$month-$day');
  // }
}
