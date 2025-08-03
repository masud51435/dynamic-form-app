class FormDataHelper {
  static String getDisplayValue(dynamic value, List<Map<String, dynamic>>? listItems) {
    if (listItems == null || value == null) {
      return value?.toString() ?? '';
    }

    if (value is List) {
      return value.map((v) => _findItemName(v, listItems)).join(', ');
    }

    return _findItemName(value, listItems);
  }

  static String _findItemName(dynamic value, List<Map<String, dynamic>> listItems) {
    final item = listItems.firstWhere(
      (item) => item['value'] == value,
      orElse: () => {'name': value.toString()},
    );
    return item['name'];
  }
}
