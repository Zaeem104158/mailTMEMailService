import 'dart:core';

extension CapitalizeString on String {
  get allWordsCapitalize {
    return toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }
}
