import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

//getting time
DateTime currentTime = DateTime.now();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Date/Time Section

          Positioned(
            top: 50,
            left: 20,
            right:
                20, // Ensure the bar spans the width of the screen with some padding
            child: Container(
                width: double
                    .infinity, // Ensures the container takes the full width
                height: 40, // Set a fixed height for the container
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 95, 104, 119),
                  borderRadius: BorderRadius.circular(
                      30), // Higher value for more rounded corners
                ),
                child: Center(
                  child: Text(
                    intl.DateFormat('EEE, MMM d, HH:mm').format(currentTime),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),

          // Positioned(
          //   top: 50,
          //   left: 20,
          //   right: 20, // Ensure the bar spans the width of the screen with some padding
          //   child: Container(
          //     width: double.infinity, // Ensures the container takes the full width
          //     height: 60, // Adjusted height to accommodate both time and date
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     decoration: BoxDecoration(
          //       color: Color.fromARGB(255, 95, 104, 119),
          //       borderRadius: BorderRadius.circular(30), // Higher value for more rounded corners
          //     ),
          //     child: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             DateFormat('HH:mm').format(DateTime.now()), // Display current time
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(height: 4), // Space between time and date
          //           Text(
          //             DateFormat('EEE, MMM d').format(DateTime.now()), // Display current date
          //             style: TextStyle(
          //               color: Colors.white70,
          //               fontSize: 12,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Navigation Tabs

          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Corrected part: Removed the erroneous Container opening and directly started with the intended Containers.
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 95, 104, 119),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.home, color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 95, 104, 119),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.check_box, color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 95, 104, 119),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.calendar_today, color: Colors.white),
                ),
              ],
            ),
          ),

          // Task Sections
          Positioned(
            top: 170,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // In-Progress Tasks

                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 34, 255, 0),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(100, 34, 255,
                            0), // 51 is approximately 20% of 255, for similar 20% opacity
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In Progress',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                          color: const Color.fromARGB(
                              255, 255, 255, 255)), // Divider
                      SizedBox(height: 8),

                      // Placeholder for in progress items
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(139, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Shadow color with opacity
                              offset: Offset(
                                  0, 4), // Horizontal and vertical offset
                              blurRadius: 8.0, // Blur radius
                              spreadRadius: 0, // Spread radius
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Upcoming Tasks
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 95, 104, 119),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(color: Colors.grey), // Divider
                      SizedBox(height: 8),

                      // Placeholder for upcoming items
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 144, 149, 158),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Shadow color with opacity
                              offset: Offset(
                                  0, 4), // Horizontal and vertical offset
                              blurRadius: 8.0, // Blur radius
                              spreadRadius: 0, // Spread radius
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 144, 149, 158),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Shadow color with opacity
                              offset: Offset(
                                  0, 4), // Horizontal and vertical offset
                              blurRadius: 8.0, // Blur radius
                              spreadRadius: 0, // Spread radius
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 144, 149,
                              158), // Correctly set the color property
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                  0.2), // Shadow color with opacity
                              offset: Offset(
                                  0, 4), // Horizontal and vertical offset
                              blurRadius: 8.0, // Blur radius
                              spreadRadius: 0, // Spread radius
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mic Button
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 123, 0),
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Action to perform on button press
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => voice_recording_page(),
                    ),
                  );*/
                  print('Mic on');
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), // Makes the button a circle
                  padding: EdgeInsets.all(20), // Button size
                  backgroundColor:
                      Color.fromARGB(255, 255, 123, 0), // Button color
                  elevation: 10, // Button shadow
                ),
                child: Icon(
                  Icons.mic, // Example icon
                  color: Color(0xFF0F1D35), // Icon color
                ),
              ),
            ),
          ),

          // Add Task Button
          Positioned(
            right: 90,
            bottom: 30,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 123, 0),
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: SizedBox(
                width: 25, // Specify the width of the square
                height: 25, // Specify the height of the square
                child: ElevatedButton(
                  onPressed: () {
                    // Action to perform on button press
                    print('add task');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.all(0), // Button size
                    backgroundColor:
                        Color.fromARGB(255, 255, 123, 0), // Button color
                    elevation: 10, // Button shadow
                  ),
                  child: Icon(
                    Icons.add,
                    color: Color(0xFF0F1D35),
                  ),
                ),
              ),
            ),
          ),

          // More Button
          Positioned(
            left: 20,
            bottom: 30,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 144, 149, 158),
                    blurRadius: 10.0,
                    spreadRadius: .0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Action to perform on button press
                  print('more menu');
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), // Makes the button a circle
                  padding: EdgeInsets.all(5), // Button size
                  backgroundColor:
                      Color.fromARGB(255, 144, 149, 158), // Button color
                  elevation: 10, // Button shadow
                ),
                child: Icon(
                  Icons.more_horiz, // Example icon
                  color: Color(0xFF0F1D35), // Icon color
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0F1D35),
    );
  }
}
