import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/widget/contract_widgets/timer_for_contract_widget.dart';
import 'package:flutter/material.dart';

class ContractDetails extends StatelessWidget {
  final Contracts contract;

  const ContractDetails({super.key, required this.contract});

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
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: chipColor.withOpacity(0.75),

      padding: EdgeInsets.symmetric(horizontal: 12.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contract Details"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CountdownTimerBox(
              endDate: contract.endRent,
              status: contract.rentStatus,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5.0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/user.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                contract.contractApartment.headDescription!,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildStatusChip(contract.rentStatus),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildDetailRow(
                          Icons.monetization_on,
                          'Rent Fee:',
                          '\$${contract.rentFee.toStringAsFixed(2)}/month',
                        ),
                        Divider(height: 30, thickness: 1),

                        Center(
                          child: ActionChip(
                            label: Text('View Apartment Details'),
                            avatar: Icon(Icons.home),
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
                          ),
                        ),
                        Divider(height: 30, thickness: 1),

                        _buildSectionHeader(context, 'Contract Period'),
                        SizedBox(height: 16),
                        _buildDetailRow(
                          Icons.calendar_today,
                          'Start Date:',
                          '${contract.startRent.toLocal()}'.split(' ')[0],
                        ),
                        SizedBox(height: 8),
                        _buildDetailRow(
                          Icons.calendar_today,
                          'End Date:',
                          '${contract.endRent.toLocal()}'.split(' ')[0],
                        ),
                        Divider(height: 30, thickness: 1),

                        _buildSectionHeader(context, 'Parties Involved'),
                        SizedBox(height: 16),
                        _buildPartyInfo(
                          'Renter',
                          contract.user.firstName,
                          contract.user.firstName,
                        ),
                        SizedBox(height: 16),
                        _buildPartyInfo(
                          'Tenant',
                          contract.user.firstName,
                          contract.user.firstName,
                        ),
                        Divider(height: 30, thickness: 1),

                        _buildSectionHeader(context, 'Description'),
                        SizedBox(height: 10),
                        Text(
                          contract.contractApartment.headDescription!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
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
}

Widget _buildDetailRow(IconData icon, String title, String value) {
  return Row(
    children: [
      Icon(icon, color: Colors.grey[600], size: 20),
      SizedBox(width: 12),
      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Spacer(),
      Text(value, style: TextStyle(fontSize: 16)),
    ],
  );
}

Widget _buildSectionHeader(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      color: Theme.of(context).primaryColor,
    ),
  );
}

Widget _buildPartyInfo(String role, String name, String number) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        role,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            _buildDetailRow(Icons.person, 'Name:', name),
            SizedBox(height: 8),
            _buildDetailRow(Icons.phone, 'Number:', number),
          ],
        ),
      ),
    ],
  );
}
