import 'package:hive_flutter/adapters.dart';

class HiveUtils {
  static final HiveUtils instance = HiveUtils._internal();
  factory HiveUtils() {
    return instance;
  }
  final String _keyPublicBox = 'publicBox';
  late Box _publicBox;
  final String _keyPage = 'page';
  HiveUtils._internal();
  Future _init() async {
    await Hive.initFlutter();
    _publicBox = await Hive.openBox(_keyPublicBox);
  }

  static Future initHive() async {
    await HiveUtils.instance._init();
  }

  T? _get<T>({required String key, required Box box}) {
    final value = box.get(key);
    if (value is List && T is List<String>) {
      final listValue = <String>[];
      for (var data in value) {
        listValue.add(data.toString());
      }
      return listValue as T;
    }
    return value as T?;
  }

  _set<T>({required String key, required T value, required Box box}) async {
    if (value != null) {
      await box.put(key, value);
    } else {
      print('Remove instead: [$key]');
      box.delete(key);
    }
  }

  Map? page(int page) => _get<Map>(key: "$_keyPage$page", box: _publicBox);
  void savePage(int? page, Map data) =>
      _set(key: "$_keyPage$page", value: data, box: _publicBox);
}
