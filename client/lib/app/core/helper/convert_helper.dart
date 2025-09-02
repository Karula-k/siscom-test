class ConvertHelper {
  static String mapToQueryString(Map<String, dynamic>? map) {
    if (map == null) return '';
    List<String?> output = map.entries.map((e) {
      if (e.value != null && e.value.toString().isNotEmpty) {
        return '${e.key}=${e.value}';
      }
    }).toList();

    output.removeWhere((element) => element == null);
    return output.join('&');
  }
}
