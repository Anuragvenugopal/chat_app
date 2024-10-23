import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseMessaging messaging;

  void initState() {
    _initializeFCM();
    foregroundNotifications();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message received");
      print(event.notification!.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              elevation: 50,
              title: Text(
                event.notification!.title!,
                style: const TextStyle(
                  color: Colors.cyan,
                ),
              ),
              content: Text(
                event.notification!.body!,
                style: const TextStyle(
                  color: Colors.cyan,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    super.initState();
  }

  Future<void> _initializeFCM() async {
    FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token: $token");
    });
  }

  void foregroundNotifications() async {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        if (notification != null) {
          _showCupertinoDialog(context, notification.title.toString(),
              notification.body.toString());
        }
      });
    } catch (e) {}
  }

  _showCupertinoDialog(context, String title, String body) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: Center(child: new Text(title)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                body,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.grey),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 120
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.black;
                            return Colors
                                .red; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Reject'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void Notify() async{
    // local notification
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body',
            bigPicture:'assets://images/protocoderlogo.png'
        )
    );

  }


  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

    print("Handling a background message: ${message.messageId}");

    //firebase push notification
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      _showCupertinoDialog(context, "Sample Title", "Sample Body");
                      Notify();
                    },
                    child: Text(
                      'ok',
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
