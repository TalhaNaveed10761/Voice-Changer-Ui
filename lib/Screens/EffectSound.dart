import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Effectsound extends StatefulWidget {
  const Effectsound({super.key});

  @override
  State<Effectsound> createState() => _EffectsoundState();
}

class _EffectsoundState extends State<Effectsound> {
   final List<Map<String, dynamic>> gridItems = [
    {
      'color':  Color(0xEEADFE6B),
      'image': 'assets/Normal.svg',
      'text': 'Normal',
    },
    {
      'color':  Color(0xC1E0FFB2),
      'image': 'assets/Fast.svg',
      'text': 'Fast',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Slow.svg',
      'text': 'Slow',
    },
    
   ];
    final List<Map<String, dynamic>> Items = [
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Man.svg',
      'text': 'Man',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Women.svg',
      'text': 'Women',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Boy.svg',
      'text': 'Boy',
    }, {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Girl.svg',
      'text': 'Girl',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Layer 1.svg',
      'text': 'Poop',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Baby (2).svg',
      'text': 'Baby',
    },
    ];
     final List<Map<String, dynamic>> grid = [
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Bee.svg',
      'text': 'Bee',
    },
    {
      'color': Color(0xCFF0D2B2),
      'image': 'assets/Cat.svg',
      'text': 'Cat',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Lion.svg',
      'text': 'Lion',
    },
     ];
     final List<Map<String, dynamic>> gridItem = [
    {
      'color':  Color(0xEEADFE6B),
      'image': 'assets/Zombie.svg',
      'text': 'Zombie',
    },
    {
      'color':  Color(0xC1E0FFB2),
      'image': 'assets/Alien.svg',
      'text': 'Alien',
    },
    {
      'color': Color(0xC1E0FFB2),
      'image': 'assets/Ghost.svg',
      'text': 'Ghost',
    },
     ];
     
    
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 15),
                  child: Text("Speech Sound",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                 GridView.builder(
                         padding: EdgeInsets.all(15),
                          physics: NeverScrollableScrollPhysics(), 
                  shrinkWrap: true,
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
                 
                 Padding(
                  padding: const EdgeInsets.only(left: 10,),
                  child: Text("Basic Sound",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                GridView.builder(
                         padding: EdgeInsets.all(15),
                          physics: NeverScrollableScrollPhysics(), 
                  shrinkWrap: true,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3,
                           childAspectRatio: 0.99,
                           crossAxisSpacing: 20,
                           mainAxisSpacing: 18,
                         ),
                         itemCount: Items.length,
                         itemBuilder: (context, index) {
                           return GestureDetector(
                  onTap: () {
                  
                    print("Tapped on ${Items[index]['text']}");
                  },
                  child: Container(
                   
                    decoration: BoxDecoration(
                      color: Items[index]['color'],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Items[index]['image'],
                          
                          placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(10),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: height*0.01,
                        ),
                        Text(
                          Items[index]['text'],
                         
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
                       Padding(
                  padding: const EdgeInsets.only(left: 10,),
                  child: Text("Animal Sound",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                GridView.builder(
                         padding: EdgeInsets.all(15),
                          physics: NeverScrollableScrollPhysics(), 
                  shrinkWrap: true,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3,
                           childAspectRatio: 0.99,
                           crossAxisSpacing: 20,
                           mainAxisSpacing: 18,
                         ),
                         itemCount: grid.length,
                         itemBuilder: (context, index) {
                           return GestureDetector(
                  onTap: () {
                  
                    print("Tapped on ${grid[index]['text']}");
                  },
                  child: Container(
                   
                    decoration: BoxDecoration(
                      color: grid[index]['color'],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          grid[index]['image'],
                          
                         
                          placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(10),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: height*0.01,
                        ),
                        Text(
                          grid[index]['text'],
                         
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
                      Padding(
                  padding: const EdgeInsets.only(left: 10,top: 15),
                  child: Text("Horror Sound",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                ),
                 GridView.builder(
                         padding: EdgeInsets.all(15),
                          physics: NeverScrollableScrollPhysics(), 
                  shrinkWrap: true,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3,
                           childAspectRatio: 0.99,
                           crossAxisSpacing: 20,
                           mainAxisSpacing: 18,
                         ),
                         itemCount: gridItem.length,
                         itemBuilder: (context, index) {
                           return GestureDetector(
                  onTap: () {
                  
                    print("Tapped on ${gridItem[index]['text']}");
                  },
                  child: Container(
                   
                    decoration: BoxDecoration(
                      color: gridItem[index]['color'],
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          gridItem[index]['image'],
                          
                         
                          placeholderBuilder: (BuildContext context) => Container(
                            padding: const EdgeInsets.all(10),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: height*0.01,
                        ),
                        Text(
                          gridItem[index]['text'],
                         
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
                   
              ],
            ),
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