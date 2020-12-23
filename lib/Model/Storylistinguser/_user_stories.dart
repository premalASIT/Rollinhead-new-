
class UserStories {

  final String userStoryId;
  final String userId;
  final String content;
  final String location;
  final String imagePath;
  final String videoPath;
  final String isActive;
  final String diaryId;
  final String postId;
  final String storyTime;

	UserStories.fromJsonMap(Map<String, dynamic> map): 
		userStoryId = map["userStoryId"],
		userId = map["userId"],
		content = map["content"],
		location = map["location"],
		imagePath = map["imagePath"],
		videoPath = map["videoPath"],
		isActive = map["isActive"],
		diaryId = map["diaryId"],
		postId = map["postId"],
		storyTime = map["storyTime"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userStoryId'] = userStoryId;
		data['userId'] = userId;
		data['content'] = content;
		data['location'] = location;
		data['imagePath'] = imagePath;
		data['videoPath'] = videoPath;
		data['isActive'] = isActive;
		data['diaryId'] = diaryId;
		data['postId'] = postId;
		data['storyTime'] = storyTime;
		return data;
	}
}
