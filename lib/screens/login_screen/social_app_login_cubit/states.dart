abstract class SocialLoginStates {}

class SocialInitState extends SocialLoginStates{}

class ShowPassState extends SocialLoginStates{}

class SocialLoginScreenSuccessState extends SocialLoginStates{
  final String uId;
  final String message;

  SocialLoginScreenSuccessState(this.uId, this.message);
}

class SocialLoginScreenLoadingState extends SocialLoginStates{}

class SocialLoginScreenErrorState extends SocialLoginStates{
  final String error;
  SocialLoginScreenErrorState(this.error);
}


