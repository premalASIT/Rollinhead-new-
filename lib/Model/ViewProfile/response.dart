
class Response {

  final String userId;
  final String userSecret;
  final Object name;
  final Object userName;
  final String firstName;
  final String lastName;
  final String userEmail;
  final String userPassword;
  final String userMobile;
  final String userDateOfBirth;
  final Object userGender;
  final String userStatus;
  final String active;
  final String userVerification;
  final Object userAddress;
  final String userProfilePicture;
  final Object userResetToken;
  final String userType;
  final String lastModified;
  final String isOTPVerified;
  final String OTP;
  final Object bio;
  final String personalityType;
  final Object website;
  final Object isPublic;

	Response.fromJsonMap(Map<String, dynamic> map): 
		userId = map["userId"],
		userSecret = map["userSecret"],
		name = map["name"],
		userName = map["userName"],
		firstName = map["firstName"],
		lastName = map["lastName"],
		userEmail = map["userEmail"],
		userPassword = map["userPassword"],
		userMobile = map["userMobile"],
		userDateOfBirth = map["userDateOfBirth"],
		userGender = map["userGender"],
		userStatus = map["userStatus"],
		active = map["active"],
		userVerification = map["userVerification"],
		userAddress = map["userAddress"],
		userProfilePicture = map["userProfilePicture"],
		userResetToken = map["userResetToken"],
		userType = map["userType"],
		lastModified = map["lastModified"],
		isOTPVerified = map["isOTPVerified"],
		OTP = map["OTP"],
		bio = map["bio"],
		personalityType = map["personalityType"],
		isPublic = map["isPublic"],
		website = map["website"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = userId;
		data['userSecret'] = userSecret;
		data['name'] = name;
		data['userName'] = userName;
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['userEmail'] = userEmail;
		data['userPassword'] = userPassword;
		data['userMobile'] = userMobile;
		data['userDateOfBirth'] = userDateOfBirth;
		data['userGender'] = userGender;
		data['userStatus'] = userStatus;
		data['active'] = active;
		data['userVerification'] = userVerification;
		data['userAddress'] = userAddress;
		data['userProfilePicture'] = userProfilePicture;
		data['userResetToken'] = userResetToken;
		data['userType'] = userType;
		data['lastModified'] = lastModified;
		data['isOTPVerified'] = isOTPVerified;
		data['OTP'] = OTP;
		data['bio'] = bio;
		data['personalityType'] = personalityType;
		data['isPublic'] = isPublic;
		data['website'] = website;
		return data;
	}
}
