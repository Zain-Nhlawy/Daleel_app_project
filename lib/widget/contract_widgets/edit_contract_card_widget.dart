// ignore_for_file: unused_element, use_build_context_synchronously, deprecated_member_use

import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/screen/details_screens/contract_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:daleel_app_project/models/edit_contract.dart';

class ContractModificationRequestCard extends StatelessWidget {
  final EditContract editContract;
  final Function(EditContract edit) acceptEdit;
  final Function(EditContract edit) rejectEdit;

  const ContractModificationRequestCard({
    super.key,
    required this.editContract,
    required this.acceptEdit,
    required this.rejectEdit,
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
    Contracts contract = Contracts(
      id: editContract.id!,
      startRent: originalContract!.startRent,
      endRent: originalContract.endRent,
      rentFee: originalContract.rentFee,
      rentStatus: originalContract.rentStatus,
      contractApartment: editContract.department!,
      user: editContract.user!,
      departmentRents: originalContract.departmentRents,
    );
    final oldStartDate = originalContract.startRent;
    final oldEndDate = originalContract.endRent;
    final oldRentPrice = originalContract.rentFee;
    final newStartDate = editContract.startRent;
    final newEndDate = editContract.endRent;
    final newRentPrice = double.tryParse(editContract.rentFee ?? '');

    // جلب الـ bottom padding تبع الجهاز
    final double bottomSafeArea = MediaQuery.of(context).padding.bottom;

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
            ElevatedButton(
              onPressed: () {
                print(editContract.user!.firstName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ContractDetails(contract: contract),
                  ),
                );
              },
              child: Text(AppLocalizations.of(context)!.viewContractDetails),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              title: AppLocalizations.of(context)!.currentContract,
              startDate: oldStartDate,
              endDate: oldEndDate,
              rentPrice: oldRentPrice,
            ),
            const Divider(height: 32),
            _buildSection(
              context,
              title: AppLocalizations.of(context)!.proposedChanges,
              startDate: newStartDate,
              endDate: newEndDate,
              rentPrice: newRentPrice,
              highlight: true,
            ),
            const SizedBox(height: 24),
            // Padding الجديد لرفع الأزرار عن منطقة أزرار النظام
            Padding(
              padding: EdgeInsets.only(
                bottom: bottomSafeArea,
              ), // <--- هنا التعديل
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      rejectEdit(editContract);
                    },
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
                    child: Text(AppLocalizations.of(context)!.decline),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {
                      acceptEdit(editContract);
                    },
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
                    child: Text(AppLocalizations.of(context)!.accept),
                  ),
                ],
              ),
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
