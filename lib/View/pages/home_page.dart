import 'package:flutter/material.dart';
import 'package:fk_toggle/fk_toggle.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(
                  "Events",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF6B5F4A),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FkToggle(
                      width: 120,
                      height: 50,
                      labels: const ['Upcoming', 'Previous'],
                      selectedColor: const Color(0xFF2A4F92),
                      backgroundColor: const Color(0xFFC3C3C4),
                      onSelected: (int index, FkToggle toggle) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final double containerWidth = constraints.maxWidth < 360
                            ? constraints.maxWidth
                            : 360;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildEventContainer(containerWidth),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventContainer(double containerWidth) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB3AE99),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildEventCard(containerWidth),
          _buildEventCard(containerWidth,
              margin: const EdgeInsets.only(top: 11)),
          _buildEventCard(containerWidth,
              margin: const EdgeInsets.only(top: 12)),
          _buildEventCard(containerWidth,
              margin: const EdgeInsets.only(top: 13, bottom: 2)),
        ],
      ),
    );
  }

  Widget _buildEventCard(double containerWidth, {EdgeInsetsGeometry? margin}) {
    return Container(
      height: 130,
      width: containerWidth,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
