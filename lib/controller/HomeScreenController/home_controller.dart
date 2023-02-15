import 'package:audio_flutter/services/firebase_service.dart';
import 'package:get/get.dart';

import '../../model/audio_model.dart';

class HomeController extends GetxController {
  var homeList = <AudioModel>[].obs;
  var isNull = true.obs;

  fetchAudio() async {
    var res = await FirebaseService.fetchAudio();

    if (res != null) {
      isNull(false);
      homeList.value = res;
    }else{
       isNull(false);
    }
  }
}
