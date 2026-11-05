import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Clean, responsive search and filter action bar for the Education Portal
class ResponsiveSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? filterValue;
  final List<String> filterOptions;
  final ValueChanged<String?>? onFilterChanged;
  final String actionLabel;
  final VoidCallback onActionPressed;
  final IconData? actionIcon;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const ResponsiveSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.filterValue,
    required this.filterOptions,
    required this.onFilterChanged,
    required this.actionLabel,
    required this.onActionPressed,
    this.actionIcon,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 640;

        if (isNarrow) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x06172033),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Search Input Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.veryLightBlue,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: AppColors.primaryBlue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          onChanged: onChanged,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: AppColors.textDisabled,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      if (controller.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            controller.clear();
                            if (onClear != null) {
                              onClear!();
                            } else if (onChanged != null) {
                              onChanged!('');
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(Icons.close, size: 16, color: AppColors.textSecondary),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // 2. Filter & Action Row
                Row(
                  children: [
                    // Filter dropdown
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.filter_list_rounded, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: filterValue,
                              isDense: true,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                              items: filterOptions.map((opt) {
                                return DropdownMenuItem(value: opt, child: Text(opt));
                              }).toList(),
                              onChanged: onFilterChanged,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Action button
                    ElevatedButton(
                      onPressed: onActionPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (actionIcon != null) ...[
                            Icon(actionIcon, size: 15, color: Colors.white),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            actionLabel,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        // Desktop / Tablet Layout (>= 640px)
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06172033),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 20, color: AppColors.primaryBlue),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textDisabled,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (controller.text.isNotEmpty) ...[
                GestureDetector(
                  onTap: () {
                    controller.clear();
                    if (onClear != null) {
                      onClear!();
                    } else if (onChanged != null) {
                      onChanged!('');
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(Icons.close, size: 16, color: AppColors.textSecondary),
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Container(
                height: 24,
                width: 1,
                color: AppColors.border,
              ),
              const SizedBox(width: 12),
              const Icon(Icons.filter_list_rounded, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: filterValue,
                  isDense: true,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: AppColors.textPrimary,
                  ),
                  items: filterOptions.map((opt) {
                    return DropdownMenuItem(value: opt, child: Text(opt));
                  }).toList(),
                  onChanged: onFilterChanged,
                ),
              ),
              const SizedBox(width: 14),
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (actionIcon != null) ...[
                      Icon(actionIcon, size: 15, color: Colors.white),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      actionLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
