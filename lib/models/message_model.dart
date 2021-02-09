import 'package:resap_admin/models/message_user.dart';

class Message {
  final MessageUser sender;
  final String time, text;
  final bool unread;

  Message(this.sender, this.time, this.text, this.unread);
}
