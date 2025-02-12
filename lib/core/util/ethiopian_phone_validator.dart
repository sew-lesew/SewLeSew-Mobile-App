// Ethiopian Phone Number Validation Utility
class EthiopianPhoneValidator {
  static final RegExp mobilePattern = RegExp(r'^(\+251|0)(9\d{8})$');
  static final RegExp fixedLinePattern = RegExp(r'^(\+251|0)([1-7]\d{8})$');
  static final RegExp tollFreePattern = RegExp(r'^(\+251|0)(800\d{6})$');

  // Normalize the number by removing unwanted characters
  static String normalize(String? number) {
    String cleaned = number!.replaceAll(
        RegExp(r'[\s\-\(\)]'), ''); // Remove whitespace and special characters

    if (cleaned.startsWith('0')) {
      cleaned =
          '+251${cleaned.substring(1)}'; // Prepend country code if missing
    }

    return cleaned;
  }

  // Single validation method for Ethiopian phone numbers
  static bool isValidPhoneNumber(String number) {
    final normalized = normalize(number);
    return mobilePattern.hasMatch(normalized) ||
        fixedLinePattern.hasMatch(normalized) ||
        tollFreePattern.hasMatch(normalized);
  }
}
