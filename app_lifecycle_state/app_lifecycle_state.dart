import 'package:flutter/material.dart';

class AppLifeCycleExample extends StatefulWidget {
  const AppLifeCycleExample({super.key});

  @override
  State<AppLifeCycleExample> createState() => _AppLifeCycleExampleState();
}

class _AppLifeCycleExampleState extends State<AppLifeCycleExample>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Add logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Life Cycle Example'),
      ),
      body: Center(
        child: Text('App Life Cycle Example'),
      ),
    );
  }
}
