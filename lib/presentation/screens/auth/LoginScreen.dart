import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/core/common/custom_button.dart';
import 'package:flutter_project/core/common/custom_text_field.dart';
import 'package:flutter_project/core/utils/ui_utils.dart';
import 'package:flutter_project/data/services/service_locator.dart';
import 'package:flutter_project/logic/cubit/auth/auth_state.dart';
import 'package:flutter_project/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_project/router/app_router.dart';
import '../auth/signup_screen.dart';
import '../home/home_screen.dart';

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
      return "password must be at least 4 characters long.";
    }
    return null;
  }

  Future<void> handleSignIn() async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState?.validate() ?? false) {
      try {
        await getIt<AuthCubit>().signIn(
          email: emailController.text,
          password: passwordController.text,
        );
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }else {
      print("form validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context,state) {
        if(state.status == AuthStatus.authenticated) {
          getIt<AppRouter>().pushAndRemoveUntil(const home_screen());
        } else if (state.status == AuthStatus.error && state.error != null){
          UiUtils.showSnackBar(context, message: state.error!, isError: true);
        }
      },
      builder: (context,state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Talkito", style: TextStyle(fontSize: 14)),
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
                        const SizedBox(height: 140),

                        Text("Welcome to Talkito!",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),

                        Text("Sign in to your Account.",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 60),

                        custom_text_field(
                          controller: emailController,
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 15),

                        custom_text_field(
                          controller: passwordController,
                          hintText: "password",
                          obsecureText: !isPasswordVisible,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: _validatePassword,
                        ),

                        const SizedBox(height: 50),

                        custom_button(
                          onPressed: handleSignIn,
                          text: "Login",
                          child: state.status==AuthStatus.loading ?
                          CircularProgressIndicator(color: Colors.white,) :
                          Text("Login", style: TextStyle(color: Colors.white),),
                        ),

                        const SizedBox(height: 2),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?",
                                  style:
                                  TextStyle(color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextButton(
                                onPressed: () {
                                  getIt<AppRouter>().push(
                                      const signup_screen());
                                },
                                child: Text(
                                  "Signup here",
                                  style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    )),
              ),
            ),
          ),
        );
      }
    );
  }
}
