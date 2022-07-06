import 'dart:io';

class CheckResourceAvailability {
  static Future<bool> hasNetwork() async {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  }
}
