import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatelessWidget {
   MyHomePage({super.key});

  Iterable<CallLogEntry> calls = [];


  loadAllCallLogs() async {
    calls = await CallLog.get();
  }

  loadCallLogs()async{
    var now = DateTime.now();
    int from = now.subtract(Duration(days: 60)).millisecondsSinceEpoch;
    int to = now.subtract(Duration(days: 30)).millisecondsSinceEpoch;
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from,
      dateTo: to,
      durationFrom: 0,
      durationTo: 60,
      name: 'John Doe',
      number: '901700000',
      type: CallType.incoming,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Log Example'),
      ),

      body: Center(
        child: FutureBuilder(future: loadCallLogs(), builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: calls.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                   child: Column(
                     children: [
                       Text('name: ${calls.elementAt(index).name}'),
                       Text('number: ${calls.elementAt(index).number}'),
                       Text('callType: ${calls.elementAt(index).callType}'),
                       Text('duration: ${calls.elementAt(index).duration}'),
                       Text('simDisplayName: ${calls.elementAt(index).simDisplayName}'),
                     ],
                   ),
                );
              },
            );
          }
        },)
      ),
    );
  }
}
