import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SmsQuery _query = SmsQuery();
  List<SmsMessage> _messages = [];

  Future<void> _requestSmsPermission() async {
    if (await Permission.sms.request().isGranted) {
      _querySmsMessages();
    }
    else{
      Permission.sms.request();
    }
  }

  Future<void> _querySmsMessages() async {
    final queryMessages = await _query.querySms(
      kinds: [
        SmsQueryKind.inbox,
        SmsQueryKind.sent,
        SmsQueryKind.draft,
      ],
      address: 'vodafone',//+201111111111
      count:200,
    );

     setState(() => _messages = queryMessages);
  }

  @override
  void initState() {
    _requestSmsPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Inbox'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _requestSmsPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final SmsMessage message = _messages[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      Text('id: ${message.id}'),
                      Text('address: ${message.address}'),
                      Text('body: ${message.body}'),
                      Text('date: ${message.date}'),
                      Text('date sent: ${message.dateSent}'),
                      Text('kind: ${message.kind}'),
                      Text('is read: ${message.isRead}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


