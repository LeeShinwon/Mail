class Mail{
  String mail_id;
  String title;
  String content;
  String writer;
  String recipient;
  String time;
  bool read;
  bool sent;

  Mail(this.mail_id, this.title, this.content, this.writer, this.recipient, this.time, this.read, this.sent);

  //encapsulation 하지 않았어요...
  // getter setter 만들지 않았어요...

}