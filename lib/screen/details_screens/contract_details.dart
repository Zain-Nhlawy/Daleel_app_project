import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/screen/details_screens/ApartmentDetails_screen.dart';
import 'package:daleel_app_project/widget/contract_widgets/timer_for_contract_widget.dart';
import 'package:flutter/material.dart';

class ContractDetails extends StatelessWidget {
  final Contracts contract;
  const ContractDetails({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF795548);
    const Color accentColor = Color(0xFFD7CCC8);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Contract Details",
          style: TextStyle(
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
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child:
          contract.contractApartment.images != null &&
              contract.contractApartment.images!.isNotEmpty
          ? Image.network(
              contract.contractApartment.images![0],
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
          'Rent Fee:',
          '\$${contract.rentFee.toStringAsFixed(2)}/month',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(thickness: 1, color: accentColor),
        ),
        _buildSectionHeader(context, 'Contract Period', primaryColor),
        const SizedBox(height: 16),
        _buildDetailRow(
          context,
          Icons.calendar_today,
          'Start Date:',
          '${contract.startRent.toLocal()}'.split(' ')[0],
        ),
        const SizedBox(height: 12),
        _buildDetailRow(
          context,
          Icons.calendar_today,
          'End Date:',
          '${contract.endRent.toLocal()}'.split(' ')[0],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Divider(thickness: 1, color: accentColor),
        ),
        _buildSectionHeader(context, 'Parties Involved', primaryColor),
        const SizedBox(height: 16),
        _buildPartyInfo(
          context,
          'Renter',
          contract.contractApartment.user,
          accentColor,
        ),
        const SizedBox(height: 16),
        _buildPartyInfo(context, 'Tenant', contract.user, accentColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.home_outlined),
              label: const Text('View Apartment Details'),
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
          'Name:',
          user.firstName ?? 'N/A',
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          context,
          Icons.phone_outlined,
          'Number:',
          user.phone ?? 'N/A',
        ),
      ],
    );
  }
}
