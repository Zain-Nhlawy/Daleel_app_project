import 'package:daleel_app_project/screen/details_screens/contract_details.dart';
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContractDetails(contract: contract),
            ),
          );
        },
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Renter: ${contract.user.firstName}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Tenant: ${contract.user.firstName}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        //   Icon(Icons.calendar_today_rounded, color: Colors.brown),
                        const SizedBox(width: 6),
                        Text(
                          "Start: ${contract.startRent.toString().substring(0, 10)}",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 15, color: Colors.black54),
                        ),
                        const SizedBox(width: 60),
                        // Icon(Icons.calendar_today_rounded, color: Colors.brown),
                        const SizedBox(width: 6),
                        Text(
                          "End: ${contract.endRent.toString().substring(0, 10)}",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor(
                          contract.rentStatus,
                        ).withOpacity(0.15),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
