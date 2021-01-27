import 'package:rollinhead/Model/DisplayTreeNodesStorys/status.dart';
import 'package:rollinhead/Model/DisplayTreeNodesStorys/_tree_node_count.dart';

class TreeNodeDisplayImageApi {

  final Status status;
  final List<TreeNodeCount> treeNodeCount;
  final String response;

	TreeNodeDisplayImageApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		treeNodeCount = List<TreeNodeCount>.from(map["TreeNodeCount"].map((it) => TreeNodeCount.fromJsonMap(it))),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['TreeNodeCount'] = treeNodeCount != null ?
			this.treeNodeCount.map((v) => v.toJson()).toList()
			: null;
		data['response'] = response;
		return data;
	}
}
