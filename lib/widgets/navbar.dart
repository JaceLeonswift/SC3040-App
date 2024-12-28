import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.destinations,
    this.minExpandWidth = 500.0,
    this.horizontalStructure = true,
  });

  final List<NavBarDestination> destinations;
  final double minExpandWidth;
  final bool horizontalStructure;

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  late Widget page;
  var selectedIndex = 0;
  var isExpanded = false;
  Map<String, IconData> iconMap = {
    "a": Mdi.alphaA,
    "b": Mdi.alphaB,
    "c": Mdi.alphaC,
    "d": Mdi.alphaD,
    "e": Mdi.alphaE,
    "f": Mdi.alphaF,
    "g": Mdi.alphaG,
    "h": Mdi.alphaH,
    "i": Mdi.alphaI,
    "j": Mdi.alphaJ,
    "k": Mdi.alphaK,
    "l": Mdi.alphaL,
    "m": Mdi.alphaM,
    "n": Mdi.alphaN,
    "o": Mdi.alphaO,
    "p": Mdi.alphaP,
    "q": Mdi.alphaQ,
    "r": Mdi.alphaR,
    "s": Mdi.alphaS,
    "t": Mdi.alphaT,
    "u": Mdi.alphaU,
    "v": Mdi.alphaV,
    "w": Mdi.alphaW,
    "x": Mdi.alphaX,
    "y": Mdi.alphaY,
    "z": Mdi.alphaZ,
  };

  @override
  Widget build(BuildContext context) {
    int navBarSize = widget.destinations.length;
    if (navBarSize < 2) {
      throw Exception("NavBar must have at least 2 destinations");
    }

    if (selectedIndex >= widget.destinations.length) {
      throw UnimplementedError("No page for index $selectedIndex");
    }

    page = widget.destinations[selectedIndex].page;
    isExpanded = MediaQuery.of(context).size.width > widget.minExpandWidth;
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          SafeArea(
            child: NavigationRail(
              backgroundColor: Theme.of(context)
                  .primaryColorDark, // Use the backgroundColor field
              extended: isExpanded,
              destinations: List.generate(navBarSize, (i) {
                return NavigationRailDestination(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  icon: widget.destinations[i].icon ??
                      Icon(
                        iconMap[widget.destinations[i].name[0].toLowerCase()],
                        size: 30,
                      ),
                  label: Text(
                    widget.destinations[i].name,
                    style: GoogleFonts.actor(
                      fontSize: 20,
                    ),
                  ),
                );
              }),
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              child: page,
            ),
          ),
        ],
      );
    });
  }
}

class NavBarDestination {
  const NavBarDestination({required this.name, this.icon, required this.page});
  final String name;
  final Icon? icon;
  final Widget page;
}
