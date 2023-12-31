import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../functions/hive_functions/db_start.dart';
import '../../main.dart';
import '../screen_home.dart';
import 'on_boarding_screen.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    getallDatas(); 
    _controller = VideoPlayerController.asset('lib/assets/videos/splash.mp4')
      ..initialize().then((value) {
        setState(() {});
      })
      ..setVolume(0);
    _playVideo();
  }

  void _playVideo() async {
    await _controller.play();

    await Future.delayed(const Duration(seconds: 3));
    checkUserSignedUp();
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            Text('My Habits',
                style: GoogleFonts.acme(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))
          ],
        ));
  }

  Future<void> checkUserSignedUp() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _sharedPrefs = await SharedPreferences.getInstance();
    // ignore: no_leading_underscores_for_local_identifiers
    final _userSignedUp = _sharedPrefs.getBool(save_key_name);
    if (_userSignedUp == null || _userSignedUp == false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()), 
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }
 
}
