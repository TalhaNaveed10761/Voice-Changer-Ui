import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/AudioVoiceChanger.dart';
import 'package:flutter_application_29/Screens/FirstPage.dart';
import 'package:flutter_application_29/Screens/SecondPage.dart';
import 'package:flutter_application_29/Screens/ThirdPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DotScreen extends StatefulWidget {
  const DotScreen({super.key});

  @override
  State<DotScreen> createState() => _DotScreenState();
}

class _DotScreenState extends State<DotScreen> {
  
  
  final PageController _pageController = PageController();

  
  int currentPage = 0;

  
  List<Widget> onboardingScreens = [
   Firstpage(),
   SecondPage(),
   ThirdPage()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingScreens.length,
                itemBuilder: (context, index) {
                  return onboardingScreens[index];
                },
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingScreens.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    dotColor: Color(0xFFC9C6CA),
                    activeDotColor: Color(0xFFEEADFE),
                  ),
                ),
                 GestureDetector(
                  onTap: () {
                    if (currentPage == onboardingScreens.length - 1) {
                     
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => AudioVoiceChanger()),
                      );
                    } else {
                     
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: currentPage == onboardingScreens.length - 1
                      ? Container(
                          height: height * 0.05,
                          width: width * 0.15,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEADFE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Start",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      : Container(
                        height: height*0.05,
                      // height: 36.74,
                        width: width*0.1,
                        decoration: BoxDecoration(
                            color: Color(0xFFEEADFE),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        child: Center(
                          child: SvgPicture.asset(
                              "assets/Arrow.svg", 
                            ),
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



