import 'package:rollinhead/Model/Pri_BlockedList/status.dart';
import 'package:rollinhead/Model/Pri_BlockedList/blocked_friends.dart';

class ListBlockedUser {

  final Status status;
  final List<BlockedFriends> blockedFriends;

	ListBlockedUser.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		blockedFriends = List<BlockedFriends>.from(map["blockedFriends"].map((it) => BlockedFriends.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['blockedFriends'] = blockedFriends != null ? 
			this.blockedFriends.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
