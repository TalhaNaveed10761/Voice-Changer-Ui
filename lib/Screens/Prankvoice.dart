
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Prankvoice extends StatefulWidget {
  const Prankvoice({super.key});

  @override
  State<Prankvoice> createState() => _PrankvoiceState();
}

class _PrankvoiceState extends State<Prankvoice> {
  
  final List<Map<String, dynamic>> gridItems = [
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Group (3).svg',
      'text': 'Burp',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Layer 1.svg',
      'text': 'Poop',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Bee.svg',
      'text': 'Bee',
    },
    {
      'color': Color(0xFFE5D6FF),
      'image': 'assets/Horn.svg',
      'text': 'Horn',
    },
    {
      'color': Color(0xFFD6FFE1),
      'image': 'assets/Baby.svg',
      'text': 'Baby',
    },
    {
      'color': Color(0xFFFFF9D6),
      'image': 'assets/Alien.svg',
      'text': 'Alien',
    },
    {
      'color': Color(0xFFFFD6F1),
      'image': 'assets/Lion.svg',
      'text': 'Lion',
    },
    {
      'color': Color(0xFFD6FFFF),
      'image': 'assets/Dog.svg',
      'text': 'Dog',
    },
    {
      'color': Color(0xEEADFE6B),
      'image': 'assets/Rain.svg',
      'text': 'Rain',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Trimmer.svg',
      'text': 'Trimmer',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Dragon.svg',
      'text': 'Dragon',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Laugh.svg',
      'text': 'Laugh',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Cat.svg',
      'text': 'Cat',
    },{
      'color': Color(0xEEADFE6B),
      'image': 'assets/Frog.svg',
      'text': 'Frog',
    },{
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Helicopter.svg',
      'text': 'Helicopter',
    },{
      'color': Color(0xEEADFE6B),
      'image': 'assets/Duck.svg',
      'text': 'Duck',
    },{
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Oldman.svg',
      'text': 'Oldman',
    },{
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Fox.svg',
      'text': 'Fox',
    },
  ];
 

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
   // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pranks voice",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset("assets/Group 2.svg"),
          ),
        ],
      ),
    
      body: GridView.builder(
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
    );
  }
}