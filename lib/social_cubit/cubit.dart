import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_one/models/message_model.dart';
import 'package:fire_one/models/posts.model.dart';
import 'package:fire_one/models/social_model.dart';
import 'package:fire_one/screens/chat_screen/chat_screen.dart';
import 'package:fire_one/screens/home_screen/view/home_screen.dart';
import 'package:fire_one/screens/post_screen/post_screen.dart';
import 'package:fire_one/screens/settings_screen/setings_screen.dart';
import 'package:fire_one/screens/users_screen/users_screen.dart';
import 'package:fire_one/shared/constants/local/vars.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quick_log/quick_log.dart';

class SocialCubit extends Cubit<SocialStates> {
  Logger logger = const Logger("SocialCubit");
  SocialCubit() : super(SocialInitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  int bottomIndex = 0;
  void changeBottomNavBar(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      bottomIndex = index;
      emit(SocialBottomNavBarState());
    }
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Chat),
      label: 'Chat',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Paper_Upload),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.User),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconBroken.Setting),
      label: 'Setings',
    ),
  ];
  List<String> titles = [
    'home',
    'chat',
    'post',
    'users',
    'settings',
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    AddPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  SocialUserModel? userModel;
  SocialPostsModel? postModel;
  File? profileImage;
  var picker = ImagePicker();
  List<SocialPostsModel> posts = [];
  var postId = [];
  var noOfLikes = [];
  List<SocialUserModel> users = [];
  List<SocialMessageModel> messages = [];
  File? postImage;
  File? coverImage;
  SocialMessageModel? messageModel;

  // uId = CachHelper.getData(key: 'uId', value: userModel!.uId!);
  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      // FirebaseAuth.instance.currentUser!.reload(); // test
      userModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
      logger.error(error.toString());
    });
  }

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      logger.error('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      logger.error('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      logger.error('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(SocialUserLogOutSucessState());
    }).catchError((error) {
      emit(SocialUserLogOutErrorState());
    });
  }

  void uploadProfileImage({
    required String bio,
    required String phone,
    required String name,
    required String password,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
            bio: bio,
            phone: phone,
            name: name,
            image: value,
            password: password);
      }).catchError((error) {
        logger.error(error.toString());
      });
    }).catchError((error) {
      logger.error(error.toString());
    });
  }

  void uploadCoverImage({
    required String bio,
    required String phone,
    required String name,
    required String password,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          password: password,
          bio: bio,
          phone: phone,
          name: name,
          cover: value,
        );
      }).catchError((error) {
        logger.error(error.toString());
      });
    }).catchError((error) {
      logger.error(error.toString());
    });
  }

  void updateUser({
    String? bio,
    required String phone,
    required String name,
    required String password,
    String? image,
    String? cover,
  }) {
    emit(SocialUpdateUserLoadingState());
    userModel = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      password: password,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(
          userModel!.toMap(),
        )
        .then(
      (value) {
        getUserData();
      },
    ).catchError(
      (error) {
        emit(SocialUpdateUserErrorState());
        logger.error(error.toString());
      },
    );
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        logger.error(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      logger.error(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    postModel = SocialPostsModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          postModel!.toMap(),
        )
        .then(
      (value) {
        // updatePostsStateAfterAddingPost(postModel!);
        emit(SocialCreatePostSucessState());
        getThePosts();
      },
    ).catchError(
      (error) {
        emit(SocialCreatePostErrorState());
        logger.error(error.toString());
      },
    );
  }

  // void updatePostsStateAfterAddingPost(SocialPostsModel post) {
  //   int index = posts.indexWhere((element) => element.uId == post.uId);

  //   if (index >= 0) {
  //     // update post
  //   } else {
  //     posts.insert(index, element)
  //     posts.add(SocialPostsModel.fromJson(post.toMap()));
  //   }
  //   emit(UpdatePostsStateAfterAddingPost());
  // }

  void getThePosts() async {
    emit(SocialGetPostLoadingState());
    var postCollection =
        await FirebaseFirestore.instance.collection("posts").get();
      posts = [];
    for (var post in postCollection.docs) {
      // var likesCollection =
          post.reference.collection('likes').get().then((value) {
        posts.add(
          SocialPostsModel.fromJson(post.data()),
        );
        noOfLikes.add(value.docs.length);
        postId.add(post.id);
      });
    }
      emit(SocialGetPostSuccessState());
  }

  // void getPosts() {
  //   emit(SocialGetPostLoadingState());
  //   FirebaseFirestore.instance.collection('posts').get().then((value) {
  //     for (var element in value.docs) {
  //       posts = [];
  //       element.reference.collection('likes').get().then(
  //         (value) {
  //           posts.add(SocialPostsModel.fromJson(element.data()));
  //           noOfLikes.add(value.docs.length);
  //           postId.add(element.id);
  //           emit(SocialGetPostSuccessState());
  //         },
  //       ).catchError((error) {
  //         emit(
  //           SocialGetPostErrorState(error.toString()),
  //         );
  //       });
  //     }
  //   }).catchError((error) {
  //     logger.error(error.toString());
  //     emit(
  //       SocialGetPostErrorState(error.toString()),
  //     );
  //   });
  // }

  void removePost({
    required String postId,
  }) {
    // posts.removeWhere((element) => element.uId == postId);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(SocialRemovePostSucessState());
      // getThePosts();
    }).catchError((error) {
      logger.error(
        error.toString(),
      );
      emit(SocialRemovePostErrorState());
    });
  }

  void likesPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set(
      {
        'like': true,
      },
    ).then((value) {
      emit(
        SocialLikePostSuccssState(),
      );
    }).catchError((error) {
      emit(
        SocialLikePostErrorState(
          error.toString(),
        ),
      );
    });
  }

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.id != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
          emit(SocialGetUserSucessState());
        }
      }).catchError((error) {
        emit(SocialGetUserErrorState());
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    AudioPlayer player = AudioPlayer();
    messageModel = SocialMessageModel(
      dateTime: dateTime,
      receiverId: receiverId,
      text: text,
      senderId: userModel!.uId,
    );
    player.setAsset("assets/sound/send.mp3");

// set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel!.toMap())
        .then((value) {
      player.play();
      emit(SocialSendMessgaeSuccessState());
    }).catchError((error) {
      emit(SocialSendMessgaeErrorState());
    });

// set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel!.toMap())
        .then((value) {
      // player.play();
      emit(SocialSendMessgaeSuccessState());
    }).catchError((error) {
      emit(SocialSendMessgaeErrorState());
    });
  }

  void getMesages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        // if (!messages.isEmpty)
        messages.add(SocialMessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessgaeSuccessState());
    });
  }
}
