
class Response {

  final int userId;
  final String firstName;
  final String lastName;
  final String userName;
  final String userEmail;
  final Object userAddress;
  final String userMobile;
  final String bio;
  final int userStatus;
  final String userGender;
  final String profilePictureUrl;
  final String personalityType;
  final bool isFriend;
  final bool isRequested;
  final bool isBlocked;
  final bool isMuted;
  final bool isOwnProfile;
  final bool isPublic;
  final int postsCount;
  final int followersCount;

  final int followingsCount;

	Response.fromJsonMap(Map<String, dynamic> map): 
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
		isRequested = map["isRequested"],
		isBlocked = map["isBlocked"],
		isMuted = map["isMuted"],
		isOwnProfile = map["isOwnProfile"],
		isPublic = map["isPublic"],
		postsCount = map["postsCount"],
		followersCount = map["followersCount"],
		personalityType = map["personalityType"],
		followingsCount = map["followingsCount"],

		bio = map["bio"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
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
		data['isBlocked'] = isBlocked;
		data['isMuted'] = isMuted;
		data['isOwnProfile'] = isOwnProfile;
		data['isPublic'] = isPublic;
		data['postsCount'] = postsCount;
		data['bio'] = bio;
		data['personalityType'] = personalityType;
		data['followersCount'] = followersCount;
		data['followingsCount'] = followingsCount;

		return data;
	}
}
