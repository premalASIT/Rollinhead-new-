import 'package:rollinhead/Model/CheckUserPollAnswerOrNot/status.dart';

class CheckUserPollAnswerApi {

  final Status status;
  final bool IsAnswered;
  final String response;

	CheckUserPollAnswerApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		IsAnswered = map["IsAnswered"],
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['IsAnswered'] = IsAnswered;
		data['response'] = response;
		return data;
	}
}
