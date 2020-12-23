import 'package:rollinhead/Model/Unfollowrequest/status.dart';

class UnfollowReqApi {

  final Status status;
  final bool response;

	UnfollowReqApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response;
		return data;
	}
}
