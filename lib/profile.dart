import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smolstocks/login.dart';
import 'package:smolstocks/main.dart';

import 'package:smolstocks/utils/color.dart';
import 'package:smolstocks/utils/fonts.dart';

class ProfileLauncher extends StatefulWidget {
  const ProfileLauncher({Key? key}) : super(key: key);

  @override
  _ProfileLauncherState createState() => _ProfileLauncherState();
}

class _ProfileLauncherState extends State<ProfileLauncher>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: blue,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    List<DocumentSnapshot<Map<String, dynamic>>> values = [];
    DocumentSnapshot<Map<String, dynamic>> myHoldings = await FirebaseFirestore
        .instance
        .collection("holdings")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (myHoldings.data()!.isNotEmpty) {
      for (String keys in myHoldings.data()!.keys) {
        DocumentSnapshot<Map<String, dynamic>> temp = await FirebaseFirestore
            .instance
            .collection("stocks")
            .doc(keys)
            .get();
        if (temp.data()!.isNotEmpty) {
          values.add(temp);
        }
      }
      Get.to(
          Profile(values: values, holdings: myHoldings, size: values.length));
    }
  }
}

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    required this.values,
    required this.holdings,
    required this.size,
  }) : super(key: key);
  final List<DocumentSnapshot<Map<String, dynamic>>> values;
  final DocumentSnapshot<Map<String, dynamic>> holdings;
  final int size;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  width: size.width / 3,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: const SizedBox.expand(child: FlutterLogo()),
                            radius: size.width * 0.06,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoldText(
                                data: FirebaseAuth
                                        .instance.currentUser!.displayName ??
                                    "User",
                                size: size.width * 0.016,
                                // shadow: true,
                              ),
                              BodyText(
                                data:
                                    FirebaseAuth.instance.currentUser!.email ??
                                        "confirm your email",
                                color: lightBlue,
                                size: size.width * 0.012,
                              ),
                              BodyText(
                                data:
                                    "My Unique Id = ${FirebaseAuth.instance.currentUser!.uid}",
                                color: Colors.black,
                                size: size.width * 0.007,
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        color: green,
                        onPressed: () {},
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        minWidth: size.width / 5,
                        shape: const StadiumBorder(),
                        child: BoldText(
                          data: "Add your Shop",
                          color: Colors.white,
                          size: size.width * 0.013,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: red,
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then(
                              (value) => Get.offAll(() => const LoginScreen()));
                        },
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        minWidth: size.width / 5,
                        shape: const StadiumBorder(),
                        child: BoldText(
                          data: "SignOut",
                          color: Colors.white,
                          size: size.width * 0.013,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width / 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
