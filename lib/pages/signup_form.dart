import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../repository/auth_repository.dart';
import '../widgets/social_signin.dart';
import '../widgets/textfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
    required this.loginSwitcher,
  }) : super(key: key);
  final Widget loginSwitcher;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController? nameController,emailAddressController,
      passwordController,
      confirmPasswordController;

  late bool obscurePassword;
  late bool obscureConfirmPassword;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    obscurePassword = true;
    obscureConfirmPassword = true;
  }

  late AuthRepository auth;
  @override
  void dispose() {
    emailAddressController?.dispose();
    passwordController?.dispose();
    confirmPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthRepository>(context);
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/template-screens-hpce0u/assets/xofl99y11az0/@3xlogo_primary_color_white.png',
                        //   width: 242,
                        //   height: 60,
                        //   fit: BoxFit.fitWidth,
                        // ),
                        Text(
                          'Tourist Guide',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Welcome!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Use the form below to create your account.',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                   FormTextField(
                    textInputType: TextInputType.text,
                    controller: nameController!,
                    labelText: 'What should we call you',
                    hintText: 'Enter your first name here...',
                    errorMessage: 'Name should not be empty',
                    validator: (value) {
                      return (!value.isNotEmpty);
                    },
                  ),
                  FormTextField(
                    textInputType: TextInputType.emailAddress,
                    controller: emailAddressController!,
                    labelText: 'Email Address',
                    hintText: 'Enter your email address here...',
                    errorMessage: 'invalid email address',
                    validator: (value) {
                      return (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value));
                    },
                  ),
                  FormTextField(
                      textInputType: TextInputType.visiblePassword,
                      controller: passwordController!,
                      obscureText: obscurePassword,
                      labelText: 'Password',
                      hintText: 'Your password goes here...',
                      errorMessage: 'field cannot be empty',
                      validator: (value) {
                        return value.isEmpty;
                      },
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ))),
                  FormTextField(
                      textInputType: TextInputType.visiblePassword,
                      controller: confirmPasswordController!,
                      obscureText: obscureConfirmPassword,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Your password here...',
                      errorMessage: 'passwords do not match',
                      validator: (value) {
                        return value != passwordController!.text;
                      },
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obscureConfirmPassword = !obscureConfirmPassword;
                            });
                          },
                          child: const Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ))),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  const SocialSignIn(),
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (auth.status != Status.authenticating) {
                            if (_formKey.currentState!.validate()) {
                              auth.signUp(
                                  emailAddressController!.text.trim(),
                                  passwordController!.text.trim(),
                                  nameController!.text.trim());
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'something went wrong');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(220, 50),
                            primary: const Color(0xFF3D80DA),
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )),
                        child: auth.status == Status.authenticating
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Create Account'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        widget.loginSwitcher
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
