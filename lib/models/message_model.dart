class messageModel {
  String? message;
  String? date;
  String? senderid;

  messageModel({
    required this.message,
    required this.date,
    required this.senderid,
  });

  messageModel.fromJcon({required Map<String, dynamic> data}) {
    message = data['message'];
    date = data['date'];
    senderid = data['senderid'];
  }

  Map<String, dynamic> toJcon() {
    return {
      'message': message,
      'date': date,
      'senderid': senderid,
    };
  }
}
