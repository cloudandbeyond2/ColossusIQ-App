import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Floating card / pill-shaped bottom navigation bar inspired by modern mobile UI
class PortalBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PortalBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(bottom: 14, top: 4),
        child: Center(
          heightFactor: 1.0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              height: 66,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(38),
                border: Border.all(
                  color: const Color(0xFFF1F5F9),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      index: 0,
                      icon: Icons.home_rounded,
                      unselectedIcon: Icons.home_outlined,
                      label: "Home",
                    ),
                    _buildNavItem(
                      index: 1,
                      icon: Icons.menu_book_rounded,
                      unselectedIcon: Icons.menu_book_outlined,
                      label: "Courses",
                    ),
                    _buildNavItem(
                      index: 2,
                      icon: Icons.sticky_note_2_rounded,
                      unselectedIcon: Icons.sticky_note_2_outlined,
                      label: "Notes",
                    ),
                    _buildNavItem(
                      index: 3,
                      icon: Icons.assignment_rounded,
                      unselectedIcon: Icons.assignment_outlined,
                      label: "Assignments",
                    ),
                    _buildNavItem(
                      index: 4,
                      icon: Icons.person_rounded,
                      unselectedIcon: Icons.person_outline_rounded,
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData unselectedIcon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    const activeColor = Color(0xFF0F172A);
    const inactiveColor = Color(0xFF94A3B8);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(index),
          splashColor: Colors.black.withValues(alpha: 0.04),
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Icon(
                isSelected ? icon : unselectedIcon,
                size: 22,
                color: isSelected ? activeColor : inactiveColor,
              ),

              // Active Underline Indicator
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 2),
                  width: 14,
                  height: 2.2,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                )
              else
                const SizedBox(height: 6.2),

              // Text Label
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? activeColor : inactiveColor,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
