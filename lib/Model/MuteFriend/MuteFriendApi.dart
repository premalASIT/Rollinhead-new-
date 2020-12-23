import 'package:rollinhead/Model/MuteFriend/status.dart';
import 'package:rollinhead/Model/MuteFriend/response.dart';

class MuteFriendApi {

  final Status status;
  final Response response;

	MuteFriendApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = Response.fromJsonMap(map["response"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response == null ? null : response.toJson();
		return data;
	}
}
