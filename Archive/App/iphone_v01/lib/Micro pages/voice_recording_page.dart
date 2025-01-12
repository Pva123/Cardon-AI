import 'package:flutter/material.dart';

class VoiceRecordingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1D37), // Dark blue background color
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: MicrophoneButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MicrophoneButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle microphone button press (functionality can be added here)
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Color(0xFFFF8C00), // Orange color
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Icon(
          Icons.mic, // Microphone icon
          color: Colors.black,
          size: 40.0,
        ),
      ),
    );
  }
}
