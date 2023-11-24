import 'package:flutter/material.dart';

import 'shared preferences package.dart';

class SharedPreferencesHomePage extends StatelessWidget {
  const SharedPreferencesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await setStringData();
                await setBoolData();
                await setDoubleData();
                await setIntData();
                await setStringListData();
              },
              child: const Text('set data'),
            ),
            ElevatedButton(
              onPressed: () {
                String? data = getStringData();
               print(data);
              },
              child: const Text('get data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await removeData();
              },
              child: const Text('delete data'),
            ),
          ],
        ),
      ),
    );
  }
}
