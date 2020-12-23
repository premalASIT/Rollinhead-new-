
class Status {

  final int code;
  final String message;
  final bool isMoreDataAvailable;

	Status.fromJsonMap(Map<String, dynamic> map): 
		code = map["code"],
		message = map["message"],
		isMoreDataAvailable = map["isMoreDataAvailable"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = code;
		data['message'] = message;
		data['isMoreDataAvailable'] = isMoreDataAvailable;
		return data;
	}
}
