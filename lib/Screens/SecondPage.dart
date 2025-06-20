import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
   // final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Stack(
                    children: [
                        SvgPicture.asset("assets/Vector(6).svg"),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: SvgPicture.asset("assets/Group(1).svg")),
                            
                    ],
                ),
                SizedBox(height: height*0.05,),
                Text("Text to Audio",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                ),),
                 Text("Transforn your text into lively audio",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                ),),
                 Text("with unique voices and effects!",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                ),)
            ],
        ),
    );
  }
}