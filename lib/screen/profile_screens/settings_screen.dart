import 'package:daleel_app_project/core/storage/storage_keys.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/l10n/app_localizations.dart';
import 'package:daleel_app_project/providers.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLang = language;
  bool _isDarkMode = false; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the toggle state based on current brightness
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  final _localizedValues = {
    'en': {'name': 'English (EN)'},
    'ar': {'name': 'العربية (AR)'},
    'fr': {'name': 'Français (FR)'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings, // Changed to Settings since it now does both
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSectionLabel("Appearance"),
              const SizedBox(height: 12),
              _buildThemeToggle(),
              const SizedBox(height: 32),
              _buildSectionLabel("Language"),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLang,
                    icon: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    isExpanded: true,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    items: _localizedValues.keys.map((String langCode) {
                      return DropdownMenuItem<String>(
                        value: langCode,
                        child: Text(_localizedValues[langCode]!['name']!),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() => _selectedLang = newValue);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 48),
              applyButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for section labels
  Widget _buildSectionLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // Styled Switch for Dark Mode
  Widget _buildThemeToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 12),
              Text(
                _isDarkMode ? AppLocalizations.of(context)!.darkMode : AppLocalizations.of(context)!.lightMode,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Switch(
            value: _isDarkMode,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget applyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Save Language
        language = _selectedLang;
        appStorage.write(StorageKeys.language, language);
        appStorage.write(StorageKeys.theme, _isDarkMode ? "dark" : "light");
        
        context.read<SettingsProvider>().changeLanguage(language);
        context.read<SettingsProvider>().changeTheme((_isDarkMode ? ThemeMode.dark : ThemeMode.light));
        
        // Save Theme (Example logic - apply your actual storage key)

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenTabs()),
          (route) => false,
        );
      },
      child: Container(
        // ... (rest of your existing applyButton code)
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.apply,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
