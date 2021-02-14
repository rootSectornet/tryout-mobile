import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/local.dart';

class PickVideo extends StatefulWidget {
  final Function onSaved;
  final Function onDuplicate;
  final int number;
  final int rekam;

  const PickVideo(
      {Key key,
      @required this.onSaved,
      this.onDuplicate,
      this.number,
      this.rekam})
      : super(key: key);
  @override
  _PickVideoState createState() => _PickVideoState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}
LocalFileSystem fs = LocalFileSystem();
final picker = ImagePicker();
File _video;
String fileName;

class _PickVideoState extends State<PickVideo> {
  IconData _recordIcon = Icons.videocam;

  // Recorder properties
  FlutterAudioRecorder audioRecorder;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    audioRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RaisedButton(
          onPressed: () async {
            var rekaman = widget.rekam - 1;
            print(rekaman);
            Directory appDirectorys = await getApplicationDocumentsDirectory();
            String filePath =
                appDirectorys.path + '/' + widget.number.toString() + '.mp4';
            File file = fs.file(filePath);
            if (await file.exists()) {
              print('double');
              widget.onDuplicate();
            } else if (!await file.parent.exists()) {
              print("The specified parent directory does not exist");
            } else {
              // print(appDirectory);
              await _initRekam();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: 60,
            height: 50,
            child: Icon(
              _recordIcon,
              size: 20,
            ),
          ),
        ),
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Padding(
        //       child: Text(_recordText),
        //       padding: const EdgeInsets.all(8),
        //     ))
      ],
    );
  }

  Future<void> deleteFile(String filePath) async {
    try {
      var file = File(filePath);

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
        print('kepaus');

        widget.onSaved();
      }
    } catch (e) {
      print(e);
    }
  }

  Future _initRekam() async {
    final pickedFile = await picker.getVideo(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      _video = File(pickedFile.path);

      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(
          dir, widget.rekam.toString() + widget.number.toString() + '.mp4');
      File images = _video.renameSync(newPath);
      print('NewPath: $newPath');
      print(images);

      File newImage = await images.copy(appDirectory.path +
          '/' +
          widget.rekam.toString() +
          widget.number.toString() +
          '.mp4');
      print('kloning: $newImage');
      setState(() {
        _video = null;
      });
      widget.onSaved();
    } else {
      print('No image selected.');
    }
  }
}
