import 'package:rollinhead/Model/ViewProfile/status.dart';
import 'package:rollinhead/Model/ViewProfile/response.dart';

class ViewprofileApi {

  final Status status;
  final Response response;

	ViewprofileApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = Response.fromJsonMap(map["response"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response == null ? null : response.toJson();
		return data;
	}
}
