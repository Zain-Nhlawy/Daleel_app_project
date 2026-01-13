import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/screen/details_screens/contract_details.dart';
import 'package:flutter/material.dart';
import '../../models/contracts.dart';

class ContractDataCardWidget extends StatefulWidget {
  final Contracts contract;
  const ContractDataCardWidget({super.key, required this.contract});

  @override
  State<ContractDataCardWidget> createState() => _ContractDataCardWidgetState();
}

class _ContractDataCardWidgetState extends State<ContractDataCardWidget> {
  late Contracts contract;

  @override
  void initState() {
    super.initState();
    contract = widget.contract;
  }

  Color _statusColor(BuildContext context, RentStatus status) {
    final scheme = Theme.of(context).colorScheme;

    switch (status) {
      case RentStatus.completed:
        return Colors.green.shade600;
      case RentStatus.pending:
        return Colors.orange.shade600;
      case RentStatus.cancelled:
        return scheme.error;
      case RentStatus.onRent:
        return scheme.primary;
    }
  }

  String _statusText(RentStatus status) {
    String statusText = '';
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
    return statusText;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ContractDetails(contract: contract),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                height: 140,
                width: double.infinity,
                child: contract.contractApartment.images.isNotEmpty
                    ? Image.network(
                        contract.contractApartment.images.first,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          "assets/images/user.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset("assets/images/user.png", fit: BoxFit.cover),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _titleText(
                        context,
                        "${AppLocalizations.of(context)!.renter}: "
                        "${contract.contractApartment.user.firstName}",
                      ),
                      _titleText(
                        context,
                        "${AppLocalizations.of(context)!.tenant}: "
                        "${contract.user.firstName}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateInfo(
                        context,
                        AppLocalizations.of(context)!.start,
                        contract.startRent,
                        Icons.calendar_today_outlined,
                      ),
                      _buildDateInfo(
                        context,
                        AppLocalizations.of(context)!.end,
                        contract.endRent,
                        Icons.calendar_today_outlined,
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor(
                          context,
                          contract.rentStatus,
                        ).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _statusText(contract.rentStatus),
                        style: textTheme.bodyMedium?.copyWith(
                          color: _statusColor(context, contract.rentStatus),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleText(BuildContext context, String text) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Text(
        text,
        style: textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDateInfo(
    BuildContext context,
    String label,
    DateTime date,
    IconData icon,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, color: scheme.onSurface.withOpacity(0.6), size: 18),
        const SizedBox(width: 6),
        Text(
          "$label: ${date.toString().substring(0, 10)}",
          style: textTheme.bodySmall?.copyWith(
            color: scheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
