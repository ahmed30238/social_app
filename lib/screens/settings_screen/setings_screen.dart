import 'package:fire_one/screens/login_screen/loginscreen.dart';
import 'package:fire_one/screens/settings_screen/profile_image_view.dart';
import 'package:fire_one/screens/update_profile/update_profile_screen.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/shared/token_util/token_util.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    SocialCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                          image: model?.cover != ""
                              ? NetworkImage(
                                  model?.cover ?? "",
                                )
                              : const AssetImage(
                                  "assets/images/default_image.png",
                                ) as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileImageView(image: model?.image ?? ""),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 84,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                              '${model?.image}',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    model?.name ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    model?.bio ?? "",
                    // 'ahmed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '265',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '99',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Follower',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add Photos',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, UpdateProfleScreen());
                      },
                      child: const Icon(IconBroken.Edit),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      await TokenUtil.clearToken();
                      Future.delayed(Duration.zero, () {
                        navigateAndFinishTo(context, SocialLoginScreen());
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(
                          300,
                          47,
                        ),
                        backgroundColor: Colors.red),
                    child: const Text("logout"))
              ],
            ),
          ),
        );
      },
    );
  }
}
