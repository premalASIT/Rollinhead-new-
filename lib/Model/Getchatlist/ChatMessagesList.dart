import 'package:rollinhead/Model/Getchatlist/status.dart';
import 'package:rollinhead/Model/Getchatlist/chat_detail.dart';
import 'package:rollinhead/Model/Getchatlist/chat_messages.dart';
import 'package:rollinhead/Model/Getchatlist/user_detail.dart';

class ChatMessagesList {

  final Status status;
  final List<Chat_detail> chat_detail;
  final List<Chat_messages> chat_messages;
  final User_detail user_detail;

	ChatMessagesList.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		chat_detail = List<Chat_detail>.from(map["chat_detail"].map((it) => Chat_detail.fromJsonMap(it))),
		chat_messages = List<Chat_messages>.from(map["chat_messages"].map((it) => Chat_messages.fromJsonMap(it))),
		user_detail = User_detail.fromJsonMap(map["user_detail"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['chat_detail'] = chat_detail != null ? 
			this.chat_detail.map((v) => v.toJson()).toList()
			: null;
		data['chat_messages'] = chat_messages != null ? 
			this.chat_messages.map((v) => v.toJson()).toList()
			: null;
		data['user_detail'] = user_detail == null ? null : user_detail.toJson();
		return data;
	}
}
