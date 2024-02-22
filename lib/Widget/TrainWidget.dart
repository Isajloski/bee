import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainWidget extends StatefulWidget {
  @override
  _TrainState createState() => _TrainState();
}

class _TrainState extends State<TrainWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Times'),
      ),
      body: Center(
        child: Column( // Use Column, Row, or Stack here depending on your layout needs
          children: [
            TimelineCard(),
            TimelineCard(),
          ],
        ),
      )
    );
  }
}

class TimelineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline line with dots
                  Column(
                    children: [
                      Icon(Icons.fiber_manual_record, size: 15, color: Colors.brown.shade900),
                      Expanded(
                        child: Container(
                          width: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.brown.shade900, Colors.brown.shade400],
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.fiber_manual_record, size: 15, color:  Colors.brown.shade400),
                    ],
                  ),
                  SizedBox(width: 10),
                  // Times and destinations
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('11:00', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Start'),
                        SizedBox(height: 20),
                        Text('11:35', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Finish'),
                      ],
                    ),
                  ),
                  // Price bubble
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade900,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('\$5.00', style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Distance and travel time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_car, color: Colors.red),
                    SizedBox(width: 4),
                    Text('12km', style: TextStyle(color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.red),
                    SizedBox(width: 4),
                    Text('Travel Time 35 min', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}