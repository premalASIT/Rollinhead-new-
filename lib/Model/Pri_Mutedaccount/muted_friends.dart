
class MutedFriends {

  final int userId;
  final String firstName;
  final String lastName;
  final String userEmail;
  final Object userAddress;
  final String userMobile;
  final int userStatus;
  final Object userGender;
  final String profilePictureUrl;
  final String isPublic;

	MutedFriends.fromJsonMap(Map<String, dynamic> map): 
		userId = map["userId"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		userEmail = map["userEmail"],
		userAddress = map["userAddress"],
		userMobile = map["userMobile"],
		userStatus = map["userStatus"],
		userGender = map["userGender"],
		profilePictureUrl = map["profilePictureUrl"],
		isPublic = map["isPublic"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = userId;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['userEmail'] = userEmail;
		data['userAddress'] = userAddress;
		data['userMobile'] = userMobile;
		data['userStatus'] = userStatus;
		data['userGender'] = userGender;
		data['profilePictureUrl'] = profilePictureUrl;
		data['isPublic'] = isPublic;
		return data;
	}
}
