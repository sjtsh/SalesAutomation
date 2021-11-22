import 'package:flutter/material.dart';

class CalendarContent extends StatefulWidget {
  const CalendarContent({Key? key}) : super(key: key);

  @override
  _CalendarContentState createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent> {

  DateTime _date = DateTime.now();
  Future <Null> _selectDatePicker() async {
    DateTime? _datePicker = await showDatePicker(context: context,
        initialDate: _date,
        firstDate: DateTime(1999),
        lastDate: DateTime(2022));
    if(_datePicker!=null && _datePicker!=_date){
      setState(() {
        _date = _datePicker;
        print(_date.toString());
      });
    }
  }

  @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           decoration: ShapeDecoration(
//             color: Color(0xffF5F5F5),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           child: SizedBox(
//             height: 400,
//             width: 550,
//             // child: SfCalendar(
//             //   view: CalendarView.week,
//             //   // initialDisplayDate: DateTime(2021, 11, 21, 08, 30),
//             //   // initialSelectedDate: DateTime(2021, 11, 21, 08, 30),
//             //   dataSource: MeetingDataSource(getAppointments()),
//             //
//             child: ,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// List <Appointment> getAppointments() {
//   List<Appointment> meetings = <Appointment>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//
//   meetings.add(Appointment(
//     startTime: startTime,
//     endTime: endTime,
//     subject: 'Conference',
//     color: Colors.blue,
//     recurrenceRule: 'FREQ=DAILY;COUNT=10'
//   ));
//   return meetings;
// }
//
// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.red,
          onPressed: () {
            setState(() {
              _selectDatePicker();
            });
          },
          child: Text(
            "Pick Your Date",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
