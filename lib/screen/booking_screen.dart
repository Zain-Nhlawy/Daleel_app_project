import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';

class BookingCalendar extends StatefulWidget {
  final Apartments2 apartment;
  const BookingCalendar({super.key, required this.apartment});
  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  DateTime? _startDate;
  DateTime? _endDate;

  late EventList<Event> _markedDates;

  List<Map<String, String>> availableTimes = [];

  @override
  void initState() {
    super.initState();
    _markedDates = EventList<Event>(events: {});
    _initAvailableTimes(); 
  }

  void _initAvailableTimes() {
    setState(() {
      availableTimes = widget.apartment.freeTimes != null
          ? widget.apartment.freeTimes!.map((ft) {
              final start = ft['start_time']?.toString().split(' ').first ?? '--';
              final end = ft['end_time']?.toString().split(' ').first ?? 'Not specified';
              return {'from': start, 'to': end};
            }).toList()
          : [];
    });
  }

  String formatDate(DateTime date) => DateFormat('d/M/yyyy').format(date);

  void _onDayPressed(DateTime date) {
    if (date.isBefore(DateTime.now())) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cannot select past dates')),
    );
    return;
  }
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

  Future<void> _refreshFreeTimes() async {
    final updatedApartment =
        await apartmentController.fetchApartment(widget.apartment.id);

    if (updatedApartment != null) {
      setState(() {
        widget.apartment.freeTimes = updatedApartment.freeTimes;
        availableTimes = updatedApartment.freeTimes != null
            ? updatedApartment.freeTimes!.map((ft) {
                final start =
                    ft['start_time']?.toString().split(' ').first ?? '--';
                final end =
                    ft['end_time']?.toString().split(' ').first ?? 'Not specified';
                return {'from': start, 'to': end};
              }).toList()
            : [];
      });
    }
  }

  void _handleDateSelection(BuildContext context) async {
    if (_startDate != null && _endDate != null) {
      try {
        final contract = await contractController.bookApartment(
          apartmentId: widget.apartment.id,
          start: _startDate!,
          end: _endDate!,
          rentFee: widget.apartment.rentFee ?? 0.0,
        );
        if (!mounted) return;

        if (contract != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking successful')),
          );

          await _refreshFreeTimes(); 
          if (!mounted) return;
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Booking failed')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'This house is rented during this period, please choose another time.',
            ),
          ),
        );
        print('Error during booking: $e');
      }
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
          onPressed: () => Navigator.pop(context),
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
                        maxSelectedDate: DateTime(2100, 12, 31),
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
                        customDayBuilder: (
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
                              _startDate != null && day.isAtSameMomentAs(_startDate!);
                          bool isEnd =
                              _endDate != null && day.isAtSameMomentAs(_endDate!);

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
