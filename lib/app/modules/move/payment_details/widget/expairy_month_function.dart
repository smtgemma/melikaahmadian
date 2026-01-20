import 'package:flutter/services.dart';

Map<String, String>? parseExpiryDate(String input) {
  if (!input.contains('/')) return null;
  final parts = input.split('/');
  if (parts.length != 2) return null;
  final month = parts[0].padLeft(2, '0'); // 1 → 01
  var year = parts[1];
  if (year.length == 2) year = '20$year'; // 27 → 2027
  return {'month': month, 'year': year};
}


class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    var newText = '';
    for (var i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && i % 4 == 0) newText += ' ';
      newText += digitsOnly[i];
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

