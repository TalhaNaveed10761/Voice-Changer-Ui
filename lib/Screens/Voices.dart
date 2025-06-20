import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/Backdrop.dart';
import 'package:flutter_application_29/Screens/EffectSound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Voices extends StatefulWidget {
  final String spokenText;
  const Voices({super.key, required this.spokenText});

  @override
  State<Voices> createState() => _VoicesState();
}

class _VoicesState extends State<Voices> with TickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late TabController _tabController;
  Timer? _timer;

  double pitch = 1.0;
  double rate = 0.5;
  double volume = 1.0;
  double progress = 0.0;
  int estimatedDuration = 1;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    initTts();
    estimateSpeechDuration();
  }

  Future<void> initTts() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);

    flutterTts.setCompletionHandler(() {
      if (mounted) {
        _stopSpeech();
      }
    });

    flutterTts.setErrorHandler((message) {
      if (mounted) {
        _stopSpeech();
      }
    });
  }


  void estimateSpeechDuration() {
    setState(() {
      estimatedDuration = (widget.spokenText.length * 70 ~/ rate).clamp(500, 15000);
    });
  }

  Future<void> playWithEffects() async {
    if (widget.spokenText.isNotEmpty) {
      setState(() {
        isPlaying = true;
        progress = 0.0;
      });

      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {
          progress += 100 / estimatedDuration;
          if (progress >= 1.0) {
            progress = 1.0;
            _timer?.cancel();
          }
        });
      });

      await flutterTts.speak(widget.spokenText);
    }
  }

  void _stopSpeech() {
    _timer?.cancel();
    setState(() {
      isPlaying = false;
      progress = 0.0; 
    });
  }

  Future<void> stopVoice() async {
    await flutterTts.stop();
    _stopSpeech();
  }

  @override
  void dispose() {
    _tabController.dispose();
    flutterTts.stop();
    _timer?.cancel();
    super.dispose();
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
      body: Column(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 30,
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          stopVoice();
                        } else {
                          playWithEffects();
                        }
                      },
                    ),
                    Expanded(
                      child: Slider(
                        value: progress,
                        min: 0.0,
                        max: 1.0,
                        activeColor: Color(0xFFEEADFE),
                        inactiveColor: Color(0xFFACAAAA),
                        onChanged: (_) {}, 
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            height: height * 0.07,
            width: width,
            decoration: const BoxDecoration(color: Color(0xFFF7D7FF)),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "Effects Sound"),
                Tab(text: "Backdrop Sound"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Effectsound(),
                Backdrop(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
