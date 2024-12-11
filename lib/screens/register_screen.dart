import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/register/register_bloc.dart';
import 'package:habit_app/bloc/register/register_event.dart';
import 'package:habit_app/bloc/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<RegisterBloc>().add(RegisterUserEvent(
                      email: _emailController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text));
                },
                child: const Text("Register")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already Have a account? Login")),
            BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  Navigator.pushReplacementNamed(context, '/home');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Registered Succesfully as $state.email')));
                } else if (state is RegisterFailureState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                if (state is RegisterLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SizedBox.shrink();
              }),
            )
          ],
        ),
      ),
    );
  }
}
