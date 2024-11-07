import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global.dart';
import '../../../service/pref.dart';
import '../../../theme/cubit/theme_cubit.dart';
import '../../../widget/logo.dart';
import '../cubit/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final _c = context.read<AuthCubit>();

  final _email = TextEditingController()..text = Pref.email;
  final _password = TextEditingController()..text = Pref.password;

  final _node = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final space = SizedBox(height: mq.height * .02);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_node),
      child: Scaffold(
        //app bar
        appBar: AppBar(
          title: BlocSelector<AuthCubit, AuthState, bool>(
            selector: (state) => state.isNewUser,
            builder: (_, state) =>
                Text(state ? 'Register Now' : 'Welcome Back'),
          ),

          //
          actions: [
            IconButton(
              splashRadius: 25,
              tooltip: 'App Theme',
              visualDensity: const VisualDensity(horizontal: -4),
              onPressed: () => context.read<ThemeCubit>().changeTheme(),
              icon: BlocSelector<ThemeCubit, ThemeState, bool>(
                selector: (state) => state.isDarkMode,
                builder: (context, state) {
                  return Padding(
                    padding: state
                        ? const EdgeInsets.only(bottom: 2)
                        : EdgeInsets.zero,
                    child: Icon(
                      state
                          ? CupertinoIcons.moon_stars
                          : CupertinoIcons.sun_max,
                      color: state
                          ? const Color(0xCCFFFFFF)
                          : const Color(0xCC000000),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),

        //body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * .05,
            vertical: mq.height * .1,
          ),
          child: Column(children: [
            //logo
            const Logo(),

            //
            SizedBox(height: mq.height * .05),

            //email input field
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.mail, size: 20),
                  hintText: 'Email'),
            ),

            space,

            //Password input field
            BlocSelector<AuthCubit, AuthState, bool>(
              selector: (state) => state.hidePass,
              builder: (context, state) {
                return TextFormField(
                  obscureText: state,
                  controller: _password,
                  decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),

                      //lock
                      prefixIcon: const Icon(CupertinoIcons.lock, size: 24),

                      //
                      suffixIcon: IconButton(
                        icon: Icon(
                            state
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            size: 24),
                        onPressed: _c.updateHidePass,
                      ),
                      hintText: 'Password'),
                );
              },
            ),

            space,

            Row(
              children: [
                BlocSelector<AuthCubit, AuthState, bool>(
                  selector: (state) => state.keepSignedIn,
                  builder: (_, state) => CupertinoCheckbox(
                    activeColor: Colors.green,
                    value: state,
                    onChanged: _c.updateKeepSignedIn,
                  ),
                ),
                const Text(
                  'Keep me signed In',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),

            space,

            // button
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(_node);
                _c.handleButtonClick(context, _email, _password);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(mq.width * .45, 50),
              ),
              child: BlocSelector<AuthCubit, AuthState, bool>(
                selector: (state) => state.isNewUser,
                builder: (_, state) => Text(state ? 'Register' : 'Login'),
              ),
            ),

            //
            SizedBox(height: mq.height * .05),

            BlocSelector<AuthCubit, AuthState, bool>(
              selector: (state) => state.isNewUser,
              builder: (_, state) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state
                        ? 'Already have an account?'
                        : 'Don\'t have an account?',
                  ),

                  //
                  TextButton(
                      onPressed: _c.updateIsNewUser,
                      child: Text(state ? 'Login' : ' Register '))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
