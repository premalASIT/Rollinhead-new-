import 'package:rollinhead/DisplayPollAnswer/status.dart';
import 'package:rollinhead/DisplayPollAnswer/_answer_detail.dart';

class DisplayPollAnswerApi {

  final Status status;
  final List<AnswerDetail> answerDetail;
  final String response;

	DisplayPollAnswerApi.fromJsonMap(Map<String, dynamic> map): 
		status = Status.fromJsonMap(map["status"]),
		answerDetail = List<AnswerDetail>.from(map["AnswerDetail"].map((it) => AnswerDetail.fromJsonMap(it))),
		response = map["response"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = status == null ? null : status.toJson();
		data['AnswerDetail'] = answerDetail != null ?
			this.answerDetail.map((v) => v.toJson()).toList()
			: null;
		data['response'] = response;
		return data;
	}
}
