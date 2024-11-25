import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

int? id;
String? toGoRoute;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  id = int.parse(message.data['id']);
  if (id != null) {
    navigatorKey.currentState!.pushNamed('/notification', arguments: id);
  }
}

firebaseMessagingTerminatedHandler() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.getInitialMessage().then((message) {
    if (message != null) {
      id = int.parse(message.data['id']);
      if (id != null) {
        toGoRoute = '/notification';
      }
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firebaseMessagingTerminatedHandler();

  FirebaseMessaging.onMessageOpenedApp
      .listen(firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: toGoRoute ?? "/",
      routes: {
        '/': (context) => const HomePage(),
        '/notification': (context) => const NotificationsPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        Navigator.of(context).pushNamed('/');
      },
      child: const Scaffold(
        body: Center(
          child: Text('Notification Page'),
        ),
      ),
    );
  }
}
