abstract class SocialStates {}

class SocialInitState extends SocialStates {}

class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String error;

  SocialGetUserDataErrorState(this.error);
}
class SocialLikePostSuccssState extends SocialStates {}
class UpdatePostsStateAfterAddingPost extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialGetPostSuccessState extends SocialStates {}

class SocialBottomNavBarState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialUpdateProfileImageSuccessState extends SocialStates{}

class SocialUpdateProfileImageErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}


class SocialUpdateCoverImageSuccessState extends SocialStates{}

class SocialUpdateCoverImageErrorState extends SocialStates{}

class SocialUpdateUserErrorState extends SocialStates{}

class SocialUpdateUserLoadingState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImageState extends SocialStates{}

class SocialCreatePostSucessState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialRemovePostSucessState extends SocialStates{}

class SocialRemovePostErrorState extends SocialStates{}


class SocialUserLogOutSucessState extends SocialStates{}

class SocialUserLogOutErrorState extends SocialStates{}

class SocialGetUserSucessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{}

//chats
class SocialSendMessgaeSuccessState extends SocialStates{}

class SocialSendMessgaeErrorState extends SocialStates{}

class SocialGetMessgaeSuccessState extends SocialStates{}

class SocialGetMessgaeErrorState extends SocialStates{}



