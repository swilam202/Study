
import '../main.dart';

//!put the following above the main function
// late SharedPreferences prefs;

//!put the following in the main function
//  WidgetsFlutterBinding.ensureInitialized();
//  prefs = await SharedPreferences.getInstance();

Future<void> setStringData() async {
  await prefs.setString('key1', 'value');
}

Future<void> setBoolData() async {
  await prefs.setBool('key2', true);
}

Future<void> setDoubleData() async {
  await prefs.setDouble('key3', 5.5);
}

Future<void> setIntData() async {
  await prefs.setInt('key4', 5);
}

Future<void> setStringListData() async {
  await prefs.setStringList('key5', ['value1', 'value2', 'value3', 'value4']);
}

String? getStringData() {
  return prefs.getString('key1');
}

bool? getBoolData() {
  return prefs.getBool('key2');
}

double? getDoubleData() {
  return prefs.getDouble('key3');
}

int? getIntData() {
  return prefs.getInt('key4');
}

List<String>? getStringListData() {
  return prefs.getStringList('key5');
}

Future<void> removeData() async {
  await prefs.remove('key1');
}
