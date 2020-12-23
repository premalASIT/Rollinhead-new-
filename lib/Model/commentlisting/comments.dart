
class Comments {

  final String ID;
  final String userId;
  final String postId;
  final String comment;
  final String timestamp;
  final String name;
  final String userName;
  final Object firstName;
  final Object lastName;
  final String userEmail;
  final String userMobile;
  final String userProfilePicture;

	Comments.fromJsonMap(Map<String, dynamic> map): 
		ID = map["ID"],
		userId = map["userId"],
		postId = map["postId"],
		comment = map["comment"],
		timestamp = map["timestamp"],
		name = map["name"],
		userName = map["userName"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		userEmail = map["userEmail"],
		userMobile = map["userMobile"],
		userProfilePicture = map["userProfilePicture"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ID'] = ID;
		data['userId'] = userId;
		data['postId'] = postId;
		data['comment'] = comment;
		data['timestamp'] = timestamp;
		data['name'] = name;
		data['userName'] = userName;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['userEmail'] = userEmail;
		data['userMobile'] = userMobile;
		data['userProfilePicture'] = userProfilePicture;
		return data;
	}
}
