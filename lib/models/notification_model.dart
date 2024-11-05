// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:twitter_clone/core/enums/notification_type_enum.dart';

class Notification {
  final String text;
  final String postId;
  final String uid;
  final String id;
  final NotificationType notificationType;

  Notification({
    required this.text,
    required this.postId,
    required this.uid,
    required this.id,
    required this.notificationType,
  });

  Notification copyWith({
    String? text,
    String? postId,
    String? uid,
    String? id,
    NotificationType? notificationType,
  }) {
    return Notification(
      text: text ?? this.text,
      postId: postId ?? this.postId,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      notificationType: notificationType ?? this.notificationType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'postId': postId,
      'uid': uid,
      'notificationType': notificationType.type,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      text: map['text'] ??'',
      postId: map['postId'] ??'',
      uid: map['uid'] ??'',
      id: map['\$id'] ??'',
      notificationType: (map['notificationType'] as String ).toNotificationTypeEnum(),
    );
  }

  @override
  String toString() {
    return 'Notification(text: $text, postId: $postId, uid: $uid, id: $id, notificationType: $notificationType)';
  }

  @override
  bool operator ==(covariant Notification other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.postId == postId &&
        other.uid == uid &&
        other.id == id &&
        other.notificationType == notificationType;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        postId.hashCode ^
        uid.hashCode ^
        id.hashCode ^
        notificationType.hashCode;
  }
}
