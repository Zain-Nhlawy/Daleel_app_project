import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/models/user.dart';
import 'package:daleel_app_project/screen/booking_screen.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/widget/contract_widgets/timer_for_contract_widget.dart';
import 'package:flutter/material.dart';

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


  @override
  Widget build(BuildContext context) {

    final Contracts contract = this.contract;

    const Color primaryColor = Color(0xFF795548);
    const Color accentColor = Color(0xFFD7CCC8);

    final User? user = userController.user;
    // ignore: unused_local_variable
    final bool isTenant = (user != null && contract.user.userId == user.userId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.contractDetails,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 255, 255, 255),
            ],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSection(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildDetailsSection(
                          context,
                          primaryColor,
                          accentColor,
                        ),
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
              isTenant: contract.user.userId == user.userId,
              onUpdate: _updateContract,
              onApprove: _approveContract,
              onReject: _rejectContract,
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

  Widget _buildDetailsSection(
    BuildContext context,
    Color primaryColor,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                contract.contractApartment.headDescription!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(width: 10),
            _buildStatusChip(contract.rentStatus),
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
          child: Divider(thickness: 1, color: accentColor),
        ),
        _buildSectionHeader(
          context,
          AppLocalizations.of(context)!.contractPeriod,
          primaryColor,
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
          child: Divider(thickness: 1, color: accentColor),
        ),
        _buildSectionHeader(
          context,
          AppLocalizations.of(context)!.partiesInvolved,
          primaryColor,
        ),
        const SizedBox(height: 16),
        _buildPartyInfo(
          context,
          AppLocalizations.of(context)!.renter,
          contract.contractApartment.user,
          accentColor,
        ),
        const SizedBox(height: 16),
        _buildPartyInfo(
          context,
          AppLocalizations.of(context)!.tenant,
          contract.user,
          accentColor,
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
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
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

  Widget _buildStatusChip(RentStatus status) {
    Color chipColor;
    String statusText = status.toString().split('.').last;
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
    return Chip(
      label: Text(
        statusText,
        style: const TextStyle(
          color: Colors.white,
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
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      border: Border(top: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Row(
      children: [
        if (isTenant) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => BookingCalendar(
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
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
              ),
              child: Text(AppLocalizations.of(context)!.edit),
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
                      AppLocalizations.of(context)!.confirmCancelContract,
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

                if (confirm == true) {
                  try {
                    await contractController.cancelRent(rentId: contract.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.contractCancelled,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
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
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!
                                .contractApprovedSuccessfully,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
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
                      content: Text(e.toString()),
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
                    content: Text(AppLocalizations.of(context)!.confirmRejectContract),
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
                            style: const TextStyle(fontSize: 16),
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
                      content: Text(e.toString()),
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
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: Text(AppLocalizations.of(context)!.reject),
            ),
          ),
        ],
      ],
    ),
  );
}
