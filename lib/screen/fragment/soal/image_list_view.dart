// import 'dart:io';

// import 'package:TesUjian/src/model/soal.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class ImageListView extends StatefulWidget {
//   final List<String> pictures;
//   final Function onSaved;
//   final Function onDelete;
//   final Function onUdah;
//   final int number;
//   final bool status;
//   const ImageListView(
//       {Key key,
//       this.pictures,
//       this.number,
//       @required this.onSaved,
//       this.onDelete,
//       this.onUdah,
//       this.status})
//       : super(key: key);

//   @override
//   _ImageListViewState createState() => _ImageListViewState();
// }

// class _ImageListViewState extends State<ImageListView> {
//   SoalModel _soalModel;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: widget.pictures.map((value) {
//         //   return Text(value);
//         // }).toList(),
//         if (value.endsWith(widget.number.toString() + '.jpg')) {
//           this._soalModel.status = 2;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                 alignment: Alignment.center, // This is needed
//                 child: Image.file(
//                   File(value),
//                   width: 170,
//                   height: 170,
//                   fit: BoxFit.fitHeight,
//                 ),
//               ),
//               ButtonTheme(
//                 buttonColor: Colors.red,
//                 minWidth: 40.0,
//                 height: 30.0,
//                 child: widget.status == true
//                     ? Container()
//                     : RaisedButton(
//                         onPressed: () => deleteFile(value),
//                         child: Icon(
//                           Icons.delete,
//                           size: 18,
//                         ),
//                       ),
//               ),
//             ],
//           );
//         } else {
//           return Container();
//           //Return an empty Container for non-matching case
//         }
//       }).toList(),
//     );
//   }

//   Future<void> deleteFile(String filePath) async {
//     try {
//       var file = File(filePath);

//       if (await file.exists()) {
//         // file exits, it is safe to call delete on it
//         await file.delete();
//         print('keapus');

//         widget.onDelete();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
