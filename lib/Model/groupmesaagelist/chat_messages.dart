import 'package:rollinhead/Model/groupmesaagelist/user_detail.dart';

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
  final UserDetail userDetail;

	Chat_messages.fromJsonMap(Map<String, dynamic> map): 
		ID = map["ID"],
		userid = map["userid"],
		chatid = map["chatid"],
		imagepath = map["imagepath"],
		videopath = map["videopath"],
		docid = map["docid"],
		message = map["message"],
		timestamp = map["timestamp"],
		isSendByMe = map["isSendByMe"],
		userDetail = UserDetail.fromJsonMap(map["userDetail"]);

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
		data['userDetail'] = userDetail == null ? null : userDetail.toJson();
		return data;
	}
}
