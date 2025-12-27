// ignore_for_file: unused_local_variable

import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/models/apartments.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/widget/custom_button.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart';

class BookingCalendar extends StatefulWidget {
  final Apartments2 apartment;
  final Contracts? contract;
  const BookingCalendar({super.key, required this.apartment, this.contract});
  bool get isEdit => contract != null;

  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  DateTime? _startDate;
  DateTime? _endDate;

  // ignore: unused_field
  late EventList<Event> _markedDates;

  List<Map<String, String>> availableTimes = [];

  bool _isProcessing = false;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _markedDates = EventList<Event>(events: {});

    if (widget.contract != null) {
    _startDate = widget.contract!.startRent;
    _endDate = widget.contract!.endRent;
  }

    if (widget.apartment.freeTimes != null) {
      availableTimes = widget.apartment.freeTimes!.map((ft) {
        final start = ft['start_time']?.toString().split(' ').first ?? '__';
        final end = ft['end_time']?.toString().split(' ').first ?? '__';
        return {'from': start, 'to': end};
      }).toList();
    } else {
      availableTimes = [];
    }
  }

  String formatDate(DateTime date) => DateFormat('d/M/yyyy').format(date);

  void _onDayPressed(DateTime date) {
    if (date.isBefore(DateTime.now())) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.cannotSelectPastDates),
        ),
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

  String extractCleanErrorMessage(dynamic error) {
  String message = 'Something went wrong';

  if (error is DioException) {
    final response = error.response;

    if (response?.data != null) {
      final data = response!.data;

      if (data is Map<String, dynamic> && data['message'] != null) {
        message = data['message'].toString();
      } else if (data is String) {
        message = data;
      }
    } else if (error.message != null) {
      message = error.message!;
    }
  } else if (error is Exception) {
    message = error.toString();
  }

  message = message
      .replaceAll('Exception:', '')
      .replaceAll('Exception', '')
      .replaceAll('Error:', '')
      .replaceAll('Error', '')
      .trim();

  if (message.isEmpty || message.length < 3) {
    message = 'Operation failed';
  }

  return message;
}


Future<void> _confirmBooking() async {
  if (_isProcessing) return;

  setState(() => _isProcessing = true);

  try {
    await userController.getProfile();
    final user = userController.user;

    if (user == null) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.userDataNotAvailable)),
      );
      return;
    }

    if (user.verificationState != 'verified') {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.yourAccountIsNotAllowedToMakeBookings)),
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseSelectStartAndEndDates)),
      );
      return;
    }

    await contractController.bookApartment(
      apartmentId: widget.apartment.id,
      start: _startDate!,
      end: _endDate!,
      rentFee: widget.apartment.rentFee ?? 0.0,
    );

    if (!mounted) return;
    Navigator.pop(context);

  } catch (e) {
    if (!mounted) return;

    final cleanMessage = extractCleanErrorMessage(e);
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(content: Text(cleanMessage)),
    );

  } finally {
    if (mounted) setState(() => _isProcessing = false);
  }
}



  // Future<void> _confirmBooking() async {
  //   if (_isProcessing) return;

  //   setState(() => _isProcessing = true);

  //   try {
  //     await userController.getProfile();
  //     final user = userController.user;

  //     if (user == null) {
  //       _scaffoldMessengerKey.currentState?.showSnackBar(
  //         SnackBar(
  //           content: Text(AppLocalizations.of(context)!.userDataNotAvailable),
  //         ),
  //       );
  //       return;
  //     }

  //     if (user.verificationState != 'verified') {
  //       _scaffoldMessengerKey.currentState?.showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             AppLocalizations.of(
  //               context,
  //             )!.yourAccountIsNotAllowedToMakeBookings,
  //           ),
  //         ),
  //       );
  //       return;
  //     }

  //     if (_startDate == null || _endDate == null) {
  //       _scaffoldMessengerKey.currentState?.showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             AppLocalizations.of(context)!.pleaseSelectStartAndEndDates,
  //           ),
  //         ),
  //       );
  //       return;
  //     }

  //     await contractController.bookApartment(
  //       apartmentId: widget.apartment.id,
  //       start: _startDate!,
  //       end: _endDate!,
  //       rentFee: widget.apartment.rentFee ?? 0.0,
  //     );

  //     if (!mounted) return;
  //     Navigator.pop(context);
  //   } on DioException catch (e) {
  //     if (!mounted) return;

  //     String? message;

  //     if (e.response?.data != null) {
  //       final data = e.response!.data;
  //       if (data is Map<String, dynamic>) {
  //         message = data['message'] as String?;
  //       } else if (data is String) {
  //         message = data;
  //       }
  //     }

  //     final statusCode = e.response?.statusCode;

  //     if (statusCode == 401) {
  //       _scaffoldMessengerKey.currentState?.showSnackBar(
  //         const SnackBar(content: Text('Unauthorized, please login again')),
  //       );
  //       return;
  //     }

  //     if (statusCode == 500) {
  //       _scaffoldMessengerKey.currentState?.showSnackBar(
  //         const SnackBar(content: Text('Server error, try again later')),
  //       );
  //       return;
  //     }

  //     _scaffoldMessengerKey.currentState?.showSnackBar(
  //       SnackBar(
  //         content: Text(AppLocalizations.of(context)!.bookingPeriodUnavailable),
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     if (!mounted) return;

  //     String errorMessage = e.toString();

  //     int lastColonIndex = errorMessage.lastIndexOf(':');
  //     String cleanMessage;

  //     if (lastColonIndex != -1 && lastColonIndex < errorMessage.length - 1) {
  //       cleanMessage = errorMessage.substring(lastColonIndex + 1).trim();
  //     } else {
  //       cleanMessage = errorMessage;
  //     }

  //     cleanMessage = cleanMessage
  //         .replaceAll('Exception', '')
  //         .replaceAll('Error', '')
  //         .trim();

  //     if (cleanMessage.length < 3) {
  //       cleanMessage = 'Booking failed';
  //     }

  //     _scaffoldMessengerKey.currentState?.showSnackBar(
  //       SnackBar(content: Text(cleanMessage)),
  //     );
  //   } finally {
  //     if (mounted) {
  //       setState(() => _isProcessing = false);
  //     }
  //   }
  // }

