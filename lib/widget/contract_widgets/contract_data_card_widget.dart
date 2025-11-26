import 'package:flutter/material.dart';
import '../../models/contracts.dart';

class ContractDataCardWidget extends StatelessWidget {
  const ContractDataCardWidget({super.key, required this.contract});
  final Contracts contract;

  Color _statusColor(RentStatus status) {
    switch (status) {
      case RentStatus.completed:
        return Colors.green;
      case RentStatus.pending:
        return Colors.orange;
      case RentStatus.cancelled:
        return Colors.red;
      case RentStatus.onRent:
        return Colors.blue;
    }
  }

  String _statusText(RentStatus status) {
    return status.toString().split('.').last;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: _statusColor(contract.rentStatus).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _statusText(contract.rentStatus),
                  style: TextStyle(
                    color: _statusColor(contract.rentStatus),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Renter: ${contract.renterName}",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Tenant: ${contract.tenantName}",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start: ${contract.startRent.toString().substring(0, 10)}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  Text(
                    "End: ${contract.endRent.toString().substring(0, 10)}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                "Fee: ${contract.rentFee} JD",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                contract.contractApartment.apartmentCountry,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
