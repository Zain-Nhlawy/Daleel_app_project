/*import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/widget/contract_widgets/contract_data_card_widget.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Contract',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list_sharp,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 243, 243, 243),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder(
            future: contractController.loadContracts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No contracts found',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              }

              final contracts = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: ContractDataCardWidget(contract: contracts[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}*/

import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/widget/contract_widgets/contract_data_card_widget.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  late Future<List<Contracts>> _contractsFuture;

  @override
  void initState() {
    super.initState();
    _loadContracts();
  }

  void _loadContracts() {
    _contractsFuture = contractController.loadContracts();
  }

  void _refreshContracts() {
    setState(() {
      _loadContracts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.myContract,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 155, 132),
              Color.fromARGB(255, 243, 243, 243),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FutureBuilder<List<Contracts>>(
            future: _contractsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${AppLocalizations.of(context)!.error}: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.noContractsFound,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                );
              }

              final contracts = snapshot.data!;
              return RefreshIndicator(
                onRefresh: () async => _refreshContracts(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: contracts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ContractDataCardWidget(
                        contract: contracts[index],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

