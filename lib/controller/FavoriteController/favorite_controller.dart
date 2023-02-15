import 'package:get/get.dart';

import '../../model/audio_model.dart';
import '../../services/firebase_service.dart';

class FavoriteController extends GetxController {
  var favList = <AudioModel>[].obs;
  var isNull = true.obs;

  fetchAudio() async {
    var res = await FirebaseService.fetchAudio();

    if (res != null) {
      isNull(false);
      favList.value = res.where((element) => element.isFav == true).toList();
    } else {
      isNull(false);
    }
  }
}
