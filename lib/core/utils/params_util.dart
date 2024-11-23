class ParamsUtil {
  static Map<String, dynamic> paramsCamelToSnakeCase(
      {Map<String, dynamic>? filters}) {
    if (filters == null || filters.isEmpty) {
      return {};
    }
    return filters.map((key, value) {
      final snakeCaseKey = key.replaceAllMapped(
          RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}');
      return MapEntry(snakeCaseKey, value);
    });
  }

  static List<String> generateWhereClauses({
    required Map<String, dynamic> filters,
  }) {
    final whereClauses = <String>[];
    filters.forEach((key, value) {
      if (value != null) {
        whereClauses.add('$key = ?');
      }
    });
    return whereClauses;
  }

  static List<dynamic> generateWhereArgs({
    required Map<String, dynamic> filters,
  }) {
    final whereArgs = <dynamic>[];
    filters.forEach((key, value) {
      if (value != null) {
        whereArgs.add(value);
      }
    });
    return whereArgs;
  }
}
