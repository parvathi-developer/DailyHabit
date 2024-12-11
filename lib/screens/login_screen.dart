import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/login/login_bloc.dart';
import 'package:habit_app/bloc/login/login_event.dart';
import 'package:habit_app/bloc/login/login_state.dart';
import 'package:habit_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCOntroller = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSucess) {
              Navigator.pushReplacementNamed(context, '/home');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Login Succesfully as ${state.user.email}')));
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailCOntroller,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginButtonPressed(
                              email: _emailCOntroller.text,
                              password: _passwordController.text));
                    },
                    child: Text("Login")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text("Don'\t have a account? Register"))
              ],
            );
          }),
        )),
      ),
    );
  }
}
