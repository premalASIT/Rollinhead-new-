
class UserPolls {

  final String UserId;
  final String userName;
  final String userProfilePicture;
  final String firstName;
  final String lastName;
  final String userEmail;

	UserPolls.fromJsonMap(Map<String, dynamic> map): 
		UserId = map["UserId"],
		userName = map["userName"],
		userProfilePicture = map["userProfilePicture"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		userEmail = map["userEmail"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['UserId'] = UserId;
		data['userName'] = userName;
		data['userProfilePicture'] = userProfilePicture;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['userEmail'] = userEmail;
		return data;
	}
}
