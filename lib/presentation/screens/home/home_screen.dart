import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/data/services/service_locator.dart';
import 'package:flutter_project/logic/cubit/auth/auth_cubit.dart';
import 'package:flutter_project/logic/cubit/auth/auth_state.dart';
import 'package:flutter_project/presentation/screens/auth/LoginScreen.dart';
import 'package:flutter_project/router/app_router.dart';

import '../../../core/utils/ui_utils.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  Future<void> handleSignOut() async {
     await getIt<AuthCubit>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthState>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state){
        if(state.status == AuthStatus.unauthenticated ){
          getIt<AppRouter>().pushAndRemoveUntil(LoginScreen());
        } else if (state.status == AuthStatus.error && state.error != null){
          UiUtils.showSnackBar(context, message: state.error!, isError: true);
        }
      },
      builder: (context,state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Talkito", style: TextStyle(fontSize: 14)),
              toolbarHeight: 45,
            ),
            body: Center(
              child: Column(
                children: [
                  Text("HomePage", style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),

                  InkWell(
                    onTap: handleSignOut,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text("SignOut"),
                    ),
                  ),
                  //ElevatedButton(onPressed: handleSignOut, child: Text("SignOut"))
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