void _showUpdateRequestDialog({required bool isPendingApproval}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Icon(
          Icons.check_circle_outline,
          color: Colors.green,
          size: 50,
        ),
      ),
      content: Text(
        isPendingApproval
            ? AppLocalizations.of(context)!
                .updateRequestSentWaitingForApproval
            : AppLocalizations.of(context)!
                .contractUpdatedSuccessfully,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.pop(context, true);
          },
          child: Text(
            AppLocalizations.of(context)!.okay,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}


// Future<void> _updateBooking() async {
//   if (_isProcessing) return;

//   setState(() => _isProcessing = true);

//   try {
//     if (_startDate == null || _endDate == null) {
//       return;
//     }

//     final result = await contractController.updateRent(
//       rentId: widget.contract!.id,
//       start: _startDate!,
//       end: _endDate!,
//     );

//     if (!mounted) return;

//     if (result == null) {
//       Navigator.pop(context, null);
//       _showUpdateRequestDialog(isPendingApproval: true);
//     } else {
//       Navigator.pop(context, {
//         'start': _startDate!,
//         'end': _endDate!,
//       });
//       _showUpdateRequestDialog(isPendingApproval: false);
//     }
//   } catch (e) {
//     if (!mounted) return;

//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(
//           AppLocalizations.of(context)!.error,
//           style: const TextStyle(color: Colors.red),
//         ),
//         content: Text(e.toString()),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: Text(AppLocalizations.of(context)!.okay),
//           ),
//         ],
//       ),
//     );
//   } finally {
//     if (mounted) setState(() => _isProcessing = false);
//   }
// }

Future<void> _updateBooking() async {
  if (_isProcessing) return;

  setState(() => _isProcessing = true);

  try {
    if (_startDate == null || _endDate == null) {
      return;
    }

    final result = await contractController.updateRent(
      rentId: widget.contract!.id,
      start: _startDate!,
      end: _endDate!,
    );

    if (!mounted) return;

    if (result == null) {
      Navigator.pop(context, null);
      _showUpdateRequestDialog(isPendingApproval: true);
    } else {
      Navigator.pop(context, {
        'start': _startDate!,
        'end': _endDate!,
      });
      _showUpdateRequestDialog(isPendingApproval: false);
    }
  } catch (e) {
    if (!mounted) return;

    final cleanMessage = extractCleanErrorMessage(e);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.error,
          style: const TextStyle(color: Colors.red),
        ),
        content: Text(cleanMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.okay),
          ),
        ],
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isProcessing = false);
    }
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
          title: AppLocalizations.of(context)!.start,
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
          title: AppLocalizations.of(context)!.end,
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

    return WillPopScope(
      onWillPop: () async => !_isProcessing,
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.bookingDetails,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            backgroundColor: Colors.white70,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.brown[700]),
              onPressed: _isProcessing ? null : () => Navigator.pop(context),
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
                          AppLocalizations.of(context)!.selectDate,
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
                                      color: isStart
                                          ? Colors.green
                                          : Colors.red,
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
                                label: AppLocalizations.of(context)!.start,
                                date: _startDate,
                                icon: Icons.play_arrow,
                                color: brown,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: _dateBox(
                                label: AppLocalizations.of(context)!.end,
                                date: _endDate,
                                icon: Icons.flag,
                                color: brown,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.availableTimes,
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
                            border: TableBorder.all(
                              color: Colors.grey.shade300,
                            ),
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      AppLocalizations.of(context)!.from,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      AppLocalizations.of(context)!.to,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
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
                  text: _isProcessing
                      ? AppLocalizations.of(context)!.processing
                      : widget.isEdit
                          ? AppLocalizations.of(context)!.updateBooking
                          : AppLocalizations.of(context)!.confirmBooking,
                  color: brown,
                  onPressed: () {
                    if (!_isProcessing) {
                      widget.isEdit ? _updateBooking() : _confirmBooking();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
