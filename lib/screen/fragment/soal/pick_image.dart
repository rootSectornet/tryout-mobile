import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/local.dart';

class PickImage extends StatefulWidget {
  final Function onSaved;
  final Function onDuplicate;
  final int number;
  final int jepret;

  const PickImage(
      {Key key,
      @required this.onSaved,
      this.onDuplicate,
      this.number,
      this.jepret})
      : super(key: key);
  @override
  _PickImageState createState() => _PickImageState();
}

enum RecordingState {
  UnSet,
  Set,
  Recording,
  Stopped,
}
LocalFileSystem fs = LocalFileSystem();
final picker = ImagePicker();
File _image;
String fileName;

class _PickImageState extends State<PickImage> {
  IconData _recordIcon = Icons.image;
  String _recordText = 'Click To Start';
  RecordingState _recordingState = RecordingState.UnSet;

  // Recorder properties
  FlutterAudioRecorder audioRecorder;

  @override
  void initState() {
    super.initState();

    FlutterAudioRecorder.hasPermissions.then((hasPermision) {
      if (hasPermision) {
        _recordingState = RecordingState.Set;
        _recordIcon = Icons.image;
        _recordText = 'Record';
      }
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.UnSet;
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
            var jepretan = widget.jepret - 1;

            Directory appDirectorys = await getApplicationDocumentsDirectory();
            String filePath = appDirectorys.path +
                '/' +
                jepretan.toString() +
                widget.number.toString() +
                '.jpg';
            File file = fs.file(filePath);
            if (await file.exists()) {
              print('double');
              print(jepretan);
              widget.onDuplicate();
              // Directory appDirectorys =
              //     await getApplicationDocumentsDirectory();
              // String filePaths =
              //     appDirectorys.path + '/' + widget.number.toString() + '.jpg';
              // File files = fs.file(filePaths);
              // if (await files.exists()) {
              //   print("A file already exists at the path :" + filePath);
              //   widget.onDuplicate();
              // } else if (!await file.parent.exists()) {
              //   print("The specified parent directory does not exist");
              // } else {
              //   // print(appDirectory);
              //   await _initJepret();
              //   widget.onSaved();
              // }
            } else if (!await file.parent.exists()) {
              print("The specified parent directory does not exist");
            } else {
              // print(appDirectory);
              await _initJepret();
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

  Future _initJepret() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 75);
    if (pickedFile != null) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      _image = File(pickedFile.path);

      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(
          dir, widget.jepret.toString() + widget.number.toString() + '.jpg');
      File images = _image.renameSync(newPath);
      print('NewPath: $newPath');
      print(images);

      File newImage = await images.copy(appDirectory.path +
          '/' +
          widget.jepret.toString() +
          widget.number.toString() +
          '.jpg');
      print('kloning: $newImage');
      setState(() {
        _image = null;
      });
      widget.onSaved();
    } else {
      print('No image selected.');
    }
  }
}
