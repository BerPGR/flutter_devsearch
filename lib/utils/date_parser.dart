class DateParser {
  static String parseUpdatedRepo(DateTime updatedAt) {
    Duration difference = DateTime.now().difference(updatedAt);
    String daysAgo = difference.inDays.toString();
    return daysAgo;
  }
}