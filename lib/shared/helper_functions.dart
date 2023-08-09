

import 'dart:developer';
import 'dart:io';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void closeKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> urlLauncher(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

Future<void> openWhatsapp({required String whatsNumber}) async {
  final whatsapp = whatsNumber.startsWith('00')
      ? whatsNumber.substring(2)
      : whatsNumber.startsWith('+')
          ? whatsNumber.substring(1)
          : whatsNumber;
  const message = 'السلام عليكم ورحمه الله وبركاته';
  final whatsappURlAndroid =
      "https://wa.me/$whatsapp/?text=${Uri.parse(message)}";
  final whatsappURLIos =
      "https://api.whatsapp.com/send?phone=$whatsapp=${Uri.parse(message)}";
  if (Platform.isIOS) {
    await launchUrlString(
      whatsappURLIos,
      mode: LaunchMode.externalApplication,
    );
  } else {
    await launchUrlString(
      whatsappURlAndroid,
      mode: LaunchMode.externalApplication,
    );
  }
}

void closeBottomSheet() {
  if (Get.isBottomSheetOpen!) Get.back();
}

Future<XFile?> pickImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  return image;
}

Future<List<XFile>?> pickMultiImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = await picker.pickMultiImage();

  return images;
}

Future<List<File>> pickMultiImageAndVideoFromGallery({
  bool showCamera = true,
  int selectCount = 5,
  int videoMaxSecond = 30,
}) async {
  final List<Media> images = await ImagePickers.pickerPaths(
    galleryMode: GalleryMode.all,
    compressSize: 500,
    language:
        Get.locale?.languageCode == 'ar' ? Language.arabic : Language.english,
    showCamera: showCamera,
    selectCount: selectCount,
    videoRecordMaxSecond: videoMaxSecond,
    videoSelectMaxSecond: videoMaxSecond,
    showGif: false,
  );

  List<File> editedImages = images.map((e) => File(e.path ?? '')).toList();
  return editedImages;
}

// Future<void> logOut() async {
//   await TokenUtil.clearToken();
//   Get.offAllNamed(LoginRouting.config().path);
// }

void showFlashBar({required BuildContext context, required String message}) {
  showFlash(
    context: context,
    duration: const Duration(seconds: 2),
    builder: (_, controller) {
      return Flash(
        controller: controller,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // behavior: FlashBehavior.floating,
        position: FlashPosition.top,
        // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // borderRadius: BorderRadius.circular(10),
        child: FlashBar(
          controller: controller,
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          showProgressIndicator: false,
          progressIndicatorBackgroundColor: Colors.transparent,
          progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary),
        ),
      );
    },
  );
}

void showLoading() {
  Get.dialog(
    Center(
        child: CircularProgressIndicator(
            color: Theme.of(Get.context!).colorScheme.primary)),
    barrierColor: Colors.white.withOpacity(.35),
    barrierDismissible: false,
  );
}

void hideLoading() {
  if (Get.isDialogOpen!) Get.back();
}
class AppsStoreLinkEnum {
  static const String androidId = '';
  static const String iosId = '';
}

void shareApp({required BuildContext context}) async {
  final box = context.findRenderObject() as RenderBox?;
  if (Platform.isAndroid) {
    await Share.share(
      AppsStoreLinkEnum.androidId,
    );
  } else if (Platform.isIOS) {
    await Share.share(
      AppsStoreLinkEnum.iosId,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}

// void cacheUserData(
//   LoginModel data, {
//   String? alternativeNamedRouteAfterCacheSuccess,
// }) {
//   saveValue(StorageEnum.userData, jsonEncode(data.body?.toJson()));
//   TokenUtil.saveToken(data.body?.accessToken ?? '');
//   Get.find<LayoutVm>().changeCurrentIndex(0);
//   Get.offNamed(
//       alternativeNamedRouteAfterCacheSuccess ?? LayoutRouting.config().path);
//   saveValue(StorageEnum.isGuest, false);
// }

// UserDataModel? get cachedUserData => !containsKey(StorageEnum.userData)
    // ? null
    // : LoginDataModel.fromJson(jsonDecode(getValue(StorageEnum.userData))).user;

// List<int> get _seenAdvIds => !containsKey(StorageEnum.seenAdvList)
//     ? []
//     : List<int>.from(jsonDecode(getValue(StorageEnum.seenAdvList)));

// Future<void> storeSeenAdId({required int adId}) async {
//   var hasSeen = hasSeenThisAd(adId);
//   if (hasSeen) {
//     return;
//   }
//   var list = _seenAdvIds;

//   list.add(adId);
//   await saveValue(StorageEnum.seenAdvList, jsonEncode(list));
// }

// bool hasSeenThisAd(int adId) =>
//     _seenAdvIds.indexWhere((element) => element == adId) >= 0;

double calculateAverage(List<double> numbers) {
  if (numbers.isEmpty) {
    return 0; // Return 0 for an empty list, or you can handle it differently based on your requirements.
  }

  double sum = 0;
  for (double number in numbers) {
    sum += number;
  }

  double average = sum / numbers.length;
  return average;
}

String getImageFromPosition({
  required String lat,
  required String lng,
}) {
  var apiKey =
      'Ap1KkkdRwpQpuzlwc9jZ-6waIdxHCJHj439BdOxUhwFBKNtheMoREdHlmZpZi6OZ';
  String zoomLevel = '335';
  String image = '';
  try {
    image =
        'https://dev.virtualearth.net/REST/v1/Imagery/Map/Road/$lat,$lng/18?mapSize=1000,500&pp=$lat,$lng;66&mapLayer=Basemap,Buildings&zoomLevel=$zoomLevel&key=$apiKey';
  } catch (e) {
    log('$e');
  }
  return image;
}
