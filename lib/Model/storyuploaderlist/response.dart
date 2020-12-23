
class Response {

  final String userId;
  final String userProfilePicture;
  final String firstName;
  final String lastName;
  final String userEmail;
  final String userMobile;

	Response.fromJsonMap(Map<String, dynamic> map): 
		userId = map["userId"],
		userProfilePicture = map["userProfilePicture"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		userEmail = map["userEmail"],
		userMobile = map["userMobile"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = userId;
		data['userProfilePicture'] = userProfilePicture;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['userEmail'] = userEmail;
		data['userMobile'] = userMobile;
		return data;
	}
}
