import 'package:rollinhead/Model/UserListChats/status.dart';
import 'package:rollinhead/Model/UserListChats/chat_list.dart';

class ChatingUsers {

  final Status status;
  final List<Chat_list> chat_list;

	ChatingUsers.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		chat_list = List<Chat_list>.from(map["chat_list"].map((it) => Chat_list.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['chat_list'] = chat_list != null ? 
			this.chat_list.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
