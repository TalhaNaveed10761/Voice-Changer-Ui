import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/Prankvoice.dart';
import 'package:flutter_application_29/Screens/RecordVoice.dart';
import 'package:flutter_application_29/Screens/Setting.dart';
import 'package:flutter_application_29/Screens/Texttovoice.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioVoiceChanger extends StatefulWidget {
  const AudioVoiceChanger({super.key});

  @override
  State<AudioVoiceChanger> createState() => _AudioVoiceChangerState();
}

class _AudioVoiceChangerState extends State<AudioVoiceChanger> {
  @override
  Widget build(BuildContext context) {
     final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Voice Changer",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset("assets/Group 2.svg"),
          ),
           Padding(
             padding:  EdgeInsets.only(right: 20),
             child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting(),));
              },
              child: SvgPicture.asset("assets/Group (2).svg")),
           )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/OBJECTS.svg"),
            SizedBox(
              height: height*0.1,
            ),
            GestureDetector(
              onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RecordVoice(),));
              },
              child: Container(
                height: height*0.2,
                        
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xFFEEADFE),
                  borderRadius: BorderRadius.circular(10),
                  
                  
                ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Record voice",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),),
                      Text("& Effects",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),),
                       Text("Lets try it now",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),)
                    ],
                  ),
                  Stack(
                    children: [
                      SvgPicture.asset("assets/Union.svg"),
              
                      Positioned(
                        top: 50,
                        left: 105,
                        child: SvgPicture.asset("assets/Microphone.svg"))
                    ],
                  )
                  
                ],
               ),
               
              ),
            ),
            SizedBox(
              height: height*0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Texttovoice(),));
                  },
                   child: Container(
                                 height: height*0.2,
                             
                                 width: width*0.42,
                                 decoration: BoxDecoration(
                                   color: Color(0xFFC1E0FF),
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                  child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                    Container(
                      height: height*0.08,
                    
                      width:width*0.15,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFF85),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(child: SvgPicture.asset("assets/Group 47863.svg")),
                    ),
                    SizedBox(
                      height: height*0.01,
                    ),
                    Text("Text to voice",style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),)
                                   ],
                                 ),
                               ),
                 ),
             GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Prankvoice(),));
              },
               child: Container(
                height: height*0.2,
                         
                width: width*0.42,
                decoration: BoxDecoration(
                  color: Color(0xFFCFF0D2),
                  borderRadius: BorderRadius.circular(10)
                ),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height*0.08,
                    
                      width:width*0.15,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFF69),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(child: SvgPicture.asset("assets/Vector (8).svg")),
                    ),
                     SizedBox(
                      height: height*0.01,
                    ),
                    Text("Pranks voice",style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),)
                  ],
                ),
                           ),
             ),
              ],
            )
          ],
        ),
      ),
    );
  }
}