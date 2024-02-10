import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF132248),
        centerTitle: true,
        title: Text("Calendar", style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Color(0xFF132248),
                scrollable: true,
                title:
                    Text("Event Name", style: TextStyle(color: Colors.white)),
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: _eventController,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                actions: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 32, 57, 122)
                          .withOpacity(0.7), // Set the desired color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        events.addAll({
                          _selectedDay!: [Event(_eventController.text)]
                        });
                        Navigator.of(context).pop();
                        _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Set transparent color
                        elevation: 0, // No shadow
                      ),
                      child:
                          Text("Save", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Color(0xFF132248),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2022),
            lastDay: DateTime(2027),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            eventLoader: _getEventsForDay,
            rowHeight: 60,
            daysOfWeekHeight: 60,
            headerStyle: HeaderStyle(
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
              formatButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.white,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
          ),
          SizedBox(height: 25),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () => print(""),
                        title: Text('${value[index]}',
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
