import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/models/contracts.dart';
import 'package:daleel_app_project/widget/contract_widgets/contract_data_card_widget.dart';
import 'package:flutter/material.dart';

class ContractHistoryScreen extends StatefulWidget {
  const ContractHistoryScreen({super.key});

  @override
  State<ContractHistoryScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractHistoryScreen> {
  List<Contracts> _contracts = [];
  final ScrollController _controller = ScrollController();
  bool _isLoading = true, _hasMore = true;
  int _page = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContracts();
    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 1 &&
          !_isLoading &&
          _hasMore) {
        _loadContracts();
      }
    });
  }

  Future<void> _loadContracts() async {
    try {
      final contracts = await contractController.loadContractsScreen(_page);
      if (mounted) {
        setState(() {
          _contracts += contracts;
          if (contracts.isEmpty) {
            _hasMore = false;
          } else {
            _page++;
          }
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
    setState(() {
      _page = 1;
      _contracts = [];
      _isLoading = true;
    });
    _loadContracts();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.contractHistory,
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: paginationWidget(colorScheme, textTheme)),
      ),
    );
  }

  Widget paginationWidget(ColorScheme colorScheme, TextTheme textTheme) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      );
    }

    if (_error != null) {
      return Center(
        child: Text(
          '${AppLocalizations.of(context)!.error}: $_error',
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
        ),
      );
    }

    if (_contracts.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noContractsFound,
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onBackground),
        ),
      );
    }

    return RefreshIndicator(
      color: colorScheme.primary,
      onRefresh: () async => _refreshContracts(),
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        controller: _controller,
        itemCount: _contracts.length + (_contracts.length >= 10 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _contracts.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ContractDataCardWidget(contract: _contracts[index]),
            );
          }

          if (_hasMore) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              ),
            );
          }

          return const SizedBox(height: 12);
        },
      ),
    );
  }
}
