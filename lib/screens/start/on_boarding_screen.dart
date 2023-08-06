import 'package:flutter/material.dart';
import 'package:habit_project/screens/start/intro_screens/intropage_1.dart';
import 'package:habit_project/screens/start/intro_screens/intropage_2.dart';
import 'package:habit_project/screens/start/screen_first.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 1);
              });
            },
            children: const [
              IntroPageOne(),
              IntroPageTwo(),
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.95),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        pageController.jumpToPage(1);
                      },
                      child: const Text('skip')),
                  SmoothPageIndicator(controller: pageController, count: 2),
                  onLastPage
                      ? TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const FirstPage();
                              }),
                            );
                          },
                          child: const Text('Done'))
                      : TextButton(
                          onPressed: () {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: const Text('next')),
                ],
              ))
        ],
      ),
    );
  }
}
