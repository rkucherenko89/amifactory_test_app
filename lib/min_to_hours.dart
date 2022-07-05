abstract class MinToHours {
  static String minToHours(int min) {
    int hours = min ~/ 60;
    int mins = min - hours * 60;
    String result = '${hours}h ${mins}m';
    return result;
  }
}
