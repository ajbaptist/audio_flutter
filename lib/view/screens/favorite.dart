import 'package:audio_flutter/controller/FavoriteController/favorite_controller.dart';
import 'package:audio_flutter/services/firebase_service.dart';
import 'package:audio_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  void initState() {
    favoriteController.fetchAudio();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<FavoriteController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite Screen'),
      ),
      body: Obx(() {
        if (favoriteController.favList.isNotEmpty &&
            favoriteController.isNull.isFalse) {
          return ListView.builder(
            itemCount: favoriteController.favList.length,
            itemBuilder: (context, index) {
              var data = favoriteController.favList[index];

              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 3.hp, vertical: 1.wp),
                leading: const Icon(Icons.music_note),
                title: Text(
                  data.title,
                  textAlign: TextAlign.start,
                ),
              );
            },
          );
        } else if (favoriteController.favList.isEmpty &&
            favoriteController.isNull.isFalse) {
          return const Center(child: Text('You Have No Favorite'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
