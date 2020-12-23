import 'package:rollinhead/Model/AddPersonality/status.dart';

class AddPersonalityApi {

  final Status status;

	AddPersonalityApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		return data;
	}
}
