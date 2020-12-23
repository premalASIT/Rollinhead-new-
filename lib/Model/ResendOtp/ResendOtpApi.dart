import 'package:rollinhead/Model/ResendOtp/status.dart';

class ResendOtpApi {

  final Status status;

	ResendOtpApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		return data;
	}
}
