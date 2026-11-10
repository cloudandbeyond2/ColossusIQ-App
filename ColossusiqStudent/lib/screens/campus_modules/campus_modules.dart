import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Campus Events Screen [P3] (Image 4)
/// ─────────────────────────────────────────────────────────────────────────────
class CampusEventsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CampusEventsScreen({super.key, this.onBack});

  @override
  State<CampusEventsScreen> createState() => _CampusEventsScreenState();
}

class _CampusEventsScreenState extends State<CampusEventsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = "All";

  void _showEventDetailsDialog(Map<String, dynamic> e) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.event_note_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e["title"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("${e["id"]} · ${e["type"]}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date & Venue", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text("${e["date"]} · ${e["venue"]}", style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(6)),
                        child: Text(e["status"] as String, style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF15803D))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.people_outline_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text("Capacity: ${e["capacity"]} attendees · Updated: ${e["updated"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Event Description & Schedule", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "All enrolled students and campus community members are invited. Please arrive 15 minutes before opening remarks.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditEventDialog(e);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Event"),
          ),
        ],
      ),
    );
  }

  void _showEditEventDialog(Map<String, dynamic> e) {
    _showCreateEventDialog(e);
  }

  void _showCreateEventDialog([Map<String, dynamic>? initialData]) {
    final isEdit = initialData != null;
    final titleCtrl = TextEditingController(text: initialData?["title"] as String? ?? "");
    final startDateCtrl = TextEditingController(
      text: initialData?["startDate"] as String? ?? (initialData?["date"] as String? ?? ""),
    );
    final endDateCtrl = TextEditingController(text: initialData?["endDate"] as String? ?? "");
    final timeCtrl = TextEditingController(text: initialData?["time"] as String? ?? "");
    final venueCtrl = TextEditingController(text: initialData?["venue"] as String? ?? "");
    final organizerCtrl = TextEditingController(
      text: initialData?["organizer"] as String? ?? "Department / Faculty",
    );
    final capacityCtrl = TextEditingController(
      text: initialData != null ? (initialData["capacity"]?.toString() ?? "0") : "0",
    );
    final descCtrl = TextEditingController(text: initialData?["description"] as String? ?? "");

    String selectedType = initialData?["type"] as String? ?? "Academic";
    String selectedStatus = initialData?["status"] as String? ?? "Upcoming";

    final typeOptions = const [
      "Academic",
      "Cultural",
      "Sports",
      "Workshop",
      "Seminar",
      "Technical",
      "Other",
    ];

    final statusOptions = const [
      "Upcoming",
      "Active",
      "Published",
      "Draft",
      "Completed",
      "Cancelled",
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          Future<void> pickDate(TextEditingController controller) async {
            final now = DateTime.now();
            final picked = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: DateTime(2025),
              lastDate: DateTime(2030),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF7E84EC),
                      onPrimary: Colors.white,
                      onSurface: Color(0xFF0F172A),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              setDialogState(() {
                controller.text =
                    "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
              });
            }
          }

          Future<void> pickTime(TextEditingController controller) async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFF7E84EC),
                      onPrimary: Colors.white,
                      onSurface: Color(0xFF0F172A),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
              final minute = picked.minute.toString().padLeft(2, '0');
              final period = picked.period == DayPeriod.am ? "AM" : "PM";
              setDialogState(() {
                controller.text = "${hour.toString().padLeft(2, '0')}:$minute $period";
              });
            }
          }

          Widget buildLabel(String label) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            );
          }

          Widget buildTextField({
            required TextEditingController controller,
            required String hintText,
            IconData? suffixIcon,
            VoidCallback? onSuffixTap,
            int minLines = 1,
            int maxLines = 1,
            TextInputType? keyboardType,
          }) {
            return TextField(
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                suffixIcon: suffixIcon != null
                    ? InkWell(
                        onTap: onSuffixTap,
                        borderRadius: BorderRadius.circular(8),
                        child: Icon(suffixIcon, size: 18, color: const Color(0xFF64748B)),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF7E84EC), width: 1.5),
                ),
              ),
            );
          }

          Widget buildDropdown({
            required String value,
            required List<String> items,
            required ValueChanged<String?> onChanged,
          }) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: items.contains(value) ? value : items.first,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF64748B)),
                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                  items: items.map((opt) {
                    return DropdownMenuItem<String>(
                      value: opt,
                      child: Text(opt, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            );
          }

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540, maxHeight: 720),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isEdit ? "Edit Event" : "Create Event",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),

                  // Scrollable Form
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Event Title *
                          buildLabel("Event Title *"),
                          buildTextField(
                            controller: titleCtrl,
                            hintText: "Annual Tech Symposium",
                          ),
                          const SizedBox(height: 16),

                          // Type & Status Row
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Type"),
                                        buildDropdown(
                                          value: selectedType,
                                          items: typeOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedType = val);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Status"),
                                        buildDropdown(
                                          value: selectedStatus,
                                          items: statusOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedStatus = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Type"),
                                        buildDropdown(
                                          value: selectedType,
                                          items: typeOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedType = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Status"),
                                        buildDropdown(
                                          value: selectedStatus,
                                          items: statusOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedStatus = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Start Date * & End Date Row
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Start Date *"),
                                        buildTextField(
                                          controller: startDateCtrl,
                                          hintText: "mm/dd/yyyy",
                                          suffixIcon: Icons.calendar_today_outlined,
                                          onSuffixTap: () => pickDate(startDateCtrl),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("End Date"),
                                        buildTextField(
                                          controller: endDateCtrl,
                                          hintText: "mm/dd/yyyy",
                                          suffixIcon: Icons.calendar_today_outlined,
                                          onSuffixTap: () => pickDate(endDateCtrl),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Start Date *"),
                                        buildTextField(
                                          controller: startDateCtrl,
                                          hintText: "mm/dd/yyyy",
                                          suffixIcon: Icons.calendar_today_outlined,
                                          onSuffixTap: () => pickDate(startDateCtrl),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("End Date"),
                                        buildTextField(
                                          controller: endDateCtrl,
                                          hintText: "mm/dd/yyyy",
                                          suffixIcon: Icons.calendar_today_outlined,
                                          onSuffixTap: () => pickDate(endDateCtrl),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Time & Venue Row
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Time"),
                                        buildTextField(
                                          controller: timeCtrl,
                                          hintText: "--:-- --",
                                          suffixIcon: Icons.access_time_rounded,
                                          onSuffixTap: () => pickTime(timeCtrl),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Venue"),
                                        buildTextField(
                                          controller: venueCtrl,
                                          hintText: "Auditorium, Hall A...",
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Time"),
                                        buildTextField(
                                          controller: timeCtrl,
                                          hintText: "--:-- --",
                                          suffixIcon: Icons.access_time_rounded,
                                          onSuffixTap: () => pickTime(timeCtrl),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Venue"),
                                        buildTextField(
                                          controller: venueCtrl,
                                          hintText: "Auditorium, Hall A...",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Organizer & Capacity Row
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Organizer"),
                                        buildTextField(
                                          controller: organizerCtrl,
                                          hintText: "Department / Faculty",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Capacity"),
                                        buildTextField(
                                          controller: capacityCtrl,
                                          hintText: "0",
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Organizer"),
                                        buildTextField(
                                          controller: organizerCtrl,
                                          hintText: "Department / Faculty",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("Capacity"),
                                        buildTextField(
                                          controller: capacityCtrl,
                                          hintText: "0",
                                          keyboardType: TextInputType.number,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Description
                          buildLabel("Description"),
                          buildTextField(
                            controller: descCtrl,
                            hintText: "Brief event description...",
                            minLines: 3,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Actions Footer
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF334155),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7E84EC),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            final title = titleCtrl.text.trim();
                            final startDate = startDateCtrl.text.trim();

                            if (title.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter the Event Title."),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }
                            if (startDate.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please specify a Start Date."),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              Color typeColor;
                              Color typeBg;
                              switch (selectedType) {
                                case "Cultural":
                                  typeColor = const Color(0xFF4F46E5);
                                  typeBg = const Color(0xFFEEF2FF);
                                  break;
                                case "Workshop":
                                  typeColor = const Color(0xFF7C3AED);
                                  typeBg = const Color(0xFFF5F3FF);
                                  break;
                                case "Sports":
                                  typeColor = const Color(0xFFEA580C);
                                  typeBg = const Color(0xFFFFF7ED);
                                  break;
                                case "Seminar":
                                  typeColor = const Color(0xFF0D9488);
                                  typeBg = const Color(0xFFCCFBF1);
                                  break;
                                case "Technical":
                                  typeColor = const Color(0xFF0284C7);
                                  typeBg = const Color(0xFFE0F2FE);
                                  break;
                                case "Academic":
                                default:
                                  typeColor = const Color(0xFF2563EB);
                                  typeBg = const Color(0xFFEFF6FF);
                                  break;
                              }

                              if (isEdit) {
                                initialData["title"] = title;
                                initialData["type"] = selectedType;
                                initialData["typeColor"] = typeColor;
                                initialData["typeBg"] = typeBg;
                                initialData["status"] = selectedStatus;
                                initialData["date"] = startDate;
                                initialData["startDate"] = startDate;
                                initialData["endDate"] = endDateCtrl.text.trim();
                                initialData["time"] = timeCtrl.text.trim();
                                initialData["venue"] = venueCtrl.text.trim().isEmpty ? "Campus Hall" : venueCtrl.text.trim();
                                initialData["capacity"] = capacityCtrl.text.trim().isEmpty ? "100" : capacityCtrl.text.trim();
                                initialData["organizer"] = organizerCtrl.text.trim();
                                initialData["description"] = descCtrl.text.trim();
                                initialData["updated"] = "Today";
                              } else {
                                final newEvent = {
                                  "id": "EVT-${1064 + _events.length}",
                                  "title": title,
                                  "type": selectedType,
                                  "typeColor": typeColor,
                                  "typeBg": typeBg,
                                  "status": selectedStatus,
                                  "date": startDate,
                                  "startDate": startDate,
                                  "endDate": endDateCtrl.text.trim(),
                                  "time": timeCtrl.text.trim(),
                                  "venue": venueCtrl.text.trim().isEmpty ? "Auditorium, Hall A" : venueCtrl.text.trim(),
                                  "capacity": capacityCtrl.text.trim().isEmpty ? "100" : capacityCtrl.text.trim(),
                                  "organizer": organizerCtrl.text.trim().isEmpty ? "Department / Faculty" : organizerCtrl.text.trim(),
                                  "description": descCtrl.text.trim(),
                                  "updated": "Today",
                                };
                                _events.insert(0, newEvent);
                              }
                            });

                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isEdit
                                      ? "Event '$title' updated successfully!"
                                      : "Event '$title' created successfully!",
                                ),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            isEdit ? "Save Changes" : "Create Event",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final List<Map<String, dynamic>> _events = [
    {
      "id": "EVT-1063",
      "title": "Sports day",
      "type": "Cultural",
      "typeColor": Color(0xFF4F46E5),
      "typeBg": Color(0xFFEEF2FF),
      "date": "7 Oct 2026",
      "venue": "Big Ground",
      "capacity": "250",
      "status": "Published",
      "updated": "6 Oct 2026",
    },
    {
      "id": "EVT-1057",
      "title": "Annuval Day",
      "type": "Workshop",
      "typeColor": Color(0xFF475569),
      "typeBg": Color(0xFFF1F5F9),
      "date": "15 Oct 2026",
      "venue": "Auditorium",
      "capacity": "250",
      "status": "Published",
      "updated": "6 Oct 2026",
    },
    {
      "id": "EVT-1021",
      "title": "Full Stack Web Development Workshop",
      "type": "Workshop",
      "typeColor": Color(0xFF475569),
      "typeBg": Color(0xFFF1F5F9),
      "date": "10 Oct 2026",
      "venue": "Computer Lab, College Campus",
      "capacity": "100",
      "status": "Published",
      "updated": "3 Oct 2026",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredEvents = _events.where((e) {
      final matchesSearch = query.isEmpty ||
          e["title"].toLowerCase().contains(query) ||
          e["id"].toLowerCase().contains(query) ||
          e["type"].toLowerCase().contains(query);
      final matchesTab = _selectedTab == "All" || e["status"] == _selectedTab;
      return matchesSearch && matchesTab;
    }).toList();

    return PortalPageBody(
      title: "Campus Events",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner with Create Event action
        BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Campus Events",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.celebration_rounded,
          title: "Campus Events",
          subtitle: "College and department events, seminars, workshops, cultural and alumni events.",
          watermarkIcon: Icons.celebration_rounded,
          action: ElevatedButton.icon(
            onPressed: () => _showCreateEventDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E1B4B),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.add, size: 16, color: Color(0xFF1E1B4B)),
            label: Text(
              "Create Event",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1B4B),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // 2. Status summary tabs (Dynamic counts)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _statusTab("All", _events.length),
              const SizedBox(width: 8),
              _statusTab("Draft", _events.where((e) => e["status"] == "Draft").length),
              const SizedBox(width: 8),
              _statusTab("Published", _events.where((e) => e["status"] == "Published").length),
              const SizedBox(width: 8),
              _statusTab("Completed", _events.where((e) => e["status"] == "Completed").length),
              const SizedBox(width: 8),
              _statusTab("Cancelled", _events.where((e) => e["status"] == "Cancelled").length),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. Records Card with Search, Table & Pagination
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Header inside card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (_) => setState(() {}),
                                style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                decoration: InputDecoration(
                                  hintText: "Search by name, ID or type...",
                                  hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              GestureDetector(
                                onTap: () => setState(() => _searchController.clear()),
                                child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${filteredEvents.length} records",
                        style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w600, color: const Color(0xFF475569)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _showCreateEventDialog(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7E84EC),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.add, size: 16),
                      label: Text(
                        "Create Event",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Responsive Table
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 680) {
                    return _buildEventsMobileList(filteredEvents);
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 880),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    horizontalMargin: 20,
                    columnSpacing: 26,
                    columns: const [
                      DataColumn(label: SizedBox(width: 85, child: Text("ID"))),
                      DataColumn(label: Text("EVENT TITLE")),
                      DataColumn(label: Text("TYPE")),
                      DataColumn(label: Text("DATE")),
                      DataColumn(label: Text("VENUE")),
                      DataColumn(label: Text("CAPACITY")),
                      DataColumn(label: Text("STATUS")),
                      DataColumn(label: Text("UPDATED")),
                      DataColumn(label: Text("ACTIONS")),
                    ],
                    rows: filteredEvents.map((e) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              e["id"],
                              style: GoogleFonts.sourceCodePro(
                                fontSize: 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["title"],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: e["typeBg"],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                e["type"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: e["typeColor"],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["date"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["venue"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["capacity"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                e["status"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF059669),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              e["updated"],
                              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF0F766E)),
                                  onPressed: () => _showEventDetailsDialog(e),
                                  tooltip: "View details",
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF4338CA)),
                                  onPressed: () => _showEditEventDialog(e),
                                  tooltip: "Edit event",
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
                },
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Pagination Footer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Page 1 of 1",
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.chevron_left, size: 16, color: Color(0xFF94A3B8)),
                              Text("Prev", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              Text("Next", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))),
                              const Icon(Icons.chevron_right, size: 16, color: Color(0xFF94A3B8)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventsMobileList(List<Map<String, dynamic>> events) {
    if (events.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            "No events found",
            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
          ),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE5E7EB)),
      itemBuilder: (context, index) {
        final e = events[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e["id"],
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: e["typeBg"],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e["type"],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: e["typeColor"],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      e["status"],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                e["title"],
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Text(
                    e["date"],
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.place_outlined, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      e["venue"],
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 13, color: Color(0xFF94A3B8)),
                      const SizedBox(width: 4),
                      Text(
                        "Cap: ${e["capacity"]}",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Upd: ${e["updated"]}",
                        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => _showEventDetailsDialog(e),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            "View",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F766E),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _showEditEventDialog(e),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4338CA),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusTab(String label, int count) {
    final isSelected = _selectedTab == label;
    return InkWell(
      onTap: () => setState(() => _selectedTab = label),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Clubs Screen [P3] (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class ClubsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ClubsScreen({super.key, this.onBack});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  void _showClubDetailsDialog(Map<String, dynamic> club) {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          final isMember = club["isMember"] == true;
          final category = club["category"] as String? ?? "Technical";
          final status = club["status"] as String? ?? "Active";
          final membersCount = int.tryParse(club["members"]?.toString() ?? "1") ?? 1;

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Tags & Close Button
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: club["categoryBg"] as Color? ?? const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: club["categoryColor"] as Color? ?? const Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF15803D),
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Club Title
                    Text(
                      club["name"] as String? ?? "Club Name",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Club Description
                    Text(
                      club["description"] as String? ??
                          "To encourage students to explore technology, creative thinking, and collaborative project development. Open to all students.",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF475569),
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 2x2 Info Grid Card (Matching Image 1)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBFBF9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF1F0E8)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Student Lead",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.person_outline, size: 16, color: Color(0xFF475569)),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            club["lead"] as String? ?? "bala",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Faculty Advisor",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.auto_awesome, size: 15, color: Color(0xFFD97706)),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            club["advisor"] as String? ?? "Dr. Lakshmi Sundaram",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Current Members",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.people_outline, size: 16, color: Color(0xFF059669)),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            "$membersCount students",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Meeting Venue",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 1),
                                          child: Icon(Icons.location_on_outlined, size: 16, color: Color(0xFFDC2626)),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            club["venue"] as String? ?? "Computer Science Lab – Block B",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF0F172A),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Next Activity / Schedule Card (Matching Image 1)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time_rounded, size: 16, color: Color(0xFF475569)),
                              const SizedBox(width: 8),
                              Text(
                                "NEXT ACTIVITY / SCHEDULE",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => _showChangeScheduleDialog(club),
                                child: Text(
                                  "Change",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E1B4B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            club["activity"] as String? ?? "Every Saturday – 10:00 AM",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 16),

                    // Footer Action: Leave Club / Join Club
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isMember ? const Color(0xFF0F172A) : Colors.white,
                          backgroundColor: isMember ? Colors.white : const Color(0xFF1E1B4B),
                          side: BorderSide(color: isMember ? const Color(0xFFCBD5E1) : const Color(0xFF1E1B4B)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            if (isMember) {
                              club["isMember"] = false;
                              final c = int.tryParse(club["members"]?.toString() ?? "1") ?? 1;
                              club["members"] = (c > 0 ? c - 1 : 0).toString();
                            } else {
                              club["isMember"] = true;
                              final c = int.tryParse(club["members"]?.toString() ?? "0") ?? 0;
                              club["members"] = (c + 1).toString();
                            }
                          });
                          Navigator.of(ctx).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isMember ? "You have left ${club["name"]}." : "You joined ${club["name"]}!",
                              ),
                              backgroundColor: isMember ? const Color(0xFF475569) : const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: Text(
                          isMember ? "Leave Club" : "Join Club",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChangeScheduleDialog(Map<String, dynamic> club, {bool fromDetails = true}) {
    final scheduleCtrl = TextEditingController(text: club["activity"] as String? ?? "Every Saturday – 10:00 AM");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Update Meeting Schedule",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: TextField(
          controller: scheduleCtrl,
          decoration: const InputDecoration(
            labelText: "Next Activity / Schedule",
            hintText: "e.g. Every Saturday – 10:00 AM",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1B4B),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final newSched = scheduleCtrl.text.trim();
              if (newSched.isNotEmpty) {
                setState(() {
                  club["activity"] = newSched;
                });
              }
              Navigator.pop(ctx);
              if (fromDetails) {
                Navigator.pop(context); // close parent dialog to refresh
                _showClubDetailsDialog(club);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Club meeting schedule updated!"),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showEditClubMembershipDialog(Map<String, dynamic> club) {
    _showChangeScheduleDialog(club, fromDetails: false);
  }

  /// Start a Campus Club Dialog (Matching Image 2)
  void _showStartClubDialog() {
    final nameCtrl = TextEditingController();
    final scheduleCtrl = TextEditingController(text: "Every Saturday – 10:00 AM");
    final venueCtrl = TextEditingController(text: "Computer Science Lab – Block B");
    final missionCtrl = TextEditingController();

    String selectedCategory = "Technical";
    String selectedLead = "bala";
    String selectedAdvisor = "Dr. Lakshmi Sundaram";

    final categoryOptions = const [
      "Technical",
      "Cultural",
      "Social",
      "Innovation",
      "Sports",
      "Literary",
    ];

    final leadOptions = const [
      "bala",
      "Arjun Varma",
      "Meera Nair",
      "Harish Patel",
      "Anand Kumar",
    ];

    final advisorOptions = const [
      "Dr. Lakshmi Sundaram",
      "Dr. K. Saravanan",
      "Dr. P. Ramanathan",
      "Dr. S. Meenakshi",
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          Widget buildLabel(String text) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF475569),
                  letterSpacing: 0.5,
                ),
              ),
            );
          }

          Widget buildTextField({
            required TextEditingController controller,
            required String hintText,
            int minLines = 1,
            int maxLines = 1,
          }) {
            return TextField(
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF312E81), width: 1.5),
                ),
              ),
            );
          }

          Widget buildDropdown({
            required String value,
            required List<String> items,
            required ValueChanged<String?> onChanged,
          }) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: items.contains(value) ? value : items.first,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF64748B)),
                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                  items: items.map((opt) {
                    return DropdownMenuItem<String>(
                      value: opt,
                      child: Text(opt, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            );
          }

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520, maxHeight: 720),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start a Campus Club",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Register a new student club with activities and faculty guidance.",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),

                  // Scrollable Form
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Club Name *
                          buildLabel("CLUB NAME *"),
                          buildTextField(
                            controller: nameCtrl,
                            hintText: "e.g. AI Builders Club, Fine Arts Society",
                          ),
                          const SizedBox(height: 16),

                          // Category *
                          buildLabel("CATEGORY *"),
                          buildDropdown(
                            value: selectedCategory,
                            items: categoryOptions,
                            onChanged: (val) {
                              if (val != null) setDialogState(() => selectedCategory = val);
                            },
                          ),
                          const SizedBox(height: 16),

                          // Student Lead * & Faculty Advisor Row
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("STUDENT LEAD *"),
                                        buildDropdown(
                                          value: selectedLead,
                                          items: leadOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedLead = val);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("FACULTY ADVISOR"),
                                        buildDropdown(
                                          value: selectedAdvisor,
                                          items: advisorOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedAdvisor = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("STUDENT LEAD *"),
                                        buildDropdown(
                                          value: selectedLead,
                                          items: leadOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedLead = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("FACULTY ADVISOR"),
                                        buildDropdown(
                                          value: selectedAdvisor,
                                          items: advisorOptions,
                                          onChanged: (val) {
                                            if (val != null) setDialogState(() => selectedAdvisor = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Meeting Schedule * & Meeting Venue Row
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("MEETING SCHEDULE *"),
                                        buildTextField(
                                          controller: scheduleCtrl,
                                          hintText: "e.g. Weekly contest — Sat",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("MEETING VENUE"),
                                        buildTextField(
                                          controller: venueCtrl,
                                          hintText: "e.g. CSE Lab 2 / Block B",
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("MEETING SCHEDULE *"),
                                        buildTextField(
                                          controller: scheduleCtrl,
                                          hintText: "e.g. Weekly contest — Sat",
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildLabel("MEETING VENUE"),
                                        buildTextField(
                                          controller: venueCtrl,
                                          hintText: "e.g. CSE Lab 2 / Block B",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Club Mission / About
                          buildLabel("CLUB MISSION / ABOUT"),
                          buildTextField(
                            controller: missionCtrl,
                            hintText: "What does this club do? Who should join?",
                            minLines: 3,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Actions Footer
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E293B),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E2C9B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            final name = nameCtrl.text.trim();
                            final schedule = scheduleCtrl.text.trim();

                            if (name.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter the Club Name."),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }
                            if (schedule.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please provide a Meeting Schedule."),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }

                            Color catColor;
                            Color catBg;
                            switch (selectedCategory) {
                              case "Cultural":
                                catColor = const Color(0xFF059669);
                                catBg = const Color(0xFFECFDF5);
                                break;
                              case "Social":
                                catColor = const Color(0xFF2563EB);
                                catBg = const Color(0xFFEFF6FF);
                                break;
                              case "Innovation":
                                catColor = const Color(0xFFD97706);
                                catBg = const Color(0xFFFFFBEB);
                                break;
                              case "Sports":
                                catColor = const Color(0xFFEA580C);
                                catBg = const Color(0xFFFFF7ED);
                                break;
                              case "Technical":
                              default:
                                catColor = const Color(0xFF4F46E5);
                                catBg = const Color(0xFFEEF2FF);
                                break;
                            }

                            final newClub = {
                              "name": name,
                              "category": selectedCategory,
                              "categoryColor": catColor,
                              "categoryBg": catBg,
                              "members": "1",
                              "lead": selectedLead,
                              "advisor": selectedAdvisor,
                              "venue": venueCtrl.text.trim().isEmpty ? "Campus Lab / Block B" : venueCtrl.text.trim(),
                              "activity": schedule,
                              "description": missionCtrl.text.trim().isEmpty
                                  ? "A student club focused on $selectedCategory excellence, practical learning, and campus collaborative initiatives."
                                  : missionCtrl.text.trim(),
                              "isMember": true,
                              "status": "Active",
                            };

                            setState(() {
                              _clubs.insert(0, newClub);
                            });

                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Club \"$name\" registered successfully!"),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            "Create Club",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final List<Map<String, dynamic>> _clubs = [
    {
      "name": "AI & Innovation Club",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "1",
      "lead": "bala",
      "advisor": "Dr. Lakshmi Sundaram",
      "venue": "Computer Science Lab – Block B",
      "activity": "Every Saturday – 10:00 AM",
      "description":
          "To encourage students to explore Artificial Intelligence, Machine Learning, Web Development, Flutter, and emerging technologies through workshops, coding competitions, project development, and collaborative learning. Open to all interested students.",
      "isMember": true,
      "status": "Active",
    },
    {
      "name": "Coding Club",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "40",
      "lead": "Arjun Varma",
      "advisor": "Dr. Lakshmi Sundaram",
      "venue": "Lab 3 – Tech Block",
      "activity": "Weekly contest — Sat",
      "description": "Weekly algorithm competitions, open source development, and code reviews.",
      "isMember": false,
      "status": "Active",
    },
    {
      "name": "Robotics Society",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "77",
      "lead": "Meera Nair",
      "advisor": "Dr. K. Saravanan",
      "venue": "Robotics Workshop, Ground Floor",
      "activity": "Weekly contest — Sat",
      "description": "Designing autonomous robots, drone prototypes, and embedded IoT systems.",
      "isMember": false,
      "status": "Active",
    },
    {
      "name": "AI & Data Science Circle",
      "category": "Technical",
      "categoryColor": Color(0xFF4F46E5),
      "categoryBg": Color(0xFFEEF2FF),
      "members": "114",
      "lead": "Harish Patel",
      "advisor": "Dr. P. Ramanathan",
      "venue": "Data Lab 2",
      "activity": "Weekly contest — Sat",
      "description": "Deep learning models, Kaggle competitions, and NLP/CV research sprints.",
      "isMember": false,
      "status": "Active",
    },
    {
      "name": "Tamil Mandram",
      "category": "Cultural",
      "categoryColor": Color(0xFF059669),
      "categoryBg": Color(0xFFECFDF5),
      "members": "151",
      "lead": "Kavya Gupta",
      "advisor": "Dr. S. Meenakshi",
      "venue": "Central Auditorium",
      "activity": "Weekly contest — Sat",
      "description": "Literature, debate, poetry, and cultural celebration of Tamil language and heritage.",
      "isMember": false,
      "status": "Active",
    },
    {
      "name": "Music Club",
      "category": "Cultural",
      "categoryColor": Color(0xFF059669),
      "categoryBg": Color(0xFFECFDF5),
      "members": "188",
      "lead": "Nikhil Sharma",
      "advisor": "Dr. S. Meenakshi",
      "venue": "Amphitheater",
      "activity": "Weekly contest — Sat",
      "description": "Vocalists, instrumentalists, and sound designers creating campus concerts and band shows.",
      "isMember": false,
      "status": "Active",
    },
    {
      "name": "NSS Unit",
      "category": "Social",
      "categoryColor": Color(0xFF2563EB),
      "categoryBg": Color(0xFFEFF6FF),
      "members": "65",
      "lead": "Pooja Das",
      "advisor": "Dr. K. Saravanan",
      "venue": "Main Quadrangle",
      "activity": "Weekly contest — Sat",
      "description": "Community outreach, cleanliness drives, green energy programs, and blood donation camps.",
      "isMember": false,
      "status": "Active",
    },
    {
      "name": "Entrepreneurship Cell",
      "category": "Innovation",
      "categoryColor": Color(0xFFD97706),
      "categoryBg": Color(0xFFFFFBEB),
      "members": "102",
      "lead": "Sanjay Balaji",
      "advisor": "Dr. Lakshmi Sundaram",
      "venue": "Incubation Center Room 102",
      "activity": "Weekly contest — Sat",
      "description": "Pitch events, VC office hours, startup incubator accelerators, and business plan bootcamps.",
      "isMember": false,
      "status": "Active",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredClubs = _clubs.where((c) {
      final matchesSearch = query.isEmpty ||
          c["name"].toLowerCase().contains(query) ||
          c["lead"].toLowerCase().contains(query) ||
          c["category"].toLowerCase().contains(query);
      final matchesFilter = _filter == "All" || c["category"] == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return PortalPageBody(
      title: "Clubs",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner with Start a Club action
        BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Clubs",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.flag_outlined,
          title: "Clubs",
          subtitle: "Technical, cultural and social clubs, membership and activities.",
          watermarkIcon: Icons.flag_outlined,
          action: ElevatedButton.icon(
            onPressed: _showStartClubDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E3A8A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(
              "Start a Club",
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // 2. 4 Stat Summary Cards Row
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 850) {
              return Row(
                children: [
                  Expanded(child: _statCard("TOTAL CLUBS", "8", "Active campus organizations", Icons.flag_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("TOTAL MEMBERS", "795", "Students actively participating", Icons.people_outline, const Color(0xFFECFDF5), const Color(0xFF059669))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("ACTIVE CATEGORIES", "4", "Technical, cultural & social", Icons.filter_alt_outlined, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("UPCOMING ACTIVITIES", "8", "Events & meetups scheduled", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                ],
              );
            } else if (w > 500) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _statCard("TOTAL CLUBS", "8", "Active campus organizations", Icons.flag_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("TOTAL MEMBERS", "795", "Students actively participating", Icons.people_outline, const Color(0xFFECFDF5), const Color(0xFF059669))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _statCard("ACTIVE CATEGORIES", "4", "Technical, cultural & social", Icons.filter_alt_outlined, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("UPCOMING ACTIVITIES", "8", "Events & meetups scheduled", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _statCard("TOTAL CLUBS", "8", "Active campus organizations", Icons.flag_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  const SizedBox(height: 12),
                  _statCard("TOTAL MEMBERS", "795", "Students actively participating", Icons.people_outline, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  const SizedBox(height: 12),
                  _statCard("ACTIVE CATEGORIES", "4", "Technical, cultural & social", Icons.filter_alt_outlined, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  const SizedBox(height: 12),
                  _statCard("UPCOMING ACTIVITIES", "8", "Events & meetups scheduled", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Clubs Table Container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search & Filter Header (Responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 640;
                  if (isNarrow) {
                    return Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (_) => setState(() {}),
                                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                    decoration: InputDecoration(
                                      hintText: "Search clubs...",
                                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                if (_searchController.text.isNotEmpty)
                                  GestureDetector(
                                    onTap: () => setState(() => _searchController.clear()),
                                    child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
                                    const SizedBox(width: 6),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _filter,
                                        isDense: true,
                                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                                        items: const [
                                          DropdownMenuItem(value: "All", child: Text("All")),
                                          DropdownMenuItem(value: "Technical", child: Text("Technical")),
                                          DropdownMenuItem(value: "Cultural", child: Text("Cultural")),
                                          DropdownMenuItem(value: "Social", child: Text("Social")),
                                          DropdownMenuItem(value: "Innovation", child: Text("Innovation")),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _filter = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: _showStartClubDialog,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "+ Start a club",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 20, color: Color(0xFF64748B)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              hintText: "Search clubs...",
                              hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const Icon(Icons.filter_list_rounded, size: 18, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _filter,
                            isDense: true,
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                            items: const [
                              DropdownMenuItem(value: "All", child: Text("All")),
                              DropdownMenuItem(value: "Technical", child: Text("Technical")),
                              DropdownMenuItem(value: "Cultural", child: Text("Cultural")),
                              DropdownMenuItem(value: "Social", child: Text("Social")),
                              DropdownMenuItem(value: "Innovation", child: Text("Innovation")),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _filter = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        ElevatedButton(
                          onPressed: _showStartClubDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: Text(
                            "+ Start a club",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Responsive Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 780),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    horizontalMargin: 20,
                    columnSpacing: 32,
                    columns: const [
                      DataColumn(label: Text("CLUB")),
                      DataColumn(label: Text("CATEGORY")),
                      DataColumn(label: Text("MEMBERS")),
                      DataColumn(label: Text("STUDENT LEAD")),
                      DataColumn(label: Text("NEXT ACTIVITY")),
                      DataColumn(label: Text("ACTION")),
                    ],
                    rows: filteredClubs.map((club) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              club["name"],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: club["categoryBg"],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                club["category"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: club["categoryColor"],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              club["members"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              club["lead"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              club["activity"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => _showClubDetailsDialog(club),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "View",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F766E),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _showEditClubMembershipDialog(club),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4338CA),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(String label, String value, String sub, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}


/// ─────────────────────────────────────────────────────────────────────────────
/// Sports Screen [P3] (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class SportsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const SportsScreen({super.key, this.onBack});

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = "All";

  void _showSportDetailsDialog(Map<String, dynamic> sport) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.sports_soccer_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sport["sport"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text(sport["team"] as String, style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Head Coach", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(sport["coach"] as String, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: sport["statusBg"] as Color? ?? const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          sport["status"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: sport["statusColor"] as Color? ?? const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text("Schedule: ${sport["upcoming"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155), fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Varsity Team Overview", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "Varsity athletic squad competing in inter-collegiate zonal championships, state tournaments, and annual intramural leagues.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditSportTrialDialog(sport);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: const Text("Edit Registration"),
          ),
        ],
      ),
    );
  }

  void _showEditSportTrialDialog(Map<String, dynamic> sport) {
    final positionCtrl = TextEditingController(text: "Forward / Midfielder");
    final jerseyCtrl = TextEditingController(text: "10");
    final experienceCtrl = TextEditingController(text: "3 years school & club level competition experience.");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Sports Trial Entry", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: positionCtrl,
                  decoration: const InputDecoration(labelText: "Playing Position", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: jerseyCtrl,
                  decoration: const InputDecoration(labelText: "Preferred Jersey No.", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: experienceCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Previous Sports Experience", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Trial registration for '${sport["sport"]}' saved!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF141938), foregroundColor: Colors.white),
            child: Text("Save Entry", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  /// Register for Sports Trials Dialog (Matching Image 1)
  void _showRegisterSportsTrialsDialog([String? defaultSport]) {
    final positionCtrl = TextEditingController();
    final experienceCtrl = TextEditingController();

    final sportOptions = const [
      "Badminton (Men & Women)",
      "Cricket (Men)",
      "Football / Soccer",
      "Basketball (Men & Women)",
      "Athletics / Track & Field",
      "Table Tennis",
      "Volleyball",
      "Chess",
    ];

    String selectedSport = (defaultSport != null && sportOptions.contains(defaultSport))
        ? defaultSport
        : sportOptions.first;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Register for Sports Trials",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "Select an active campus sport to register for upcoming team selection trials.",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // CHOOSE SPORT *
                    Text(
                      "CHOOSE SPORT *",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF475569),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedSport,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                          items: sportOptions.map((s) {
                            return DropdownMenuItem<String>(
                              value: s,
                              child: Text(s, overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setDialogState(() => selectedSport = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // PLAYING POSITION / EVENT
                    Text(
                      "PLAYING POSITION / EVENT",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF475569),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: positionCtrl,
                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        hintText: "e.g. Forward, Opening Batsman, 100m Sprint, Point Guard",
                        hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF2E2C9B), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // PAST EXPERIENCE
                    Text(
                      "PAST EXPERIENCE",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF475569),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: experienceCtrl,
                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        hintText: "e.g. School team captain, District level participant",
                        hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF2E2C9B), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Actions Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E293B),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E2C9B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Registered for $selectedSport selection trials!"),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            "Submit Registration",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  final List<Map<String, dynamic>> _sports = [
    {
      "sport": "Cricket",
      "team": "AIT Titans",
      "coach": "Coach Sanjay",
      "upcoming": "Zonal meet · Oct 10",
      "status": "Trials open",
      "statusBg": Color(0xFFECFDF5),
      "statusColor": Color(0xFF059669),
    },
    {
      "sport": "Football",
      "team": "AIT Strikers",
      "coach": "Coach Lakshmi",
      "upcoming": "Zonal meet · Oct 12",
      "status": "Active",
      "statusBg": Color(0xFFEFF6FF),
      "statusColor": Color(0xFF2563EB),
    },
    {
      "sport": "Basketball",
      "team": "Hoopers",
      "coach": "Coach Rohan",
      "upcoming": "Zonal meet · Oct 14",
      "status": "Active",
      "statusBg": Color(0xFFEFF6FF),
      "statusColor": Color(0xFF2563EB),
    },
    {
      "sport": "Volleyball",
      "team": "Spikers",
      "coach": "Coach Nandini",
      "upcoming": "Zonal meet · Oct 16",
      "status": "Trials open",
      "statusBg": Color(0xFFECFDF5),
      "statusColor": Color(0xFF059669),
    },
    {
      "sport": "Athletics",
      "team": "Track squad",
      "coach": "Coach Suresh",
      "upcoming": "Zonal meet · Oct 18",
      "status": "Active",
      "statusBg": Color(0xFFEFF6FF),
      "statusColor": Color(0xFF2563EB),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredSports = _sports.where((s) {
      final matchesSearch = query.isEmpty ||
          s["sport"].toLowerCase().contains(query) ||
          s["team"].toLowerCase().contains(query) ||
          s["coach"].toLowerCase().contains(query);
      final matchesFilter = _filter == "All" || s["status"] == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return PortalPageBody(
      title: "Sports",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner with Register action
        BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Sports",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.sports_soccer_outlined,
          title: "Sports",
          subtitle: "Teams, tournaments, registrations and achievements.",
          watermarkIcon: Icons.sports_soccer_outlined,
          action: ElevatedButton.icon(
            onPressed: () => _showRegisterSportsTrialsDialog(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E3A8A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(
              "Register for Trials",
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // 2. 4 Stat Summary Cards Row
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 850) {
              return Row(
                children: [
                  Expanded(child: _statCard("TOTAL TEAMS", "7", "Competitive collegiate squads", Icons.emoji_events_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("TOTAL ATHLETES", "113", "Active players on team rosters", Icons.groups_outlined, const Color(0xFFECFDF5), const Color(0xFF059669))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("OPEN TRIALS", "3", "Sports actively recruiting", Icons.auto_awesome, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                  const SizedBox(width: 14),
                  Expanded(child: _statCard("UPCOMING MEETS", "7", "Zonal & university tournaments", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                ],
              );
            } else if (w > 500) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _statCard("TOTAL TEAMS", "7", "Competitive collegiate squads", Icons.emoji_events_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("TOTAL ATHLETES", "113", "Active players on team rosters", Icons.groups_outlined, const Color(0xFFECFDF5), const Color(0xFF059669))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _statCard("OPEN TRIALS", "3", "Sports actively recruiting", Icons.auto_awesome, const Color(0xFFFEF3C7), const Color(0xFFD97706))),
                      const SizedBox(width: 14),
                      Expanded(child: _statCard("UPCOMING MEETS", "7", "Zonal & university tournaments", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _statCard("TOTAL TEAMS", "7", "Competitive collegiate squads", Icons.emoji_events_outlined, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  const SizedBox(height: 12),
                  _statCard("TOTAL ATHLETES", "113", "Active players on team rosters", Icons.groups_outlined, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  const SizedBox(height: 12),
                  _statCard("OPEN TRIALS", "3", "Sports actively recruiting", Icons.auto_awesome, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  const SizedBox(height: 12),
                  _statCard("UPCOMING MEETS", "7", "Zonal & university tournaments", Icons.calendar_today_outlined, const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Sports Table Container
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search & Filter Header (Responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 640;
                  if (isNarrow) {
                    return Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    onChanged: (_) => setState(() {}),
                                    style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                                    decoration: InputDecoration(
                                      hintText: "Search sports...",
                                      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                if (_searchController.text.isNotEmpty)
                                  GestureDetector(
                                    onTap: () => setState(() => _searchController.clear()),
                                    child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
                                    const SizedBox(width: 6),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _filter,
                                        isDense: true,
                                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B)),
                                        items: const [
                                          DropdownMenuItem(value: "All", child: Text("All")),
                                          DropdownMenuItem(value: "Trials open", child: Text("Trials open")),
                                          DropdownMenuItem(value: "Active", child: Text("Active")),
                                        ],
                                        onChanged: (val) {
                                          if (val != null) setState(() => _filter = val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () => _showRegisterSportsTrialsDialog(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "+ Register",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 20, color: Color(0xFF64748B)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                            decoration: InputDecoration(
                              hintText: "Search sports...",
                              hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const Icon(Icons.filter_list_rounded, size: 18, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _filter,
                            isDense: true,
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                            items: const [
                              DropdownMenuItem(value: "All", child: Text("All")),
                              DropdownMenuItem(value: "Trials open", child: Text("Trials open")),
                              DropdownMenuItem(value: "Active", child: Text("Active")),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => _filter = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        ElevatedButton(
                          onPressed: () => _showRegisterSportsTrialsDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: Text(
                            "+ Register",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Responsive Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 780),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                    headingTextStyle: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                    dataRowMinHeight: 52,
                    dataRowMaxHeight: 52,
                    horizontalMargin: 20,
                    columnSpacing: 32,
                    columns: const [
                      DataColumn(label: Text("SPORT")),
                      DataColumn(label: Text("TEAM")),
                      DataColumn(label: Text("COACH")),
                      DataColumn(label: Text("UPCOMING")),
                      DataColumn(label: Text("STATUS")),
                      DataColumn(label: Text("ACTION")),
                    ],
                    rows: filteredSports.map((sport) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              sport["sport"],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              sport["team"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              sport["coach"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                            ),
                          ),
                          DataCell(
                            Text(
                              sport["upcoming"],
                              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: sport["statusBg"],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                sport["status"],
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: sport["statusColor"],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () => _showSportDetailsDialog(sport),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "View",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF0F766E),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _showEditSportTrialDialog(sport),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF4338CA),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Pagination Footer (Matching screenshot)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 620;
                    final infoSection = Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 14,
                      runSpacing: 8,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                            children: const [
                              TextSpan(text: "Showing "),
                              TextSpan(text: "1 to 5", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                              TextSpan(text: " of "),
                              TextSpan(text: "7", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                              TextSpan(text: " sports teams"),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Per page:", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("5 ▾", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF1E293B))),
                            ),
                          ],
                        ),
                      ],
                    );

                    final controlsSection = SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Page 1 of 2", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B))),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: null,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.chevron_left, size: 15, color: Color(0xFF94A3B8)),
                                Text("Prev", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8))),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("1", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: Colors.white)),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("2", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
                          ),
                          const SizedBox(width: 6),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              children: [
                                Text("Next", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF334155))),
                                const Icon(Icons.chevron_right, size: 15, color: Color(0xFF334155)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                    if (isNarrow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoSection,
                          const SizedBox(height: 12),
                          controlsSection,
                        ],
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        infoSection,
                        controlsSection,
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(String label, String value, String sub, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Experience Passport Screen [P3] (Images 2, 3, 4, 5)
/// ─────────────────────────────────────────────────────────────────────────────
class ExperiencePassportScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ExperiencePassportScreen({super.key, this.onBack});

  @override
  State<ExperiencePassportScreen> createState() => _ExperiencePassportScreenState();
}

class _ExperiencePassportScreenState extends State<ExperiencePassportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _categoryFilter = "All";
  String _statusFilter = "Any status";

  final List<Map<String, dynamic>> _activities = [
    {
      "id": "1",
      "title": "Blood Donation Camp",
      "category": "Volunteering",
      "role": "Team Lead",
      "organisation": "Event",
      "dates": "Oct 2026",
      "startDate": "October 2026",
      "endDate": "October 2026",
      "isCurrent": false,
      "description": "Planting 1000 trees",
      "evidenceLink": "https://chat.openai.com",
      "status": "Verified",
      "verifier": "by Dr. Meena Raghavan (Faculty), 15 Oct 2026",
      "feedback": "",
    },
    {
      "id": "2",
      "title": "Smart India Hackathon 2026 - 1st Runner Up",
      "category": "Competition",
      "role": "Team Lead & ML Developer",
      "organisation": "Ministry of Education & AICTE",
      "dates": "Sep 2026 – Oct 2026",
      "startDate": "September 2026",
      "endDate": "October 2026",
      "isCurrent": false,
      "description":
          "Built a real-time smart agriculture AI kit. Won ₹75,000 cash prize among 1,200 participating teams across India.",
      "evidenceLink": "https://smartindiahackathon.gov.in",
      "status": "Needs changes",
      "verifier": "",
      "feedback": "Dr. Meena Raghavan says: verify the link",
    },
    {
      "id": "3",
      "title": "National Cyber Security Hackathon - First Prize",
      "category": "Competition",
      "role": "Team Lead & Security Researcher",
      "organisation": "IEEE Computer Society & IIT Madras",
      "dates": "Aug 2026 – Sep 2026",
      "startDate": "August 2026",
      "endDate": "September 2026",
      "isCurrent": false,
      "description":
          "Built an automated cloud vulnerability scanner with 98.4% accuracy. Secured 1st place among 120 national teams and received a ₹50,000 cash award.",
      "evidenceLink": "",
      "status": "Verified",
      "verifier": "by Dr. Meena Raghavan (Faculty), 15 Oct 2026",
      "feedback": "",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddActivityDialog() {
    final titleCtrl = TextEditingController();
    final roleCtrl = TextEditingController();
    final orgCtrl = TextEditingController();
    final startCtrl = TextEditingController(text: "October 2026");
    final endCtrl = TextEditingController(text: "October 2026");
    final achieveCtrl = TextEditingController();
    final linkCtrl = TextEditingController();

    String selectedCategory = "Volunteering";
    bool isCurrent = false;

    final categories = ["Volunteering", "Competition", "Leadership", "Project", "Other"];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520, maxHeight: 780),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Add an activity",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),

                  // Scrollable Form
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // What did you do?
                          _buildFieldLabel("What did you do?"),
                          TextField(
                            controller: titleCtrl,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration("e.g. Blood donation camp coordinator"),
                          ),
                          const SizedBox(height: 16),

                          // Category & Your role
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    _buildFieldLabel("Category"),
                                    _buildDropdown(
                                      value: selectedCategory,
                                      items: categories,
                                      onChanged: (v) {
                                        if (v != null) setDialogState(() => selectedCategory = v);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFieldLabel("Your role"),
                                    TextField(
                                      controller: roleCtrl,
                                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                      decoration: _inputDecoration("e.g. Volunteer, Team lead"),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Category"),
                                        _buildDropdown(
                                          value: selectedCategory,
                                          items: categories,
                                          onChanged: (v) {
                                            if (v != null) setDialogState(() => selectedCategory = v);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Your role"),
                                        TextField(
                                          controller: roleCtrl,
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                          decoration: _inputDecoration("e.g. Volunteer, Team lead"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Organisation or event
                          _buildFieldLabel("Organisation or event"),
                          TextField(
                            controller: orgCtrl,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration(""),
                          ),
                          const SizedBox(height: 16),

                          // Started & Ended
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    _buildFieldLabel("Started"),
                                    TextField(
                                      controller: startCtrl,
                                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                      decoration: _inputDecoration("---------- ----", icon: Icons.calendar_today_outlined),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFieldLabel("Ended"),
                                    TextField(
                                      controller: endCtrl,
                                      enabled: !isCurrent,
                                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                      decoration: _inputDecoration("---------- ----", icon: Icons.calendar_today_outlined),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Started"),
                                        TextField(
                                          controller: startCtrl,
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                          decoration: _inputDecoration("---------- ----", icon: Icons.calendar_today_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Ended"),
                                        TextField(
                                          controller: endCtrl,
                                          enabled: !isCurrent,
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                          decoration: _inputDecoration("---------- ----", icon: Icons.calendar_today_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10),

                          // Checkbox: I am still doing this
                          InkWell(
                            onTap: () {
                              setDialogState(() {
                                isCurrent = !isCurrent;
                                if (isCurrent) {
                                  endCtrl.text = "Present";
                                } else {
                                  endCtrl.text = "October 2026";
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isCurrent,
                                  onChanged: (v) {
                                    setDialogState(() {
                                      isCurrent = v ?? false;
                                      if (isCurrent) {
                                        endCtrl.text = "Present";
                                      } else {
                                        endCtrl.text = "October 2026";
                                      }
                                    });
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  activeColor: const Color(0xFF2E2C9B),
                                ),
                                Text(
                                  "I am still doing this",
                                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // What did you achieve? (optional)
                          _buildFieldLabel("What did you achieve? (optional)"),
                          TextField(
                            controller: achieveCtrl,
                            minLines: 3,
                            maxLines: 4,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration(""),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Numbers help: people reached, funds raised, position won.",
                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 16),

                          // Evidence link (optional)
                          _buildFieldLabel("Evidence link (optional)"),
                          TextField(
                            controller: linkCtrl,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration("https://"),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "A certificate, event page or post the verifier can open.",
                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Actions Footer
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E293B),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E2C9B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            final title = titleCtrl.text.trim();
                            if (title.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter what you did."),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }

                            final startDate = startCtrl.text.trim();
                            final endDate = isCurrent ? "Present" : endCtrl.text.trim();
                            final dates = startDate == endDate ? startDate : "$startDate – $endDate";

                            setState(() {
                              _activities.insert(0, {
                                "id": DateTime.now().millisecondsSinceEpoch.toString(),
                                "title": title,
                                "category": selectedCategory,
                                "role": roleCtrl.text.trim().isEmpty ? "Participant" : roleCtrl.text.trim(),
                                "organisation": orgCtrl.text.trim().isEmpty ? "Campus Event" : orgCtrl.text.trim(),
                                "dates": dates.isEmpty ? "Oct 2026" : dates,
                                "startDate": startDate,
                                "endDate": endDate,
                                "isCurrent": isCurrent,
                                "description": achieveCtrl.text.trim(),
                                "evidenceLink": linkCtrl.text.trim(),
                                "status": "Waiting",
                                "verifier": "",
                                "feedback": "",
                              });
                            });

                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Activity added to your Experience Passport!"),
                                backgroundColor: Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            "Add to passport",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditActivityDialog(Map<String, dynamic> activity) {
    final titleCtrl = TextEditingController(text: activity["title"] as String? ?? "");
    final roleCtrl = TextEditingController(text: activity["role"] as String? ?? "");
    final orgCtrl = TextEditingController(text: activity["organisation"] as String? ?? "");
    final startCtrl = TextEditingController(text: activity["startDate"] as String? ?? "October 2026");
    final endCtrl = TextEditingController(text: activity["endDate"] as String? ?? "October 2026");
    final achieveCtrl = TextEditingController(text: activity["description"] as String? ?? "");
    final linkCtrl = TextEditingController(text: activity["evidenceLink"] as String? ?? "");

    String selectedCategory = activity["category"] as String? ?? "Volunteering";
    bool isCurrent = activity["isCurrent"] == true;

    final categories = ["Volunteering", "Competition", "Leadership", "Project", "Other"];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520, maxHeight: 800),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Edit activity",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),

                  // Scrollable Form
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // What did you do?
                          _buildFieldLabel("What did you do?"),
                          TextField(
                            controller: titleCtrl,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration("e.g. Blood donation camp coordinator"),
                          ),
                          const SizedBox(height: 16),

                          // Category & Your role
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    _buildFieldLabel("Category"),
                                    _buildDropdown(
                                      value: selectedCategory,
                                      items: categories,
                                      onChanged: (v) {
                                        if (v != null) setDialogState(() => selectedCategory = v);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFieldLabel("Your role"),
                                    TextField(
                                      controller: roleCtrl,
                                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                      decoration: _inputDecoration("Team Lead"),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Category"),
                                        _buildDropdown(
                                          value: selectedCategory,
                                          items: categories,
                                          onChanged: (v) {
                                            if (v != null) setDialogState(() => selectedCategory = v);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Your role"),
                                        TextField(
                                          controller: roleCtrl,
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                          decoration: _inputDecoration("Team Lead"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // Organisation or event
                          _buildFieldLabel("Organisation or event"),
                          TextField(
                            controller: orgCtrl,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration("Event"),
                          ),
                          const SizedBox(height: 16),

                          // Started & Ended
                          LayoutBuilder(
                            builder: (context, c) {
                              if (c.maxWidth < 420) {
                                return Column(
                                  children: [
                                    _buildFieldLabel("Started"),
                                    TextField(
                                      controller: startCtrl,
                                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                      decoration: _inputDecoration("October 2026", icon: Icons.calendar_today_outlined),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFieldLabel("Ended"),
                                    TextField(
                                      controller: endCtrl,
                                      enabled: !isCurrent,
                                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                      decoration: _inputDecoration("October 2026", icon: Icons.calendar_today_outlined),
                                    ),
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Started"),
                                        TextField(
                                          controller: startCtrl,
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                          decoration: _inputDecoration("October 2026", icon: Icons.calendar_today_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildFieldLabel("Ended"),
                                        TextField(
                                          controller: endCtrl,
                                          enabled: !isCurrent,
                                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                                          decoration: _inputDecoration("October 2026", icon: Icons.calendar_today_outlined),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10),

                          // Checkbox: I am still doing this
                          InkWell(
                            onTap: () {
                              setDialogState(() {
                                isCurrent = !isCurrent;
                                if (isCurrent) {
                                  endCtrl.text = "Present";
                                } else {
                                  endCtrl.text = "October 2026";
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isCurrent,
                                  onChanged: (v) {
                                    setDialogState(() {
                                      isCurrent = v ?? false;
                                      if (isCurrent) {
                                        endCtrl.text = "Present";
                                      } else {
                                        endCtrl.text = "October 2026";
                                      }
                                    });
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  activeColor: const Color(0xFF2E2C9B),
                                ),
                                Text(
                                  "I am still doing this",
                                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // What did you achieve? (optional)
                          _buildFieldLabel("What did you achieve? (optional)"),
                          TextField(
                            controller: achieveCtrl,
                            minLines: 3,
                            maxLines: 4,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration("Planting 1000 trees"),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Numbers help: people reached, funds raised, position won.",
                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 16),

                          // Evidence link (optional)
                          _buildFieldLabel("Evidence link (optional)"),
                          TextField(
                            controller: linkCtrl,
                            style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                            decoration: _inputDecoration("https://chat.openai.com"),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "A certificate, event page or post the verifier can open.",
                            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                          ),
                          const SizedBox(height: 18),

                          // Warning Note Box (Matching Image 4)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFFDE68A)),
                            ),
                            child: Text(
                              "Saving changes sends this activity back for verification.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF92400E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Actions Footer
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E293B),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E2C9B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            final title = titleCtrl.text.trim();
                            if (title.isEmpty) return;

                            final startDate = startCtrl.text.trim();
                            final endDate = isCurrent ? "Present" : endCtrl.text.trim();
                            final dates = startDate == endDate ? startDate : "$startDate – $endDate";

                            setState(() {
                              activity["title"] = title;
                              activity["category"] = selectedCategory;
                              activity["role"] = roleCtrl.text.trim();
                              activity["organisation"] = orgCtrl.text.trim();
                              activity["dates"] = dates;
                              activity["startDate"] = startDate;
                              activity["endDate"] = endDate;
                              activity["isCurrent"] = isCurrent;
                              activity["description"] = achieveCtrl.text.trim();
                              activity["evidenceLink"] = linkCtrl.text.trim();
                              if (activity["status"] == "Needs changes") {
                                activity["status"] = "Waiting";
                                activity["feedback"] = "";
                              }
                            });

                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Activity updated and sent for verification!"),
                                backgroundColor: Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            "Save changes",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCertificateDialog(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.verified_rounded, color: Color(0xFF059669), size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Verified Certificate",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity["title"] as String? ?? "Activity",
              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            Text(
              "${activity["role"]} · ${activity["organisation"]}",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Verification Details", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B))),
                  const SizedBox(height: 4),
                  Text(activity["verifier"] as String? ?? "Verified by Faculty", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                  const SizedBox(height: 4),
                  Text("Credential ID: PASSPORT-EXP-${activity["id"] ?? "2026"}", style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF4F46E5), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _deleteActivity(Map<String, dynamic> act) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Activity?",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Text(
          "Are you sure you want to remove \"${act["title"]}\" from your Experience Passport?",
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final idx = _activities.indexOf(act);
              setState(() {
                _activities.remove(act);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("\"${act["title"]}\" removed from passport."),
                  action: SnackBarAction(
                    label: "Undo",
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        if (idx >= 0 && idx <= _activities.length) {
                          _activities.insert(idx, act);
                        } else {
                          _activities.add(act);
                        }
                      });
                    },
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  static Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1E293B),
        ),
      ),
    );
  }

  static InputDecoration _inputDecoration(String hintText, {IconData? icon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      suffixIcon: icon != null ? Icon(icon, size: 18, color: const Color(0xFF64748B)) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF2E2C9B), width: 1.5),
      ),
    );
  }

  static Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: items.contains(value) ? value : items.first,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
          items: items.map((opt) {
            return DropdownMenuItem<String>(
              value: opt,
              child: Text(opt, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = _activities.where((a) {
      final matchesQuery = query.isEmpty ||
          (a["title"] as String).toLowerCase().contains(query) ||
          (a["role"] as String).toLowerCase().contains(query) ||
          (a["organisation"] as String).toLowerCase().contains(query) ||
          (a["description"] as String).toLowerCase().contains(query);

      final matchesCategory = _categoryFilter == "All" || a["category"] == _categoryFilter;
      final matchesStatus = _statusFilter == "Any status" || a["status"] == _statusFilter;

      return matchesQuery && matchesCategory && matchesStatus;
    }).toList();

    final totalCount = _activities.length;
    final verifiedCount = _activities.where((a) => a["status"] == "Verified").length;
    final waitingCount = _activities.where((a) => a["status"] == "Waiting").length;
    final needChangesCount = _activities.where((a) => a["status"] == "Needs changes").length;

    return PortalPageBody(
      title: "Experience Passport",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner (Matching Image 2)
        BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Experience Passport",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.star_rounded,
          title: "Experience Passport",
          subtitle: "Record volunteering, leadership, competitions and more; faculty verify each entry.",
          watermarkIcon: Icons.star_rounded,
          action: ElevatedButton.icon(
            onPressed: _showAddActivityDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1E3A8A),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.add_rounded, size: 18),
            label: Text(
              "Add Activity",
              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // 2. 4 Metric Cards (Matching Image 2)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 820) {
              return Row(
                children: [
                  Expanded(
                    child: _buildMetricCard("Activities", "$totalCount", Icons.bookmark_outline_rounded, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard("Verified", "$verifiedCount", Icons.verified_user_outlined, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard("Waiting", "$waitingCount", Icons.access_time_rounded, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildMetricCard("Need changes", "$needChangesCount", Icons.refresh_rounded, const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
                  ),
                ],
              );
            } else if (w > 480) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard("Activities", "$totalCount", Icons.bookmark_outline_rounded, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildMetricCard("Verified", "$verifiedCount", Icons.verified_user_outlined, const Color(0xFFECFDF5), const Color(0xFF059669)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard("Waiting", "$waitingCount", Icons.access_time_rounded, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildMetricCard("Need changes", "$needChangesCount", Icons.refresh_rounded, const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildMetricCard("Activities", "$totalCount", Icons.bookmark_outline_rounded, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  const SizedBox(height: 12),
                  _buildMetricCard("Verified", "$verifiedCount", Icons.verified_user_outlined, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  const SizedBox(height: 12),
                  _buildMetricCard("Waiting", "$waitingCount", Icons.access_time_rounded, const Color(0xFFFEF3C7), const Color(0xFFD97706)),
                  const SizedBox(height: 12),
                  _buildMetricCard("Need changes", "$needChangesCount", Icons.refresh_rounded, const Color(0xFFFEE2E2), const Color(0xFFDC2626)),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Search & Filter Bar (Matching Image 2)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 20, color: Color(0xFF64748B)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                        decoration: InputDecoration(
                          hintText: "Search your activities...",
                          hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () => setState(() => _searchController.clear()),
                        child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Dropdown Filters Row
              LayoutBuilder(
                builder: (context, c) {
                  if (c.maxWidth < 620) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildFilterDropdown(
                          value: _categoryFilter,
                          items: const ["All", "Volunteering", "Competition", "Leadership", "Project"],
                          onChanged: (v) {
                            if (v != null) setState(() => _categoryFilter = v);
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildFilterDropdown(
                          value: _statusFilter,
                          items: const ["Any status", "Verified", "Waiting", "Needs changes"],
                          onChanged: (v) {
                            if (v != null) setState(() => _statusFilter = v);
                          },
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _showAddActivityDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E2C9B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.add, size: 18),
                          label: Text(
                            "Add activity",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: _buildFilterDropdown(
                          value: _categoryFilter,
                          items: const ["All", "Volunteering", "Competition", "Leadership", "Project"],
                          onChanged: (v) {
                            if (v != null) setState(() => _categoryFilter = v);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFilterDropdown(
                          value: _statusFilter,
                          items: const ["Any status", "Verified", "Waiting", "Needs changes"],
                          onChanged: (v) {
                            if (v != null) setState(() => _statusFilter = v);
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      ElevatedButton.icon(
                        onPressed: _showAddActivityDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E2C9B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(
                          "Add activity",
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 4. Activities List
        if (filtered.isEmpty)
          Container(
            width: double.infinity,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _LightBlueprintGridPainter(),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "No matching records",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Try a different search or filter.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final act = filtered[index];
              return _buildActivityCard(act);
            },
          ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String count, IconData icon, Color iconBg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF475569),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: items.contains(value) ? value : items.first,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
          items: items.map((opt) {
            return DropdownMenuItem<String>(
              value: opt,
              child: Text(opt, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> act) {
    final title = act["title"] as String? ?? "";
    final category = act["category"] as String? ?? "Activity";
    final role = act["role"] as String? ?? "";
    final org = act["organisation"] as String? ?? "";
    final dates = act["dates"] as String? ?? "";
    final desc = act["description"] as String? ?? "";
    final status = act["status"] as String? ?? "Waiting";
    final verifier = act["verifier"] as String? ?? "";
    final feedback = act["feedback"] as String? ?? "";
    final link = act["evidenceLink"] as String? ?? "";

    Color catBg;
    Color catColor;
    if (category == "Volunteering") {
      catBg = const Color(0xFFF5EBE1);
      catColor = const Color(0xFF78350F);
    } else if (category == "Competition") {
      catBg = const Color(0xFFF1F5F9);
      catColor = const Color(0xFF475569);
    } else if (category == "Leadership") {
      catBg = const Color(0xFFEEF2FF);
      catColor = const Color(0xFF4F46E5);
    } else {
      catBg = const Color(0xFFECFDF5);
      catColor = const Color(0xFF059669);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title, Category pill, Edit & Delete buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 6,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: catBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: catColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Action buttons: Edit & Delete
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF475569),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _showEditActivityDialog(act),
                    icon: const Icon(Icons.edit_outlined, size: 14),
                    label: Text(
                      "Edit",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFEF4444)),
                    onPressed: () => _deleteActivity(act),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Subtitle: Role · Organisation
          if (role.isNotEmpty || org.isNotEmpty)
            Text(
              role.isNotEmpty && org.isNotEmpty ? "$role · $org" : (role.isNotEmpty ? role : org),
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
              ),
            ),
          const SizedBox(height: 2),

          // Dates
          if (dates.isNotEmpty)
            Text(
              dates,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF94A3B8),
              ),
            ),
          const SizedBox(height: 10),

          // Description / Achievement
          if (desc.isNotEmpty) ...[
            Text(
              desc,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xFF334155),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Buttons: View Certificate & External Link
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => _showCertificateDialog(act),
                icon: const Icon(Icons.card_membership_outlined, size: 15, color: Color(0xFF475569)),
                label: Text(
                  "View Certificate",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              if (link.isNotEmpty)
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Opening evidence: $link")),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "External Link",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.open_in_new_rounded, size: 13, color: Color(0xFF64748B)),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Status & Verifier / Needs changes Notice
          if (status == "Verified") ...[
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Verified",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF15803D),
                    ),
                  ),
                ),
                if (verifier.isNotEmpty)
                  Text(
                    verifier,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
              ],
            ),
          ] else if (status == "Needs changes") ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Needs changes",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFB91C1C),
                ),
              ),
            ),
            if (feedback.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Text(
                  feedback,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF92400E),
                  ),
                ),
              ),
            ],
          ] else ...[
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Waiting",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD97706),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Submitted for faculty verification",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Refresh Zone Screen [P3] (Image 3)
/// ─────────────────────────────────────────────────────────────────────────────
/// ─────────────────────────────────────────────────────────────────────────────
/// Refresh Zone Screen [P3] (Images 2 & 3)
/// ─────────────────────────────────────────────────────────────────────────────
class RefreshZoneScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const RefreshZoneScreen({super.key, this.onBack});

  @override
  State<RefreshZoneScreen> createState() => _RefreshZoneScreenState();
}

class _RefreshZoneScreenState extends State<RefreshZoneScreen> {
  // Current active mode: null = main dashboard, "quiz_battle" = Subject Quiz Battle
  String? _activeGame;

  int _todayBreaks = 0;
  final int _maxBreaks = 3;
  int _quizQuestionIndex = 0;
  int _quizScore = 0;
  int? _selectedOptionIndex;
  bool _answered = false;

  final List<Map<String, dynamic>> _quizQuestions = [
    {
      "question": "Which layer of the OSI model is responsible for routing?",
      "options": ["Data link", "Session", "Transport", "Network"],
      "answer": 3,
      "explanation": "The Network layer (Layer 3) handles packet routing, forwarding, and IP addressing.",
    },
    {
      "question": "What is the worst-case time complexity of QuickSort?",
      "options": ["O(n log n)", "O(n²)", "O(log n)", "O(n)"],
      "answer": 1,
      "explanation": "When the chosen pivot is always the smallest or largest element, QuickSort degrades to O(n²).",
    },
    {
      "question": "Which data structure follows the LIFO (Last In First Out) principle?",
      "options": ["Queue", "Binary Tree", "Stack", "Linked List"],
      "answer": 2,
      "explanation": "A Stack operates on Last-In, First-Out where the most recently inserted item is popped first.",
    },
    {
      "question": "In relational databases, which SQL clause is used to filter aggregated group rows?",
      "options": ["WHERE", "HAVING", "GROUP BY", "ORDER BY"],
      "answer": 1,
      "explanation": "HAVING filters groups created by GROUP BY, while WHERE filters individual rows before grouping.",
    },
    {
      "question": "What does ACID stand for in Database Management Systems?",
      "options": [
        "Atomicity, Consistency, Isolation, Durability",
        "Array, Column, Index, Domain",
        "Access, Control, Interface, Data",
        "Accuracy, Concurrency, Integrity, Distribution"
      ],
      "answer": 0,
      "explanation": "ACID properties ensure reliable processing of database transactions.",
    },
    {
      "question": "Which protocol is primarily used for secure, encrypted web communication?",
      "options": ["HTTP", "FTP", "HTTPS", "SMTP"],
      "answer": 2,
      "explanation": "HTTPS transmits web traffic over TLS/SSL encryption on port 443.",
    },
    {
      "question": "In OOP, what concept allows a subclass to provide a specific implementation of a parent method?",
      "options": ["Encapsulation", "Method Overriding", "Method Overloading", "Abstraction"],
      "answer": 1,
      "explanation": "Method Overriding allows a derived class to rewrite a method defined in its superclass.",
    },
    {
      "question": "Which CPU scheduling algorithm gives CPU to the process with the smallest burst time?",
      "options": ["Round Robin", "First Come First Served", "Shortest Job First (SJF)", "Priority Scheduling"],
      "answer": 2,
      "explanation": "Shortest Job First (SJF) selects the waiting process with the smallest execution time.",
    },
  ];

  void _startQuizBattle() {
    setState(() {
      _activeGame = "quiz_battle";
      _quizQuestionIndex = 0;
      _quizScore = 0;
      _selectedOptionIndex = null;
      _answered = false;
    });
  }

  void _handleOptionSelect(int index) {
    if (_answered) return;
    setState(() {
      _selectedOptionIndex = index;
      _answered = true;
      if (index == _quizQuestions[_quizQuestionIndex]["answer"]) {
        _quizScore++;
      }
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      if (_quizQuestionIndex < _quizQuestions.length - 1) {
        setState(() {
          _quizQuestionIndex++;
          _selectedOptionIndex = null;
          _answered = false;
        });
      } else {
        _finishQuiz();
      }
    });
  }

  void _skipQuestion() {
    if (_quizQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _quizQuestionIndex++;
        _selectedOptionIndex = null;
        _answered = false;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    setState(() {
      if (_todayBreaks < _maxBreaks) {
        _todayBreaks++;
      }
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.emoji_events_rounded, color: Color(0xFFD97706), size: 26),
            const SizedBox(width: 10),
            Text(
              "Battle Complete!",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You scored $_quizScore out of ${_quizQuestions.length} questions correctly (${((_quizScore / _quizQuestions.length) * 100).round()}%).",
              style: GoogleFonts.poppins(fontSize: 13.5, color: const Color(0xFF334155)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: Color(0xFF059669), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "+25 XP awarded · Today's brain break logged ($_todayBreaks/3)!",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF065F46),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _activeGame = null);
            },
            child: Text("Back to Refresh Zone", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2C9B),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              _startQuizBattle();
            },
            child: Text("Play Again", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showBreathingBreakDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2FE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.air_rounded, color: Color(0xFF0284C7), size: 20),
            ),
            const SizedBox(width: 10),
            Text("Breathing Break", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  colors: [Color(0xFFBAE6FD), Color(0xFF38BDF8)],
                ),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF38BDF8).withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 4),
                ],
              ),
              child: Center(
                child: Text(
                  "Breathe In\n4s",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0C4A6E)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Take a 2-minute mindful breathing pause to reset mental focus before your next study block.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0284C7),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                if (_todayBreaks < _maxBreaks) _todayBreaks++;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Breathing session completed! Feeling refreshed."),
                  backgroundColor: Color(0xFF0284C7),
                ),
              );
            },
            child: const Text("Start 2m Timer"),
          ),
        ],
      ),
    );
  }

  void _showGamePlaceholder(String title) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700)),
        content: Text(
          "Launching $title session! Sharpen your brain skills and placement readiness.",
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Close")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2C9B),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                if (_todayBreaks < _maxBreaks) _todayBreaks++;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("$title completed! Break logged ($_todayBreaks/3)."),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
            },
            child: const Text("Complete Round"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_activeGame == "quiz_battle") {
      return _buildQuizBattleScreen();
    }

    return PortalPageBody(
      title: "Refresh Zone",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner (Matching Image 2)
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Refresh Zone",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.sports_esports_rounded,
          title: "Refresh Zone",
          subtitle: "Short brain breaks with saved scores: subject quiz battles, aptitude and vocabulary rounds, a memory game and guided breathing.",
          watermarkIcon: Icons.sports_esports_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Today's breaks Card (Matching Image 2)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 580;
              final progressFraction = (_todayBreaks / _maxBreaks).clamp(0.0, 1.0);

              final leftSide = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's breaks",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "$_todayBreaks",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "of $_maxBreaks",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progressFraction,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E2C9B)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department_outlined, size: 16, color: Color(0xFF64748B)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "No streak yet. Play one game today. · best 0 · 22% correct overall",
                          style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
                        ),
                      ),
                    ],
                  ),
                ],
              );

              final weekDays = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];
              final rightSide = Row(
                mainAxisSize: MainAxisSize.min,
                children: weekDays.map((day) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 22,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          day,
                          style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: leftSide),
                    const SizedBox(width: 24),
                    rightSide,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  leftSide,
                  const SizedBox(height: 16),
                  Center(child: rightSide),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // 3. 5 Brain Break Cards (Matching Image 2)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final isTwoCol = w > 680;

            final card1 = _buildBreakCard(
              title: "Subject quiz battle",
              badge: "Quiz battle",
              badgeBg: const Color(0xFFFEF3C7),
              badgeColor: const Color(0xFFD97706),
              icon: Icons.sports_esports_rounded,
              iconBg: const Color(0xFFFEF2F2),
              iconColor: const Color(0xFFDC2626),
              desc: "Ten rapid-fire questions from your own subject area, scored with explanations.",
              secondary: "From the Computer Science & Engineering question bank.",
              scoreText: "Best 63% · played 3x",
              onPlay: _startQuizBattle,
            );

            final card2 = _buildBreakCard(
              title: "Aptitude sprint",
              badge: "Logic & aptitude",
              badgeBg: const Color(0xFFEEF2FF),
              badgeColor: const Color(0xFF4F46E5),
              icon: Icons.sports_esports_rounded,
              iconBg: const Color(0xFFEFF6FF),
              iconColor: const Color(0xFF2563EB),
              desc: "Percentages, time and work, ratios and number series, built fresh every round for placement tests.",
              secondary: "Questions are generated from formulas, so every answer is exact.",
              scoreText: "Best 0% · played 1x",
              onPlay: () => _showGamePlaceholder("Aptitude sprint"),
            );

            final card3 = _buildBreakCard(
              title: "Vocabulary power",
              badge: "Language",
              badgeBg: const Color(0xFFFEF3C7),
              badgeColor: const Color(0xFFD97706),
              icon: Icons.sports_esports_rounded,
              iconBg: const Color(0xFFFFFBEB),
              iconColor: const Color(0xFFD97706),
              desc: "Ten GRE and CAT level words. Pick the right meaning before the clock runs out.",
              secondary: "",
              scoreText: "Best 40% · played 2x",
              onPlay: () => _showGamePlaceholder("Vocabulary power"),
            );

            final card4 = _buildBreakCard(
              title: "Memory matrix",
              badge: "Brain fitness",
              badgeBg: const Color(0xFFCCFBF1),
              badgeColor: const Color(0xFF0F766E),
              icon: Icons.grid_view_rounded,
              iconBg: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF059669),
              desc: "Watch the pattern, then repeat it. Every level adds one more square.",
              secondary: "Best is the highest level you cleared.",
              scoreText: "Not played yet",
              onPlay: () => _showGamePlaceholder("Memory matrix"),
            );

            final card5 = _buildBreakCard(
              title: "Breathing break",
              badge: "Reset",
              badgeBg: const Color(0xFFE0F2FE),
              badgeColor: const Color(0xFF0284C7),
              icon: Icons.air_rounded,
              iconBg: const Color(0xFFF0F9FF),
              iconColor: const Color(0xFF0284C7),
              desc: "A guided breathing circle to settle your mind between study blocks.",
              secondary: "Best shows your total minutes of calm.",
              scoreText: "Not played yet",
              onPlay: _showBreathingBreakDialog,
            );

            if (isTwoCol) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: card1),
                      const SizedBox(width: 16),
                      Expanded(child: card2),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: card3),
                      const SizedBox(width: 16),
                      Expanded(child: card4),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: card5),
                      const SizedBox(width: 16),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              );
            }

            return Column(
              children: [
                card1,
                const SizedBox(height: 14),
                card2,
                const SizedBox(height: 14),
                card3,
                const SizedBox(height: 14),
                card4,
                const SizedBox(height: 14),
                card5,
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildBreakCard({
    required String title,
    required String badge,
    required Color badgeBg,
    required Color badgeColor,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String desc,
    required String secondary,
    required String scoreText,
    required VoidCallback onPlay,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Badge
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 17, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            desc,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF334155),
              height: 1.45,
            ),
          ),
          if (secondary.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              secondary,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
          const SizedBox(height: 16),

          // Footer: Score + Play Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.emoji_events_outlined, size: 15, color: Color(0xFF64748B)),
                  const SizedBox(width: 6),
                  Text(
                    scoreText,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E2C9B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onPlay,
                child: Text(
                  "Play",
                  style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Interactive Quiz Battle Play Screen (Matching Image 3)
  Widget _buildQuizBattleScreen() {
    final currentQ = _quizQuestions[_quizQuestionIndex];
    final questionText = currentQ["question"] as String;
    final options = currentQ["options"] as List<String>;
    final letters = ["A", "B", "C", "D"];
    final progress = (_quizQuestionIndex + 1) / _quizQuestions.length;

    return PortalPageBody(
      title: "Subject quiz battle",
      category: "Campus Life",
      onBack: () => setState(() => _activeGame = null),
      children: [
        // Top Back Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Subject quiz battle",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            InkWell(
              onTap: () => setState(() => _activeGame = null),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back, size: 16, color: Color(0xFF475569)),
                    const SizedBox(width: 4),
                    Text(
                      "Back",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Centered Quiz Card (Matching Image 3)
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top progress & Timer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question ${_quizQuestionIndex + 1} of ${_quizQuestions.length}",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        "40s",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E2C9B)),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Question Text
                  Text(
                    questionText,
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 4 Option Buttons
                  ...List.generate(options.length, (i) {
                    final isSelected = _selectedOptionIndex == i;
                    final isCorrect = _answered && i == currentQ["answer"];
                    final isWrong = _answered && isSelected && !isCorrect;

                    Color borderColor = const Color(0xFFE2E8F0);
                    Color bgColor = Colors.white;
                    if (isCorrect) {
                      borderColor = const Color(0xFF10B981);
                      bgColor = const Color(0xFFECFDF5);
                    } else if (isWrong) {
                      borderColor = const Color(0xFFEF4444);
                      bgColor = const Color(0xFFFEF2F2);
                    } else if (isSelected) {
                      borderColor = const Color(0xFF2E2C9B);
                      bgColor = const Color(0xFFEEF2FF);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => _handleOptionSelect(i),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: borderColor, width: isSelected || isCorrect ? 1.5 : 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: const Color(0xFFCBD5E1)),
                                ),
                                child: Center(
                                  child: Text(
                                    letters[i],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  options[i],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),

                  // Bottom Skip Action
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _skipQuestion,
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// XP & Badges Screen [P3] (Images 4 & 5)
/// ─────────────────────────────────────────────────────────────────────────────
class XpBadgesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const XpBadgesScreen({super.key, this.onBack});

  @override
  State<XpBadgesScreen> createState() => _XpBadgesScreenState();
}

class _XpBadgesScreenState extends State<XpBadgesScreen> {
  String _badgeFilter = "All"; // "All", "Earned", "Locked"

  final List<Map<String, dynamic>> _badgesList = [
    // QUIZZES
    {
      "category": "QUIZZES",
      "title": "First steps",
      "desc": "Attempt your first quiz",
      "isEarned": true,
      "progress": null,
      "icon": Icons.military_tech_outlined,
      "iconColor": Color(0xFF2563EB),
      "iconBg": Color(0xFFEFF6FF),
    },
    {
      "category": "QUIZZES",
      "title": "Quiz regular",
      "desc": "Attempt 10 quizzes",
      "isEarned": true,
      "progress": null,
      "icon": Icons.military_tech_outlined,
      "iconColor": Color(0xFF2563EB),
      "iconBg": Color(0xFFEFF6FF),
    },
    {
      "category": "QUIZZES",
      "title": "Quiz marathon",
      "desc": "Attempt 25 quizzes",
      "isEarned": false,
      "progress": "10 of 25",
      "progressFraction": 10 / 25,
      "icon": Icons.lock_outline_rounded,
      "iconColor": Color(0xFF94A3B8),
      "iconBg": Color(0xFFF1F5F9),
    },
    {
      "category": "QUIZZES",
      "title": "Passed it",
      "desc": "Pass a quiz",
      "isEarned": true,
      "progress": null,
      "icon": Icons.military_tech_outlined,
      "iconColor": Color(0xFF059669),
      "iconBg": Color(0xFFECFDF5),
    },
    {
      "category": "QUIZZES",
      "title": "Hat-trick",
      "desc": "Pass 3 different quizzes",
      "isEarned": true,
      "progress": null,
      "icon": Icons.military_tech_outlined,
      "iconColor": Color(0xFF059669),
      "iconBg": Color(0xFFECFDF5),
    },
    {
      "category": "QUIZZES",
      "title": "Perfect score",
      "desc": "Score 100% on a quiz",
      "isEarned": true,
      "progress": null,
      "icon": Icons.military_tech_outlined,
      "iconColor": Color(0xFFD97706),
      "iconBg": Color(0xFFFEF3C7),
    },

    // COURSES
    {
      "category": "COURSES",
      "title": "Certified",
      "desc": "Earn your first certificate",
      "isEarned": true,
      "progress": null,
      "icon": Icons.card_membership_outlined,
      "iconColor": Color(0xFFD97706),
      "iconBg": Color(0xFFFEF3C7),
    },
    {
      "category": "COURSES",
      "title": "Certificate collector",
      "desc": "Earn 3 certificates",
      "isEarned": true,
      "progress": null,
      "icon": Icons.card_membership_outlined,
      "iconColor": Color(0xFFD97706),
      "iconBg": Color(0xFFFEF3C7),
    },
    {
      "category": "COURSES",
      "title": "Lesson reader",
      "desc": "Finish 20 lessons",
      "isEarned": true,
      "progress": null,
      "icon": Icons.menu_book_outlined,
      "iconColor": Color(0xFF0D9488),
      "iconBg": Color(0xFFCCFBF1),
    },
    {
      "category": "COURSES",
      "title": "Course finisher",
      "desc": "Finish every lesson of a course",
      "isEarned": true,
      "progress": null,
      "icon": Icons.school_outlined,
      "iconColor": Color(0xFF4F46E5),
      "iconBg": Color(0xFFEEF2FF),
    },

    // ASSIGNMENTS
    {
      "category": "ASSIGNMENTS",
      "title": "Always on time",
      "desc": "Hand in 3 assignments before the deadline",
      "isEarned": true,
      "progress": null,
      "icon": Icons.alarm_on_outlined,
      "iconColor": Color(0xFFD97706),
      "iconBg": Color(0xFFFEF3C7),
    },
    {
      "category": "ASSIGNMENTS",
      "title": "Assignment ace",
      "desc": "Score 80% or more on an assignment",
      "isEarned": true,
      "progress": null,
      "icon": Icons.assignment_turned_in_outlined,
      "iconColor": Color(0xFFDC2626),
      "iconBg": Color(0xFFFEE2E2),
    },

    // EXAM PREP
    {
      "category": "EXAM PREP",
      "title": "Aptitude habit",
      "desc": "Take the daily aptitude test 7 days in a row",
      "isEarned": false,
      "progress": "0 of 7",
      "progressFraction": 0.0,
      "icon": Icons.lock_outline_rounded,
      "iconColor": Color(0xFF94A3B8),
      "iconBg": Color(0xFFF1F5F9),
    },
    {
      "category": "EXAM PREP",
      "title": "Mock marathon",
      "desc": "Finish 5 practice mocks",
      "isEarned": false,
      "progress": "0 of 5",
      "progressFraction": 0.0,
      "icon": Icons.lock_outline_rounded,
      "iconColor": Color(0xFF94A3B8),
      "iconBg": Color(0xFFF1F5F9),
    },
    {
      "category": "EXAM PREP",
      "title": "News reader",
      "desc": "Take a weekly current-affairs quiz",
      "isEarned": true,
      "progress": null,
      "icon": Icons.newspaper_outlined,
      "iconColor": Color(0xFF0D9488),
      "iconBg": Color(0xFFCCFBF1),
    },

    // CONSISTENCY
    {
      "category": "CONSISTENCY",
      "title": "3-day streak",
      "desc": "Be active 3 days in a row",
      "isEarned": true,
      "progress": null,
      "icon": Icons.local_fire_department_outlined,
      "iconColor": Color(0xFFD97706),
      "iconBg": Color(0xFFFEF3C7),
    },
    {
      "category": "CONSISTENCY",
      "title": "Week warrior",
      "desc": "Be active 7 days in a row",
      "isEarned": false,
      "progress": "3 of 7",
      "progressFraction": 3 / 7,
      "icon": Icons.lock_outline_rounded,
      "iconColor": Color(0xFF94A3B8),
      "iconBg": Color(0xFFF1F5F9),
    },
    {
      "category": "CONSISTENCY",
      "title": "Unstoppable",
      "desc": "Be active 30 days in a row",
      "isEarned": false,
      "progress": "3 of 30",
      "progressFraction": 3 / 30,
      "icon": Icons.lock_outline_rounded,
      "iconColor": Color(0xFF94A3B8),
      "iconBg": Color(0xFFF1F5F9),
    },

    // PROGRESS
    {
      "category": "PROGRESS",
      "title": "Halfway hero",
      "desc": "Reach 50% course progress",
      "isEarned": true,
      "progress": null,
      "icon": Icons.trending_up_rounded,
      "iconColor": Color(0xFF2563EB),
      "iconBg": Color(0xFFEFF6FF),
    },
    {
      "category": "PROGRESS",
      "title": "Knowledge sponge",
      "desc": "Complete 10 module units",
      "isEarned": true,
      "progress": null,
      "icon": Icons.auto_awesome,
      "iconColor": Color(0xFF7C3AED),
      "iconBg": Color(0xFFF3E8FF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "XP & Badges",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner (Matching Image 4)
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  XP & Badges",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.emoji_events_rounded,
          title: "XP & Badges",
          subtitle: "Your XP, level, streak and badges from real quizzes, courses and assignments, plus your class rank.",
          watermarkIcon: Icons.emoji_events_rounded,
        ),
        const SizedBox(height: 20),

        // 2. Level & Streak Row (Matching Image 4)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final isWide = w > 650;

            final levelCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF141938),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LEVEL",
                          style: GoogleFonts.poppins(fontSize: 8.5, fontWeight: FontWeight.w700, color: Colors.white70),
                        ),
                        Text(
                          "6",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Expert",
                              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF64748B)),
                            ),
                            const Spacer(),
                            Text(
                              "1,655 XP",
                              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            value: 0.85,
                            minHeight: 5,
                            backgroundColor: Color(0xFFF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF141938)),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "145 XP to level 7",
                          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

            final streakCard = Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.local_fire_department_outlined, size: 24, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "0 day streak",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Take a quiz or hand in work to start one · best 3",
                          style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: levelCard),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: streakCard),
                ],
              );
            }

            return Column(
              children: [
                levelCard,
                const SizedBox(height: 14),
                streakCard,
              ],
            );
          },
        ),
        const SizedBox(height: 18),

        // 3. 4 Quick Stat Cards (Matching Image 4)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 820) {
              return Row(
                children: [
                  Expanded(child: _buildStatItem("Badges earned", "15/20", Icons.military_tech_outlined)),
                  const SizedBox(width: 14),
                  Expanded(child: _buildStatItem("Quizzes passed", "7", Icons.check_circle_outline)),
                  const SizedBox(width: 14),
                  Expanded(child: _buildStatItem("Certificates", "5", Icons.card_membership_outlined)),
                  const SizedBox(width: 14),
                  Expanded(child: _buildStatItem("Class rank", "#1 of 3", Icons.leaderboard_outlined)),
                ],
              );
            } else if (w > 480) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildStatItem("Badges earned", "15/20", Icons.military_tech_outlined)),
                      const SizedBox(width: 14),
                      Expanded(child: _buildStatItem("Quizzes passed", "7", Icons.check_circle_outline)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _buildStatItem("Certificates", "5", Icons.card_membership_outlined)),
                      const SizedBox(width: 14),
                      Expanded(child: _buildStatItem("Class rank", "#1 of 3", Icons.leaderboard_outlined)),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildStatItem("Badges earned", "15/20", Icons.military_tech_outlined),
                  const SizedBox(height: 12),
                  _buildStatItem("Quizzes passed", "7", Icons.check_circle_outline),
                  const SizedBox(height: 12),
                  _buildStatItem("Certificates", "5", Icons.card_membership_outlined),
                  const SizedBox(height: 12),
                  _buildStatItem("Class rank", "#1 of 3", Icons.leaderboard_outlined),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 22),

        // 4. Next Up Section (Matching Image 4)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Next up",
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
              ),
              const SizedBox(height: 2),
              Text(
                "The badges you are closest to",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final isWide = w > 680;

                  final next1 = _buildNextUpCard("Week warrior", "Be active 7 days in a row", "3 of 7", 3 / 7);
                  final next2 = _buildNextUpCard("Quiz marathon", "Attempt 25 quizzes", "10 of 25", 10 / 25);
                  final next3 = _buildNextUpCard("Unstoppable", "Be active 30 days in a row", "3 of 30", 3 / 30);

                  if (isWide) {
                    return Row(
                      children: [
                        Expanded(child: next1),
                        const SizedBox(width: 14),
                        Expanded(child: next2),
                        const SizedBox(width: 14),
                        Expanded(child: next3),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      next1,
                      const SizedBox(height: 12),
                      next2,
                      const SizedBox(height: 12),
                      next3,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // 5. Badges Catalog Section (Matching Images 4 & 5)
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Badges & Filters (All, Earned, Locked)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Badges",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFilterPill("All"),
                      const SizedBox(width: 8),
                      _buildFilterPill("Earned"),
                      const SizedBox(width: 8),
                      _buildFilterPill("Locked"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Categorized Badges List
              ..._buildCategorizedBadges(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }

  Widget _buildNextUpCard(String title, String subtitle, String progressText, double progressFraction) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F0E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progressFraction,
              minHeight: 4,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF141938)),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            progressText,
            style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill(String label) {
    final isSelected = _badgeFilter == label;
    return InkWell(
      onTap: () => setState(() => _badgeFilter = label),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategorizedBadges() {
    final categories = ["QUIZZES", "COURSES", "ASSIGNMENTS", "EXAM PREP", "CONSISTENCY", "PROGRESS"];

    final List<Widget> widgets = [];

    for (final cat in categories) {
      final badgesInCat = _badgesList.where((b) {
        if (b["category"] != cat) return false;
        if (_badgeFilter == "Earned") return b["isEarned"] == true;
        if (_badgeFilter == "Locked") return b["isEarned"] == false;
        return true;
      }).toList();

      if (badgesInCat.isEmpty) continue;

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 12),
          child: Text(
            cat,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
        ),
      );

      widgets.add(
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final crossAxisCount = w > 860 ? 3 : (w > 540 ? 2 : 1);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: badgesInCat.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 96,
              ),
              itemBuilder: (context, index) {
                final b = badgesInCat[index];
                final isEarned = b["isEarned"] == true;
                final progressStr = b["progress"] as String?;
                final progressFraction = b["progressFraction"] as double?;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: b["iconBg"] as Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(b["icon"] as IconData, size: 20, color: b["iconColor"] as Color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    b["title"] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isEarned)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "Earned",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF15803D),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              b["desc"] as String,
                              style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (!isEarned && progressFraction != null) ...[
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: LinearProgressIndicator(
                                  value: progressFraction,
                                  minHeight: 3,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF141938)),
                                ),
                              ),
                              const SizedBox(height: 2),
                              if (progressStr != null)
                                Text(
                                  progressStr,
                                  style: GoogleFonts.poppins(fontSize: 9.5, color: const Color(0xFF94A3B8)),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
      widgets.add(const SizedBox(height: 10));
    }

    return widgets;
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Wellness & Habits Screen [P3] (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class WellnessHabitsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const WellnessHabitsScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Wellness & Habits",
      category: "Campus Life",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Wellness & Habits",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.favorite_rounded,
          title: "Wellness & Habits",
          subtitle: "Educational content on sleep, hydration, breaks, screen time and healthy routines.",
          watermarkIcon: Icons.favorite_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Notice Banner (Image 5)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFDE68A)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 18,
                color: Color(0xFFD97706),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "This area is educational and non-diagnostic. If you are struggling, please reach out to your student counsellor or the Student Welfare Office. In an emergency, call 112 (India).",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // 3. Responsive Content & Sidebars
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildRoutineCard(),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        _infoCallout("Educational guidance only — not medical advice."),
                        const SizedBox(height: 14),
                        _infoCallout("Student Welfare Office: Block C, Room 104 · Counsellor hours 10:00–17:00."),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildRoutineCard(),
                  const SizedBox(height: 18),
                  _infoCallout("Educational guidance only — not medical advice."),
                  const SizedBox(height: 12),
                  _infoCallout("Student Welfare Office: Block C, Room 104 · Counsellor hours 10:00–17:00."),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildRoutineCard() {
    final routines = [
      _RoutineItem(
        time: "Morning",
        desc: "10 minutes of light movement and sunlight",
        barColor: Color(0xFF0F766E),
        tag: "Activity",
        tagBg: Color(0xFFECFDF5),
        tagColor: Color(0xFF059669),
      ),
      _RoutineItem(
        time: "Every 45 min",
        desc: "5-minute study break, look away from screens",
        barColor: Color(0xFF2563EB),
        tag: "Breaks",
        tagBg: Color(0xFFEFF6FF),
        tagColor: Color(0xFF2563EB),
      ),
      _RoutineItem(
        time: "All day",
        desc: "Aim for regular water intake",
        barColor: Color(0xFF2563EB),
        tag: "Hydration",
        tagBg: Color(0xFFEFF6FF),
        tagColor: Color(0xFF2563EB),
      ),
      _RoutineItem(
        time: "Evening",
        desc: "Screen-free wind-down 30 minutes before bed",
        barColor: AppColors.primaryBlue,
        tag: "Sleep",
        tagBg: Color(0xFFEEF2FF),
        tagColor: Color(0xFF4F46E5),
      ),
      _RoutineItem(
        time: "Night",
        desc: "Consistent 7–8 hour sleep window",
        barColor: AppColors.primaryBlue,
        tag: "Sleep",
        tagBg: Color(0xFFEEF2FF),
        tagColor: Color(0xFF4F46E5),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Healthy routine suggestions",
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 18),
          ...routines.map((r) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 105,
                    child: Text(
                      r.time,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  Container(
                    width: 3.5,
                    height: 20,
                    decoration: BoxDecoration(
                      color: r.barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      r.desc,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: r.tagBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      r.tag,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: r.tagColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _infoCallout(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 18,
            color: Color(0xFF1D4ED8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF1E3A8A),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineItem {
  final String time;
  final String desc;
  final Color barColor;
  final String tag;
  final Color tagBg;
  final Color tagColor;

  _RoutineItem({
    required this.time,
    required this.desc,
    required this.barColor,
    required this.tag,
    required this.tagBg,
    required this.tagColor,
  });
}

/// Light Blueprint Grid Painter for empty states
class _LightBlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1.0;

    const step = 20.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


/// Campus Assistant Screen [P3]
/// Matches ColossusIQ web UI design with Blueprint hero banner, context chips,
/// knowledge agent intro, suggestion prompt pills, agent sidebar/disclaimer, and interactive chat.
class CampusAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CampusAssistantScreen({super.key, this.onBack});

  @override
  State<CampusAssistantScreen> createState() => _CampusAssistantScreenState();
}

class _CampusAssistantMessage {
  final String sender; // "user" or "agent"
  final String text;
  final String? citation;
  final DateTime time;

  _CampusAssistantMessage({
    required this.sender,
    required this.text,
    this.citation,
    DateTime? time,
  }) : time = time ?? DateTime.now();
}

class _CampusAssistantScreenState extends State<CampusAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<_CampusAssistantMessage> _messages = [];
  bool _isTyping = false;

  final List<Map<String, dynamic>> _suggestions = [
    {
      "icon": Icons.lightbulb_outline,
      "text": "Where is the placement office?",
    },
    {
      "icon": Icons.calendar_today_outlined,
      "text": "What is the exam application process?",
    },
    {
      "icon": Icons.trending_up_outlined,
      "text": "How can I register for sports?",
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    final query = text.trim();
    if (query.isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add(_CampusAssistantMessage(
        sender: "user",
        text: query,
      ));
      _isTyping = true;
    });

    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;
      String reply = "";
      String citation = "";

      final lower = query.toLowerCase();
      if (lower.contains("placement")) {
        reply =
            "The Central Placement & Training Cell is located in Admin Block A, 2nd Floor (Room 204). Office hours: 9:00 AM – 5:30 PM (Mon–Fri). Verified contact: placement@ait.edu.in.";
        citation = "Campus Directory & Placement Cell Guide, p. 12";
      } else if (lower.contains("exam") || lower.contains("application")) {
        reply =
            "Semester exam applications open on November 1 through the Student Portal under 'Assessments & Examinations'. Ensure all tuition dues are cleared and minimum 75% attendance criteria are met prior to hall ticket generation.";
        citation = "Academic Regulations 2024-25 §7.1";
      } else if (lower.contains("sport") || lower.contains("register")) {
        reply =
            "Registration for varsity teams and intramural sports tournaments is handled at the Directorate of Physical Education (Indoor Sports Stadium) or online via the Campus Life > Sports tab.";
        citation = "Student Welfare Handbook §9.3";
      } else {
        reply =
            "According to verified institutional documentation, Anna Institute of Technology provides accredited coursework and campus facilities under standard academic guidelines. Please consult your academic advisor for individualized exemptions.";
        citation = "Student Handbook 2024-25 §4.2";
      }

      setState(() {
        _isTyping = false;
        _messages.add(_CampusAssistantMessage(
          sender: "agent",
          text: reply,
          citation: citation,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Campus Assistant",
      category: "Campus Life",
      onBack: widget.onBack,
      badge: const AppBadge(label: "PHASE 3", tone: BadgeTone.brand),
      children: [
        // 1. Hero Glow Blueprint Banner matching Web UI
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Campus Assistant",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          icon: Icons.school_outlined,
          watermarkIcon: Icons.school_outlined,
          title: "Campus Assistant",
          subtitle: "Ask anything about your campus — answered from institution-approved sources.",
        ),
        const SizedBox(height: 18),

        // 2. Context Row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.hub_outlined, size: 14, color: AppColors.ink3),
                  const SizedBox(width: 5),
                  Text(
                    "CONTEXT",
                    style: GoogleFonts.poppins(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink3,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  "Knowledge base: 8 approved documents",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Text(
                  "Campus: Main",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.ink2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // 3. Knowledge Agent Greeting Box
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bot avatar
            Container(
              width: 36,
              height: 36,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.smart_toy_outlined, color: Color(0xFFE5B84A), size: 19),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF162044).withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Knowledge Agent",
                      style: GoogleFonts.poppins(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(fontSize: 13, color: AppColors.ink2, height: 1.45),
                        children: const [
                          TextSpan(text: "Ask me anything about Anna Institute of Technology. I answer from "),
                          TextSpan(
                            text: "institution-approved sources",
                            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF1B2233)),
                          ),
                          TextSpan(text: " and cite them."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // 4. Suggested Prompts Cards
        Padding(
          padding: const EdgeInsets.only(left: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _suggestions.map((s) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => _sendMessage(s["text"] as String),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF162044).withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(s["icon"] as IconData, size: 16, color: const Color(0xFF4A5BD4)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            s["text"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: AppColors.ink,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF9CA3AF)),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // 5. Chat History (if user interacted)
        if (_messages.isNotEmpty) ...[
          const SizedBox(height: 12),
          ..._messages.map((m) {
            final isUser = m.sender == "user";
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isUser) ...[
                    Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(top: 2, right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.smart_toy_outlined, color: Color(0xFFE5B84A), size: 16),
                      ),
                    ),
                  ],
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isUser ? AppColors.primaryBlue : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: isUser ? null : Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.text,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: isUser ? Colors.white : AppColors.ink,
                              height: 1.45,
                            ),
                          ),
                          if (m.citation != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0ECF8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "Institution source: ${m.citation!}",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1D5FA8),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],

        if (_isTyping) ...[
          Padding(
            padding: const EdgeInsets.only(left: 44, bottom: 12),
            child: Row(
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryBlue),
                ),
                const SizedBox(width: 8),
                Text(
                  "Knowledge Agent is retrieving verified sources...",
                  style: GoogleFonts.poppins(fontSize: 11.5, color: AppColors.ink3),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 14),

        // 6. Side Cards (Agent Info & Disclaimer from Screenshot 1 right panel)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AGENT",
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink3,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Knowledge Agent",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Institution-specific RAG assistant with source citations.",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: AppColors.ink2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 7. Sky Notice Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1FC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 18, color: Color(0xFF1D5FA8)),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B), height: 1.45),
                    children: const [
                      TextSpan(text: "Answers marked "),
                      TextSpan(
                        text: "Institution source",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            " come from approved documents. Everything else is a general AI explanation — verify before relying on it.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 8. Bottom Message Input Bar matching screenshot
        Container(
          padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF162044).withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  onSubmitted: _sendMessage,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(fontSize: 13.5, color: AppColors.ink),
                  decoration: InputDecoration(
                    hintText: "Message Knowledge Agent...",
                    hintStyle: GoogleFonts.poppins(fontSize: 13.5, color: const Color(0xFF9CA3AF)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _sendMessage(_messageController.text),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0ECF8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.send_rounded, size: 17, color: Color(0xFF1D5FA8)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),

        // 9. Input Footer Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Enter to send · Shift+Enter for a new line · Don't share passwords or personal IDs",
                  style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF9CA3AF)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${_messageController.text.length}/2000",
                style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF9CA3AF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// Alumni Network Screen [P3]
/// Matches ColossusIQ web UI design with Blueprint hero banner, filter search bar,
/// "Request mentorship" action, and notebook grid empty state / verified alumni cards.
/// ─────────────────────────────────────────────────────────────────────────────
/// Alumni Network Screen [P3] (Images 2, 3, 4)
/// ─────────────────────────────────────────────────────────────────────────────
class AlumniNetworkScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AlumniNetworkScreen({super.key, this.onBack});

  @override
  State<AlumniNetworkScreen> createState() => _AlumniNetworkScreenState();
}

class _AlumniNetworkScreenState extends State<AlumniNetworkScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTab = 0; // 0 = Alumni Mentors, 1 = My Mentorship Requests
  String _selectedTopic = "All Topics";
  bool _availableOnly = false;

  final List<Map<String, dynamic>> _mentors = [
    {
      "id": "1",
      "initials": "AK",
      "name": "Anand Kumar",
      "location": "Hyderabad, India",
      "batch": "Batch 2019",
      "degree": "B.E. Computer Science & Engineering",
      "role": "Tech Lead",
      "company": "Microsoft",
      "topic": "Mock Interviews & System Design",
      "topicBg": Color(0xFFEEF2FF),
      "topicColor": Color(0xFF4F46E5),
      "score": 94,
      "available": true,
    },
    {
      "id": "2",
      "initials": "RS",
      "name": "Revathi Srinivasan",
      "location": "Bengaluru, India",
      "batch": "Batch 2019",
      "degree": "B.E. Computer Science & Engineering",
      "role": "Tech Lead",
      "company": "IBM",
      "topic": "Placement Prep",
      "topicBg": Color(0xFFECFDF5),
      "topicColor": Color(0xFF059669),
      "score": 94,
      "available": true,
    },
    {
      "id": "3",
      "initials": "RI",
      "name": "Rohan Iyer",
      "location": "Bengaluru / Singapore",
      "batch": "Batch 2022",
      "degree": "B.Tech Information Technology",
      "role": "Data Scientist",
      "company": "Google",
      "topic": "ML & Analytics Career Guidance",
      "topicBg": Color(0xFFEFF6FF),
      "topicColor": Color(0xFF2563EB),
      "score": 94,
      "available": true,
    },
    {
      "id": "4",
      "initials": "KS",
      "name": "Karthik Sharma",
      "location": "Bengaluru, India",
      "batch": "Batch 2021",
      "degree": "B.E. Computer Science & Engineering",
      "role": "System Analyst",
      "company": "Microsoft",
      "topic": "Placement Prep",
      "topicBg": Color(0xFFECFDF5),
      "topicColor": Color(0xFF059669),
      "score": 90,
      "available": true,
    },
    {
      "id": "5",
      "initials": "PH",
      "name": "Pooja Hegde",
      "location": "Chennai, India",
      "batch": "Batch 2020",
      "degree": "B.Tech Information Technology",
      "role": "Senior Frontend Engineer",
      "company": "Zoho Corporation",
      "topic": "Placement Prep",
      "topicBg": Color(0xFFECFDF5),
      "topicColor": Color(0xFF059669),
      "score": 90,
      "available": true,
    },
    {
      "id": "6",
      "initials": "NS",
      "name": "Nikhil Sharma",
      "location": "Bengaluru, India",
      "batch": "Batch 2021",
      "degree": "B.E. Computer Science & Engineering",
      "role": "Data Scientist",
      "company": "Amazon",
      "topic": "Resume Review & Startups",
      "topicBg": Color(0xFFFFFBEB),
      "topicColor": Color(0xFFD97706),
      "score": 88,
      "available": true,
    },
    {
      "id": "7",
      "initials": "MV",
      "name": "Meera Varma",
      "location": "Pune, India",
      "batch": "Batch 2020",
      "degree": "B.E. Computer Science & Engineering",
      "role": "Product Manager",
      "company": "Flipkart",
      "topic": "Product Management & Strategy",
      "topicBg": Color(0xFFF3E8FF),
      "topicColor": Color(0xFF7C3AED),
      "score": 86,
      "available": true,
    },
    {
      "id": "8",
      "initials": "SB",
      "name": "Sanjay Balaji",
      "location": "Chennai, India",
      "batch": "Batch 2018",
      "degree": "B.E. Computer Science & Engineering",
      "role": "Engineering Manager",
      "company": "Cisco",
      "topic": "Cloud Architecture & Networking",
      "topicBg": Color(0xFFEFF6FF),
      "topicColor": Color(0xFF2563EB),
      "score": 85,
      "available": true,
    },
  ];

  final List<Map<String, dynamic>> _myRequests = [
    {
      "id": "req-1",
      "mentorName": "Anand Kumar",
      "mentorCompany": "Microsoft",
      "status": "Pending",
      "topic": "Mock Interviews & System Design",
      "mode": "Virtual Call",
      "date": "8 Oct 2026",
      "goals":
          "Share your goals (e.g. preparing for technical interview, reviewing resume, or transitioning to data science)...",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showRequestMentorshipDialog([Map<String, dynamic>? preselectedMentor]) {
    final mentor = preselectedMentor ?? _mentors.first;
    final topicOptions = const [
      "Mock Interviews & System Design",
      "Placement Prep",
      "ML & Analytics Career Guidance",
      "Resume Review & Startups",
      "Product Management & Strategy",
      "Cloud Architecture & Networking",
    ];

    String selectedTopic = (mentor["topic"] as String?) ?? topicOptions.first;
    if (!topicOptions.contains(selectedTopic)) {
      selectedTopic = topicOptions.first;
    }

    String selectedMode = "Virtual Call";
    final goalsCtrl = TextEditingController(
      text:
          "Share your goals (e.g. preparing for technical interview, reviewing resume, or transitioning to data science)...",
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Request Mentorship with ${mentor["name"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Top Profile Card (Matching Image 3)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBFBF9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFF1F0E8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${mentor["role"]} at ${mentor["company"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "${mentor["batch"]} • ${mentor["degree"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Mentorship Topic Dropdown
                    Text(
                      "Mentorship Topic",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedTopic,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                          items: topicOptions.map((t) {
                            return DropdownMenuItem<String>(
                              value: t,
                              child: Text(t, overflow: TextOverflow.ellipsis),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setDialogState(() => selectedTopic = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Preferred Mode Dropdown
                    Text(
                      "Preferred Mode",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedMode,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF64748B)),
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                          items: const [
                            DropdownMenuItem(value: "Virtual Call", child: Text("Virtual Call")),
                            DropdownMenuItem(value: "Email Guidance", child: Text("Email Guidance")),
                            DropdownMenuItem(value: "In-person Meet", child: Text("In-person Meet")),
                          ],
                          onChanged: (val) {
                            if (val != null) setDialogState(() => selectedMode = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Specific Questions or Goals
                    Text(
                      "Specific Questions or Goals",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: goalsCtrl,
                      minLines: 3,
                      maxLines: 4,
                      style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                      decoration: InputDecoration(
                        hintText: "Share your goals (e.g. preparing for technical interview, reviewing resume, or transitioning to data science)...",
                        hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Color(0xFF2E2C9B), width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirmation Note Box (Matching Image 3)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        "✓ Once submitted, your request is forwarded to the mentor and saved in your institution's alumni mentorship pipeline.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                          height: 1.45,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Footer Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E293B),
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E2C9B),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            setState(() {
                              _myRequests.insert(0, {
                                "id": "req-${DateTime.now().millisecondsSinceEpoch}",
                                "mentorName": mentor["name"],
                                "mentorCompany": mentor["company"],
                                "status": "Pending",
                                "topic": selectedTopic,
                                "mode": selectedMode,
                                "date": "Today, 8 Oct 2026",
                                "goals": goalsCtrl.text.trim(),
                              });
                              _selectedTab = 1; // switch to requests tab
                            });

                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Mentorship request sent to ${mentor["name"]}!"),
                                backgroundColor: const Color(0xFF10B981),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Text(
                            "Send Request",
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _cancelRequest(Map<String, dynamic> req) {
    setState(() {
      _myRequests.remove(req);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Mentorship request to ${req["mentorName"]} cancelled."),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();

    final filteredMentors = _mentors.where((m) {
      final matchesQuery = query.isEmpty ||
          (m["name"] as String).toLowerCase().contains(query) ||
          (m["company"] as String).toLowerCase().contains(query) ||
          (m["role"] as String).toLowerCase().contains(query) ||
          (m["topic"] as String).toLowerCase().contains(query);

      final matchesTopic = _selectedTopic == "All Topics" || m["topic"] == _selectedTopic;
      final matchesAvail = !_availableOnly || m["available"] == true;

      return matchesQuery && matchesTopic && matchesAvail;
    }).toList();

    return PortalPageBody(
      title: "Alumni Network",
      category: "Campus Life",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner (Matching Image 2)
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Campus Life  ›  Alumni Network",
          category: "CAMPUS LIFE",
          phase: "Phase 3",
          isMvp: false,
          icon: Icons.chair_alt_outlined,
          title: "Alumni Network",
          subtitle: "Mentors, speakers, recruiters and project advisors matched to your goals.",
          watermarkIcon: Icons.chair_alt_outlined,
        ),
        const SizedBox(height: 20),

        // 2. 4 Stat KPI Cards (Matching Image 2)
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            if (w > 860) {
              return Row(
                children: [
                  Expanded(child: _buildKpiCard("Alumni Mentors", "8", "Verified alumni directory", Icons.people_outline_rounded, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                  const SizedBox(width: 14),
                  Expanded(child: _buildKpiCard("Available Now", "8", "Taking new mentees", Icons.person_pin_circle_outlined, const Color(0xFFECFDF5), const Color(0xFF059669))),
                  const SizedBox(width: 14),
                  Expanded(child: _buildKpiCard("My Requests", "${_myRequests.length}", "0 accepted", Icons.chat_bubble_outline_rounded, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                  const SizedBox(width: 14),
                  Expanded(child: _buildKpiCard("Top Employers", "Microsoft, IBM, Google", "Hiring partner alumni", Icons.business_center_outlined, const Color(0xFFFFFBEB), const Color(0xFFD97706), isTextValue: true)),
                ],
              );
            } else if (w > 500) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildKpiCard("Alumni Mentors", "8", "Verified alumni directory", Icons.people_outline_rounded, const Color(0xFFEEF2FF), const Color(0xFF4F46E5))),
                      const SizedBox(width: 14),
                      Expanded(child: _buildKpiCard("Available Now", "8", "Taking new mentees", Icons.person_pin_circle_outlined, const Color(0xFFECFDF5), const Color(0xFF059669))),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _buildKpiCard("My Requests", "${_myRequests.length}", "0 accepted", Icons.chat_bubble_outline_rounded, const Color(0xFFEFF6FF), const Color(0xFF2563EB))),
                      const SizedBox(width: 14),
                      Expanded(child: _buildKpiCard("Top Employers", "Microsoft, IBM, Google", "Hiring partner alumni", Icons.business_center_outlined, const Color(0xFFFFFBEB), const Color(0xFFD97706), isTextValue: true)),
                    ],
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildKpiCard("Alumni Mentors", "8", "Verified alumni directory", Icons.people_outline_rounded, const Color(0xFFEEF2FF), const Color(0xFF4F46E5)),
                  const SizedBox(height: 12),
                  _buildKpiCard("Available Now", "8", "Taking new mentees", Icons.person_pin_circle_outlined, const Color(0xFFECFDF5), const Color(0xFF059669)),
                  const SizedBox(height: 12),
                  _buildKpiCard("My Requests", "${_myRequests.length}", "0 accepted", Icons.chat_bubble_outline_rounded, const Color(0xFFEFF6FF), const Color(0xFF2563EB)),
                  const SizedBox(height: 12),
                  _buildKpiCard("Top Employers", "Microsoft, IBM, Google", "Hiring partner alumni", Icons.business_center_outlined, const Color(0xFFFFFBEB), const Color(0xFFD97706), isTextValue: true),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 20),

        // 3. Tab Pills (Matching Images 2 & 4 - Overflow Safe)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildTabPill(0, "Alumni Mentors", "8"),
              const SizedBox(width: 10),
              _buildTabPill(1, "My Mentorship Requests", "${_myRequests.length}"),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 4. Tab Body
        if (_selectedTab == 0) ...[
          // Search & Filter Card (Fully Adaptive & Overflow Safe)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 1060;
                final isMedium = constraints.maxWidth >= 640;

                final searchField = Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
                          decoration: InputDecoration(
                            hintText: "Search alumni network...",
                            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        GestureDetector(
                          onTap: () => setState(() => _searchController.clear()),
                          child: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                        ),
                    ],
                  ),
                );

                final topicDropdown = Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedTopic,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                      style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                      items: const [
                        DropdownMenuItem(value: "All Topics", child: Text("All Topics", overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: "Mock Interviews & System Design", child: Text("Mock Interviews & System Design", overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: "Placement Prep", child: Text("Placement Prep", overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: "ML & Analytics Career Guidance", child: Text("ML & Analytics Career Guidance", overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: "Resume Review & Startups", child: Text("Resume Review & Startups", overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: "Product Management & Strategy", child: Text("Product Management & Strategy", overflow: TextOverflow.ellipsis)),
                        DropdownMenuItem(value: "Cloud Architecture & Networking", child: Text("Cloud Architecture & Networking", overflow: TextOverflow.ellipsis)),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedTopic = val);
                      },
                    ),
                  ),
                );

                final availCheckbox = InkWell(
                  onTap: () => setState(() => _availableOnly = !_availableOnly),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _availableOnly,
                        onChanged: (v) => setState(() => _availableOnly = v ?? false),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        activeColor: const Color(0xFF2E2C9B),
                      ),
                      Text(
                        "Available only",
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155)),
                      ),
                    ],
                  ),
                );

                final requestBtn = ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E2C9B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _showRequestMentorshipDialog(),
                  child: Text(
                    "Request mentorship",
                    style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                );

                if (isWide) {
                  return Row(
                    children: [
                      Expanded(child: searchField),
                      const SizedBox(width: 12),
                      SizedBox(width: 260, child: topicDropdown),
                      const SizedBox(width: 8),
                      availCheckbox,
                      const SizedBox(width: 12),
                      requestBtn,
                    ],
                  );
                }

                if (isMedium) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      searchField,
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: topicDropdown),
                          const SizedBox(width: 10),
                          availCheckbox,
                          const SizedBox(width: 12),
                          requestBtn,
                        ],
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    searchField,
                    const SizedBox(height: 10),
                    topicDropdown,
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        availCheckbox,
                        requestBtn,
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Mentors Data Table Container (Matching Image 2)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                  headingTextStyle: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.5,
                  ),
                  dataRowMinHeight: 64,
                  dataRowMaxHeight: 64,
                  horizontalMargin: 20,
                  columnSpacing: 28,
                  columns: const [
                    DataColumn(label: Text("ALUMNUS / MENTOR")),
                    DataColumn(label: Text("BATCH")),
                    DataColumn(label: Text("CURRENT POSITION")),
                    DataColumn(label: Text("COMPANY")),
                    DataColumn(label: Text("CAN MENTOR IN")),
                    DataColumn(label: Text("MATCH SCORE")),
                    DataColumn(label: Text("ACTION")),
                  ],
                  rows: filteredMentors.map((m) {
                    final initials = m["initials"] as String;
                    final name = m["name"] as String;
                    final loc = m["location"] as String;
                    final batch = m["batch"] as String;
                    final role = m["role"] as String;
                    final company = m["company"] as String;
                    final topic = m["topic"] as String;
                    final topicBg = m["topicBg"] as Color;
                    final topicColor = m["topicColor"] as Color;
                    final score = m["score"] as int;

                    return DataRow(
                      cells: [
                        // ALUMNUS / MENTOR with avatar
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFFEEF2FF),
                                child: Text(
                                  initials,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF4F46E5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        loc,
                                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "LinkedIn ↗",
                                        style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF4F46E5)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // BATCH
                        DataCell(
                          Text(
                            batch,
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569)),
                          ),
                        ),
                        // CURRENT POSITION
                        DataCell(
                          Text(
                            role,
                            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569)),
                          ),
                        ),
                        // COMPANY
                        DataCell(
                          Text(
                            company,
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
                          ),
                        ),
                        // CAN MENTOR IN
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                            decoration: BoxDecoration(
                              color: topicBg,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              topic,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: topicColor,
                              ),
                            ),
                          ),
                        ),
                        // MATCH SCORE
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: LinearProgressIndicator(
                                    value: score / 100.0,
                                    minHeight: 4,
                                    backgroundColor: const Color(0xFFE2E8F0),
                                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0F766E)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "$score%",
                                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF0F766E)),
                              ),
                            ],
                          ),
                        ),
                        // ACTION
                        DataCell(
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1E293B),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            ),
                            onPressed: () => _showRequestMentorshipDialog(m),
                            child: Text(
                              "Request",
                              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ] else ...[
          // ───────────────────────────────────────────────────────────────────
          // My Mentorship Requests Tab (Matching Image 4)
          // ───────────────────────────────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 6,
              children: [
                Text(
                  "Mentorship Requests Pipeline (${_myRequests.length})",
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  "Status updates automatically with mentor response",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          if (_myRequests.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.inbox_outlined, size: 36, color: Color(0xFF94A3B8)),
                    const SizedBox(height: 8),
                    Text(
                      "No active mentorship requests",
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Browse verified alumni mentors and send a 1:1 request.",
                      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ),
            )
          else
            ..._myRequests.map((req) {
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Name + Company, Status pill, Cancel Request button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              Text(
                                req["mentorName"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                "(${req["mentorCompany"]})",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  req["status"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFD97706),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF991B1B),
                            side: const BorderSide(color: Color(0xFFFCA5A5)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                          onPressed: () => _cancelRequest(req),
                          child: Text(
                            "Cancel Request",
                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Topic · Mode · Requested date
                    Text(
                      "Topic: ${req["topic"]}   ·   Mode: ${req["mode"]}   ·   Requested: ${req["date"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Goals Quote Box (Matching Image 4)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFF1F5F9)),
                      ),
                      child: Text(
                        "\"${req["goals"]}\"",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF475569),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, String sub, IconData icon, Color iconBg, Color iconColor, {bool isTextValue = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, size: 15, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isTextValue ? 15 : 26,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
              letterSpacing: isTextValue ? 0 : -0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill(int index, String label, String badgeCount) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedTab = index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white24 : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badgeCount,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

