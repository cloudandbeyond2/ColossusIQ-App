import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Floating card-based header matching the bottom navigation card geometry
class PortalHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final String? avatarInitials;
  final GlobalKey? avatarKey;
  final Widget? badge;
  final VoidCallback? onBack;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

  const PortalHeader({
    super.key,
    this.title = "ColossusIQ",
    this.subtitle = "Student Portal",
    this.avatarInitials,
    this.avatarKey,
    this.badge,
    this.onBack,
    this.onMenuTap,
    this.onNotificationTap,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(top: topPadding + 8, bottom: 6),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      // Left: Three-line hamburger menu icon on ALL screens
                      IconButton(
                        onPressed: onMenuTap ?? onProfileTap,
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.textPrimary,
                          size: 24,
                        ),
                        splashRadius: 18,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        tooltip: "Menu",
                      ),

                      const SizedBox(width: 8),

                      // Title and optional subtitle
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                                if (badge != null) ...[
                                  const SizedBox(width: 6),
                                  badge!,
                                ],
                              ],
                            ),
                            if (subtitle != null) ...[
                              const SizedBox(height: 1),
                              Text(
                                subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Notification action
                      IconButton(
                        onPressed: onNotificationTap,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 21),
                            Positioned(
                              right: 1,
                              top: 1,
                              child: Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        splashRadius: 18,
                        tooltip: "Notifications",
                      ),
                      const SizedBox(width: 4),

                      // Profile button / avatar
                      GestureDetector(
                        key: avatarKey,
                        onTap: onProfileTap,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.lightBlue, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.lightBlue,
                            child: Text(
                              avatarInitials ?? "AK",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
