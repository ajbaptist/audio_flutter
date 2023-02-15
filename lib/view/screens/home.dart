import 'package:audio_flutter/controller/HomeScreenController/home_controller.dart';
import 'package:audio_flutter/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 

import '../../services/firebase_service.dart';
import '../../utils/config.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.fetchAudio();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Screen'),
      ),
      body: Obx(() {
        if (homeController.homeList.isNotEmpty &&
            homeController.isNull.isFalse) {
          return ListView.builder(
            itemCount: homeController.homeList.length,
            itemBuilder: (context, index) {
              var data = homeController.homeList[index];
              var isFav = data.isFav.obs;
              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 3.hp, vertical: 1.wp),
                leading: const Icon(Icons.music_note),
                title: Text(
                  data.title,
                  textAlign: TextAlign.start,
                ),
                trailing: GestureDetector(
                    onTap: () async {
                   
                       AppConfig.ShowLoading(notDisable: false);
                      await FirebaseService.addToFav(data);
                      Get.back();
                      homeController.fetchAudio();
                    },
                    child: isFav.isFalse
                        ? Icon(Icons.favorite)
                        : Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
              );
            },
          );
        }
        else if (homeController.homeList.isEmpty &&
            homeController.isNull.isFalse) {
          return const Center(child: Text('You Have No Song List'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
