import '../main.dart';

//!put the following above the main function
// FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Future<void> setData() async {
  await secureStorage.write(key: 'key', value: 'value');
  
}

Future<String?> getData() async {
  return await secureStorage.read(key: 'key');
}

Future<Map<String, String>> getAllData() async {
  return await secureStorage.readAll();
}

Future<void> deleteData() async {
  await secureStorage.delete(key: 'key');
}

Future<void> deleteAllData() async {
  await secureStorage.deleteAll();
}

Future<bool> containsKey() async {
  return await secureStorage.containsKey(key: 'key');
}
