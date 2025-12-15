import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';


class BookingCalendar extends StatefulWidget {
  final int apartmentId;
  const BookingCalendar({super.key, required this.apartmentId});
  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  DateTime? _startDate;
  DateTime? _endDate;

  late EventList<Event> _markedDates;

  final List<Map<String, String>> availableTimes = [
    {"from": "1/1/2026", "to": "8/8/2026"},
    {"from": "2/5/2027", "to": "Not specified"},
    {"from": "12/3/2028", "to": "20/4/2028"},
  ];

  @override
  void initState() {
    super.initState();
    _markedDates = EventList<Event>(events: {});
  }

  String formatDate(DateTime date) => DateFormat('d/M/yyyy').format(date);

  void _onDayPressed(DateTime date) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = date;
        _endDate = null;
      } else if (_startDate != null && _endDate == null) {
        if (date.isBefore(_startDate!)) {
          _startDate = date;
        } else {
          _endDate = date;
        }
      }
    });
  }

  bool _isInRange(DateTime day) {
    if (_startDate != null && _endDate != null) {
      return day.isAfter(_startDate!) && day.isBefore(_endDate!);
    }
    return false;
  }


  void _handleDateSelection(BuildContext context) async{
  if (_startDate != null && _endDate != null) {
    String start = formatDate(_startDate!);
    String end = formatDate(_endDate!);

/*
    final newRent = await rentController.createRent(
      departmentId: widget.apartmentId, 
      startRent: start,
      endRent: end,
    );

    if (newRent != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Selected: ${formatDate(_startDate!)} → ${formatDate(_endDate!)}',
        ),
      ),
    );
    }*/

  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select start and end dates'),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final brown = Color(0xFF795548);
    final brownDark = Color(0xFF5D4037);

    EventList<Event> tempMarked = EventList(events: {});
    if (_startDate != null) {
      tempMarked.add(
        _startDate!,
        Event(
          date: _startDate!,
          title: 'Start',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            width: 8,
            height: 8,
          ),
        ),
      );
    }
    if (_endDate != null) {
      tempMarked.add(
        _endDate!,
        Event(
          date: _endDate!,
          title: 'End',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            width: 8,
            height: 8,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Booking Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown[700]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: brownDark,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 420,
                      child: CalendarCarousel<Event>(
                        onDayPressed: (date, events) => _onDayPressed(date),
                        weekendTextStyle: TextStyle(color: brownDark),
                        weekdayTextStyle: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w600,
                        ),
                        todayButtonColor: Colors.transparent,
                        todayTextStyle: TextStyle(color: Colors.grey),
                        markedDatesMap: tempMarked,
                        markedDateShowIcon: true,
                        markedDateIconMaxShown: 1,
                        selectedDateTime: null,
                        showOnlyCurrentMonthDate: true,
                        headerTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                        leftButtonIcon: Icon(
                          Icons.chevron_left,
                          color: brownDark,
                        ),
                        rightButtonIcon: Icon(
                          Icons.chevron_right,
                          color: brownDark,
                        ),
                        customDayBuilder:
                            (
                              bool isSelectable,
                              int index,
                              bool isSelectedDay,
                              bool isToday,
                              bool isPrevMonthDay,
                              TextStyle textStyle,
                              bool isNextMonthDay,
                              bool isThisMonthDay,
                              DateTime day,
                            ) {
                              bool inRange = _isInRange(day);
                              bool isStart =
                                  _startDate != null &&
                                  day.isAtSameMomentAs(_startDate!);
                              bool isEnd =
                                  _endDate != null &&
                                  day.isAtSameMomentAs(_endDate!);

                              BoxDecoration? box;
                              Color? textColor = brownDark;

                              if (inRange) {
                                box = BoxDecoration(
                                  color: Colors.orange.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(8),
                                );
                              }
                              if (isStart || isEnd) {
                                box = BoxDecoration(
                                  color: isStart ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                );
                                textColor = Colors.white;
                              }

                              return Container(
                                decoration: box,
                                alignment: Alignment.center,
                                child: Text(
                                  "${day.day}",
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _dateBox(
                            label: "Start",
                            date: _startDate,
                            icon: Icons.play_arrow,
                            color: brown,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _dateBox(
                            label: "End",
                            date: _endDate,
                            icon: Icons.flag,
                            color: brown,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Available Times",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: brownDark,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(12),
                      child: Table(
                        border: TableBorder.all(color: Colors.grey.shade300),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'From',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  'To',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ...availableTimes.map((time) {
                            return TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(time['from']!),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(time['to']!),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            child: CustomButton(
              text: 'Confirm Booking',
              color: brown,
              onPressed: () {
                _handleDateSelection(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateBox({
    required String label,
    required DateTime? date,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          SizedBox(width: 6),
          Text(
            date != null ? '$label: ${formatDate(date)}' : '$label: --',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
