import 'dart:convert';
import 'dart:io';

import 'package:TesUjian/helper/getStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file/local.dart';
import 'package:TesUjian/helper/paths.dart';
import 'package:http/http.dart' as http;

class PickVideoAmmaliyah extends StatefulWidget {
  final Function onSaved;
  final Function onDuplicate;
  final int number;
  final int rekam;

  const PickVideoAmmaliyah(
      {Key key,
      @required this.onSaved,
      this.onDuplicate,
      this.number,
      this.rekam})
      : super(key: key);
  @override
  _PickVideoAmmaliyahState createState() => _PickVideoAmmaliyahState();
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

class _PickVideoAmmaliyahState extends State<PickVideoAmmaliyah> {
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
            var jepretan = widget.rekam - 1;

            Directory appDirectorys = await getApplicationDocumentsDirectory();
            String filePath = appDirectorys.path +
                '/' +
                jepretan.toString() +
                widget.number.toString() +
                '.mp4';
            File file = fs.file(filePath);
            if (await file.exists()) {
              print('double');
              print(jepretan);
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
      // Directory appDirectory = await getApplicationDocumentsDirectory();
      _video = File(pickedFile.path);

      String dir = path.dirname(pickedFile.path);
      String newPath = path.join(dir, widget.number.toString() + '.mp4');
      File images = _video.renameSync(newPath);
      print('NewPath: $newPath');
      print(images);

      // File newImage = await images.copy(appDirectory.path +
      //     '/' +
      //     widget.jepret.toString() +
      //     widget.number.toString() +
      //     '.jpg');
      // print('kloning: $newImage');
      setState(() {
        _video = null;
      });

      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${Paths.BASEURL}${Paths.PRAKTEKIBADAH_UPDATEJAWABAN}"),
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(http.MultipartFile('filename',
          File(newPath).readAsBytes().asStream(), File(newPath).lengthSync(),
          filename: 'Ammaliyah' +
              GetStorage().read(ID_MURID).toString() +
              newPath.split("/").last));
      request.headers.addAll(headers);
      request.fields.addAll({
        "id": widget.number.toString(),
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        // final respStr = await response.stream.bytesToString();
        // var hasil = json.decode(respStr);
        // print(hasil['data']);
        return widget.onSaved('Ammaliyah' +
            GetStorage().read(ID_MURID).toString() +
            newPath.split("/").last);
      }
    } else {
      print('No video selected.');
    }
  }
}
