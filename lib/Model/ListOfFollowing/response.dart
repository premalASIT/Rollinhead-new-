
class Response {

  final int friend_list_id;
  final int userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String userEmail;
  final Object userAddress;
  final String userMobile;
  final int userStatus;
  final String userGender;
  final String profilePictureUrl;
  final bool isFriend;
  final bool isRequested;

	Response.fromJsonMap(Map<String, dynamic> map): 
		friend_list_id = map["friend_list_id"],
		userId = map["userId"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		userName = map["userName"],
		userEmail = map["userEmail"],
		userAddress = map["userAddress"],
		userMobile = map["userMobile"],
		userStatus = map["userStatus"],
		userGender = map["userGender"],
		profilePictureUrl = map["profilePictureUrl"],
		isFriend = map["isFriend"],
		isRequested = map["isRequested"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['friend_list_id'] = friend_list_id;
		data['userId'] = userId;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['userName'] = userName;
		data['userEmail'] = userEmail;
		data['userAddress'] = userAddress;
		data['userMobile'] = userMobile;
		data['userStatus'] = userStatus;
		data['userGender'] = userGender;
		data['profilePictureUrl'] = profilePictureUrl;
		data['isFriend'] = isFriend;
		data['isRequested'] = isRequested;
		return data;
	}
}
