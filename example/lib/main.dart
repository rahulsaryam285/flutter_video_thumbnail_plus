import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Platform messages are asynchronous, so we initialize in an async method.

  String? thumbnail;
  Uint8List? thumbanilBytes;

  Future<void> getVideoFile() async {
    if (kIsWeb) {
      final files = await FilePicker.platform.pickFiles();

      if (files != null && files.files.isNotEmpty) {
        thumbanilBytes = await FlutterVideoThumbnailPlus.thumbnailDataWeb(
            videoBytes: files.files.first.bytes ?? Uint8List(0));
      }
    } else {
      final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
      thumbnail = await FlutterVideoThumbnailPlus.thumbnailFile(
          video: file?.path ?? '');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  getVideoFile();
                },
                child: Text('Running on: \n$thumbnail'),
              ),
              if (thumbnail != null && !kIsWeb) ...[
                Image.file(
                  File(thumbnail ?? ''),
                  height: 200,
                ),
              ] else if (thumbanilBytes != null) ...[
                Image.memory(
                  thumbanilBytes ?? Uint8List(0),
                  height: 200,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
