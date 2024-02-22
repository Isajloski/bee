import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bee/Service/AwesomeNotificationService.dart';
import 'package:bee/Widget/MapWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/LocationModel.dart';
import '../navigation_bar.dart';

class LocationWidget extends StatefulWidget{
  @override
  LocationWState createState() => LocationWState();
}

class LocationWState  extends State<LocationWidget> {

  int _currentIndex = 2;

  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController timeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List <LocationModel> locations = [];

  void fetchUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      FirebaseFirestore.instance
          .collection('Location')
          .where('user_id', isEqualTo: id)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          locations.clear();
          querySnapshot.docs.forEach((doc) {
            if (doc.data() is Map<String, dynamic>) {
              locations.add(LocationModel.fromMap(doc.data() as Map<String, dynamic>));
            }
          });

          setState(() {
            locations = locations;
          });
          AwesomeNotificationService().triggerNotificationLocation(locations);
        } else {
          print('No documents found for the user.');
        }
      }).catchError((error) {
        print('Error retrieving data: $error');
      });
    }
  }

  void _add(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    TextEditingController dateController = TextEditingController();
    // Popup дијалог за креирање на предмет
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Форма за името, со контролер nameController
              TextFormField(decoration: const InputDecoration(labelText: 'Предмет'), controller: nameController),
              const SizedBox(height: 10),
              TextFormField(decoration: const InputDecoration(labelText: 'Локација'), controller: locationController),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  // Форма за датумот, со контролер dateController
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    selectedDate = pickedDate;
                    dateController.text =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Датум',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: dateController,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                // Форма за времето, со контролер timeController
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null && pickedTime != selectedTime) {
                    selectedTime = pickedTime;
                    final formattedTime = '${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}';
                    timeController.text = formattedTime;
                  }
                },


                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Време',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                    controller: timeController,
                  ),
                ),

              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Сме кликнале на копчето да се зачува, прво се зема логираникит корисник и пробуваме
                // на Exam колекцијата да го додадеме новиот испит.
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  String id = user.uid;
                  FirebaseFirestore.instance.collection('Location').add({
                    'name': nameController.text,
                    'time': timeController.text,
                    'date': dateController.text,
                    'user_id': id,
                    'location': locationController.text
                  });
                  print("Усошно е зачуван {nameController.text}");
                }
                fetchUserData();
                Navigator.of(context).pop();
              },
              child: Text('Зачувај'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchUserData();
  }

  void openGoogleMaps(String location) async {
    final uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$location&travelmode=driving');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _add(context);
            },
          ),
        ],
      ),
    body: Stack(
    children: [
    ListView.builder(
    itemCount: locations.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(locations[index].name),
          subtitle: Text('${locations[index].time} - ${locations[index].date} \nЛокација: ${locations[index].location}'),
          trailing: ElevatedButton(
            onPressed: () {
              openGoogleMaps(locations[index].location);
            },
            child: Text('Мапа'),
          ),
        );
      },
    ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.72, // Adjust the position as needed
            left: 175, // Distance from left edge
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapWidget(locations: locations)));
              },
              child: const Icon(Icons.maps_home_work), // Change the icon as needed
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

    );
  }

}

