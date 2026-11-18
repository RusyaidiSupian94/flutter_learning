import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

class HeaderPage extends StatefulWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onHelpTap;
  final String initialCurrency;
  final String initialLanguage;
  final ValueChanged<String>? onCurrencyChanged;
  final ValueChanged<String>? onLanguageChanged;

  const HeaderPage({
    super.key,
    this.onLogoTap,
    this.onHelpTap,
    this.initialCurrency = 'MYR',
    this.initialLanguage = 'BM',
    this.onCurrencyChanged,
    this.onLanguageChanged,
  });

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  String selectedCurrency = 'MYR';
  String selectedLanguage = 'BM';

  final Color teal = const Color(0xFF2DBEAA);

  final List<String> currencies = ['MYR', 'USD', 'SGD', 'THB'];

  final List<String> languages = ['EN', 'BM'];

  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.initialCurrency;
    selectedLanguage = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 66,
      ),
      color: Colors.white,
      child: Row(
        children: [
          //LOGO
          InkWell(
            onTap: widget.onLogoTap,
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/travelbuddylogo.png',
              height: 42,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Travel Buddy',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF102A40),
                  ),
                );
              },
            ),
          ),
          const Spacer(),

          //HELP CENTRE
          if (MediaQuery.of(context).size.width >= 600) ...[
            const Text(
              'Perlukan',
              style: TextStyle(fontSize: 11, color: Color(0xFF71828D)),
            ),
            const SizedBox(width: 4),
          ],
          InkWell(
            onTap: widget.onHelpTap,
            child: Text(
              'Bantuan?',
              style: TextStyle(
                color: teal,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 20),
          //DIVIDER
          Container(height: 25, width: 1, color: const Color(0xFFE0E8E3)),
          const SizedBox(width: 12),

          //CURRENCY DROPDOWN
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCurrency,
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 16),
              style: const TextStyle(fontSize: 11, color: Color(0xFF71828D)),
              items: currencies.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCurrency = value;
                  });

                  widget.onCurrencyChanged?.call(value);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          //LANGUAGE DROPDOWN
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 16),
              style: const TextStyle(fontSize: 11, color: Color(0xFF71828D)),
              items: languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedLanguage = value;
                  });
                  widget.onLanguageChanged?.call(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
