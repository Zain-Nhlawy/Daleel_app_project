import 'package:daleel_app_project/dependencies.dart';
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
            icon: const Icon(Icons.filter_list_sharp, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: contractController.loadContracts(),
          builder: (context, snapshot) {
            /// loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            /// error
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            /// no data
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No contracts found'));
            }

            final contracts = snapshot.data!;

            return ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return ContractDataCardWidget(contract: contracts[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
