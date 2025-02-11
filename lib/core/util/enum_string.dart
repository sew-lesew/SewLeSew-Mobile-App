String enumToDisplayString(dynamic enumValue) {
  if (enumValue == null) return '';

  // Convert enum to string (e.g., "BusinessSector.AGRICULTURE" -> "AGRICULTURE")
  final displayText = enumValue.toString().split('.').last;

  // Convert to user-friendly format (e.g., "AGRICULTURE" -> "Agriculture")
  final formattedText = displayText
      .toLowerCase()
      .replaceAll('_', ' ')
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  return formattedText;
}
