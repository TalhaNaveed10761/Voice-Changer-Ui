import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Backdrop extends StatefulWidget {
  const Backdrop({super.key});

  @override
  State<Backdrop> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> {
  final List<Map<String, dynamic>> gridItems = [
    {
      'color':  Color(0xEEADFE6B),
      'image': 'assets/None.svg',
      'text': 'None',
    },
    {
      'color':  Color(0xC1E0FFB2),
      'image': 'assets/Rain (2).svg',
      'text': 'Rain',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Train (2).svg',
      'text': 'Train',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Sea.svg',
      'text': 'Sea',
    },
    {
      'color': Color(0xEEADFE6B),
      'image': 'assets/Wind.svg',
      'text': 'Wind',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Bar.svg',
      'text': 'Bar Noise',
    },
    {
      'color': Color(0xEEADFE6B),
      'image': 'assets/Alarm.svg',
      'text': 'Alarm',
    },
    {
      'color': Color(0xFFD6FFFF),
      'image': 'assets/Forest (2).svg',
      'text': 'Forest',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Children.svg',
      'text': 'Children',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.99,
              crossAxisSpacing: 20,
              mainAxisSpacing: 18,
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                
                  print("Tapped on ${gridItems[index]['text']}");
                },
                child: Container(
                 
                  decoration: BoxDecoration(
                    color: gridItems[index]['color'],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        gridItems[index]['image'],
                       
                        placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(10),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: height*0.01,
                      ),
                      Text(
                        gridItems[index]['text'],
                       
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 15,
            left: 15,
            right: 15,
            child: Container(
                  height: height*0.07,
                           
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEADFE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Save",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}