import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/utils.dart';
import '../../common/util/validators.dart';
import '../../common/values/strings.dart';
import '../../routes/app_pages.dart';
import '../widgets/custom_textfield_widget.dart';
import '../widgets/my_button_style.dart';
import './controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  void _submitLogin() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    controller.login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    // initFocusNode();
    return WillPopScope(
      onWillPop: Utils.onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
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
                          CustomTextFieldWidget(
                            withAsterisk: false,
                            validator: (value) => Validators.validateEmail(value, false),
                            focusNode: _emailFocusNode,
                            controller: _emailController,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                            hintText: Strings.email.tr,
                            prefixIcon: const Icon(
                              CupertinoIcons.mail,
                            ),
                          ),
                          CustomTextFieldWidget(
                            withAsterisk: false,
                            hasObscureIcon: true,
                            hasClearIcon: false,
                            validator: Validators.validatePassword,
                            textInputAction: TextInputAction.done,
                            focusNode: _passwordFocusNode,
                            controller: _passwordController,
                            onFieldSubmitted: (_) => _submitLogin(),
                            hintText: Strings.pasword.tr,
                            prefixIcon: const Icon(CupertinoIcons.lock),
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
                      margin: const EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: ElevatedButton(
                        style: MyButtonStyle(),
                        onPressed: _submitLogin,
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/images/gg_ic.png',
                          fit: BoxFit.cover,
                          width: 23.0,
                          height: 23.0,
                        ),
                        label: const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 8.0)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
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
        ),
      ),
    );
  }
}
