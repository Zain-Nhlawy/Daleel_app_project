import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/models/edit_contract.dart';
import 'package:daleel_app_project/widget/contract_widgets/contract_data_card_widget.dart';
import 'package:daleel_app_project/widget/contract_widgets/edit_contract_card_widget.dart';
import 'package:flutter/material.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({super.key});

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _contractsController = ScrollController();
  final ScrollController _editsController = ScrollController();

  List<Contracts> _contracts = [];
  List<EditContract> _edits = [];

  bool _isLoadingContracts = true;
  bool _isLoadingEdits = true;
  bool _hasMoreContracts = true;
  bool _hasMoreEdits = true;

  int _contractsPage = 1;
  int _editsPage = 1;

  String? _contractsError;
  String? _editsError;

  @override
  void initState() {
    super.initState();
    _loadInitialData();

    _contractsController.addListener(() {
      if (_contractsController.position.pixels >=
              _contractsController.position.maxScrollExtent - 200 &&
          !_isLoadingContracts &&
          _hasMoreContracts) {
        _loadContracts();
      }
    });

    _editsController.addListener(() {
      if (_editsController.position.pixels >=
              _editsController.position.maxScrollExtent - 200 &&
          !_isLoadingEdits &&
          _hasMoreEdits) {
        _loadEdits();
      }
    });
  }

  void _loadInitialData() {
    _loadContracts();
    _loadEdits();
  }

  @override
  void dispose() {
    _contractsController.dispose();
    _editsController.dispose();
    super.dispose();
  }

  Future<void> _loadContracts({bool isRefresh = false}) async {
    if (isRefresh) {
      _contractsPage = 1;
      _contracts = [];
      _hasMoreContracts = true;
      _contractsError = null;
    }

    setState(() {
      _isLoadingContracts = true;
    });

    try {
      final newContracts = (await contractController.loadContractsHistory(
        _contractsPage,
      ));
      if (mounted) {
        setState(() {
          _contracts.addAll(newContracts);
          if (newContracts.isEmpty) {
            _hasMoreContracts = false;
          } else {
            _contractsPage++;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _contractsError = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingContracts = false;
        });
      }
    }
  }

  Future<void> _loadEdits({bool isRefresh = false}) async {
    if (isRefresh) {
      _editsPage = 1;
      _edits = [];
      _hasMoreEdits = true;
      _editsError = null;
    }

    setState(() {
      _isLoadingEdits = true;
    });

    try {
      final newEdits = (await editContractController.loadContractsEdit(
        _editsPage,
      ));
      if (mounted) {
        setState(() {
          _edits.addAll(newEdits);
          if (newEdits.isEmpty) {
            _hasMoreEdits = false;
          } else {
            _editsPage++;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _editsError = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingEdits = false;
        });
      }
    }
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
              Tab(text: "Edits Request"),
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
            children: [_buildContractsView(), _buildEditsView()],
          ),
        ),
      ),
    );
  }

  Widget _buildContractsView() {
    if (_isLoadingContracts && _contracts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_contractsError != null) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.error}: $_contractsError'),
      );
    }

    if (_contracts.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noContractsFound),
      );
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _loadContracts(isRefresh: true),
        child: ListView.builder(
          controller: _contractsController,
          padding: const EdgeInsets.all(8.0),
          itemCount: _contracts.length + (_hasMoreContracts ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _contracts.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ContractDataCardWidget(contract: _contracts[index]),
              );
            }
            return const Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditsView() {
    if (_isLoadingEdits && _edits.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_editsError != null) {
      return Center(
        child: Text('${AppLocalizations.of(context)!.error}: $_editsError'),
      );
    }

    if (_edits.isEmpty) {
      return const Center(child: Text("No Edit Requests Found"));
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _loadEdits(isRefresh: true),
        child: ListView.builder(
          controller: _editsController,
          padding: const EdgeInsets.all(8.0),
          itemCount: _edits.length + (_hasMoreEdits ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _edits.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ContractModificationRequestCard(
                  editContract: _edits[index],  
                ),
              );
            }
            return const Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
