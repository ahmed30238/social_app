import 'package:firebase_auth/firebase_auth.dart';

var user = FirebaseAuth.instance.currentUser;
String? uId = user?.uid;






    // if (!FirebaseAuth.instance.currentUser!.emailVerified)
                //   Container(
                //     color: Colors.amber.withOpacity(.8),
                //     height: 60,
                //     child: Padding(
                //       padding: const EdgeInsets.all(15.0),
                //       child: Row(
                //         children: [
                //           const Icon(Icons.info_outline),
                //           const SizedBox(width: 15.0),
                //           const Text('Verify Your Email'),
                //           const Spacer(),
                //           TextButton(
                //             onPressed: () {
                //               FirebaseAuth.instance.currentUser!
                //                   .sendEmailVerification()
                //                   .then((value) {
                //                 showToast(
                //                     text: 'check your mail',
                //                     state: ToastStates.SUCCESS);
                //               }).catchError((error) {
                //                 print(error.toString());
                //               });
                //             },
                //             child: const Text('Verify'),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),