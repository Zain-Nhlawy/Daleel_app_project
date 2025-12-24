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

class _ContractScreenState extends State<ContractScreen>
    with SingleTickerProviderStateMixin {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.myContracts,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            labelStyle: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: "Contracts"),
              Tab(text: "ٌEdits Request"),
            ],
          ),
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
          child: TabBarView(
            children: [_buildContractsView(), _buildAmendmentsView()],
          ),
        ),
      ),
    );
  }

  Widget _buildContractsView() {
    return SafeArea(
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
          final realTimeContract = contracts
              .where(
                (a) =>
                    a.rentStatus == RentStatus.onRent ||
                    a.rentStatus == RentStatus.pending,
              )
              .toList();
          if (realTimeContract.isEmpty) {
            return const Center(child: Text("No Contract Found"));
          }
          return RefreshIndicator(
            onRefresh: () async => _refreshContracts(),
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: realTimeContract.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ContractDataCardWidget(
                    contract: realTimeContract[index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildAmendmentsView() {
    return const SafeArea(
      child: Center(
        child: Text(
          "Contract Amendments Screen",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
