import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:intl/intl.dart';
import '../Model/LocationModel.dart';

class AwesomeNotificationService{

  void init(){
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests.'
          )
        ],
        debug: true
    );
  }

  void triggerNotificationLocation(List<LocationModel> locations) {
    for (LocationModel location in locations){
      DateTime date = DateFormat("dd-MM-yyyy HH:mm").parse("${location.date} ${location.time}");
      if(date.isAfter(DateTime.now())) {
        print(location.name);
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(1000),
              channelKey: 'basic_channel',
              title: 'Локациски потсетник ${location.name}',
              body: 'Време ${location.time} часот'
          ),
          schedule: NotificationCalendar(
              minute: date.subtract(const Duration(minutes: 5)).minute,
              second: date.second,
              hour: date.hour,
              day: date.day,
              month: date.month,
              year: date.year
          ),
        );
      }
    }

  }



}