
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
class VoiceTransformerApp extends StatefulWidget {
  const VoiceTransformerApp({Key? key}) : super(key: key);
  @override
  State<VoiceTransformerApp> createState() => _VoiceTransformerAppState();
}
class _VoiceTransformerAppState extends State<VoiceTransformerApp> {
  final _audioRecorder = AudioRecorder();
  final _audioPlayer = AudioPlayer();
  String? _recordedFilePath;
  String? _transformedFilePath;
  bool _isRecording = false;
  bool _isProcessing = false;
  
  
  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/original_voice.wav';
        // Check if file exists and delete it
        final file = File(filePath);
        if (await file.exists()) {
          await file.delete();
        }
        // Also delete previous transformed files if they exist
        if (_transformedFilePath != null) {
          final transformedFile = File(_transformedFilePath!);
          if (await transformedFile.exists()) {
            await transformedFile.delete();
          }
          // Reset the transformed file path
          setState(() {
            _transformedFilePath = null;
          });
        }
        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: filePath,
        );
        setState(() {
          _isRecording = true;
          _recordedFilePath = filePath;
        });
      }
    } catch (e) {
      print('Error recording: $e');
    }
  }
  Future<void> _stopRecording() async {
    try {
      await _audioRecorder.stop();
      setState(() => _isRecording = false);
    } catch (e) {
      print('Error stopping: $e');
    }
  }
  Future<void> _transformToWomanVoice() async {
    if (_recordedFilePath == null) return;
    setState(() => _isProcessing = true);
    try {
      final directory = await getApplicationDocumentsDirectory();
      final newTransformedFilePath = '${directory.path}/woman_voice.wav';
      // Check if previous transformed file exists and delete it
      if (_transformedFilePath != null) {
        final oldFile = File(_transformedFilePath!);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }
      _transformedFilePath = newTransformedFilePath;
      // FFmpeg command to increase pitch and adjust formants for woman's voice
      final command = '-i $_recordedFilePath -af asetrate=44100*1.3,aresample=44100,atempo=0.77 $_transformedFilePath';
      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        _playTransformedAudio();
      } else {
        print('FFmpeg error: ${await session.getAllLogsAsString()}');
      }
    } catch (e) {
      print('Error transforming: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }
  Future<void> _transformToManVoice() async {
    if (_recordedFilePath == null) return;
    setState(() => _isProcessing = true);
    try {
      final directory = await getApplicationDocumentsDirectory();
      final newTransformedFilePath = '${directory.path}/man_voice.wav';
      // Check if previous transformed file exists and delete it
      if (_transformedFilePath != null) {
        final oldFile = File(_transformedFilePath!);
        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      }
      _transformedFilePath = newTransformedFilePath;
      // FFmpeg command to decrease pitch and adjust formants for man's voice
      final command = '-i $_recordedFilePath -af asetrate=44100*0.8,aresample=44100,atempo=1.25 $_transformedFilePath';
      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        _playTransformedAudio();
      } else {
        print('FFmpeg error: ${await session.getAllLogsAsString()}');
      }
    } catch (e) {
      print('Error transforming: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }
  Future<void> _playTransformedAudio() async {
    if (_transformedFilePath != null) {
      final file = File(_transformedFilePath!);
      if (await file.exists()) {
        await _audioPlayer.play(DeviceFileSource(_transformedFilePath!));
      } else {
        print('Transformed file does not exist: $_transformedFilePath');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Transformer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Recording button
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),
           
            if (_recordedFilePath != null && !_isRecording)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _isProcessing ? null : _transformToWomanVoice,
                    child: Text(_isProcessing ? 'Processing...' : 'Transform to Woman Voice'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isProcessing ? null : _transformToManVoice,
                    child: Text(_isProcessing ? 'Processing...' : 'Transform to Man Voice'),
                  ),
                  if (_transformedFilePath != null) ...[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _playTransformedAudio,
                      child: const Text('Play Transformed Audio'),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}






