
class Response {

  final String userPostIdInfo;
  final String userPostId;
  final String userId;
  final String content;
  final String imagePath;
  final String videoPath;
  final String isActive;
  final String diaryId;
  final String storyId;
  final String postTime;
  final String userProfilePicture;
  final Object firstName;
  final Object lastName;
  final String name;
  final String userName;

	Response.fromJsonMap(Map<String, dynamic> map): 
		userPostIdInfo = map["userPostIdInfo"],
		userPostId = map["userPostId"],
		userId = map["userId"],
		content = map["content"],
		imagePath = map["imagePath"],
		videoPath = map["videoPath"],
		isActive = map["isActive"],
		diaryId = map["diaryId"],
		storyId = map["storyId"],
		postTime = map["postTime"],
		userProfilePicture = map["userProfilePicture"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		name = map["name"],
		userName = map["userName"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userPostIdInfo'] = userPostIdInfo;
		data['userPostId'] = userPostId;
		data['userId'] = userId;
		data['content'] = content;
		data['imagePath'] = imagePath;
		data['videoPath'] = videoPath;
		data['isActive'] = isActive;
		data['diaryId'] = diaryId;
		data['storyId'] = storyId;
		data['postTime'] = postTime;
		data['userProfilePicture'] = userProfilePicture;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['name'] = name;
		data['userName'] = userName;
		return data;
	}
}
