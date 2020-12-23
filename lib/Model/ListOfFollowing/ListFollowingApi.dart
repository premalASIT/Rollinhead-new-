import 'package:rollinhead/Model/ListOfFollowing/status.dart';
import 'package:rollinhead/Model/ListOfFollowing/response.dart';

class ListFollowingApi {

  final Status status;
  final List<Response> response;

	ListFollowingApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = List<Response>.from(map["response"].map((it) => Response.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response != null ? 
			this.response.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
