import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/screen/booking_screen.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/widget/contract_widgets/timer_for_contract_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ContractDetails extends StatefulWidget {
  final Contracts contract;
  const ContractDetails({super.key, required this.contract});

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  late Contracts contract;

  @override
  void initState() {
    super.initState();
    contract = widget.contract;
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

  Future<void> _updateContract(DateTime start, DateTime end) async {
    final updated = await contractController.updateRent(
      rentId: contract.id,
      start: start,
      end: end,
    );

    if (updated != null) {
      setState(() {
        contract = updated;
      });
    }
  }

  Future<void> _approveContract() async {
    final approved = await contractController.approveContract(
      rentId: contract.id,
    );

    setState(() {
      contract = approved;
    });
  }

  Future<Contracts> _rejectContract() async {
    final rejected = await contractController.rejectContract(
      rentId: contract.id,
    );

    setState(() {
      contract = rejected;
    });

  return rejected;
}

double calculateCancellationFee({
  required double rentFee,
  required int untilStartDays,
}) {
  final factor = 2 / exp((1 / 3) * (untilStartDays - 1));
  final percentage = min(1, factor);
  return rentFee * percentage;
}

Future<void> _handleCancelContract() async {
  int untilStartDays =
      contract.startRent.difference(DateTime.now()).inDays;

  if (untilStartDays < 0) {
    untilStartDays = 0;
  }

  final cancelFee = calculateCancellationFee(
    rentFee: contract.rentFee,
    untilStartDays: untilStartDays,
  );

  if (contract.rentStatus == RentStatus.cancelled) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.info),
        content: Text(
          AppLocalizations.of(context)!.contractAlreadyCancelled,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.okay),
          ),
        ],
      ),
    );
    return;
  }

  final confirm = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.confirm),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.confirmCancelContract,
          ),
          const SizedBox(height: 12),
          Text(
            '${AppLocalizations.of(context)!.daysUntilStart}: $untilStartDays',
          ),
          const SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.cancellationFee}: '
            '${cancelFee.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(AppLocalizations.of(context)!.no),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(AppLocalizations.of(context)!.yes),
        ),
      ],
    ),
  );

  if (confirm != true) return;

  try {
    await contractController.cancelRent(rentId: contract.id);

    if (!mounted) return;

    setState(() {
      contract = contract.copyWith(
        rentStatus: RentStatus.cancelled,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.contractCancelled,
        ),
      ),
    );

    Navigator.pop(context);
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(extractCleanErrorMessage(e)),
      ),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    final Contracts contract = this.contract;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final User? user = userController.user;
    final bool isTenant = (user != null && contract.user.userId == user.userId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.contractDetails,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 120, bottom: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CountdownTimerBox(
                  endDate: contract.endRent,
                  status: contract.rentStatus,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSection(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildDetailsSection(context, colorScheme),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (user != null)
          ? _buildBottomActions(
              context,
              contract,
              isTenant: isTenant,
              onUpdate: _updateContract,
              onApprove: _approveContract,
              onReject: _rejectContract,
              onCancelPressed: _handleCancelContract,
              extractErrorMessage: extractCleanErrorMessage,
            )
          : null,
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: contract.contractApartment.images.isNotEmpty
          ? Image.network(
              contract.contractApartment.images[0],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildImageError(),
            )
          : _buildImageError(),
    );
  }

  Widget _buildImageError() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
    );
  }

  Widget _buildDetailsSection(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                contract.contractApartment.headDescription ?? 'N/A',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 10),
            _buildStatusChip(contract.rentStatus, colorScheme),
          ],
        ),
        const SizedBox(height: 16),
        _buildDetailRow(
          context,
          Icons.monetization_on,
          '${AppLocalizations.of(context)!.rentFee}:',
          '\$${contract.rentFee.toStringAsFixed(2)}/${AppLocalizations.of(context)!.day}',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            thickness: 1,
            color: colorScheme.onSurface.withOpacity(0.1),
          ),
        ),
        _buildSectionHeader(
          context,
          AppLocalizations.of(context)!.contractPeriod,
          colorScheme.primary,
        ),
        const SizedBox(height: 16),
        _buildDetailRow(
          context,
          Icons.calendar_today,
          '${AppLocalizations.of(context)!.startDate}:',
          '${contract.startRent.toLocal()}'.split(' ')[0],
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          context,
          Icons.calendar_today,
          '${AppLocalizations.of(context)!.endDate}:',
          '${contract.endRent.toLocal()}'.split(' ')[0],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(
            thickness: 1,
            color: colorScheme.onSurface.withOpacity(0.1),
          ),
        ),
        _buildSectionHeader(
          context,
          AppLocalizations.of(context)!.partiesInvolved,
          colorScheme.primary,
        ),
        const SizedBox(height: 16),
        _buildPartyInfo(
          context,
          AppLocalizations.of(context)!.renter,
          contract.contractApartment.user,
          colorScheme.onSurface.withOpacity(0.1),
        ),
        const SizedBox(height: 16),
        _buildPartyInfo(
          context,
          AppLocalizations.of(context)!.tenant,
          contract.user,
          colorScheme.onSurface.withOpacity(0.1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.home_outlined),
              label: Text(AppLocalizations.of(context)!.viewApartmentDetails),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApartmentDetailsScreen(
                      apartment: contract.contractApartment,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(RentStatus status, ColorScheme colorScheme) {
    Color chipColor;
    String statusText = '';
    switch (status) {
      case RentStatus.completed:
        chipColor = Colors.green;
        break;
      case RentStatus.onRent:
        chipColor = Colors.blue;
        break;
      case RentStatus.pending:
        chipColor = Colors.orange;
        break;
      case RentStatus.cancelled:
        chipColor = Colors.red;
        break;
    }
    switch (status) {
      case RentStatus.completed:
        statusText = AppLocalizations.of(context)!.completed;
        break;
      case RentStatus.onRent:
        statusText = AppLocalizations.of(context)!.onRent;
        break;
      case RentStatus.pending:
        statusText = AppLocalizations.of(context)!.pending;
        break;
      case RentStatus.cancelled:
        statusText = AppLocalizations.of(context)!.cancelled;
        break;
    }
    return Chip(
      label: Text(
        statusText,
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 22),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, Color color) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildPartyInfo(
    BuildContext context,
    String role,
    dynamic user,
    Color dividerColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          role,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          context,
          Icons.person_outline,
          '${AppLocalizations.of(context)!.name}:',
          user.firstName ?? 'N/A',
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          context,
          Icons.phone_outlined,
          '${AppLocalizations.of(context)!.number}:',
          user.phone ?? 'N/A',
        ),
      ],
    );
  }
}

