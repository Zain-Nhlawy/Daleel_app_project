import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/widget/contract_widgets/timer_for_contract_widget.dart';
import 'package:flutter/material.dart';

class ContractDetails extends StatelessWidget {
  const ContractDetails({super.key, required this.contract});

  final Contracts contract;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contract Details',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CountdownTimerBox(
            endDate: DateTime(
              contract.endRent.year,
              contract.endRent.month,
              contract.endRent.day,
              contract.endRent.hour,
              contract.endRent.minute,
              contract.endRent.second,
            ),
            status: contract.rentStatus,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 15),
              Text(
                'Renter :',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              SizedBox(width: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 25),

              Text('Zain Nhlawy', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline, color: Colors.brown),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 15),
              Text(
                'Tenant :',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 25),
              Text('Abo Abdo', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.info_outline, color: Colors.brown),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
