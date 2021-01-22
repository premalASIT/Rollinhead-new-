import 'package:rollinhead/Model/SelectedNodeTree/status.dart';

class SelectedNodeTreeApi {

  final Status status;
  final int userTreeId;
  final String response;

	SelectedNodeTreeApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		userTreeId = map["userTreeId"],
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['userTreeId'] = userTreeId;
		data['response'] = response;
		return data;
	}
}
