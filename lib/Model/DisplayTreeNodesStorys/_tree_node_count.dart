
class TreeNodeCount {

  final String UserNodeImageId;
  final String Image;
  final String CreatedDate;
  final String IsActive;
  final String NodeNumber;
  final String UserTreeId;

	TreeNodeCount.fromJsonMap(Map<String, dynamic> map): 
		UserNodeImageId = map["UserNodeImageId"],
		Image = map["Image"],
		CreatedDate = map["CreatedDate"],
		IsActive = map["IsActive"],
		NodeNumber = map["NodeNumber"],
		UserTreeId = map["UserTreeId"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['UserNodeImageId'] = UserNodeImageId;
		data['Image'] = Image;
		data['CreatedDate'] = CreatedDate;
		data['IsActive'] = IsActive;
		data['NodeNumber'] = NodeNumber;
		data['UserTreeId'] = UserTreeId;
		return data;
	}
}
