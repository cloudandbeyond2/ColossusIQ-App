# StudentApp — Dedicated ColossusIQ Higher-Education OS

A dedicated, standalone Flutter application containing **only** Student screens, modules, and workflows with the exact design system, colors, typography, components, and animations of ColossusIQ.

---

## 📱 Application Structure & Modules

### 1. Main Navigation Architecture
- **Header (`PortalHeader`)**:
  - Interactive top bar with breadcrumbs and portal status (`ColossusIQ` · `Student Portal · Scholar Indigo`).
  - Student Profile popup with verified MFA badge, quick details, and sign out flow.
  - Interactive Notifications sheet displaying recent student alerts.
  - Hamburger drawer menu trigger.
- **Bottom Navigation Bar (`PortalBottomNav`)**:
  - **Tab 0: Home** (`StudentHomeScreen`): AI Mentor hero banner, daily routine timeline, 3 KPI stats, readiness cards (Academic, Skills, Career), upcoming deadlines, and weak topic remediation.
  - **Tab 1: My Courses** (`CoursesScreen`): Enrolled subjects, syllabus units, completed lessons count, interactive Course Reader (`CourseReaderScreen`) with lesson checkpoints.
  - **Tab 2: Class Notes** (`ClassNotesScreen`): Unit-wise class notes, teacher takeaways, homework pointers, and infographic summaries.
  - **Tab 3: Assignments** (`AssignmentsScreen`): Active, submitted, and graded homework with interactive file upload modals and deadline countdowns.
  - **Tab 4: Profile** (`ProfileScreen`): Student digital identity, CGPA (8.74), attendance (89%), semester timeline, credentials, and settings.

### 2. Comprehensive Student Portal Drawer
Slide-in animated dark drawer (`#13193A`) providing direct access to all 11 student functional areas:
1. **OVERVIEW**
   - **Fees & Payments** (`StudentFeesScreen`): Semester fee breakdown, online payment gateway simulator, and payment receipts.
   - **Notice Board** (`NoticeBoardScreen`): Campus announcements, urgent exams notices, and circulars.
2. **STUDENT SUCCESS**
   - **AI Mentor** (`MentorChatScreen`): Real-time chat with AI study mentor for DBMS, OS, and algorithms.
   - **AI Study Planner** (`CareerPlannerScreen`): Structured study plans, milestone tracking, and daily schedule builder.
   - **Daily Routine** (`CareerReadinessScreen`): Daily schedule breakdown and routine optimizer.
   - **Academic Tracker** (`AssessmentsScreen`): Continuous internal assessment grades and GPA projections.
   - **Skill Graph** (`PlacementScreen`): Radar and bar breakdown of technical, cognitive, and interpersonal competencies.
   - **Mission Planner** (`CareerPlannerScreen`): Long-term career targets and goal milestones.
   - **AI Study Twin** (`MentorChatScreen`): Personalized AI learning twin trained on student syllabus.
   - **Digital Student Passport** (`CertificatesScreen`): Cryptographically verifiable credentials and skill badges.
3. **ACADEMICS**
   - **My Courses** (`CoursesScreen`)
   - **Class Notes** (`ClassNotesScreen`)
   - **Academic Calendar** (`AcademicCalendarScreen`): Month and timeline views of exams, holidays, and college events.
   - **Assignments** (`AssignmentsScreen`)
   - **Document AI** (`ExamPrepScreen`): AI syllabus summarization and question extraction.
4. **ASSESSMENT**
   - **Mock Tests** (`AssessmentsScreen` & `TestPlayerScreen`): Timed tests with multiple-choice questions, instant scoring, and review.
   - **Exam Preparation** (`ExamPrepScreen`): Exam countdowns, topic checklists, and formula sheets.
   - **Handwritten Evaluation** (`HandwrittenEvaluationScreen`): Upload assignment photo for automated rubrics assessment.
   - **Viva Simulator** (`VivaSimulatorScreen`): AI voice viva simulator with mock oral examinations.
   - **Competitive Exams** (`CompetitiveExamsScreen`): GATE, GRE, CAT, and PSU preparation tracks.
5. **AI COURSE & CERTIFICATION**
   - **My Quizzes** (`MyQuizzesScreen`): Department and campus-wide skill assessments.
   - **My Certificates** (`CertificatesScreen`): Issued certificates with QR verification dialogs.
6. **CAREER**
   - **Career Planner & Twin** (`CareerPlannerScreen`)
   - **Resume Builder** (`ResumeBuilderScreen`): ATS-optimized resume generator with instant preview.
   - **Job Preparation** (`JobPrepScreen`): Tech stack questions, DSA roadmaps, and company patterns.
   - **AI Mock Interview** (`MockInterviewScreen`): Role-based interview simulations with immediate feedback.
   - **Opportunity Marketplace** (`OpportunityMarketplaceScreen`): Campus internships and entry-level openings.
   - **Career Readiness** (`CareerReadinessScreen`)
   - **Placement Readiness** (`PlacementScreen`)
7. **COMMUNICATION & SKILLS**
   - **Communication Lab** (`CommunicationLabScreen`): Pitch practice, vocabulary trainer, and voice analytics.
   - **GD & Debate Simulator** (`GdSimulatorScreen`): Group discussion AI simulator with topic arguments.
   - **Language Learning** (`LanguageLearningScreen`): Multilingual proficiency practice modules.
   - **Certification Roadmap** (`CertificationRoadmapScreen`): Step-by-step external certification pathways (AWS, Google Cloud, Cisco).
8. **PROJECT & INNOVATION**
   - **Project Hub** (`ProjectHubScreen`): Capstone project repository, milestones, and AI architecture evaluator.
   - **Project Idea Generator** (`ProjectIdeaGeneratorScreen`): AI generator for high-impact final year projects.
   - **Team Finder** (`TeamFinderScreen`): Match with cross-department peers based on tech skills.
   - **Startup Idea Hub** (`StartupIdeaHubScreen`): Venture validation, lean canvas builder, and incubation links.
   - **Research Assistant** (`ResearchAssistantScreen`): Literature review search, paper outlining, and citation manager.
   - **Hackathon Hub** (`HackathonHubScreen`): Team assembly, SIH tracking, and hackathon alerts.
9. **CAMPUS LIFE**
   - **Campus Events** (`CampusEventsScreen`): Cultural, technical, and sports event registrations.
   - **Clubs** (`ClubsScreen`): IEEE, ACM, Rotaract, and Coding club activities.
   - **Sports** (`SportsScreen`): Inter-college tournament schedules, team tryouts, and ground bookings.
   - **Campus Assistant** (`CampusAssistantScreen`): Campus navigation, facility timings, and FAQ bot.
   - **Alumni Network** (`AlumniNetworkScreen`): Connect with alumni mentors working in top tech companies.
10. **DEPARTMENT**
    - **Department Portal** (`DepartmentPortalScreen`): Department news, lab schedules, faculty office hours, and resources.
11. **PLACEMENT**
    - **Job Matching** (`JobMatchingScreen`): Role-fit percentage calculation, eligibility filters, and application tracking.

---

## 🚀 Running the App

Navigate to the project root:
```bash
cd d:\StudentApp\student_portal
```

### Run on Windows Desktop:
```bash
flutter run -d windows
```

### Run on Chrome (Web):
```bash
flutter run -d chrome
```

### Run on Android Device / Emulator:
```bash
flutter run -d android
```

### Run Analyzer & Tests:
```bash
flutter analyze
flutter test
```
