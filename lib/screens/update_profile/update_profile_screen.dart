import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfleScreen extends StatelessWidget {
  UpdateProfleScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        passwordController.text = userModel.password!;

        return Scaffold(
          appBar: defaultAppBar(
            title: 'EDIT PROFILE',
            elevation: 10,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUser(
                      bio: bioController.text,
                      name: nameController.text,
                      phone: phoneController.text,
                      password: passwordController.text
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is SocialUpdateUserLoadingState)
                    const SizedBox(
                      height: 10,
                    ),
                  if (state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
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
                            image: coverImage == null
                                ? NetworkImage(
                                    '${userModel.cover}',
                                  )
                                : FileImage(coverImage) as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 84,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: profileImage == null
                                ? NetworkImage(
                                    '${userModel.image}',
                                  )
                                : FileImage(profileImage) as ImageProvider,
                          ),
                        ),
                      ),
                      //cover image camera icon
                      Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 15,
                          child: IconButton(
                            icon: const Icon(
                              IconBroken.Camera,
                              size: 15,
                            ),
                            onPressed: () {
                              SocialCubit.get(context).getCoverImage();
                            },
                          ),
                        ),
                      ),
                      //profile image camera icon
                      Positioned(
                        bottom: 10,
                        right: 140,
                        child: CircleAvatar(
                          radius: 15,
                          child: IconButton(
                            icon: const Icon(
                              IconBroken.Camera,
                              size: 15,
                            ),
                            onPressed: () {
                              SocialCubit.get(context).getProfileImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      '${userModel.name}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      '${userModel.bio}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 45,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        password: passwordController.text
                                      );
                                    },
                                    child: const Text(
                                      'Save Profile Image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                if (state is SocialUpdateUserLoadingState)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (state is SocialUpdateUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 45,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                        bio: bioController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                      );
                                    },
                                    child: const Text(
                                      'Save Cover Image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                if (state is SocialUpdateUserLoadingState)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (state is SocialUpdateUserLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextFormField(
                    controller: nameController,
                    text: 'Name',
                    validate: (String? value) {
                      return null;
                    },
                    prefix: IconBroken.User1,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    keyType: TextInputType.phone,
                    controller: phoneController,
                    text: 'Phone',
                    validate: (String? value) {
                      return null;
                    },
                    prefix: IconBroken.Call,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    text: 'Bio',
                    validate: (String? value) {
                      return null;
                    },
                    prefix: IconBroken.Info_Circle,
                    isPass: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: passwordController,
                    text: 'password',
                    validate: (String? value) {
                      return null;
                    },
                    prefix: IconBroken.Info_Circle,
                    isPass: true,
                    maxLines: 1
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
