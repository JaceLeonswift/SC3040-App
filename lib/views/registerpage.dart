import 'package:SC3040_App/viewModels/register_viewmodel.dart';
import 'package:SC3040_App/views/loginpage.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:SC3040_App/widgets/customtextinput.dart';
import 'package:SC3040_App/widgets/linktext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) =>
          RegisterViewModel(), //the change notifier that is used
      child: Scaffold(
        appBar: const CustomAppBar(
          displayProfileIcon: false,
        ),
        //the widgets that will respond to change notifier
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: const RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  Future<bool> _register(
      BuildContext context, RegisterViewModel registerViewModel) async {
    bool? registered = await registerViewModel.register();
    if (registered == true) {
      // show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${registerViewModel.successMessage}"),
        ),
      );
    } else {
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${registerViewModel.errorMessage}"),
        ),
      );
    }
    return registered;
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            'Create an Account',
            textAlign: TextAlign.center,
            style: GoogleFonts.bebasNeue(fontSize: 40, letterSpacing: 2),
          ),
          const SizedBox(height: 40),

          // Username Field
          CustomTextInput(
            labelText: "Username",
            labelTextStyle: GoogleFonts.bebasNeue(fontSize: 20),
            controller: registerViewModel.usernameController,
          ),
          const SizedBox(height: 20),

          // Password Field
          CustomTextInput(
            labelText: "Password",
            labelTextStyle: GoogleFonts.bebasNeue(fontSize: 20),
            controller: registerViewModel.passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 20),

          // Confirm Password Field
          CustomTextInput(
            labelText: "Confirm Password",
            labelTextStyle: GoogleFonts.bebasNeue(fontSize: 20),
            controller: registerViewModel.confirmPasswordController,
            obscureText: true,
          ),
          const SizedBox(height: 30),

          // Sign Up Button
          FutureBuilder<bool>(
            future: null, // Future is null initially
            builder: (context, snapshot) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: registerViewModel.isLoading
                    ? null
                    : () async {
                        // Trigger the FutureBuilder by setting the future
                        final registerFuture =
                            _register(context, registerViewModel);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return FutureBuilder<bool>(
                              future: registerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  );
                                } else {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  return Container(); // Return an empty container
                                }
                              },
                            );
                          },
                        );
                        await registerFuture;
                      },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Error Message
          if (registerViewModel.errorMessage != null)
            Text(
              registerViewModel.errorMessage!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 16,
              ),
            ),

          // Success Message
          if (registerViewModel.successMessage != null)
            Text(
              registerViewModel.successMessage!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),

          // Register Text with Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: GoogleFonts.bebasNeue(
                  fontSize: 20,
                ),
              ),
              LinkText(
                text: 'Sign in',
                page: const LoginPage(),
                textStyle: GoogleFonts.bebasNeue(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
