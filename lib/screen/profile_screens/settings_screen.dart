import 'package:daleel_app_project/core/storage/storage_keys.dart';
import 'package:daleel_app_project/dependencies.dart';
import 'package:daleel_app_project/language_provider.dart';
import 'package:daleel_app_project/main.dart';
import 'package:daleel_app_project/screen/tabs_screen/home_screen_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}
class _SettingsScreenState extends State<SettingsScreen>{
  String _selectedLang = language;
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
          'Language Selector',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        // Use primary brown from your theme
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
              // Styled Dropdown Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLang,
                    // Dynamic icon color based on primary theme
                    icon: Icon(Icons.language, color: Theme.of(context).colorScheme.primary),
                    dropdownColor: Theme.of(context).colorScheme.surface,
                    isExpanded: true, // Makes it look better inside the container
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
                      if(newValue != null) {
                        setState((){
                          _selectedLang = newValue;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Your "Apply" button called here
              applyButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget applyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        language = _selectedLang;
        appStorage.write(StorageKeys.language, language);
        context.read<LanguageProvider>().changeLanguage(language);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenTabs()),
          (route) => false,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
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
              "APPLY",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0
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