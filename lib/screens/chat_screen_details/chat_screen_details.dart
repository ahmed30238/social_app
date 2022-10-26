import 'package:fire_one/models/message_model.dart';
import 'package:fire_one/models/social_model.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:fire_one/social_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenDetails extends StatelessWidget {
  // const ChatScreenDetails({Key? key}) : super(key: key);
  SocialUserModel userModel;
  // String? id = userModel.uId;
  ChatScreenDetails(this.userModel, {super.key});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMesages(receiverId: userModel.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SocialCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${userModel.image}',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('${userModel.name}'),
                    ],
                  )),
              body: cubit.messages.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                var message = cubit.messages[index];
                                if (cubit.userModel!.uId! == message.senderId) {
                                  return buildMyMessage(message);
                                }
                                return buildMessage(message);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: cubit.messages.length,
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    toolbarOptions: const ToolbarOptions(
                                      copy: true,
                                      paste: true,
                                      cut: true,
                                    ),
                                    controller: messageController,
                                    onFieldSubmitted: (v) {
                                      cubit.sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: v,
                                      );
                                      messageController.clear();
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: 'write your message here ...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      cubit.sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                      messageController.clear();
                                    },
                                    minWidth: 1,
                                    child: const Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text('No Mesages Yet'),
                            ),
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    toolbarOptions: const ToolbarOptions(
                                      copy: true,
                                      paste: true,
                                      cut: true,
                                    ),
                                    controller: messageController,
                                    onFieldSubmitted: (v) {
                                      cubit.sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: v,
                                      );
                                      messageController.clear();
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: 'write your message here ...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      cubit.sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text,
                                      );
                                      messageController.clear();
                                    },
                                    minWidth: 1,
                                    child: const Icon(
                                      IconBroken.Send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(SocialMessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${model.text}',
            ),
          ),
        ),
      );

  Widget buildMyMessage(SocialMessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.2),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${model.text}',
            ),
          ),
        ),
      );
}
