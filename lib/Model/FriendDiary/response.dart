
class Response {

  final String userDiaryId;
  final String userId;
  final String content;
  final String imagePath;
  final String isPublic;
  final String diaryTime;
  final String userProfilePicture;
  final String firstName;
  final String lastName;
  final String name;
  final String userName;

	Response.fromJsonMap(Map<String, dynamic> map): 
		userDiaryId = map["userDiaryId"],
		userId = map["userId"],
		content = map["content"],
		imagePath = map["imagePath"],
		isPublic = map["isPublic"],
		diaryTime = map["diaryTime"],
		userProfilePicture = map["userProfilePicture"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		name = map["name"],
		userName = map["userName"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userDiaryId'] = userDiaryId;
		data['userId'] = userId;
		data['content'] = content;
		data['imagePath'] = imagePath;
		data['isPublic'] = isPublic;
		data['diaryTime'] = diaryTime;
		data['userProfilePicture'] = userProfilePicture;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['name'] = name;
		data['userName'] = userName;
		return data;
	}
}
