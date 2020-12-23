import 'package:rollinhead/Model/UploadDiary/status.dart';

class UploaddiaryApi {

  final Status status;

	UploaddiaryApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		return data;
	}
}
