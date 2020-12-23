import 'package:rollinhead/Model/Storylistinguser/_user_detail.dart';
import 'package:rollinhead/Model/Storylistinguser/status.dart';
import 'package:rollinhead/Model/Storylistinguser/_user_stories.dart';
import 'package:rollinhead/Model/Storylistinguser/_user_detail.dart';

class UserStoryApi {

  final Status status;
  final List<UserStories> userStories;
  final UserDetail userDetail;

	UserStoryApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		userStories = List<UserStories>.from(map["UserStories"].map((it) => UserStories.fromJsonMap(it))),
		userDetail = UserDetail.fromJsonMap(map["UserDetail"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['UserStories'] = userStories != null ?
			this.userStories.map((v) => v.toJson()).toList()
			: null;
		data['UserDetail'] = userDetail == null ? null : userDetail.toJson();
		return data;
	}
}
