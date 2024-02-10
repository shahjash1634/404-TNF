import 'package:connect/pages/calendar_screen.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CalendarScreen(),
    );
  }
}
