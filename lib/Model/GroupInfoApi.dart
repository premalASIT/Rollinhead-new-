import 'package:rollinhead/Model/status.dart';
import 'package:rollinhead/Model/_users.dart';
import 'package:rollinhead/Model/_group_information.dart';

class GroupInfoApi {

  final Status status;
  final List<Users> users;
  final GroupInformation groupInformation;

	GroupInfoApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		users = List<Users>.from(map["Users"].map((it) => Users.fromJsonMap(it))),
		groupInformation = GroupInformation.fromJsonMap(map["GroupInformation"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['Users'] = users != null ?
			this.users.map((v) => v.toJson()).toList()
			: null;
		data['GroupInformation'] = groupInformation == null ? null : groupInformation.toJson();
		return data;
	}
}
