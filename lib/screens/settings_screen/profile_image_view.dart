import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImageView extends StatefulWidget {
  final String image;
  const ProfileImageView({super.key, required this.image});

  @override
  State<ProfileImageView> createState() => _ProfileImageViewState();
}

class _ProfileImageViewState extends State<ProfileImageView> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Get.back(),
      key: const Key('dismiss'),
      child: Scaffold(
        body: InkWell(
          onTap: () {
            isVisible = !isVisible;
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.9),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.image,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: Localizations.localeOf(context).languageCode == "ar"
                    ? 10
                    : MediaQuery.sizeOf(context).width *.9,
                child: Visibility(
                  visible: isVisible,
                  child: SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.center,
                        iconSize: 35,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
