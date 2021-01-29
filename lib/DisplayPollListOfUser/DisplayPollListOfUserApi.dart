import 'package:rollinhead/DisplayPollListOfUser/status.dart';
import 'package:rollinhead/DisplayPollListOfUser/_user_polls.dart';

class DisplayPollListOfUserApi {

  final Status status;
  final List<UserPolls> userPolls;
  final String response;

	DisplayPollListOfUserApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		userPolls = List<UserPolls>.from(map["UserPolls"].map((it) => UserPolls.fromJsonMap(it))),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['UserPolls'] = userPolls != null ?
			this.userPolls.map((v) => v.toJson()).toList()
			: null;
		data['response'] = response;
		return data;
	}
}
