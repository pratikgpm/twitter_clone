class AppwriteConstants {
  static const String databaseId = '66a28151002bd0ddf085';
  static const String projectId = '66a27e09001a33453cd0';
  static const String endPoint = 'http://192.168.0.105:80/v1';

  static const String usersCollection = '66aa527e000a30ac9966';
  static const String tweetsCollection = '66ad049a003029b6d5fe';
  static const String notificationsCollection = '66b4bccb002f9df1a587';

  static const String imagesBucket = '66ae2f6800356881a4e3';

  static String imageUrl(String imageId) =>
        "$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin";

}
