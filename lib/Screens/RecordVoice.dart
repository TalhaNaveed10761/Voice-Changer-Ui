import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/Effects.dart';
import 'package:flutter_application_29/Screens/Setting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordVoice extends StatefulWidget {
  const RecordVoice({super.key});

  @override
  State<RecordVoice> createState() => _RecordVoiceState();
}

class _RecordVoiceState extends State<RecordVoice> {
  final _audioRecorder = AudioRecorder();
  final _audioPlayer = AudioPlayer();
  String? _recordedFilePath;
  bool _isRecording = false;
  bool _isPlaying = false;
  bool _hasRecordedAudio = false;
  
  late RecorderController recorderController;

 @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
       _initializeRecorder();
    });
    _setupAudioPlayerListeners();
  }

  void _setupAudioPlayerListeners() {
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() => _isPlaying = false);
    });
  }

  void _initializeRecorder() async {
    try {
      final hasPermission = await _audioRecorder.hasPermission();
      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission not granted'))
        );
        return;
      }

      recorderController = RecorderController()
        ..androidEncoder = AndroidEncoder.aac
        ..androidOutputFormat = AndroidOutputFormat.mpeg4
        ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
        ..sampleRate = 44100
        ..bitRate = 128000;

      _recordedFilePath = null;
      _hasRecordedAudio = false;
      
      print('RecordVoice: Recorder initialized successfully');
    } catch (e) {
      print('RecordVoice: Error initializing recorder: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to initialize recorder: $e'))
      );
    }
  }


  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/original_voice.m4a'; // Use m4a instead of wav for better compatibility
        
        print('RecordVoice: Attempting to record to: $filePath');
        
     
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
          print('RecordVoice: Deleted existing file');
        }
        
       
        if (_isPlaying) {
          await _audioPlayer.stop();
          setState(() => _isPlaying = false);
        }

      
        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: filePath,
        );
        print('RecordVoice: Started recording with _audioRecorder');
        
        if (!recorderController.isRecording) {
          await recorderController.record();
          print('RecordVoice: Started recording with recorderController');
        }

        setState(() {
          _isRecording = true;
          _recordedFilePath = filePath;
          _hasRecordedAudio = false;
        });
      }
    } catch (e) {
      print('RecordVoice: Error recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error starting recording: $e'))
      );
      setState(() => _isRecording = false);
    }
  }

  Future<void> _stopRecording() async {
    try {
      if (_isRecording) {
        print('RecordVoice: Stopping recording');
        String? recordPath;
       
        if (await _audioRecorder.isRecording()) {
          recordPath = await _audioRecorder.stop();
          print("RecordVoice: Recording stopped, file at: $recordPath");
        }
        
        
        if (recorderController.isRecording) {
          final wavePath = await recorderController.stop();
          print("RecordVoice: Waveform recording stopped, file at: $wavePath");
        }
        
     
        if (recordPath != null) {
          _recordedFilePath = recordPath;
        }
        
        setState(() {
          _isRecording = false;
          _hasRecordedAudio = true;
        });
        
       
        if (_recordedFilePath != null) {
          final file = File(_recordedFilePath!);
          final exists = await file.exists();
          final size = exists ? await file.length() : 0;
          print("RecordVoice: Recorded file exists: $exists, size: $size bytes");
          
          if (exists && size > 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recording completed successfully'))
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Recording failed or file is empty'))
            );
            setState(() => _hasRecordedAudio = false);
          }
        }
      }
    } catch (e) {
      print('RecordVoice: Error stopping recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error stopping recording: $e'))
      );
      setState(() => _isRecording = false);
    }
  }

 Future<void> _resetRecording() async {
  if (!mounted) return;

  try {
    if (_isRecording) {
      await _stopRecording();
    }

    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    }

    if (_recordedFilePath != null) {
      final file = File(_recordedFilePath!);
      if (await file.exists()) {
        await file.delete();
        print("RecordVoice: Deleted recorded file: $_recordedFilePath");
      }
    }

    setState(() {
      _recordedFilePath = null;
      _hasRecordedAudio = false;
    });

    if (mounted) {
      Future.delayed(Duration(milliseconds: 500), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording reset')),
        );
      });
    }
  } catch (e) {
    print('RecordVoice: Error resetting recording: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error resetting: $e')),
      );
    }
  }
}


 Future<void> _saveRecording() async {
  if (_recordedFilePath == null || !_hasRecordedAudio) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No recording to save'))
    );
    return;
  }

  try {
    print('RecordVoice: Saving recording from: $_recordedFilePath');
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final savedFilePath = '${directory.path}/saved_voice_$timestamp.m4a';

   
    final sourceFile = File(_recordedFilePath!);
    if (!await sourceFile.exists()) {
      print("RecordVoice: Error: Source file doesn't exist at $_recordedFilePath");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recording file not found'))
      );
      return;
    }

    final fileSize = await sourceFile.length();
    if (fileSize == 0) {
      print("RecordVoice: Error: Source file is empty at $_recordedFilePath");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recording file is empty'))
      );
      return;
    }

   
    await sourceFile.copy(savedFilePath);
    print("RecordVoice: Saved recording to: $savedFilePath (size: $fileSize bytes)");

   
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Effects(audioFilePath: savedFilePath),
      ),
    ).then((_) {
      _resetRecording(); 
    });

  } catch (e) {
    print('RecordVoice: Error saving recording: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error saving: $e'))
    );
  }
}
  
  Future<void> _playRecording() async {
    if (_recordedFilePath == null || !_hasRecordedAudio) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No recording to play'))
      );
      return;
    }
    
    try {
      final file = File(_recordedFilePath!);
      if (!await file.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording file not found'))
        );
        return;
      }
      
      final fileSize = await file.length();
      if (fileSize == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recording file is empty'))
        );
        return;
      }
      
      if (_isPlaying) {
        await _audioPlayer.stop();
        setState(() => _isPlaying = false);
        print('RecordVoice: Stopped playback');
      } else {
        print('RecordVoice: Playing audio from: $_recordedFilePath');
        await _audioPlayer.play(DeviceFileSource(_recordedFilePath!));
        setState(() => _isPlaying = true);
      }
    } catch (e) {
      print('RecordVoice: Error playing recording: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error playing: $e'))
      );
    }
  }

  @override
  void dispose() {
    _stopRecording(); 
    recorderController.dispose();
    _audioPlayer.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Record voice & Effects",
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
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );
              },
              child: SvgPicture.asset("assets/Group (2).svg"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.3,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _isRecording
                ? AudioWaveforms(
                    enableGesture: true,
                    size: Size(width - 40, height * 0.3),
                    recorderController: recorderController,
                    waveStyle: WaveStyle(
                      waveColor: Color(0xFFEEADFE),
                      extendWaveform: true,
                      showMiddleLine: false,
                      spacing: 8.0,
                      waveThickness: 6,
                      showDurationLabel: false,
                    ),
                    backgroundColor: Colors.transparent,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _hasRecordedAudio 
                              ? 'Recording complete - ready to save' 
                              : 'Tap the microphone to start recording',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        if (_hasRecordedAudio) ...[
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: _playRecording,
                            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                            label: Text(_isPlaying ? 'Pause' : 'Play Recording'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFEEADFE),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Container(
            height: height * 0.25,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xFFFAE9FE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _resetRecording,
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEADFE),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: SvgPicture.asset("assets/Vector (10).svg"),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_isRecording) {
                          _stopRecording();
                        } else {
                          _startRecording();
                        }
                      },
                      child: Container(
                        height: height * 0.11,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEADFE),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            _isRecording
                                ? "assets/Pause.svg"
                                : "assets/Audio.svg",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      _isRecording ? 'Stop Recording' : 'Record Voice',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _saveRecording,
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                          color: _hasRecordedAudio ? Color(0xFFEEADFE) : Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: SvgPicture.asset("assets/Tick.svg"),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _hasRecordedAudio ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}