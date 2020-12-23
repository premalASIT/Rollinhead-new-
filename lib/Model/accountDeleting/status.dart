
class Status {

  final int code;
  final String message;

	Status.fromJsonMap(Map<String, dynamic> map): 
		code = map["code"],
		message = map["message"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = code;
		data['message'] = message;
		return data;
	}
}
