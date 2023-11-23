import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_one/models/posts.model.dart';
import 'package:fire_one/shared/styles/icon_broken.dart';
import 'package:fire_one/social_cubit/cubit.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final SocialPostsModel model;
  final int index;
  const PostItem({
    super.key,
    required this.index,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        image: NetworkImage('${model.image}'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                      Text(
                        model.dateTime?.substring(0, 16) ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    SocialCubit.get(context).removePost(
                      postId: SocialCubit.get(context).postId[index],
                    );
                  },
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 3,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                model.text ?? "",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: [
                    SizedBox(
                      height: 20,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        minWidth: 0,
                        textColor: Colors.blue,
                        onPressed: () {},
                        child: const Text('#SalamaAhmed'),
                      ),
                    ),
                    const SizedBox(width: 3),
                    SizedBox(
                      height: 20,
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        minWidth: 0,
                        textColor: Colors.blue,
                        onPressed: () {},
                        child: const Text('#flutter'),
                      ),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != "") ...{
              Container(
                height: 200,
                width: double.infinity,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage('${model.postImage}'),
                  // ),
                ),
                child: checkUrl(
                  model.postImage ?? "no image",
                ),
              ),
            },
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // SocialCubit.get(context).noOfLikes
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              // '5'
                              '${SocialCubit.get(context).noOfLikes[index]}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('0 comment'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 3,
              color: Colors.grey[300],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              '${model.image}',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('write a comment'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            SocialCubit.get(context).likesPost(
                              SocialCubit.get(context).postId[index],
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Heart,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Like',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget checkUrl(String url) {
  try {
    // if (!url.contains("posts%"))
     return Image.network(url, fit: BoxFit.cover);

    // return const SizedBox(
    //   height: 0,
    // );
  } catch (e) {
    return const Icon(Icons.image);
  }
}

class CustomImages extends StatelessWidget {
  final String imageUrl;
  const CustomImages({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl, 

    );
  }
}
