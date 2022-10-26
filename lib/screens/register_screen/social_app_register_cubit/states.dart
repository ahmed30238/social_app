abstract class SocialRegisterStates {}

class SocialRegisterInitState extends SocialRegisterStates{}

class ShowRegisterPassState extends SocialRegisterStates{}

class SocialRegisterScreenSuccessState extends SocialRegisterStates{}

class SocialRegisterScreenLoadingState extends SocialRegisterStates{}

class SocialRegisterScreenErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterScreenErrorState(this.error);
}

class SocialCreateUserScreenSuccessState extends SocialRegisterStates{}

class SocialCreateUserScreenLoadingState extends SocialRegisterStates{}
class SocialUpdateUserErrorState extends SocialRegisterStates{}

class SocialUpdateUserLoadingState extends SocialRegisterStates{}

class SocialCreateUserScreenErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserScreenErrorState(this.error);
}




