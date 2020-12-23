import 'package:rollinhead/Model/UserListChats/user_detail.dart';

class Chat_list {

  final String ID;
  final String userid;
  final String title;
  final String last_reply_userid;
  final String last_replyid;
  final String last_reply_timestamp;
  final String posts;
  final List<UserDetail> userDetail;

	Chat_list.fromJsonMap(Map<String, dynamic> map): 
		ID = map["ID"],
		userid = map["userid"],
		title = map["title"],
		last_reply_userid = map["last_reply_userid"],
		last_replyid = map["last_replyid"],
		last_reply_timestamp = map["last_reply_timestamp"],
		posts = map["posts"],
		userDetail = List<UserDetail>.from(map["userDetail"].map((it) => UserDetail.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ID'] = ID;
		data['userid'] = userid;
		data['title'] = title;
		data['last_reply_userid'] = last_reply_userid;
		data['last_replyid'] = last_replyid;
		data['last_reply_timestamp'] = last_reply_timestamp;
		data['posts'] = posts;
		data['userDetail'] = userDetail != null ? 
			this.userDetail.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
