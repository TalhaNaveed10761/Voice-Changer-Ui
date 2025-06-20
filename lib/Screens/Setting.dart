import 'package:flutter/material.dart';
import 'package:flutter_application_29/Resuable.dart';
import 'package:flutter_application_29/Screens/Creation.dart';
import 'package:flutter_application_29/Screens/Languages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';


class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
   final String appUrl = "https://play.google.com/store/apps/details?id=com.example.yourapp"; // Change this to your actual app link

  Future<void> _shareApp() async {
    final Uri url = Uri.parse(appUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $appUrl";
    }
  }
   final String privacyPolicyUrl = "https://yourwebsite.com/privacy-policy";

  Future<void> _openPrivacyPolicy() async {
    if (await canLaunchUrl(Uri.parse(privacyPolicyUrl))) {
      await launchUrl(Uri.parse(privacyPolicyUrl), mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $privacyPolicyUrl";
    }
  }
 final String androidAppId = "com.example.yourapp"; 
 
  Future<void> _rateApp() async {
    final Uri url = Uri.parse(
      "https://play.google.com/store/apps/details?id=$androidAppId", 
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

    
  @override
  Widget build(BuildContext context) {
     final height=MediaQuery.of(context).size.height;
   // final width=MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
       
        
        
        title: Text("Setting",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),),
        actions: [
           Padding(
             padding: const EdgeInsets.only(right: 15),
             child: SvgPicture.asset("assets/Group 2.svg"),
           ),
        ],
      ),
    
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 15,),
       child: Column(
        
        children: [
          CustomContainer(imagePath: "assets/Creation.svg", text: "My Creation",onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => Creation(),)); 
          },),
          SizedBox(
            height: height*0.03,
          ),
          CustomContainer(imagePath: "assets/Language.svg", text: "Language",onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Languages(),));
          },),
           SizedBox(
            height: height*0.03,
          ),
          CustomContainer(imagePath: "assets/upgrade.svg", text: "Upgrade to pro",onTap: () {
            
          },),
           SizedBox(
            height: height*0.03,
          ),
          CustomContainer(imagePath: "assets/Privacy.svg", text: "Privacy policy",onTap: () {
            _openPrivacyPolicy();
          },),
           SizedBox(
            height: height*0.03,
          ),
          CustomContainer(imagePath: "assets/Rateus.svg", text: "Rate us",onTap: () {
            _rateApp();
          },),
           SizedBox(
            height: height*0.03,
          ),
          CustomContainer(imagePath: "assets/Share.svg", text: "Share",onTap: () {
           _shareApp();
          },
          ),
          
       
        ],
       ),
     ),
    );
  }
}