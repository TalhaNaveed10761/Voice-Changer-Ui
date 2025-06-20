import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Firstpage extends StatelessWidget {
  const Firstpage({super.key});

  @override
  Widget build(BuildContext context) {
     final height=MediaQuery.of(context).size.height;
    //final width=MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Stack(
                    children: [
                        SvgPicture.asset("assets/Vector(4).svg"),
                        Positioned(
                            top: 50,
                            left: 50,
                            child: SvgPicture.asset("assets/Character.svg")),
                            Positioned(
                                right: 20,
                                top: 20,
                                child: SvgPicture.asset("assets/Device.svg"))
                    ],
                ),
                SizedBox(height: height*0.05,),
                Text("Audio Voice Changer",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                ),),
                 Text("Transforn your Voice in fun and creative",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                ),),
                 Text("ways somthing totally unique!",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                ),)
            ],
        ),
    );
  }
}