import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);

  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            title: 'Create Post',
            actions: [
              TextButton(
                onPressed: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      text: postController.text,
                      dateTime: DateTime.now().toString(),

                      // postImage: SocialCubit.get(context).postImage != ? '' FileImage(postImage)
                    );
                    Navigator.pop(context);
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      text: postController.text,
                      dateTime: DateTime.now().toString(),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'POST',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                '${SocialCubit.get(context).userModel!.image}'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '${SocialCubit.get(context).userModel!.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            topLeft: Radius.circular(5),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              SocialCubit.get(context).postImage!,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 15,
                            ),
                            onPressed: () {
                              SocialCubit.get(context).removePostImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              IconBroken.Camera,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
