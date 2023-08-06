import 'package:flutter/material.dart';
import 'package:revenge4u/screens/archived_screen.dart';
import 'package:revenge4u/screens/dashboard_screen.dart';
import 'package:revenge4u/screens/idea_screen.dart';
import 'package:revenge4u/screens/liked_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    LikedScreen(),
    ArchivedScreen(),
    IdeaScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _buildThemeData(),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up),
              label: 'Liked',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: 'Archived',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Idea',
            ),
          ],
        ),
      ),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.redAccent,
        toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        titleLarge: TextStyle(
          fontSize: 18.0,
          color: Colors.redAccent,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.redAccent,
          textStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
          .copyWith(secondary: Colors.redAccent),
    );
  }
}
