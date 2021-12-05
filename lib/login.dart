import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smolstocks/shop_view.dart';
import 'package:smolstocks/utils/color.dart';
import 'package:smolstocks/utils/fonts.dart';

class LoginState extends GetxController {
  RxInt state = 0.obs;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final obj = Get.put(LoginState());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    BoldText(
                      data: "Welcome to Smol Stoks",
                      size: size.width * 0.03,
                      color: blue,
                      shadow: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => BodyText(
                            data: (obj.state.value == 0)
                                ? "Not having a Account?"
                                : "Already having a Account?",
                            color: lightBlue,
                            size: size.width * 0.012,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          padding: const EdgeInsets.all(10),
                          shape: const StadiumBorder(),
                          color: lightBlue,
                          onPressed: () {
                            obj.state.value = (obj.state.value + 1) % 2;
                          },
                          child: Obx(
                            () => BoldText(
                              data: (obj.state.value == 0) ? "SignUp" : "Login",
                              color: Colors.white,
                              size: size.width * 0.01,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Obx(
                  () => Container(
                    child: (obj.state.value == 0)
                        ? const Login()
                        : const Register(),
                    height: size.width / 3,
                    width: size.width / 3,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.grey)
                        ]),
                  ),
                ),
              ])
        ],
      ),
    );
  }
}

class LoadingState extends GetxController {
  RxBool state = false.obs;
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final obj = Get.put(LoadingState());
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => SizedBox(
        child: (obj.state.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: blue,
                ),
              )
            : AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BoldText(
                      data: "Login",
                      size: size.width * 0.015,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          width: size.width / 4,
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                border: InputBorder.none,
                                hintText: "Enter your Email"),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          width: size.width / 4,
                          child: TextField(
                            controller: password,
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                border: InputBorder.none,
                                hintText: "Enter Password"),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: const StadiumBorder(),
                          color: blue,
                          minWidth: size.width / 4,
                          height: size.width * 0.04,
                          onPressed: () async {
                            obj.state.value = true;
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .catchError((error) {
                              obj.state.value = false;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Error! $error"),
                              ));
                            });
                            obj.state.value = false;
                            Get.to(() => const ShopView());
                          },
                          child: BodyText(
                            data: "Continue",
                            size: size.width * 0.01,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final obj = Get.put(LoadingState());
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => SizedBox(
        child: (obj.state.value)
            ? Center(
                child: CircularProgressIndicator(
                  color: blue,
                ),
              )
            : AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BoldText(
                      data: "SignUp",
                      size: size.width * 0.015,
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          width: size.width / 4,
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                border: InputBorder.none,
                                hintText: "Enter your Email"),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          width: size.width / 4,
                          child: TextField(
                            controller: name,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: InputBorder.none,
                                hintText: "Enter your Name"),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                          width: size.width / 4,
                          child: TextField(
                            controller: password,
                            obscureText: true,
                            obscuringCharacter: "*",
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                border: InputBorder.none,
                                hintText: "Enter Password"),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          shape: const StadiumBorder(),
                          color: blue,
                          minWidth: size.width / 4,
                          height: size.width * 0.04,
                          onPressed: () async {
                            obj.state.value = true;
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text)
                                .catchError((error) {
                              obj.state.value = false;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Error! $error"),
                              ));
                            });

                            await FirebaseAuth.instance.currentUser!
                                .updateDisplayName((name.text == "")
                                    ? "User Name"
                                    : name.text);
                            obj.state.value = false;
                            Get.to(() => const ShopView());
                          },
                          child: BodyText(
                            data: "Continue",
                            size: size.width * 0.01,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
