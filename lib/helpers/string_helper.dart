import 'dart:convert';
import 'dart:typed_data';

class StringHelper {

  ///
  ///
  ///
  static Uint8List stringToUint8List(String data) {
    List<int> list = utf8.encode(data);
    Uint8List bytes = Uint8List.fromList(list);
    // String outcome = utf8.decode(bytes);
    return bytes;
  }

  ///
  ///
  ///
  static String uint8ListToString(Uint8List data) {
    // List<int> list = utf8.encode(data);
    // Uint8List bytes = Uint8List.fromList(data);
    String outcome = utf8.decode(data);
    return outcome;
  }
}
