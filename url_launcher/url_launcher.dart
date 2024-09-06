import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URL'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CustomButton(
              'Launch URL',
              () async {
                await launchLink('https://pub.dev/');
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'Launch Google Maps',
              () async {
                await launchGoogleMaps(30.112477830047354, 31.39909907372025);
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'Make a call',
              () async {
                await makeCall('+201111111111');
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              'Launch WhatsApp',
              () async {
                await launchWhatsApp('+201111111111', message: 'Hello');
              },
            ),
            const SizedBox(height: 10),
            
            CustomButton(
              'Send sms',
              () async {
                await sendSMS('+201111111111', message: 'Hello');
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(this.text, this.onPressed, {super.key});

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

launchLink(String url) async {
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e.toString());
  }
}

makeCall(String phoneNumber) async {
  Uri uri = Uri.parse('tel:$phoneNumber');
  try {
    await launchUrl(uri);
  } catch (e) {
    print(e.toString());
  }
}

launchGoogleMaps(
  double latitude,
  double longitude,
) async {
  Uri uri = Uri.parse('https://maps.google.com/?q=$latitude,$longitude');
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e.toString());
  }
}

launchWhatsApp(String phoneNumber, {String? message}) async {
  Uri uri = Uri.parse('https://wa.me/$phoneNumber?text=${message ?? ''}');
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e.toString());
  }
}

launchTelegram(String phoneNumber, {String? message}) async {
  Uri uri = Uri.parse('https://t.me/$phoneNumber?message=${message ?? ''}');
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e.toString());
  }
}

sendSMS(String phoneNumber, {String? message}) async {
  Uri uri = Uri.parse('sms:$phoneNumber?body=${message ?? ''}');
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print(e.toString());
  }
}


