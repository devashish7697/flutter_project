import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/common/custom_button.dart';
import 'package:flutter_project/core/common/custom_text_field.dart';
import 'package:flutter_project/presentation/screens/auth/LoginScreen.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({super.key});

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool isPasswordVisible = false;

  void dispose(){
    emailController.dispose();
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value){
    if (value == null || value.isEmpty){
      return "Please enter your full name";
    }
    return null;
  }

  String? _validateUsername(String? value){
    if (value == null || value.isEmpty){
      return "Please enter your Username";
    }
    return null;
  }

  String? _validateEmail(String? value){
    if (value == null || value.isEmpty){
      return "Please enter your Email";
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if(!emailRegex.hasMatch(value)){
      return "please provide correct email address";
    }
    return null;
  }

  String? _validatePassword(String? value){
    if (value == null || value.isEmpty){
      return "Please enter your password";
    }
    if(value.length < 4 ){
      return "password must be at least 4 character long." ;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: true,
      //--------App Bar --------------
      appBar: AppBar(
        title: Text("Talkito", style: TextStyle(fontSize: 14),),
        toolbarHeight: 45,
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),

                      // Text Area
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Text("Join Talkito!" ,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                  fontSize: 29,
                                ),
                              ),
                          Row(
                            children: [
                              Text("Connect with Anyone at " ,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              Text("Anytime." ,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.lightBlueAccent,
                                    fontSize: 16,
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
            
                      const SizedBox(
                        height:50,
                      ),
                      // input Fields
                      custom_text_field(
                          controller: emailController,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined),
                          focusNode: _emailFocus,
                        validator: _validateEmail,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      custom_text_field(
                        controller: nameController,
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person_2_outlined),
                        focusNode: _nameFocus,
                        validator: _validateName,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      custom_text_field(
                        controller: usernameController,
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person_outline),
                        focusNode: _usernameFocus,
                        validator: _validateUsername,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      custom_text_field(
                        controller: passwordController,
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline),
                        focusNode: _passwordFocus,
                        obsecureText: !isPasswordVisible,
                        validator: _validatePassword,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon( isPasswordVisible ? Icons.visibility_off : Icons.visibility)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      custom_text_field(
                        controller: phoneController,
                        hintText: "Phone no.",
                        prefixIcon: Icon(Icons.call_outlined),
                        focusNode: _phoneFocus,
                      ),
            
                      const SizedBox(
                        height: 50,
                      ),

                      // --------- signup Button ----------
                      custom_button (
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if(_formKey.currentState?.validate() ?? false) {};
                        },
                        text: "Sign up",
                      ),

                      const SizedBox(
                        height: 13,
                      ),

                      //--------Text Area --------
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an Account? ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(
                                text: "Login here.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (){
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(content: Text("Navigating to Login Up page...")),
                                    );
                                    Navigator.pop(context);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          )),
    );
  }
}
