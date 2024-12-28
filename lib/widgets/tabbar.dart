import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.tabBarDestinations,
    this.labelColor,
    this.indicatorColor,
  });
  final List<TabBarDestination> tabBarDestinations;
  final Color? labelColor;
  final Color? indicatorColor;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
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

    Color labelColor, indicatorColor;
    widget.labelColor == null
        ? labelColor = Theme.of(context).colorScheme.primary
        : labelColor = widget.labelColor!;
    widget.indicatorColor == null
        ? indicatorColor = Theme.of(context).colorScheme.onPrimaryContainer
        : indicatorColor = widget.indicatorColor!;
    return DefaultTabController(
      initialIndex: 0,
      length: widget.tabBarDestinations.length,
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
              child: TabBar(
                isScrollable: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                splashBorderRadius: BorderRadius.circular(10),
                labelColor: labelColor,
                indicatorColor: indicatorColor,
                labelStyle: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                tabs: List.generate(
                  widget.tabBarDestinations.length,
                  (index) => Tab(
                    text: widget.tabBarDestinations[index].tabName!,
                    icon: widget.tabBarDestinations[index].icon ??
                        Icon(
                          iconMap[widget.tabBarDestinations[index].tabName![0]
                              .toLowerCase()]!,
                          // color: Colors.black,
                          size: 25,
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  widget.tabBarDestinations.length,
                  (index) => widget.tabBarDestinations[index].tabWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarDestination {
  const TabBarDestination({
    required this.tabWidget,
    this.icon,
    this.tabName,
  });
  final Icon? icon;
  final String? tabName;
  final Widget tabWidget;
}
