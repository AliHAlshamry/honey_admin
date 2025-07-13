import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  final NumberFormat _intFmt = NumberFormat('#,##0', 'en_US');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // strip out existing commas
    String raw = newValue.text.replaceAll(',', '');
    if (raw.isEmpty) return newValue;
    // bail if not a valid double
    if (double.tryParse(raw) == null) return oldValue;
    // split int / dec
    final parts = raw.split('.');
    final formattedInt = _intFmt.format(int.parse(parts[0]));
    final output = parts.length > 1 ? '$formattedInt.${parts[1]}' : formattedInt;
    return TextEditingValue(
      text: output,
      selection: TextSelection.collapsed(offset: output.length),
    );
  }
}
