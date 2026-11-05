# ColossusIQ StudentApp (Flutter & Dart)

A cross-platform Flutter application replicating the **ColossusIQ Student Portal** with the **Scholar Indigo** design system.

## 🎨 Scholar Indigo Design System

Matches `frontend/src/app/globals.css` with fidelity:
- **Brand Colors**: Scholar Indigo (`#1E2A5A`), Brand 2 (`#4A5BD4`), Brand Soft (`#E8EBF6`)
- **Accents**: Gold (`#C9962B`), Teal (`#0F766E`), Rose (`#B42318`), Amber (`#B45309`), Sky (`#1D5FA8`)
- **Background & Surfaces**: Warm Notebook Cream (`#FAF8F3`), Surface White (`#FFFFFF`), Border Line (`#E4DFD3`)
- **Typography**: Google Fonts **Poppins** for headings & body, **JetBrains Mono** for codes, metrics & timestamps.
- **Components**: `AppCard`, `AppBadge`, `AppLinearProgress`, `CircularScoreRing`, `PortalHeader`, and `EmptyStateWidget`.

---

## 📱 Implemented Student Screens

1. **Student Dashboard / Command Center** (`lib/screens/home/student_home_screen.dart`):
   - Personal AI Mentor recommendation callout with high-priority action cards
   - Daily learning streak, XP counter, and exam countdown timer
   - Readiness cards (Academic progress, Technical & Communication skills, Career readiness)
   - Today's routine timetable with schedule badges and location tags
   - Active Capstone project tracker with milestone progress bar
   - Upcoming deadlines list (exams, hackathons, lab submissions)
   - Weak topics to fix with instant adaptive test button

2. **My Courses & Lessons** (`lib/screens/courses/courses_screen.dart`):
   - 4-step learning journey roadmap
   - Department filters (All, CSE, AI&DS)
   - Course cards with Brand Gradient headers, progress indicators, and credits
   - **Course Reader Screen** (`course_reader_screen.dart`) with interactive unit accordion, lesson reader, completion toggles, and 30-question final assessment gateway

3. **Class Notes & Handouts** (`lib/screens/notes/class_notes_screen.dart`):
   - Timeline of faculty post-class summaries
   - Department filters & unread counter badge
   - Topic takeaways, assigned homework tasks, and downloadable handout resources

4. **Mock Tests & Department Quizzes** (`lib/screens/assessments/assessments_screen.dart`):
   - Adaptive mock tests and department quizzes
   - Certificate grade scale reference card (O, A+, A, B)
   - **Test Player Screen** (`test_player_screen.dart`) with live timer, question pagination, radio options, and instant AI tutor rationale feedback

5. **Placement Readiness** (`lib/screens/placement/placement_screen.dart`):
   - 100-point circular score ring ("Almost ready" / "Placement ready")
   - 5 weighted placement dimension progress bars (Quizzes, Certifications, Aptitude, Mock Interview, Resume)
   - Recruitment drive eligibility checklist with status tags

6. **My Certificates** (`lib/screens/certificates/certificates_screen.dart`):
   - Verifiable achievement certificates with gold ribbons and letter grades (O, A+, A)
   - View & Verify modal dialog with ColossusIQ gold seal, score, grade, and verifiable ID
   - Shareable verification link copy action

7. **Persistent AI Academic Mentor** (`lib/screens/mentor/mentor_chat_screen.dart`):
   - Persistent conversational interface with AI tutor
   - Quick prompt suggestion chips
   - Student Intelligence Profile modal drawer (live GPA, weak areas, career goal)

8. **Assignments & Submissions** (`lib/screens/assignments/assignments_screen.dart`):
   - Coursework deadlines and grading status
   - Interactive file upload & submission dialog

9. **Campus Life (Clubs & Sports)** (`lib/screens/campus/campus_life_screen.dart`):
   - Segmented tabs for Clubs and Sports tournaments
   - Membership join/leave toggles and trial registrations

10. **Portal Navigation Shell** (`lib/screens/main_navigation_screen.dart`):
    - Top Scholar Indigo `PortalHeader` with notification drawer
    - Responsive Bottom Navigation Bar
    - Full Student Portal Drawer accessing all features

---

## 🚀 Running the App

```bash
# Get dependencies
flutter pub get

# Check analyzer
flutter analyze

# Run tests
flutter test

# Run application on an emulator or browser/desktop
flutter run
```
