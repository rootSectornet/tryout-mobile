import 'dart:io';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoListView extends StatefulWidget {
  final List<String> videos;
  final Function onSaved;
  final Function onUdah;
  final int number;
  final bool status;
  const VideoListView(
      {Key key,
      this.videos,
      this.number,
      @required this.onSaved,
      this.onUdah,
      this.status})
      : super(key: key);

  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.videos.map((value) {
        //   return Text(value);
        // }).toList(),
        if (value.endsWith(widget.number.toString() + '.mp4')) {
          widget.onUdah();
          return Column(
            children: [
              Text(value.split("/").last),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                buttonColor: Colors.red,
                minWidth: 40.0,
                height: 30.0,
                child: widget.status == true
                    ? Container()
                    : RaisedButton(
                        onPressed: () => deleteFile(value),
                        child: Icon(
                          Icons.delete,
                          size: 18,
                        ),
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

  Future<void> deleteFile(String filePath) async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
        print('keapus');

        widget.onSaved();
      }
    } catch (e) {
      print(e);
    }
  }
}
