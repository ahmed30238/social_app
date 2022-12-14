import 'package:fire_one/screens/update_profile/update_profile_screen.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;

        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
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
                            image: NetworkImage(
                              '${model!.cover}',
                            ),
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
                            backgroundImage: NetworkImage(
                              '${model.image}',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Text(
                      '${model.name}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      '${model.bio}',
                      // 'ahmed',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
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
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
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
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption,
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
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                'Follower',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                      const SizedBox(
                        width: 8,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          navigateTo(context, UpdateProfleScreen());
                        },
                        child: const Icon(
                          IconBroken.Edit,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
