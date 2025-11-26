import 'package:daleel_app_project/data/dummy_data.dart';
import 'package:daleel_app_project/widget/contract_widgets/contract_data_card_widget.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Contract',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list_sharp, size: 30),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contractsData.length,
        itemBuilder: (context, index) {
          return ContractDataCardWidget(contract: contractsData[index]);
        },
      ),
    );
  }
}
