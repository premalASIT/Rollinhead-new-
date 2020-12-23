import 'package:rollinhead/Model/GetProfiles/status.dart';
import 'package:rollinhead/Model/GetProfiles/response.dart';

class UserProfileApi {

  final Status status;
  final Response response;

	UserProfileApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = Response.fromJsonMap(map["response"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response == null ? null : response.toJson();
		return data;
	}
}
