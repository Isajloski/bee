import 'package:bee/Widget/TrainWidget.dart';
import 'package:flutter/material.dart';
import 'package:bee/Widget/LocationWidget.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: (index) {
        onTap(index);
        _navigateToWidget(context, index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus),  // Adjust the size as needed
          label: ''
              '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.train_sharp),  // Adjust the size as needed
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_taxi),  // Adjust the size as needed
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),  // Adjust the size as needed
          label: '',
        ),
      ],
    );
  }

  void _navigateToWidget(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrainWidget()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrainWidget()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationWidget()));
        break;
    }
  }
}
