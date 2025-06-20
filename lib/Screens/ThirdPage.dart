import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
   // final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Stack(
                    children: [
                        SvgPicture.asset("assets/Vector (7).svg"),
                        Positioned(
                            top: 50,
                            left: 40,
                            
                            child: SvgPicture.asset("assets/Group47843.svg")),
                            
                    ],
                ),
                SizedBox(height: height*0.05,),
                Text("Playfull prank voice",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                ),),
                 Text("play pre-recorded prank voices to",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                ),),
                 Text("trick and amuse your friends!",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                ),)
            ],
        ),
    );
  }
}