import 'package:rollinhead/Model/Pri_Mutedaccount/status.dart';
import 'package:rollinhead/Model/Pri_Mutedaccount/muted_friends.dart';

class UserMutedList {

  final Status status;
  final List<MutedFriends> mutedFriends;

	UserMutedList.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		mutedFriends = List<MutedFriends>.from(map["mutedFriends"].map((it) => MutedFriends.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['mutedFriends'] = mutedFriends != null ? 
			this.mutedFriends.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
