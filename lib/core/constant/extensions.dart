import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DateFormatter on Jalali{
  String showDate() {
    JalaliFormatter dateFormat = formatter;
    return "${dateFormat.yyyy}/${dateFormat.m}/${dateFormat.d} ${dateFormat.wN}";
  }
}

// extension IntFormat on int{
//   String localFormatNumbers (BuildContext context) {
//     return NumberFormat("",Localizations.localeOf(context).languageCode).format(this);
//   }
// }

extension StringFormat on String {
  String localFormatNumbers(BuildContext context) {
    double? value = double.tryParse(this);

    if (value == null) return this;

    final locale = Localizations.localeOf(context).languageCode;

    // Format the double value according to the locale
    return NumberFormat("#,##0", locale).format(value);
  }
}

extension CustomDate on DateTime {
  String showDate(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    // For Persian (Jalali) Calendar
    if (locale == "fa") {
      final jalali = toJalali();
      final year = NumberFormat("", locale).format(jalali.year);
      final month = _jalaliMonthName(jalali.month);
      final day = NumberFormat("", locale).format(jalali.day);
      return "$day $month $year";
    }
    // For Gregorian Calendar
    else {
      final year = DateFormat.y().format(this);  // Year with correct locale
      final month = DateFormat.MMMM(locale).format(this); // Full month name
      final day = DateFormat.d(locale).format(this); // Day
      return "$day $month $year";
    }
  }

  // Helper method to get Jalali month names
  String _jalaliMonthName(int month) {
    const jalaliMonths = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند'
    ];
    return jalaliMonths[month - 1];  // month is 1-based
  }
}


class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int value = int.parse(newValue.text.replaceAll('.', ''));
    final String formattedValue = NumberFormat('#,###').format(value);
    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
