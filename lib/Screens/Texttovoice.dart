import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/Voices.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Texttovoice extends StatefulWidget {

  const Texttovoice({super.key});

  @override
  State<Texttovoice> createState() => _TexttovoiceState();
}

class _TexttovoiceState extends State<Texttovoice> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    initTts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.addScopedWillPopCallback(_onWillPop);
    });
  }

  @override
  void dispose() {
    textController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    flutterTts.stop();
    setState(() {
      textController.clear();
      isProcessing = false;
    });
    return true;
  }

  Future<void> initTts() async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    flutterTts.setCompletionHandler(() {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    });
  }

  Future<void> speakAndNavigate() async {
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        isProcessing = true;
      });

      
      await flutterTts.speak(text);

      
      flutterTts.setCompletionHandler(() {
        if (mounted) {
          setState(() {
            isProcessing = false;
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Voices(spokenText: text),
            ),
          ).then((_) {
            
            setState(() {
              textController.clear();
              isProcessing = false;
            });
            flutterTts.stop();
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter some text to convert"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Text to Voice",
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                controller: textController,
                maxLines: 8,
                decoration: InputDecoration(
                  fillColor: Color(0xFFF7D7FF),
                  filled: true,
                  hintText: "Start From Here",
                 
                  hintStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFC6AECC), width: 2),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: isProcessing ? null : speakAndNavigate,
              child: Container(
                height: height * 0.08,
                width: width,
                decoration: BoxDecoration(
                  color: isProcessing ? Color(0xFFD3A0E3) : Color(0xFFEEADFE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: isProcessing
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(strokeWidth: 2, color: Colors.black54),
                            SizedBox(width: 10),
                            Text("Converting...", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        )
                      : Text("Next", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
