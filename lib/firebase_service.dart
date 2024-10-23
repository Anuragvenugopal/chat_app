// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
//
// class FirebaseService {
//
//   final flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
//
//   // Initialize Firebase and Notification servicesvoid setupFirebaseAndLocalNotification() async {
// //   var initializationSettingsAndroid =
// //       new AndroidInitializationSettings('notification_icon_push');
// //
// //   var initializationSettingsIOS = IOSInitializationSettings();
// //
// //   var initializationSettings = InitializationSettings(
// //       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
// //
// //   flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //       onSelectNotification: onSelect);
// //
// //   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
// //
// //   await _firebaseMessaging.requestNotificationPermissions(
// //     const IosNotificationSettings(
// //         sound: true, badge: true, alert: true, provisional: false),
// //   );
// //   firebaseMessaging.getToken().then((value) => print(value));
// //   _firebaseMessaging.configure(
// //     onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
// //     onMessage: (message) async {
// //       print("onMessage: $message");
// //     },
// //     onLaunch: (message) async {
// //       print("onLaunch: $message");
// //     },
// //     onResume: (message) async {
// //       print("onResume: $message");
// //     },
// //   );
// // }
