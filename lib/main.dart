import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  String _animationType = 'fade'; // 'fade', 'slide', 'scale', etc.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(title: const Text('Theme Switcher')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (Widget child, Animation<double> animation) {
                switch (_animationType) {
                  case 'slide':
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: child,
                    );
                  case 'scale':
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  case 'rotate':
                    return RotationTransition(
                      turns: animation,
                      child: child,
                    );
                  default: // 'fade'
                    return FadeTransition(opacity: animation, child: child);
                }
              },
              child: Container(
                key: ValueKey(_themeMode),
                alignment: Alignment.center,
                child: Icon(
                  _themeMode == ThemeMode.light
                      ? Icons.wb_sunny
                      : Icons.nights_stay,
                  size: 100,
                  color: _themeMode == ThemeMode.light
                      ? Colors.orange
                      : Colors.blueGrey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _themeMode = _themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                });
              },
              child: const Text('Toggle Theme'),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _animationType,
              onChanged: (String? newValue) {
                setState(() {
                  _animationType = newValue!;
                });
              },
              items: <String>['fade', 'slide', 'scale', 'rotate']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('Animation: $value'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
