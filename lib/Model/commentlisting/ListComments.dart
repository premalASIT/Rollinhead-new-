import 'package:rollinhead/Model/commentlisting/status.dart';
import 'package:rollinhead/Model/commentlisting/comments.dart';

class ListComments {

  final Status status;
  final List<Comments> comments;
  final String response;

	ListComments.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		comments = List<Comments>.from(map["comments"].map((it) => Comments.fromJsonMap(it))),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['comments'] = comments != null ? 
			this.comments.map((v) => v.toJson()).toList()
			: null;
		data['response'] = response;
		return data;
	}
}
