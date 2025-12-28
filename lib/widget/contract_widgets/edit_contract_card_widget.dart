import 'package:daleel_app_project/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:daleel_app_project/models/edit_contract.dart';

class ContractModificationRequestCard extends StatelessWidget {
  final EditContract editContract;

  const ContractModificationRequestCard({
    super.key,
    required this.editContract,
  });

  void approvingEdit() {
    editContractController.approvingEdit(editContract.id!);
  }

  void cancelEdit() {
    editContractController.rejectingEdit(editContract.id!);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatPrice(double? price) {
    if (price == null) return 'N/A';
    return '\$${price.toStringAsFixed(2)} / day';
  }

  @override
  Widget build(BuildContext context) {
    final originalContract = editContract.originalRent;

    final oldStartDate = originalContract?.startRent;
    final oldEndDate = originalContract?.endRent;
    final oldRentPrice = originalContract?.rentFee;

    final newStartDate = editContract.startRent;
    final newEndDate = editContract.endRent;
    final newRentPrice = double.tryParse(editContract.rentFee ?? '');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contract Modification Request',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: 'Current Contract',
              startDate: oldStartDate,
              endDate: oldEndDate,
              rentPrice: oldRentPrice,
            ),
            const Divider(height: 32),
            _buildSection(
              context,
              title: 'Proposed Changes',
              startDate: newStartDate,
              endDate: newEndDate,
              rentPrice: newRentPrice,
              highlight: true,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: cancelEdit,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                    side: BorderSide(color: Colors.red.shade700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Decline'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: approvingEdit,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 104, 190, 34),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 48, 211, 42),
                    ),
                    backgroundColor: const Color.fromARGB(0, 56, 142, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Accept'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required DateTime? startDate,
    required DateTime? endDate,
    required double? rentPrice,
    bool highlight = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow(
          context,
          icon: Icons.calendar_today_outlined,
          label: 'Start Date',
          value: _formatDate(startDate),
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          icon: Icons.event_busy_outlined,
          label: 'End Date',
          value: _formatDate(endDate),
        ),
        const SizedBox(height: 8),
        _buildInfoRow(
          context,
          icon: Icons.monetization_on_outlined,
          label: 'Rent Price',
          value: _formatPrice(rentPrice),
          isHighlighted: highlight,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    final valueStyle = TextStyle(
      fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
      color: isHighlighted
          ? Theme.of(context).primaryColorDark
          : Colors.black54,
      fontSize: 15,
    );
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 15)),
        const Spacer(),
        Text(value, style: valueStyle),
      ],
    );
  }
}
