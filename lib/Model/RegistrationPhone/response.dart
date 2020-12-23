
class Response {

  final Object firstName;
  final String userName;
  final String profilePicture;
  final Object userEmail;
  final String userMobile;
  final String userId;

	Response.fromJsonMap(Map<String, dynamic> map): 
		firstName = map["firstName"],
		userName = map["userName"],
		profilePicture = map["profilePicture"],
		userEmail = map["userEmail"],
		userMobile = map["userMobile"],
		userId = map["userId"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['firstName'] = firstName;
		data['userName'] = userName;
		data['profilePicture'] = profilePicture;
		data['userEmail'] = userEmail;
		data['userMobile'] = userMobile;
		data['userId'] = userId;
		return data;
	}
}
