import 'package:daleel_app_project/screen/details_screens/contract_details.dart';
import 'package:flutter/material.dart';
import '../../models/contracts.dart';

class ContractDataCardWidget extends StatelessWidget {
  const ContractDataCardWidget({super.key, required this.contract});

  final Contracts contract;

  Color _statusColor(RentStatus status) {
    switch (status) {
      case RentStatus.completed:
        return Colors.green.shade700;
      case RentStatus.pending:
        return Colors.orange.shade700;
      case RentStatus.cancelled:
        return Colors.red.shade700;
      case RentStatus.onRent:
        return Colors.blue.shade700;
    }
  }

  String _statusText(RentStatus status) {
    return status.toString().split('.').last;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              builder: (context) => ContractDetails(contract: contract),
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
                child:
                    contract.contractApartment.images != null &&
                        contract.contractApartment.images!.isNotEmpty
                    ? Image.network(
                        contract.contractApartment.images![0],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.cover,
                            ),
                      )
                    : Image.asset(
                        "assets/images/user.png",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Renter: ${contract.contractApartment.user.firstName}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Tenant: ${contract.user.firstName}",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateInfo(
                        context,
                        "Start",
                        contract.startRent,
                        Icons.calendar_today_outlined,
                      ),
                      _buildDateInfo(
                        context,
                        "End",
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
                          contract.rentStatus,
                        ).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _statusText(contract.rentStatus),
                        style: TextStyle(
                          color: _statusColor(contract.rentStatus),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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

  Widget _buildDateInfo(
    BuildContext context,
    String label,
    DateTime date,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 18),
        const SizedBox(width: 6),
        Text(
          "$label: ${date.toString().substring(0, 10)}",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
