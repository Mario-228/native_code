import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const platform = MethodChannel('samples.flutter.dev/battery');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String batteryLevel = 'Unknown battery level.';
  void getBatteryLevel() async {
    HomePage.platform.invokeMethod<int>('getBatteryLevel').then(
      (value) {
        setState(() {
          batteryLevel = 'Battery level at $value%';
        });
      },
    ).catchError((error) {
      setState(() {
        batteryLevel = "Failed to get battery level:'${error.toString()}'.";
      });
    });
    // String batteryLevel;
    // try {
    //   final int? result =
    //       await HomePage.platform.invokeMethod<int>('getBatteryLevel');
    //   batteryLevel = 'Battery level at $result%';
    // } on PlatformException catch (e) {
    //   batteryLevel = "Failed to get battery level: '${e.message}'.";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Native Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Click The Button To Get Battery Level',
            ),
            Text(
              batteryLevel,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:getBatteryLevel,
        tooltip: 'Increment',
        child: const Icon(Icons.battery_alert),
      ),
    );
  }
}
