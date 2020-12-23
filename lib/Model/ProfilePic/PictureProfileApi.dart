import 'package:rollinhead/Model/ProfilePic/status.dart';
import 'package:rollinhead/Model/ProfilePic/token.dart';

class PictureProfileApi {

  final Status status;
  final String response;
  final Token token;
  final String type;

	PictureProfileApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		response = map["response"],
		token = Token.fromJsonMap(map["token"]),
		type = map["type"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['response'] = response;
		data['token'] = token == null ? null : token.toJson();
		data['type'] = type;
		return data;
	}
}
