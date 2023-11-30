import 'package:flutter/material.dart';
import 'package:researches/flutter%20secure%20storage/flutter%20secure%20storage%20package.dart';

class FlutterSecureStorageHomePage extends StatelessWidget {
  const FlutterSecureStorageHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await setData();
              },
              child: const Text('set data'),
            ),
            ElevatedButton(
              onPressed: () async {
                String? data = await getData();
                print(data);
              },
              child: const Text('get data'),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, String> data = await getAllData();
                print(data);
              },
              child: const Text('get all data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await deleteData();
              },
              child: const Text('delete data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await deleteAllData();
              },
              child: const Text('delete all data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await containsKey();
              },
              child: const Text('does contain key'),
            ),
          ],
        ),
      ),
    );
  }
}
