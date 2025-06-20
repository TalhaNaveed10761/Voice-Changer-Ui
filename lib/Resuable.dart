import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;  

  const CustomContainer({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap, 
      child: Container(
        height: height * 0.085,
        width: width,
        decoration: BoxDecoration(
          color: Color(0xFFF9DDFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              SvgPicture.asset(imagePath),
              SizedBox(width: 10),  
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
