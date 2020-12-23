import 'package:rollinhead/Model/Groupcreation/status.dart';
import 'package:rollinhead/Model/Groupcreation/chat_detail.dart';

class GroupcreationAPI {

  final Status status;
  final List<Chat_detail> chat_detail;

	GroupcreationAPI.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		chat_detail = List<Chat_detail>.from(map["chat_detail"].map((it) => Chat_detail.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['chat_detail'] = chat_detail != null ? 
			this.chat_detail.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
