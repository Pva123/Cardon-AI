import 'package:flutter/material.dart';

class MinimalPage extends StatefulWidget {
  const MinimalPage({super.key});

  @override
  _MinimalPageState createState() => _MinimalPageState();
}

class _MinimalPageState extends State<MinimalPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showTextField = false;
  double _circleOffset = 0.0; // Controls movement when hovered

  void _toggleKeyboard() {
    setState(() {
      _showTextField = true;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          // Mic Button (Grey Circle + Mic Icon with Hover Effect)
          Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _circleOffset = -5.0), // Move up on hover
              onExit: (_) => setState(() => _circleOffset = 0.0), // Reset when mouse leaves
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                transform: Matrix4.translationValues(0, _circleOffset, 0),
                child: GestureDetector(
                  onTap: () {
                    print("Grey circle clicked!");
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400],
                        ),
                      ),
                      Icon(
                        Icons.mic,
                        size: 50,
                        color: Colors.black87, // Mic icon inside the grey circle
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Positioned Row for "Settings" and "Keyboard"
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Settings Button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        print("Settings Clicked");
                      },
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  // Keyboard Button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _toggleKeyboard,
                      child: Text(
                        'Keyboard',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TextField to open keyboard
          if (_showTextField)
            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Type here...",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.black54,
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  setState(() {
                    _showTextField = false; // ✅ Fixed Syntax
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
