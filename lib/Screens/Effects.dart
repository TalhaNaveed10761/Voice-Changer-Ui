
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/Backdrop.dart';
import 'package:flutter_application_29/Screens/EffectSound.dart';
import 'package:flutter_svg/svg.dart';

class Effects extends StatefulWidget {
  final String audioFilePath;
  
  const Effects({Key? key, required this.audioFilePath}) : super(key: key);

  @override
  State<Effects> createState() => _EffectsState();
}

class _EffectsState extends State<Effects> with SingleTickerProviderStateMixin {
  final _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
     _tabController = TabController(length: 2, vsync: this);
    _setupAudioPlayer();
   
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> _playAudio() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() => _isPlaying = false);
      } else {
        await _audioPlayer.play(DeviceFileSource(widget.audioFilePath));
        setState(() => _isPlaying = true);
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Effects",
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
      body: Column(
        children: [
          Text(
            "Your Recorded Voice",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "File: ${widget.audioFilePath.split('/').last}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: _playAudio,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEADFE),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            _isPlaying ? "Playing..." : "Tap to play",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: height * 0.03),
          Container(
            height: height * 0.07,
            width: width,
            decoration: BoxDecoration(color: Color(0xFFF7D7FF)),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "Effects Sound"),
                Tab(text: "Backdrop Sound"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Effectsound(),
                Backdrop()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
