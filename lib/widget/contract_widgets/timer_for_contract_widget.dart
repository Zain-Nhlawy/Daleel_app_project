import 'dart:async';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:flutter/material.dart';

class CountdownTimerBox extends StatefulWidget {
  const CountdownTimerBox({
    super.key,
    required this.endDate,
    required this.status,
  });

  final DateTime endDate;
  final RentStatus status;

  @override
  _CountdownTimerBoxState createState() => _CountdownTimerBoxState();
}

class _CountdownTimerBoxState extends State<CountdownTimerBox> {
  late Timer _timer;
  int years = 0, months = 0, days = 0, hours = 0, minutes = 0, seconds = 0;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateCountdown());
  }

  void _updateCountdown() {
    final now = DateTime.now();
    if (widget.endDate.isBefore(now)) {
      _timer.cancel();
      setState(() {
        years = months = days = hours = minutes = seconds = 0;
      });
    } else {
      int y = widget.endDate.year - now.year;
      int m = widget.endDate.month - now.month;
      int d = widget.endDate.day - now.day;
      int h = widget.endDate.hour - now.hour;
      int min = widget.endDate.minute - now.minute;
      int s = widget.endDate.second - now.second;

      if (s < 0) {
        s += 60;
        min--;
      }
      if (min < 0) {
        min += 60;
        h--;
      }
      if (h < 0) {
        h += 24;
        d--;
      }
      if (d < 0) {
        final prevMonth = DateTime(
          widget.endDate.year,
          widget.endDate.month,
          0,
        );
        d += prevMonth.day;
        m--;
      }
      if (m < 0) {
        m += 12;
        y--;
      }

      setState(() {
        years = y;
        months = m;
        days = d;
        hours = h;
        minutes = min;
        seconds = s;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 400,
        height: 120,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Time Remaining', style: TextStyle(fontSize: 17)),
              const SizedBox(height: 5),
              Text(
                '$years  : $months : $days : $hours : $minutes : $seconds ',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
