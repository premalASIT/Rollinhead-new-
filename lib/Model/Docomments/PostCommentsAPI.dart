import 'package:rollinhead/Model/Docomments/status.dart';

class PostCommentsAPI {

  final Status status;
  final String response;

	PostCommentsAPI.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response;
		return data;
	}
}
