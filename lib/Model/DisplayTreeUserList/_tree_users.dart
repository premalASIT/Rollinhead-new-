
class TreeUsers {

  final String UserTreeId;
  final String UserId;
  final String NodeCount;
  final String CreatedDate;
  final String IsActive;
  final String userName;
  final String userProfilePicture;
  final String NodeName;

	TreeUsers.fromJsonMap(Map<String, dynamic> map): 
		UserTreeId = map["UserTreeId"],
		UserId = map["UserId"],
		NodeCount = map["NodeCount"],
		CreatedDate = map["CreatedDate"],
		IsActive = map["IsActive"],
		userName = map["userName"],
		userProfilePicture = map["userProfilePicture"],
		NodeName = map["NodeName"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['UserTreeId'] = UserTreeId;
		data['UserId'] = UserId;
		data['NodeCount'] = NodeCount;
		data['CreatedDate'] = CreatedDate;
		data['IsActive'] = IsActive;
		data['userName'] = userName;
		data['userProfilePicture'] = userProfilePicture;
		data['NodeName'] = NodeName;
		return data;
	}
}
