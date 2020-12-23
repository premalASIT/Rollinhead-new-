import 'package:rollinhead/Model/FeedHome/mention_user_ids.dart';

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
  final String location;
  final List<MentionUserIds> mentionUserIds;
  final String userProfilePicture;
  final String firstName;
  final String lastName;
  final String name;
  final String userName;
  final String personalityType;
  final int likes;
  final int comments;
  final bool isLikedByMe;

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
		location = map["location"],
		mentionUserIds = List<MentionUserIds>.from(map["mentionUserIds"].map((it) => MentionUserIds.fromJsonMap(it))),
		userProfilePicture = map["userProfilePicture"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		name = map["name"],
		userName = map["userName"],
		personalityType = map["personalityType"],
		likes = map["likes"],
		comments = map["comments"],
		isLikedByMe = map["isLikedByMe"];

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
		data['location'] = location;
		data['mentionUserIds'] = mentionUserIds != null ? 
			this.mentionUserIds.map((v) => v.toJson()).toList()
			: null;
		data['userProfilePicture'] = userProfilePicture;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['name'] = name;
		data['userName'] = userName;
		data['personalityType'] = personalityType;
		data['likes'] = likes;
		data['comments'] = comments;
		data['isLikedByMe'] = isLikedByMe;
		return data;
	}
}
