import 'package:fire_one/models/social_model.dart';
import 'package:fire_one/screens/chat_screen/chat_screen.dart';
import 'package:fire_one/shared/extensions/sized_box.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    SocialCubit.get(context).getUsers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) =>
            SocialCubit.get(context).users[index].uId != null
                ? UserItem(
                    model: SocialCubit.get(context).users[index],
                  )
                : 0.ph,
        separatorBuilder: (context, index) => 10.ph,
        itemCount: SocialCubit.get(context).users.length,
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.model,
  });

  final SocialUserModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: !(model.image ?? "student.valuxapps.com")
                            .contains("student.valuxapps.com")
                        ? NetworkImage(
                            model.image ?? "",
                          )
                        : const AssetImage(Images.defImage) as ImageProvider,
                  ),
                ),
              ),
            ),
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
    );
  }
}
