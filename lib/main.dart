import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:stroktrail/pages/picture_screen.dart';
import 'package:stroktrail/pages/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
      builder: FlutterSmartDialog.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List _screens = const [PictureScreen(), WeatherScreen()];
  final List _title = const ["Pictures", "Weather"];
  final List<IconData> _icons = const [Icons.menu, Icons.person];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: const Color.fromARGB(255, 255, 0, 0),
        title: Text(_title[_currentIndex]),
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: _screens[_currentIndex],
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: _title.map(
              (element) {
                final index = _title.indexOf(element);
                return ListTile(
                  leading: Icon(_icons[index]),
                  title: Text(element),
                  onTap: () {
                    setState(() {
                    _currentIndex = index;
                  });
                  Navigator.of(context).pop();
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
