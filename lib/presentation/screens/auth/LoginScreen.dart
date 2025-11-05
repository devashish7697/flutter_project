import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/core/common/custom_button.dart';
import 'package:flutter_project/core/common/custom_text_field.dart';
import 'package:flutter_project/presentation/screens/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
    return Scaffold (

      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Talkito", style: TextStyle(fontSize: 14),),
        toolbarHeight: 45,
      ),

      // body
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
                  height: 140,
                ),
          
                // text fields
          
                Text("Welcome to Talkito!",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text("Sign in to your Account.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey,fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                      height: 60,
                ),
          
                // Input Text Fields
                custom_text_field(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  validator: _validateEmail,
                ),
                const SizedBox(
                  height: 15,
                ),
                custom_text_field(controller: passwordController,
                  hintText: "password",
                  obsecureText: !isPasswordVisible,
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                  }, icon: Icon(isPasswordVisible ? Icons.visibility_off : Icons.visibility)),
                  validator: _validatePassword,
                ),
          
          
                // --------Button----------
                const SizedBox(
                  height: 50,
                ),
                custom_button(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if(_formKey.currentState?.validate() ?? false){

                    }
                  },
                  text: "Login",
                ),
          
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(
                        text: "Don't have an Account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                              text: "Signup here.",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                              ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text("Navigating to Sign Up page...")),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signup_screen(),
                                  )
                                );
                              },
                          ),
                        ],
                      ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
