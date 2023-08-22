import 'package:fire_one/models/social_model.dart';
import 'package:fire_one/screens/chat_screen_details/chat_screen_details.dart';
import 'package:fire_one/shared/componets/components.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    SocialCubit.get(context).getUsers();
    SocialCubit.get(context).getUserData();
    // SocialCubit.get(context).getUsers();
    super.initState();
  }

//  late SocialPostsModel model ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          body: cubit.users.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => chatItem(
                    context,
                    SocialCubit.get(context).users[index],
                  ),
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  itemCount: SocialCubit.get(context).users.length,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget chatItem(
    context,
    SocialUserModel model,
  ) =>
      InkWell(
        onTap: () {
          navigateTo(context, ChatScreenDetails(userModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 70,
            // color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: !(model.image ?? "student.valuxapps.com").contains("student.valuxapps.com")
                              ? NetworkImage(
                                  model.image ?? "",
                                )
                              : const AssetImage(Images.defImage)
                                  as ImageProvider,
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    '${model.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class Images {
  Images._();
  static const String defImage = "assets/images/default_image.png";
}
