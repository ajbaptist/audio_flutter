import 'package:audio_flutter/controller/HomeScreenController/home_controller.dart';
import 'package:audio_flutter/controller/upload_controller.dart';
import 'package:audio_flutter/services/firebase_service.dart';
import 'package:audio_flutter/view/screens/favorite.dart';
import 'package:audio_flutter/view/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  var select = 0;

  var screen = <Widget>[const Home(), const FavoriteScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen.elementAt(select),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final val = await UploadController.uploadSong();

          if (val != null && Get.isRegistered<HomeController>()) {
            await FirebaseService.uploadSongs(val);

            HomeController controller = Get.find();

            controller.fetchAudio();
          }
        },
        child: const Icon(Icons.cloud_upload),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: select,
        onDestinationSelected: (value) => setState(() {
          select = value;
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}
