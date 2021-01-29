
class UserPolls {

  final String userId;
  final String userName;
  final String PollId;
  final String PollName;
  final String Question;
  final String userProfilePicture;

	UserPolls.fromJsonMap(Map<String, dynamic> map): 
		userId = map["userId"],
		userName = map["userName"],
		PollId = map["PollId"],
		PollName = map["PollName"],
		Question = map["Question"],
		userProfilePicture = map["userProfilePicture"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = userId;
		data['userName'] = userName;
		data['PollId'] = PollId;
		data['PollName'] = PollName;
		data['Question'] = Question;
		data['userProfilePicture'] = userProfilePicture;
		return data;
	}
}
