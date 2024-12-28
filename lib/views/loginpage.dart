import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:SC3040_App/views/homepage.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:SC3040_App/widgets/customtextinput.dart';
import 'package:SC3040_App/widgets/linktext.dart';
import 'package:SC3040_App/views/registerpage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<bool> _login(BuildContext context, AuthViewModel authViewModel) async {
    bool? loggedIn = await authViewModel.login();
    if (loggedIn == true) {
      // show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${authViewModel.successMessage}"),
        ),
      );
    } else {
      // show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${authViewModel.errorMessage}"),
        ),
      );
    }
    return loggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        displayProfileIcon: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (authViewModel.isLoggedIn) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          });

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcome back to MOOWEE!',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.bebasNeue(fontSize: 40, letterSpacing: 2),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Please login to continue.',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.bebasNeue(fontSize: 30, letterSpacing: 2),
                  ),
                ),
              ),
              // add space between the text and the text input
              const SizedBox(height: 20),

              CustomTextInput(
                controller: authViewModel.usernameController,
                labelText: 'Username',
                labelTextStyle: GoogleFonts.bebasNeue(fontSize: 20),
              ),
              const SizedBox(height: 20),

              CustomTextInput(
                controller: authViewModel.passwordController,
                labelText: 'Password',
                obscureText: true,
                labelTextStyle: GoogleFonts.bebasNeue(fontSize: 20),
              ),
              const SizedBox(height: 50),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                onPressed: authViewModel.isLoading
                    ? null
                    : () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            );
                          },
                        );

                        bool loggedIn = await _login(context, authViewModel);
                        Navigator.of(context).pop(); // Close the dialog

                        if (loggedIn) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                child: Text(
                  'Login',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 20,
                    ),
                  ),
                  LinkText(
                    text: 'Click here to register.',
                    textStyle: GoogleFonts.bebasNeue(fontSize: 20),
                    page: const RegisterPage(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
