
class Chat_messages {

  final String ID;
  final String userid;
  final String chatid;
  final String imagepath;
  final String videopath;
  final String docid;
  final String message;
  final String timestamp;
  final bool isSendByMe;

	Chat_messages.fromJsonMap(Map<String, dynamic> map): 
		ID = map["ID"],
		userid = map["userid"],
		chatid = map["chatid"],
		imagepath = map["imagepath"],
		videopath = map["videopath"],
		docid = map["docid"],
		message = map["message"],
		timestamp = map["timestamp"],
		isSendByMe = map["isSendByMe"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ID'] = ID;
		data['userid'] = userid;
		data['chatid'] = chatid;
		data['imagepath'] = imagepath;
		data['videopath'] = videopath;
		data['docid'] = docid;
		data['message'] = message;
		data['timestamp'] = timestamp;
		data['isSendByMe'] = isSendByMe;
		return data;
	}
}
