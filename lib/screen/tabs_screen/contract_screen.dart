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
  List<Contracts> _contracts = [];
  final ScrollController _controller = ScrollController();
  bool _isLoading = true, _hasMore = true;
  int _page = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContracts();
  }

  Future<void> _loadContracts() async {
    try {
      final contracts = (await contractController.loadContractsHistory(_page));
      if (mounted) {
        setState(() {
          _contracts += contracts;
          if(contracts.isEmpty) _hasMore = false;
          else _page++;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _refreshContracts() {
    _page = 1;
    _contracts = [];
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.error}: $_error'),
      );
    }

    if (_contracts.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noContractsFound),
      );
    }
    
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => _refreshContracts(),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount:_contracts.length + (_contracts.length >= 10 ? 1 : 0),
          itemBuilder: (context, index) {
            if(index < _contracts.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ContractDataCardWidget(
                  contract: _contracts[index],
                ),
              );
            }
            if(_hasMore) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            else {
              return const SizedBox(height: 10);
            }
          }
        ),
      )
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
