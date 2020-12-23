import 'package:rollinhead/Model/Loginapi/status.dart';
import 'package:rollinhead/Model/Loginapi/response.dart';

class NewLoginApi {

  final Status status;
  final Response response;
  final String type;

	NewLoginApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = Response.fromJsonMap(map["response"]),
		type = map["type"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response == null ? null : response.toJson();
		data['type'] = type;
		return data;
	}
}
