import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar",style: TextStyle(color: Colors.white),),
          elevation: 6,
          backgroundColor: Color(0xff0056D2),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: SfCalendar(
            view: CalendarView.month,
            initialSelectedDate: DateTime.now(),
            dataSource: MeetingDataSource(_getDataSource()),
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.redAccent,width: 2),
              borderRadius: BorderRadius.circular(4),
              shape: BoxShape.rectangle,
            ),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,showAgenda: true,),
          ),
        ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day,9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Battle Of Brands', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting('Hackathon LOC', startTime.add(Duration(hours: 3)),endTime.add(Duration(hours: 72)), const Color(0xFFFF5252), false));
    meetings.add(Meeting('Hackathon COC', startTime.add(Duration(hours: 4)),endTime.add(Duration(hours: 6)),const Color(0xFF0F8644), false));
    meetings.add(Meeting('UNICODE', startTime.add(Duration(days: 6)),endTime.add(Duration(hours: 9)), const Color(0xFFFF5252), false));


    return meetings;
  }
}
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
      this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

