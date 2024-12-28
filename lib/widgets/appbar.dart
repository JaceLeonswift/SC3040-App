import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:SC3040_App/views/homepage.dart';
import 'package:SC3040_App/views/loginpage.dart';
import 'package:SC3040_App/views/profilepage.dart';
import 'package:SC3040_App/widgets/filters.dart';
import 'package:SC3040_App/widgets/linktext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool displaySearchIcon;
  final bool displayProfileIcon;
  const CustomAppBar({
    super.key,
    this.displaySearchIcon = true,
    this.displayProfileIcon = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        bool loggedIn = authViewModel.isLoggedIn;
        return AppBar(
          leading: Navigator.canPop(context)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          actions: [
            if (widget.displaySearchIcon)
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiltersPage(),
                    ),
                  );
                },
              ),
            const Padding(padding: EdgeInsets.only(right: 15)),
            if (widget.displayProfileIcon)
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          loggedIn ? const ProfilePage() : const LoginPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_circle),
              ),
          ],
          foregroundColor: Theme.of(context).colorScheme.onTertiary,
          title: Center(
            child: Text(
              'MooWee',
              style: GoogleFonts.bebasNeue(fontSize: 50),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        );
      },
    );
  }
}
