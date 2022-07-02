class Mail {
  Mail({required this.writer, required this.recipient, required this.content, required this.mail_id, required this.read, required this.sent, required this.time, required this.title});

  Mail.fromJson(Map<String, Object?> json)
      : this(
    writer: json['writer']! as String,
    recipient: json['recipient']! as String,
    title: json['title']! as String,
    content: json['content']! as String,
    mail_id: json['mail_id']! as String,
    read: json['read']! as bool,
    sent: json['sent']! as bool,
    time: json['time']! as String,
  );

  final String writer;
  final String recipient;
  final String title;
  final String content;
  final String mail_id;
  final bool read;
  final bool sent;
  final String time;

  Map<String, Object?> toJson() {
    return {
      'writer': writer,
      'recipient': recipient,
      'title': title,
      'content': content,
      'mail_id': mail_id,
      'read': read,
      'sent': sent,
      'time': time,
    };
  }
}