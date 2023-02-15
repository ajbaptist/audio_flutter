import 'dart:convert';

import 'package:audio_flutter/model/audio_model.dart';

import 'package:audio_flutter/utils/constant.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  var client = http.Client();

  static Future<List<AudioModel>?> uploadSongs(AudioModel audio) async {
    const url = '${Constant.url}/audio.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'title': audio.title,
          'audioUrl': audio.audioUrl,
          'isFav': audio.isFav,
        }),
      );

      if (response.statusCode != 404) {
        return null;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  static Future<List<AudioModel>?> fetchAudio() async {
    const url = '${Constant.url}/audio.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 404) {
        var list = jsonDecode(response.body);

        var audioData = <AudioModel>[];

        list.forEach((prodid, data) async {
          audioData.add(AudioModel(
            id: prodid,
            audioUrl: data['audioUrl'],
            title: data['title'],
            isFav: data['isFav'],
          ));
        });

        return audioData;
      } else {
        return null;
      }
    } catch (error) {
      // print('sss');
      return null;
    }
  }

  static Future addToFav(AudioModel audioModel) async {
    var url =
        'https://flutter-audio-fc1ba-default-rtdb.firebaseio.com/audio/${audioModel.id}.json';
 

    final res = await http.patch(Uri.parse(url),
        body: json.encode({
          'id': audioModel.id,
          'title': audioModel.title,
          'audioUrl': audioModel.audioUrl,
          'isFav': !(audioModel.isFav),
        }));

    print('add fac==>${res.body}');

    return null;
  }
}
