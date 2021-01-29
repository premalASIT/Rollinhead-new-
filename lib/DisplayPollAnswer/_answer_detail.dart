
class AnswerDetail {

  final String TotalAnswers;
  final String YesAnswer;
  final String NoAnswer;

	AnswerDetail.fromJsonMap(Map<String, dynamic> map): 
		TotalAnswers = map["TotalAnswers"],
		YesAnswer = map["YesAnswer"],
		NoAnswer = map["NoAnswer"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['TotalAnswers'] = TotalAnswers;
		data['YesAnswer'] = YesAnswer;
		data['NoAnswer'] = NoAnswer;
		return data;
	}
}
