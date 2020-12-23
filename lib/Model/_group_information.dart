
class GroupInformation {

  final String ID;
  final String userid;
  final String timestamp;
  final String title;
  final String last_reply_userid;
  final String last_replyid;
  final String last_reply_timestamp;
  final String posts;
  final String group_icon;

	GroupInformation.fromJsonMap(Map<String, dynamic> map): 
		ID = map["ID"],
		userid = map["userid"],
		timestamp = map["timestamp"],
		title = map["title"],
		last_reply_userid = map["last_reply_userid"],
		last_replyid = map["last_replyid"],
		last_reply_timestamp = map["last_reply_timestamp"],
		posts = map["posts"],
		group_icon = map["group_icon"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ID'] = ID;
		data['userid'] = userid;
		data['timestamp'] = timestamp;
		data['title'] = title;
		data['last_reply_userid'] = last_reply_userid;
		data['last_replyid'] = last_replyid;
		data['last_reply_timestamp'] = last_reply_timestamp;
		data['posts'] = posts;
		data['group_icon'] = group_icon;
		return data;
	}
}
