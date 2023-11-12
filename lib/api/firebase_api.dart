import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification_flutter/main.dart';
import 'dart:convert';

class JsonData {
  final String title;
  final String message;

  JsonData({required this.title, required this.message});

  factory JsonData.fromJson(Map<String, dynamic> json) {
    return JsonData(
      title: json['title'] as String,
      message: json['message'] as String,
    );
  }
}

class JsonParser {
  static JsonData parseJsonData(String jsonString) {
    final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>;
    return JsonData.fromJson(decodedJson);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  final jsonDataObject = JsonData.fromJson(message.data);

  AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        actionType: ActionType.Default,
        title: jsonDataObject.title,
        body: jsonDataObject.message,
      )
  );
}

class FirebaseApi{

  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }


 }