import 'package:rollinhead/Model/DisplayTreeUserList/status.dart';
import 'package:rollinhead/Model/DisplayTreeUserList/_tree_users.dart';

class TreeUserListApi {

  final Status status;
  final List<TreeUsers> treeUsers;
  final String response;

	TreeUserListApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		treeUsers = List<TreeUsers>.from(map["TreeUsers"].map((it) => TreeUsers.fromJsonMap(it))),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['TreeUsers'] = treeUsers != null ?
			this.treeUsers.map((v) => v.toJson()).toList()
			: null;
		data['response'] = response;
		return data;
	}
}
