import '../../models.dart';

class BillerApiMappers {
  static List<Biller> mapSupportedBillers(Object? payload) {
    if (payload is Map<String, dynamic>) {
      return payload.entries
          .where((MapEntry<String, dynamic> entry) => entry.value is Map)
          .map<Biller>((MapEntry<String, dynamic> entry) {
            final Map<String, dynamic> value = _asMap(entry.value);
            final String code =
                _pickString(value, <String>['code']) ?? entry.key;
            final String name =
                _pickString(value, <String>['name']) ?? entry.key;
            return Biller(code: code, name: name);
          })
          .toList(growable: false);
    }

    return const <Biller>[];
  }

  static String? _pickString(Map<String, dynamic> json, List<String> keys) {
    for (final String key in keys) {
      final Object? value = json[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
    }
    return null;
  }

  static Map<String, dynamic> _asMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map<String, dynamic>(
        (Object? key, Object? val) =>
            MapEntry<String, dynamic>(key?.toString() ?? '', val),
      );
    }
    return <String, dynamic>{};
  }
}
