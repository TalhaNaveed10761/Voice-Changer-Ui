import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/Resuablelanguage.dart';
import 'package:flutter_svg/svg.dart';

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  Widget build(BuildContext context) {
     final height=MediaQuery.of(context).size.height;
     
    return Scaffold(
       appBar: AppBar(
        title: const Text(
          "Language",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset("assets/Group 2.svg"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Resuablelanguage(imagePath: "assets/Group (4).svg", text: "English", onTap: () {
              
            },),
             SizedBox(
            height: height*0.03,
          ),
          Resuablelanguage(imagePath: "assets/emojione_flag-for-pakistan.svg", text: "Urdu", onTap: () {
              
            },),
             SizedBox(
            height: height*0.03,
          ),
          Resuablelanguage(imagePath: "assets/emojione_flag-for-turkey.svg", text: "Turkey", onTap: () {
              
            },),
             SizedBox(
            height: height*0.03,
          ),
          Resuablelanguage(imagePath: "assets/emojione_flag-for-germany.svg", text: "German", onTap: () {
              
            },),
             SizedBox(
            height: height*0.03,
          ),
          Resuablelanguage(imagePath: "assets/flag_10601048 1.svg", text: "Spanish", onTap: () {
              
            },),
             SizedBox(
            height: height*0.03,
          ),
          Resuablelanguage(imagePath: "assets/south-korea_9906519 1.svg", text: "Korean", onTap: () {
              
            },),
             SizedBox(
            height: height*0.03,
          ),
          ],
        ),
      ),
    );
  }
}