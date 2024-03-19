class EmailResponse {
  String? status;
  EmailResponseData? data;

  EmailResponse({ this.status, this.data});

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      status: json['status'],
      data: EmailResponseData.fromJson(json['data']),
    );
  }
}
// void main(){
//   EmailResponse emailResponse = EmailResponse.fromJson({
//     "status": "success",
//     "data": {
//       "accepted": [
//         "rabbilidlc@gmail.com"
//       ],
//       "rejected": [],
//       "ehlo": [
//         "SIZE 52428800",
//         "8BITMIME",
//         "PIPELINING",
//         "PIPE_CONNECT",
//         "AUTH PLAIN LOGIN",
//         "HELP"
//       ],
//       "envelopeTime": 55,
//       "messageTime": 0,
//       "messageSize": 338,
//       "response": "250 OK id=1rmCxl-00449G-Ci",
//       "envelope": {
//         "from": "info@teamrabbil.com",
//         "to": [
//           "rabbilidlc@gmail.com"
//         ]
//       },
//       "messageId": "<c809e257-34c5-3425-5afc-877060389972@teamrabbil.com>"
//     }
//   });
//
//   print(emailResponse.data?.accepted.first?? '');
// }

class EmailResponseData {
  List<String> accepted;
  List<String> rejected;
  List<String> ehlo;
  int envelopeTime;
  int messageTime;
  int messageSize;
  String response;
  EmailResponseEnvelope envelope;
  String messageId;

  EmailResponseData({
    required this.accepted,
    required this.rejected,
    required this.ehlo,
    required this.envelopeTime,
    required this.messageTime,
    required this.messageSize,
    required this.response,
    required this.envelope,
    required this.messageId,
  });

  factory EmailResponseData.fromJson(Map<String, dynamic> json) {
    return EmailResponseData(
      accepted: List<String>.from(json['accepted']),
      rejected: List<String>.from(json['rejected']),
      ehlo: List<String>.from(json['ehlo']),
      envelopeTime: json['envelopeTime'],
      messageTime: json['messageTime'],
      messageSize: json['messageSize'],
      response: json['response'],
      envelope: EmailResponseEnvelope.fromJson(json['envelope']),
      messageId: json['messageId'],
    );
  }
}

class EmailResponseEnvelope {
  String from;
  List<String> to;

  EmailResponseEnvelope({required this.from, required this.to});

  factory EmailResponseEnvelope.fromJson(Map<String, dynamic> json) {
    return EmailResponseEnvelope(
      from: json['from'],
      to: List<String>.from(json['to']),
    );
  }
}
