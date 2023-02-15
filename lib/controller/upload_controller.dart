import 'dart:io';

import 'package:audio_flutter/model/audio_model.dart';
import 'package:audio_flutter/utils/config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadController {
  static Future<AudioModel?> uploadSong() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio
    );
    if (result != null) {
      File audiofile = File(result.paths.first ?? '');

      FirebaseStorage fs = FirebaseStorage.instance;

      Reference rootref = fs.ref();
      String audiofilename = audiofile.path.split('/').last;

      AppConfig.ShowLoading(notDisable: false);

      Reference audioFolderRef = rootref.child("files").child(audiofilename);

      String url;

      UploadTask uploadTask = audioFolderRef.putFile(audiofile);

      await uploadTask.whenComplete(() => true);

      Get.back();

      url = await audioFolderRef.getDownloadURL();

      return AudioModel(title: audiofilename, audioUrl: url);
    } else {
      return null;
    }
  }
}