Widget _buildBottomActions(
  BuildContext context,
  Contracts contract, {
  required bool isTenant,
  required Future<void> Function(DateTime, DateTime) onUpdate,
  required Future<void> Function() onApprove,
  required Future<Contracts> Function() onReject,
  required VoidCallback onCancelPressed,
  required String Function(dynamic error) extractErrorMessage, 
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final bool hideActions = contract.rentStatus == RentStatus.cancelled ||
contract.rentStatus == RentStatus.completed ||
contract.endRent.isBefore(DateTime.now()) ||
    (!isTenant && contract.rentStatus == RentStatus.onRent);

  if (hideActions) {
    return const SizedBox.shrink(); 
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: colorScheme.surface,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      border: Border(
        top: BorderSide(color: colorScheme.onSurface.withOpacity(0.1)),
      ),
    ),
    child: Row(
      children: [
        if (isTenant) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingCalendar(
                      apartment: contract.contractApartment,
                      contract: contract,
                    ),
                  ),
                );

                if (result != null && result is Map<String, DateTime>) {
                  final newStart = result['start']!;
                  final newEnd = result['end']!;
                  await onUpdate(newStart, newEnd);
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.primary,
                side: BorderSide(color: colorScheme.primary),
              ),
              child: Text(AppLocalizations.of(context)!.edit),
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: onCancelPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.error,
                side: BorderSide(color: colorScheme.error),
              ),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ),
        ] else ...[
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                try {
                  await onApprove();
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 60),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.contractApprovedSuccessfully,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.okay),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.error),
                      content: Text(extractErrorMessage(e)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.okay),
                        ),
                      ],
                    ),
                  );
                }

              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: const BorderSide(color: Colors.green),
              ),
              child: Text(AppLocalizations.of(context)!.accept),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(AppLocalizations.of(context)!.confirm),
                    content: Text(
                      AppLocalizations.of(context)!.confirmRejectContract,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text(AppLocalizations.of(context)!.no),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text(AppLocalizations.of(context)!.yes),
                      ),
                    ],
                  ),
                );

                if (confirm != true) return;

                try {
                  await onReject();
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.cancel, color: Colors.red, size: 60),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.contractRejectedSuccessfully,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.okay),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.error),
                      content: Text(extractErrorMessage(e)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text(AppLocalizations.of(context)!.okay),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.error,
                side: BorderSide(color: colorScheme.error),
              ),
              child: Text(AppLocalizations.of(context)!.reject),
            ),
          ),
        ],
      ],
    ),
  );
}

