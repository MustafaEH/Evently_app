import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'language';

  ThemeMode _currentTheme = ThemeMode.light;
  String _currentLanguage = "en";
  bool _isInitialized = false;

  ThemeMode get currentTheme => _currentTheme;
  String get currentLanguage => _currentLanguage;
  bool get isLightMode => _currentTheme == ThemeMode.light;
  bool get isDarkMode => _currentTheme == ThemeMode.dark;
  bool get isEnglish => _currentLanguage == "en";
  bool get isArabic => _currentLanguage == "ar";
  bool get isInitialized => _isInitialized;

  ConfigProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load theme
      final themeIndex = prefs.getInt(_themeKey) ?? 0;
      _currentTheme = ThemeMode.values[themeIndex];

      // Load language
      _currentLanguage = prefs.getString(_languageKey) ?? "en";

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      // Use defaults if loading fails
      _currentTheme = ThemeMode.light;
      _currentLanguage = "en";
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save theme
      await prefs.setInt(_themeKey, _currentTheme.index);

      // Save language
      await prefs.setString(_languageKey, _currentLanguage);
    } catch (e) {
      // Handle save error silently
      debugPrint('Failed to save preferences: $e');
    }
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (_currentTheme == newTheme) return;

    _currentTheme = newTheme;
    notifyListeners();
    await _savePreferences();
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (_currentLanguage == newLanguage) return;

    _currentLanguage = newLanguage;
    notifyListeners();
    await _savePreferences();
  }

  Future<void> toggleTheme() async {
    final newTheme =
        _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await changeTheme(newTheme);
  }

  Future<void> resetToDefaults() async {
    _currentTheme = ThemeMode.light;
    _currentLanguage = "en";
    notifyListeners();
    await _savePreferences();
  }

  String getThemeDisplayName() {
    switch (_currentTheme) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  String getLanguageDisplayName() {
    switch (_currentLanguage) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }
}
