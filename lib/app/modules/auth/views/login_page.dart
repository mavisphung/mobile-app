import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../widgets/my_button_style.dart';
import '../../widgets/my_input_decoration.dart';
import '../controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  void _submitLogin() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    await controller.login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 40.0,
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sign in with your email and password or continue with sign in with Google',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90.0,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            } else if (!value.contains(RegExp(
                                r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$'))) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          controller: _emailController,
                          decoration: MyInputDecoration(
                              hintText: 'Email',
                              prefixIcon: const Icon(
                                CupertinoIcons.mail,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 90.0,
                        child: Obx(() => TextFormField(
                              obscureText: controller.isPasswordObscure.value,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                } else if (value.length < 6) {
                                  return 'Password must has at least 6 characters';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _submitLogin();
                              },
                              controller: _passwordController,
                              decoration: MyInputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(CupertinoIcons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      controller.isPasswordObscure.value =
                                          !controller.isPasswordObscure.value,
                                  icon: !controller.isPasswordObscure.value
                                      ? const Icon(
                                          CupertinoIcons.eye_slash,
                                        )
                                      : const Icon(CupertinoIcons.eye),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {},
                    child: const Text(
                      'Forgot password?',
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // height: 38.0,
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: ElevatedButton(
                    style: MyButtonStyle(),
                    onPressed: () {
                      _submitLogin();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   margin: const EdgeInsets.only(
                //     top: 5.0,
                //     bottom: 5.0,
                //   ),
                //   child: ElevatedButton.icon(
                //     icon: Image.asset(
                //       'assets/images/gg_ic.png',
                //       fit: BoxFit.cover,
                //       width: 23.0,
                //       height: 23.0,
                //     ),
                //     label: const Text(
                //       'Sign in with Google',
                //       style: TextStyle(
                //         color: Colors.black,
                //       ),
                //     ),
                //     style: ButtonStyle(
                //       backgroundColor:
                //           MaterialStateProperty.all(Colors.white),
                //       padding: MaterialStateProperty.all<EdgeInsets>(
                //           const EdgeInsets.symmetric(vertical: 8.0)),
                //       shape: MaterialStateProperty.all(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(6.0),
                //         ),
                //       ),
                //     ),
                //     onPressed: () {},
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account yet?'),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              // color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
