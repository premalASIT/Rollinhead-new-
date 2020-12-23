import 'package:rollinhead/Model/RegistrationEmail/status.dart';
import 'package:rollinhead/Model/RegistrationEmail/response.dart';

class RegisterEmailApi {

  final Status status;
  final Response response;
  final String type;

	RegisterEmailApi.fromJsonMap(Map<String, dynamic> map): 
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
