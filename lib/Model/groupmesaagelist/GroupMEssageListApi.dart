import 'package:rollinhead/Model/groupmesaagelist/status.dart';
import 'package:rollinhead/Model/groupmesaagelist/chat_detail.dart';
import 'package:rollinhead/Model/groupmesaagelist/chat_messages.dart';

class GroupMEssageListApi {

  final Status status;
  final List<Chat_detail> chat_detail;
  final List<Chat_messages> chat_messages;

	GroupMEssageListApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		chat_detail = List<Chat_detail>.from(map["chat_detail"].map((it) => Chat_detail.fromJsonMap(it))),
		chat_messages = List<Chat_messages>.from(map["chat_messages"].map((it) => Chat_messages.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['chat_detail'] = chat_detail != null ? 
			this.chat_detail.map((v) => v.toJson()).toList()
			: null;
		data['chat_messages'] = chat_messages != null ? 
			this.chat_messages.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
