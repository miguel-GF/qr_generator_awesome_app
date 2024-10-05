import 'package:nanoid/nanoid.dart';

class StringUtil {
  static String nanoId({int lenght = 10}) {
    return nanoid(lenght);
  }
}
