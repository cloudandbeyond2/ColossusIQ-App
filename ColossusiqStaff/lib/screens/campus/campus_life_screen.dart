import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/app_badge.dart';
import '../../data/mock_data.dart';

class CampusLifeScreen extends StatefulWidget {
  const CampusLifeScreen({super.key});

  @override
  State<CampusLifeScreen> createState() => _CampusLifeScreenState();
}

class _CampusLifeScreenState extends State<CampusLifeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _joinedClubIds = {"CLB-01"};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          "Campus Life",
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.brand,
          unselectedLabelColor: AppColors.ink3,
          indicatorColor: AppColors.brand,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: "Clubs & Societies"),
            Tab(text: "Sports & Tournaments"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildClubsTab(),
          _buildSportsTab(),
        ],
      ),
    );
  }

  Widget _buildClubsTab() {
    final clubs = MockData.clubs;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: clubs.length,
      separatorBuilder: (_, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final club = clubs[index];
        final isJoined = _joinedClubIds.contains(club.id);

        BadgeTone tone;
        switch (club.category) {
          case 'Technical':
            tone = BadgeTone.brand;
            break;
          case 'Innovation':
            tone = BadgeTone.gold;
            break;
          default:
            tone = BadgeTone.teal;
        }

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppBadge(
                    label: club.category,
                    tone: tone,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.people_alt_outlined,
                          size: 14, color: AppColors.ink3),
                      const SizedBox(width: 4),
                      Text(
                        "${club.memberCount} Members",
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: AppColors.ink3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                club.name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                club.description,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.ink2,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule_rounded,
                        size: 14, color: AppColors.brand),
                    const SizedBox(width: 6),
                    Text(
                      "Next Meet: ${club.nextMeeting}",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: AppColors.ink,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          if (isJoined) {
                            _joinedClubIds.remove(club.id);
                          } else {
                            _joinedClubIds.add(club.id);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isJoined
                                  ? "Left ${club.name}"
                                  : "Joined ${club.name}!",
                            ),
                            backgroundColor:
                                isJoined ? AppColors.ink2 : AppColors.teal,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: Icon(
                        isJoined ? Icons.check : Icons.add_circle_outline,
                        size: 16,
                      ),
                      label: Text(isJoined ? "Member (Joined)" : "Join Club"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isJoined ? AppColors.tealSoft : AppColors.brand,
                        foregroundColor:
                            isJoined ? AppColors.teal : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSportsTab() {
    final sports = MockData.sports;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: sports.length,
      separatorBuilder: (_, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final sp = sports[index];

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppBadge(
                    label: sp.status,
                    tone: sp.status == "Trials open"
                        ? BadgeTone.teal
                        : BadgeTone.sky,
                  ),
                  const Spacer(),
                  Text(
                    sp.date,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color: AppColors.ink3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                sp.title,
                style: GoogleFonts.poppins(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 14, color: AppColors.ink3),
                  const SizedBox(width: 4),
                  Text(
                    sp.venue,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.ink2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "${sp.registeredCount} players currently registered",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: AppColors.ink3,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Registered for ${sp.title} selection trials!"),
                            backgroundColor: AppColors.teal,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(Icons.sports_basketball, size: 16),
                      label: const Text("Register for Trials"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
