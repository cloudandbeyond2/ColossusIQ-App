import 'package:flutter/foundation.dart';
import 'models/student_model.dart';
import 'models/course_model.dart';
import 'models/note_model.dart';
import 'models/assessment_model.dart';
import 'models/placement_model.dart';

class MockData {
  static final ValueNotifier<int> courseUpdateNotifier = ValueNotifier<int>(0);

  static Course getCourse(String courseId) {
    return courses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => courses.first,
    );
  }

  static void markLessonComplete(String courseId, String lessonId) {
    final cIndex = courses.indexWhere((c) => c.id == courseId);
    if (cIndex == -1) return;
    final course = courses[cIndex];

    final updatedUnits = course.units.map((u) {
      final updatedLessons = u.lessons.map((l) {
        if (l.id == lessonId) {
          return l.copyWith(isCompleted: true);
        }
        return l;
      }).toList();
      return CourseUnit(
        id: u.id,
        title: u.title,
        part: u.part,
        lessons: updatedLessons,
      );
    }).toList();

    int count = 0;
    for (final u in updatedUnits) {
      for (final l in u.lessons) {
        if (l.isCompleted) count++;
      }
    }

    courses[cIndex] = course.copyWith(
      completedLessons: count,
      finalUnlocked: count >= course.totalLessons,
      units: updatedUnits,
    );

    courseUpdateNotifier.value++;
  }
  static const StudentDashboardData studentDashboard = StudentDashboardData(
    name: "Anand R",
    department: "Computer Science & Engineering",
    semester: "Semester 5 · B.E.",
    rollNo: "22CS104",
    streak: 14,
    xp: 2450,
    priorities: 3,
    cgpa: 8.84,
    attendance: 94.2,
    completedCredits: 104,
    totalCredits: 160,
    aiRecommendation:
        "Focus on **Lossless-Join Decomposition** in DBMS before tomorrow's IA-II. You also have 1 mock test pending for Operating Systems (Deadlocks).",
    examCountdown: ExamCountdown(
      exam: "DBMS Internal Assessment II",
      days: 9,
      syllabusCovered: 76,
    ),
    semesterProgress: 72,
    examReadiness: 64,
    technicalSkills: 71,
    communicationSkills: 65,
    interviewSkills: 48,
    careerReadiness: 74,
    projectName: "Smart Campus AI & Autonomous Attendance",
    projectProgress: 68,
    today: [
      TodayScheduleItem(
        time: "09:00 AM",
        title: "CS3451 Database Management Systems — Normalization & BCNF",
        kind: "class",
        room: "Hall 302",
      ),
      TodayScheduleItem(
        time: "11:30 AM",
        title: "CS3461 Operating Systems Lab — Thread Synchronization",
        kind: "class",
        room: "Lab 4",
      ),
      TodayScheduleItem(
        time: "02:00 PM",
        title: "Smart Campus AI Sprint Review (Milestone 3)",
        kind: "project",
        room: "Incubation Cell",
      ),
      TodayScheduleItem(
        time: "04:30 PM",
        title: "Competitive Coding Practice · Dynamic Programming",
        kind: "study",
        room: "Library Lab",
      ),
    ],
    upcoming: [
      UpcomingDeadline(
        title: "DBMS IA-II Exam",
        when: "in 9 days",
        tag: "Exam",
      ),
      UpcomingDeadline(
        title: "Smart India Hackathon Internal Round",
        when: "Friday, 2:00 PM",
        tag: "Hackathon",
      ),
      UpcomingDeadline(
        title: "Operating Systems Assignment 3 Submission",
        when: "Sunday, 11:59 PM",
        tag: "Assignment",
      ),
      UpcomingDeadline(
        title: "Campus AI Buildathon Presentation",
        when: "Oct 21",
        tag: "Project",
      ),
    ],
    weakTopics: [
      WeakTopic(
        subject: "DBMS",
        topic: "Lossless-Join & Dependency Preservation",
        mastery: 42,
      ),
      WeakTopic(
        subject: "DBMS",
        topic: "BCNF Decomposition Algorithm",
        mastery: 48,
      ),
      WeakTopic(
        subject: "OS",
        topic: "Dining Philosophers & Semaphore Sync",
        mastery: 55,
      ),
    ],
  );

  static final List<Course> courses = [
    Course(
      id: "LC-WT106",
      code: "CSE106",
      title: "Web Technologies",
      department: "Computer Science & Engineering",
      facultyName: "Dr. Meena Raghavan",
      term: "Term 1",
      credits: 3,
      summary:
          "Web Technologies for Computer Science & Engineering students: 18 lessons in 8 chapters, followed by a 30-question final assessment.",
      totalChapters: 8,
      totalLessons: 18,
      hours: "~5 h",
      completedLessons: 2,
      finalUnlocked: false,
      units: [
        CourseUnit(
          id: "WT-U0",
          title: "Getting started",
          part: "Start here",
          lessons: [
            Lesson(
              id: "WT-L1",
              title: "Welcome to Web Technologies",
              duration: "10m",
              layoutKind: "overview",
              chapterTitle: "Getting started",
              chapterPart: "Start here",
              chapterIndex: 0,
              isCompleted: true,
              objectives: [
                "See how the course is organised",
                "Know how lessons, practice and the final assessment fit together",
                "Plan your study time",
              ],
              body:
                  "Web Technologies is offered by the Department of Computer Science & Engineering. It has 8 chapters, followed by revision and a final assessment.\n\n### How each chapter works\n1. **Key concepts** — the ideas, the key points and the vocabulary, with a concept map.\n2. **Practice & recap** — questions with model answers and a checklist of what you should now know.\n\n### Final assessment and certificate\nWhen every lesson is complete, a 30-question final assessment unlocks. Pass it to earn a certificate graded by your marks.",
              keyPoints: [
                "Each chapter moves from concepts to practice and recap.",
                "The final assessment unlocks after every lesson is complete.",
                "Certificates are graded by verified assessment scores.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U1",
          title: "Introduction to Web Technologies",
          part: "Chapter 1",
          lessons: [
            Lesson(
              id: "WT-L2",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Introduction to Web Technologies",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: true,
              objectives: [
                "Understand the architecture of the World Wide Web and HTTP/HTTPS protocol",
                "Differentiate between client-side rendering and server-side execution",
                "Explain the role of HTML, CSS, and JavaScript in modern web development",
              ],
              body:
                  "The web operates as a distributed client-server information system. Web clients (browsers) request resources via uniform resource identifiers (URIs) over HTTP/HTTPS, which web servers resolve and return.\n\n### Core Pillars\n1. **Structure (HTML5)** — Semantic element tree defining document hierarchy and data accessibility.\n2. **Presentation (CSS3)** — Box model, flexbox, CSS grid, and responsive media queries.\n3. **Behavior (JavaScript ES6+)** — Event loop, DOM tree mutation, asynchronous fetch requests, and state management.",
              keyPoints: [
                "HTTP is stateless; cookies, sessions, and JWT tokens maintain conversation state.",
                "DOM (Document Object Model) is an in-memory tree representation of the rendered document.",
                "HTTPS secures transmission using TLS/SSL certificate encryption and handshake verification.",
              ],
            ),
            Lesson(
              id: "WT-L3",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Introduction to Web Technologies",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: false,
              objectives: [
                "Check your understanding of Introduction to Web Technologies",
                "Recall the key points without notes",
              ],
              body:
                  "Review the core concepts of client-server HTTP transactions, DOM parsing, and web standards before advancing.",
              keyPoints: [
                "Explain Introduction to Web Technologies in your own words.",
                "Give an example of Introduction to Web Technologies from Computer Science & Engineering.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U2",
          title: "Basic Concepts & Terminology",
          part: "Chapter 2",
          lessons: [
            Lesson(
              id: "WT-L4",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Basic Concepts & Terminology",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              objectives: [
                "Master DNS resolution, IP routing, and port addressing",
                "Understand MIME types, headers, status codes, and payload formats",
              ],
              body:
                  "Every web transaction begins with DNS resolution converting hostnames into IP addresses. The browser then negotiates a TCP three-way handshake before transmitting HTTP request headers.\n\n### HTTP Status Codes\n• 2xx (Success): 200 OK, 201 Created\n• 3xx (Redirection): 301 Moved Permanently, 304 Not Modified\n• 4xx (Client Error): 400 Bad Request, 401 Unauthorized, 404 Not Found\n• 5xx (Server Error): 500 Internal Server Error, 503 Service Unavailable",
              keyPoints: [
                "DNS caching minimizes lookup latency across resolver, ISP, and OS levels.",
                "HTTP headers declare content-type, encoding, cache policies, and authorization credentials.",
              ],
            ),
            Lesson(
              id: "WT-L5",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Basic Concepts & Terminology",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              objectives: [
                "Check understanding of DNS, HTTP status codes, and web headers",
                "Recall status code ranges without notes",
              ],
              body:
                  "Test your recall on client-server negotiation and status code semantics.",
              keyPoints: [
                "Explain the role of DNS in web connectivity.",
                "Contrast HTTP 301 vs 302 vs 304 redirections.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U3",
          title: "Core Principles of Web Technologies",
          part: "Chapter 3",
          lessons: [
            Lesson(
              id: "WT-L6",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Core Principles of Web Technologies",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              objectives: [
                "Learn asynchronous JavaScript, Promises, and async/await",
                "Understand event propagation: capturing, targeting, and bubbling phases",
              ],
              body:
                  "JavaScript runs on a single-threaded event loop model. Non-blocking operations (I/O, network requests, timers) delegate tasks to web APIs and queue callbacks in the microtask queue.",
              keyPoints: [
                "Event bubbling triggers parent handlers unless event.stopPropagation() is called.",
                "Promises avoid callback hell by chaining .then() or using async/await syntax.",
              ],
            ),
            Lesson(
              id: "WT-L7",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Core Principles of Web Technologies",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              objectives: [
                "Check your understanding of event loops and asynchronous execution",
                "Recall promise states and microtask scheduling",
              ],
              body:
                  "Solve event bubbling scenarios and async task order problems.",
              keyPoints: [
                "Trace execution order of setTimeout vs Promise.resolve() in JavaScript.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U4",
          title: "Methods & Techniques",
          part: "Chapter 4",
          lessons: [
            Lesson(
              id: "WT-L8",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Methods & Techniques",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              objectives: [
                "Explore REST architectural constraints and resource URI naming",
                "Understand CORS (Cross-Origin Resource Sharing) headers and preflight OPTIONS",
              ],
              body:
                  "REST (Representational State Transfer) utilizes standard HTTP verbs (GET, POST, PUT, PATCH, DELETE) to manipulate stateless resources represented in JSON.",
              keyPoints: [
                "Idempotent methods (GET, PUT, DELETE) produce identical state when executed repeatedly.",
                "CORS prevents unauthorized cross-origin AJAX requests unless Access-Control-Allow-Origin is configured.",
              ],
            ),
            Lesson(
              id: "WT-L9",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Methods & Techniques",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              objectives: [
                "Validate REST API design conventions and CORS preflight rules",
              ],
              body:
                  "Formulate RESTful endpoints for an online education portal.",
              keyPoints: [
                "Differentiate PUT vs PATCH semantics.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U5",
          title: "Client-Side Scripting & DOM",
          part: "Chapter 5",
          lessons: [
            Lesson(
              id: "WT-L10",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Client-Side Scripting & DOM",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              objectives: [
                "DOM manipulation and dynamic element creation",
                "Form validation and regular expressions in browser runtime",
              ],
              body:
                  "Direct DOM querying via querySelector and element property manipulation enables interactive interfaces.",
              keyPoints: [
                "DocumentFragment minimizes reflow and repaint during bulk element insertions.",
              ],
            ),
            Lesson(
              id: "WT-L11",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Client-Side Scripting & DOM",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              objectives: [
                "Practice DOM traversal and event listeners",
              ],
              body:
                  "Write JavaScript event handlers for dynamic form validation.",
              keyPoints: [
                "Explain why separating HTML structure from JS scripts improves maintainability.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U6",
          title: "Server-Side & REST APIs",
          part: "Chapter 6",
          lessons: [
            Lesson(
              id: "WT-L12",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Server-Side & REST APIs",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              objectives: [
                "Backend runtime environments (Node.js/Express)",
                "Middleware pipelines, routing, and request body parsing",
              ],
              body:
                  "Server-side architectures handle authentication, business validation, database persistence, and payload serialization.",
              keyPoints: [
                "Middleware functions process request and response objects before calling next().",
              ],
            ),
            Lesson(
              id: "WT-L13",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Server-Side & REST APIs",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              objectives: [
                "Construct Express routes and error handling middleware",
              ],
              body:
                  "Practice building token-authenticated API endpoints.",
              keyPoints: [
                "Explain the role of JWT (JSON Web Tokens) in stateless API authentication.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U7",
          title: "Database Integration",
          part: "Chapter 7",
          lessons: [
            Lesson(
              id: "WT-L14",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Database Integration",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              objectives: [
                "Connecting web applications to relational and NoSQL databases",
                "Preventing SQL injection via parameterized queries and ORM tools",
              ],
              body:
                  "Web backends query persistent storage engines using connection pooling and transactional integrity checks.",
              keyPoints: [
                "Never concatenate raw user input into SQL queries; always use parameterized statements.",
              ],
            ),
            Lesson(
              id: "WT-L15",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Database Integration",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              objectives: [
                "Analyze web injection vulnerabilities and mitigation strategies",
              ],
              body:
                  "Review database connection pooling and schema migrations.",
              keyPoints: [
                "Explain connection pool reuse and transaction rollbacks on API failures.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "WT-U8",
          title: "Course Revision & Assessment Prep",
          part: "Chapter 8",
          lessons: [
            Lesson(
              id: "WT-L16",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Course Revision & Assessment Prep",
              chapterPart: "Chapter 8",
              chapterIndex: 8,
              objectives: [
                "Synthesize web protocols, frontend DOM, backend APIs, and security",
              ],
              body:
                  "Comprehensive summary of all 8 chapters in Web Technologies before the final exam.",
              keyPoints: [
                "Review full-stack request lifecycle from browser keystroke to database query and response.",
              ],
            ),
            Lesson(
              id: "WT-L17",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Course Revision & Assessment Prep",
              chapterPart: "Chapter 8",
              chapterIndex: 8,
              objectives: [
                "Complete sample practice assessment and checklist",
              ],
              body:
                  "Final diagnostic review to confirm readiness for the 30-question certificate assessment.",
              keyPoints: [
                "Confirm mastery of HTTP status codes, REST conventions, and asynchronous JavaScript.",
              ],
            ),
            Lesson(
              id: "WT-L18",
              title: "Final exam readiness checklist",
              duration: "10m",
              layoutKind: "revision",
              chapterTitle: "Course Revision & Assessment Prep",
              chapterPart: "Chapter 8",
              chapterIndex: 8,
              objectives: [
                "Final verification before unlocking assessment",
              ],
              body:
                  "You have completed all 18 lessons! Click below to unlock your 30-question final assessment.",
              keyPoints: [
                "All lessons verified. Good luck on your final assessment!",
              ],
            ),
          ],
        ),
      ],
    ),
    Course(
      id: "LC-OS102",
      code: "CSE102",
      title: "Operating Systems",
      department: "Computer Science & Engineering",
      facultyName: "Dr. Test",
      term: "Term 5",
      credits: 4,
      summary:
          "Operating Systems for Computer Science & Engineering students: 26 lessons in 8 chapters, followed by a revision chapter and a final assessment.",
      totalChapters: 8,
      totalLessons: 26,
      hours: "~8 h",
      completedLessons: 4,
      finalUnlocked: false,
      units: [
        CourseUnit(
          id: "U0",
          title: "Getting started",
          part: "Start here",
          lessons: [
            Lesson(
              id: "L1",
              title: "Welcome to Operating Systems",
              duration: "10m",
              layoutKind: "overview",
              chapterTitle: "Getting started",
              chapterPart: "Start here",
              chapterIndex: 0,
              isCompleted: true,
              objectives: [
                "See how the course is organised",
                "Know how lessons, practice and the final assessment fit together",
                "Plan your study time",
              ],
              body:
                  "Operating Systems is offered by the Department of Computer Science & Engineering. It has 8 chapters, shown in the course map above, followed by a revision chapter and a final assessment.\n\n### How each chapter works\n1. **Key concepts** — the ideas, the key points and the vocabulary, with a concept map.\n2. **Worked example** — the ideas applied step by step, and the mistakes students most often make.\n3. **Practice & recap** — questions with model answers and a checklist of what you should now know.\n\n### Final assessment and certificate\nWhen every lesson is complete, a 30-question final assessment unlocks. Its questions come from the key points and key terms in the lessons. Pass it to earn a certificate graded by your marks (O, A+, A, B or C).\n\n### Study tips\n• Take one lesson per sitting and finish its practice before moving on.\n• Say each key point aloud in your own words before marking a lesson complete.\n• When an idea does not click, use the **Watch & read** links in that lesson.",
              keyPoints: [
                "Each chapter moves from concepts to a worked example to practice.",
                "The final assessment unlocks after every lesson is complete.",
                "Certificates are graded O, A+, A, B or C by marks.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "U1",
          title: "Processes & Threads",
          part: "Chapter 1",
          lessons: [
            Lesson(
              id: "L2",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Processes & Threads",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: true,
              objectives: [
                "Explain process lifecycle (New, Ready, Running, Waiting, Terminated)",
                "Contrast process control blocks (PCB) with thread control blocks",
                "Differentiate user-level and kernel-level thread architectures",
              ],
              body:
                  "A process is a program in execution containing program code, counter, registers, and memory spaces (stack, heap, data).\n\n### Key Principles\n1. **Process Control Block (PCB)** stores PID, CPU registers, program counter, and memory limits.\n2. **Context Switching** saves current state to PCB and restores next process state; pure computational overhead.\n3. **Multi-threading** shares code, data, and OS resources among execution paths while maintaining separate registers and stacks.",
              keyPoints: [
                "Context switching involves register dumping and cache invalidation overhead.",
                "Threads within the same process share heap memory and file descriptors.",
                "Fork() clones parent memory space; Exec() replaces memory space entirely.",
              ],
            ),
            Lesson(
              id: "L3",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "Processes & Threads",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: true,
              objectives: [
                "Trace fork() hierarchy execution tree",
                "Calculate process count after recursive fork calls",
              ],
              body:
                  "Consider a program calling fork() 3 times sequentially. Trace process generation:\n\nParent P0 executes fork() -> creates P1.\nBoth P0 and P1 execute second fork() -> creates P2 and P3.\nAll 4 processes execute third fork() -> creates 4 new processes.\nTotal processes = 2^3 = 8.",
              keyPoints: [
                "Each fork() branches process execution; parent receives child PID, child receives 0.",
                "Zombie process exists when child exits but parent hasn't called wait().",
              ],
            ),
            Lesson(
              id: "L4",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Processes & Threads",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: true,
              objectives: [
                "Check understanding of process states and thread synchronization",
              ],
              body:
                  "Explain in your own words:\n1. Why context switching overhead cannot be eliminated.\n2. When user-level threads block the entire process on I/O operations.",
              keyPoints: [
                "User threads mapping Many-to-One block entirely if any thread issues a blocking syscall.",
                "Preemptive scheduling stops processes based on timer interrupts.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "U2",
          title: "CPU Scheduling",
          part: "Chapter 2",
          lessons: [
            Lesson(
              id: "L5",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "CPU Scheduling",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              objectives: [
                "Compare FCFS, SJF, SRTF, Priority, and Round Robin scheduling",
                "Calculate average waiting time and turnaround time",
              ],
              body:
                  "CPU scheduling determines process selection from ready queue whenever CPU becomes idle.",
              keyPoints: [
                "Shortest Job First (SJF) provides theoretically minimal average waiting time.",
                "Round Robin scheduling depends critically on time quantum sizing.",
              ],
            ),
            Lesson(
              id: "L6",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "CPU Scheduling",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              objectives: [
                "Draw Gantt charts for Round Robin with time quantum = 4ms",
              ],
              body:
                  "Gantt chart calculation walkthrough for processes P1(burst=6), P2(burst=4), P3(burst=8).",
            ),
            Lesson(
              id: "L7",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "CPU Scheduling",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              objectives: [
                "Identify starvation conditions in priority scheduling",
              ],
              body:
                  "Practice solving SJF vs Priority scheduling questions and calculate throughput.",
            ),
          ],
        ),
        CourseUnit(
          id: "U3",
          title: "Synchronisation",
          part: "Chapter 3",
          lessons: [
            Lesson(
              id: "L8",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Synchronisation",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              objectives: [
                "Define Critical Section problem requirements (Mutual exclusion, Progress, Bounded wait)",
                "Understand Semaphores, Mutexes, and Peterson's Algorithm",
              ],
              body:
                  "Cooperating processes sharing data require coordination to avoid race conditions.",
            ),
            Lesson(
              id: "L9",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "Synchronisation",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              objectives: [
                "Implement Producer-Consumer problem using counting semaphores",
              ],
              body:
                  "Code and trace Producer-Consumer with full, empty, and mutex semaphores.",
            ),
            Lesson(
              id: "L10",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Synchronisation",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              objectives: [
                "Solve Dining Philosophers problem without deadlocks",
              ],
              body:
                  "Break circular wait by making at least one philosopher pick up chopstick in reverse order.",
            ),
          ],
        ),
        CourseUnit(
          id: "U4",
          title: "Deadlocks",
          part: "Chapter 4",
          lessons: [
            Lesson(
              id: "L11",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Deadlocks",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              objectives: [
                "Recognise 4 Coffman conditions for deadlocks",
                "Differentiate Prevention, Avoidance, and Detection",
              ],
              body:
                  "Mutual exclusion, Hold & wait, No preemption, and Circular wait characterize deadlock.",
            ),
            Lesson(
              id: "L12",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "Deadlocks",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              objectives: [
                "Execute Banker's Algorithm safety check on allocation matrix",
              ],
              body:
                  "Step-by-step calculation of Need = Max - Allocation and find safe sequence <P1, P3, P4, P0, P2>.",
            ),
            Lesson(
              id: "L13",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Deadlocks",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              objectives: [
                "Evaluate Resource Allocation Graphs (RAG) with cycles",
              ],
              body:
                  "Verify if a cycle implies deadlock when single vs multiple resource instances exist.",
            ),
          ],
        ),
        CourseUnit(
          id: "U5",
          title: "Memory Management",
          part: "Chapter 5",
          lessons: [
            Lesson(
              id: "L14",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Memory Management",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              objectives: [
                "Logical vs Physical address spaces and MMU translation",
                "Paging, Page Tables, and Translation Lookaside Buffer (TLB)",
              ],
              body:
                  "Paging divides logical memory into pages and physical memory into frames.",
            ),
            Lesson(
              id: "L15",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "Memory Management",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              objectives: [
                "Calculate effective memory access time with TLB hit ratios",
              ],
              body:
                  "EMAT calculation: Hit ratio 90%, TLB access 20ns, Main memory access 100ns.",
            ),
            Lesson(
              id: "L16",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Memory Management",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              objectives: [
                "Contrast internal vs external fragmentation",
              ],
              body:
                  "Explain why segmentation causes external fragmentation while paging causes internal fragmentation.",
            ),
          ],
        ),
        CourseUnit(
          id: "U6",
          title: "Storage & File Systems",
          part: "Chapter 6",
          lessons: [
            Lesson(
              id: "L17",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Storage & File Systems",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              objectives: [
                "File structures, directory architectures, and Inodes",
                "Disk scheduling: FCFS, SSTF, SCAN, C-SCAN",
              ],
              body:
                  "File systems manage disk block allocation via contiguous, linked, and indexed methods.",
            ),
            Lesson(
              id: "L18",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "Storage & File Systems",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              objectives: [
                "Calculate total head movement in SCAN and SSTF disk scheduling",
              ],
              body:
                  "Disk head currently at cylinder 53, requests: 98, 183, 37, 122, 14, 124, 65, 67.",
            ),
            Lesson(
              id: "L19",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Storage & File Systems",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              objectives: [
                "Explain UNIX inode architecture and triple indirect blocks",
              ],
              body:
                  "Determine max file size supported by 4KB block size with 12 direct and single/double/triple indirect blocks.",
            ),
          ],
        ),
        CourseUnit(
          id: "U7",
          title: "Security & Protection",
          part: "Chapter 7",
          lessons: [
            Lesson(
              id: "L20",
              title: "Key concepts",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Security & Protection",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              objectives: [
                "Access control matrices, capabilities, and ACLs",
                "Principle of least privilege and buffer overflow exploits",
              ],
              body:
                  "Protection controls access of programs and users to system resources.",
            ),
            Lesson(
              id: "L21",
              title: "Worked example",
              duration: "20m",
              layoutKind: "example",
              chapterTitle: "Security & Protection",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              objectives: [
                "Construct access matrix and revoke rights dynamically",
              ],
              body:
                  "User domain access matrix transition walkthrough.",
            ),
            Lesson(
              id: "L22",
              title: "Practice & recap",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Security & Protection",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              objectives: [
                "Identify common operating system vulnerabilities",
              ],
              body:
                  "Review memory safety, stack canaries, and non-executable stack flags.",
            ),
          ],
        ),
        CourseUnit(
          id: "U8",
          title: "Course Revision",
          part: "Revision",
          lessons: [
            Lesson(
              id: "L23",
              title: "Comprehensive recap",
              duration: "25m",
              layoutKind: "revision",
              chapterTitle: "Course Revision",
              chapterPart: "Revision",
              chapterIndex: 8,
              objectives: [
                "Consolidate all 8 chapters before final assessment",
                "Review high-frequency formulas and algorithms",
              ],
              body:
                  "Complete syllabus revision covering Processes, Scheduling, Synchronisation, Deadlocks, Paging, and Disk Algorithms.",
            ),
            Lesson(
              id: "L24",
              title: "Exam blueprint review",
              duration: "20m",
              layoutKind: "revision",
              chapterTitle: "Course Revision",
              chapterPart: "Revision",
              chapterIndex: 8,
              objectives: [
                "Understand weightage and sample questions for 30-question final test",
              ],
              body:
                  "Detailed review of question distribution across Units 1 through 7.",
            ),
            Lesson(
              id: "L25",
              title: "Formula sheet & theorems",
              duration: "15m",
              layoutKind: "revision",
              chapterTitle: "Course Revision",
              chapterPart: "Revision",
              chapterIndex: 8,
              objectives: [
                "Quick review of Banker's Algorithm, EMAT, and disk scheduling equations",
              ],
              body:
                  "Quick reference formulas for Operating Systems exams.",
            ),
            Lesson(
              id: "L26",
              title: "Last-minute tips & checklist",
              duration: "10m",
              layoutKind: "revision",
              chapterTitle: "Course Revision",
              chapterPart: "Revision",
              chapterIndex: 8,
              objectives: [
                "Final readiness check before attempting certificate test",
              ],
              body:
                  "Verify that you can explain all key concepts without assistance.",
            ),
          ],
        ),
      ],
    ),
    Course(
      id: "LC-ML101",
      code: "AID101",
      title: "Machine Learning",
      department: "Artificial Intelligence & Data Science",
      facultyName: "Dr. Arun Kumar",
      term: "Term 1",
      credits: 3,
      summary:
          "Machine Learning for Artificial Intelligence & Data Science students: 5 lessons in 3 chapters, followed by a final assessment and certificate.",
      totalChapters: 3,
      totalLessons: 5,
      hours: "~3 h",
      completedLessons: 1,
      finalUnlocked: false,
      units: [
        CourseUnit(
          id: "ML-U0",
          title: "Getting started",
          part: "Start here",
          lessons: [
            Lesson(
              id: "ML-L1",
              title: "Welcome to Machine Learning",
              duration: "10m",
              layoutKind: "overview",
              chapterTitle: "Getting started",
              chapterPart: "Start here",
              chapterIndex: 0,
              isCompleted: true,
              objectives: [
                "Understand the paradigm shift from traditional programming to machine learning",
                "Differentiate Supervised, Unsupervised, and Reinforcement learning",
                "Learn the typical ML pipeline from data ingestion to model deployment",
              ],
              body:
                  "Machine Learning enables systems to automatically learn and improve from experience without being explicitly programmed. In this course, you will build foundations in regression, classification, clustering, and neural networks.",
              keyPoints: [
                "Supervised learning trains on labeled inputs and target pairs.",
                "Unsupervised learning discovers latent patterns and groupings in unlabeled data.",
                "Reinforcement learning learns policy actions via environmental feedback.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "ML-U1",
          title: "Supervised Learning & Regression",
          part: "Chapter 1",
          lessons: [
            Lesson(
              id: "ML-L2",
              title: "Key concepts: Linear & Logistic Regression",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Supervised Learning & Regression",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: false,
              objectives: [
                "Formulate mean squared error cost function and gradient descent",
                "Understand decision boundaries and sigmoid activation for classification",
                "Identify high bias (underfitting) versus high variance (overfitting)",
              ],
              body:
                  "Linear regression models continuous target variables using weighted combinations of input features. Logistic regression applies the logistic sigmoid function to output calibrated probabilities for binary classification.",
              keyPoints: [
                "Gradient descent iteratively updates weights in the direction of steepest loss decrease.",
                "Regularization (L1 Lasso, L2 Ridge) penalizes excessive weight magnitude to curb overfitting.",
              ],
            ),
            Lesson(
              id: "ML-L3",
              title: "Worked example: Training & Validation Split",
              duration: "25m",
              layoutKind: "example",
              chapterTitle: "Supervised Learning & Regression",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: false,
              objectives: [
                "Evaluate model performance on unseen validation splits",
                "Calculate Precision, Recall, F1-Score, and ROC-AUC metrics",
              ],
              body:
                  "Worked implementation of feature scaling, train-test splitting, training a classifier, and plotting confusion matrices and learning curves.",
              keyPoints: [
                "Never fit scalers or imputers on the test fold to avoid data leakage.",
                "F1-score provides a balanced harmonic mean when class distributions are imbalanced.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "ML-U2",
          title: "Unsupervised Learning & Practice",
          part: "Chapter 2",
          lessons: [
            Lesson(
              id: "ML-L4",
              title: "Key concepts: K-Means & Dimensionality Reduction",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Unsupervised Learning & Practice",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              isCompleted: false,
              objectives: [
                "Understand K-Means clustering centroid initialization and convergence",
                "Explain Principal Component Analysis (PCA) orthogonal projection",
              ],
              body:
                  "K-Means partitions N observations into K clusters by minimizing within-cluster sum of squares. PCA performs orthogonal linear transformations to capture maximum feature variance in fewer principal components.",
              keyPoints: [
                "The elbow method helps determine optimal cluster count K.",
                "PCA reduces curse of dimensionality while preserving variance.",
              ],
            ),
            Lesson(
              id: "ML-L5",
              title: "Practice & recap: Model Evaluation Checklist",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Unsupervised Learning & Practice",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              isCompleted: false,
              objectives: [
                "Review key algorithms before the 30-question final assessment",
                "Complete self-check quiz and checklist",
              ],
              body:
                  "Recap all supervised and unsupervised architectures, loss functions, and evaluation metrics.",
              keyPoints: [
                "Verify understanding of bias-variance tradeoff and confusion matrix derivation.",
              ],
            ),
          ],
        ),
      ],
    ),
    Course(
      id: "LC-DBMS101",
      code: "CSE101",
      title: "Database Management Systems",
      department: "Computer Science & Engineering",
      facultyName: "Dr. Meena Raghavan",
      term: "Term 4",
      credits: 4,
      summary:
          "Database Management Systems for Computer Science & Engineering students: 5 lessons in 2 chapters, followed by a 30-question final assessment and verifiable certificate.",
      totalChapters: 2,
      totalLessons: 5,
      hours: "~2 h",
      completedLessons: 1,
      certificateId: "CERT-2026-DBMS-8841",
      bestScore: 100,
      finalUnlocked: false,
      units: [
        CourseUnit(
          id: "DB-U0",
          title: "Getting started",
          part: "Start here",
          lessons: [
            Lesson(
              id: "DB-L1",
              title: "Welcome to Database Management Systems",
              duration: "10m",
              layoutKind: "overview",
              chapterTitle: "Getting started",
              chapterPart: "Start here",
              chapterIndex: 0,
              isCompleted: true,
              objectives: [
                "Understand relational database architecture and data models",
                "Differentiate between DDL, DML, DCL, and TCL commands",
                "Plan your relational modeling and normal form progression",
              ],
              body:
                  "Database Management Systems (DBMS) form the foundation of enterprise data storage, integrity, and retrieval. This course covers relational database design, relational algebra, functional dependencies, normal forms from 1NF to BCNF, transaction processing, and concurrency protocols.\n\n### Course Roadmap\n1. **Relational Modeling & ER Design** - entities, attributes, constraints, and relational algebra.\n2. **Normalization** - functional dependencies, 1NF, 2NF, 3NF, and BCNF.\n3. **Transactions & ACID** - schedules, conflict serializability, and 2PL protocols.",
              keyPoints: [
                "Relational databases structure data into tables with primary and foreign key constraints.",
                "Normalization prevents update, insertion, and deletion anomalies.",
                "ACID guarantees transactional safety and recovery.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "DB-U1",
          title: "Relational Modeling & Normalization",
          part: "Chapter 1",
          lessons: [
            Lesson(
              id: "DB-L2",
              title: "Key concepts: Relational Model & ER Design",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Relational Modeling & Normalization",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: false,
              objectives: [
                "Map Entity-Relationship (ER) diagrams to relational schemas",
                "Identify candidate keys, superkeys, and foreign key references",
                "Enforce entity integrity and referential integrity rules",
              ],
              body:
                  "An Entity-Relationship model describes the conceptual view of data. Entities translate to relations (tables), attributes become columns, and relationships become foreign key constraints. A candidate key is a minimal superkey that uniquely identifies each tuple.\n\n### Integrity Constraints\n- **Entity Integrity:** Primary key attributes cannot accept NULL values.\n- **Referential Integrity:** Foreign key values must match a candidate key value in the referenced relation or be NULL.\n- **Domain Integrity:** Attribute values must conform to their defined data type and check constraints.",
              keyPoints: [
                "Primary keys cannot contain NULL values under entity integrity.",
                "Foreign keys reference existing primary key values or NULL under referential integrity.",
                "Cardinality ratios (1:1, 1:N, M:N) dictate how relationship tables are structured.",
              ],
            ),
            Lesson(
              id: "DB-L3",
              title: "Worked example: Normalization (1NF to BCNF)",
              duration: "25m",
              layoutKind: "example",
              chapterTitle: "Relational Modeling & Normalization",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: false,
              objectives: [
                "Step through 1NF, 2NF, 3NF, and BCNF decomposition",
                "Test for lossless-join and dependency preservation",
                "Eliminate partial and transitive dependencies",
              ],
              body:
                  "Worked decomposition of a Student-Course-Instructor registration schema. We identify non-trivial functional dependencies, verify candidate keys, and decompose into Boyce-Codd Normal Form (BCNF) while ensuring all common attributes form candidate keys.\n\n### Decomposition Steps\n1. Identify all non-trivial functional dependencies X -> Y.\n2. Find candidate keys by computing attribute closures.\n3. Split relation whenever X is not a superkey, ensuring R1 ∩ R2 forms a superkey for R1 or R2.",
              keyPoints: [
                "1NF requires all attribute domains to be atomic.",
                "2NF eliminates partial dependencies on candidate keys.",
                "3NF eliminates transitive dependencies; BCNF requires every determinant to be a superkey.",
              ],
            ),
          ],
        ),
        CourseUnit(
          id: "DB-U2",
          title: "Transactions & Concurrency Control",
          part: "Chapter 2",
          lessons: [
            Lesson(
              id: "DB-L4",
              title: "Key concepts: Transactions & ACID Properties",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Transactions & Concurrency Control",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              isCompleted: false,
              objectives: [
                "Master the four ACID properties: Atomicity, Consistency, Isolation, Durability",
                "Understand transaction states: Active, Partially Committed, Failed, Aborted, Committed",
                "Learn Write-Ahead Logging (WAL) and checkpoint recovery",
              ],
              body:
                  "A transaction is a logical unit of database processing that includes one or more database access operations. Atomicity requires all-or-nothing execution, consistency preserves database invariants, isolation prevents interference from concurrent transactions, and durability ensures committed changes survive system crashes.\n\n### The ACID Guarantees\n- **Atomicity:** All operations complete or none do (managed by Undo logging).\n- **Consistency:** Database transitions from one valid state to another.\n- **Isolation:** Concurrent schedules behave as if executed serially.\n- **Durability:** Committed updates survive power loss or software crashes.",
              keyPoints: [
                "Atomicity and Durability are maintained by the recovery manager using Write-Ahead Logging.",
                "Isolation is maintained by the concurrency control manager using locking or timestamping.",
                "Serializability is the gold standard for concurrent transaction schedules.",
              ],
            ),
            Lesson(
              id: "DB-L5",
              title: "Practice & recap: Concurrency & Revision",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Transactions & Concurrency Control",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              isCompleted: false,
              objectives: [
                "Check your understanding of conflict serializability and precedence graphs",
                "Solve two-phase locking (2PL) and deadlock avoidance problems",
                "Review key checklist before taking the 30-question final assessment",
              ],
              body:
                  "Diagnostic review with model answers testing your mastery of conflict serializability, precedence graphs, strict two-phase locking, and BCNF decomposition.",
              keyPoints: [
                "A schedule is conflict serializable if and only if its precedence graph is acyclic.",
                "Strict 2PL guarantees conflict serializability and prevents cascading aborts.",
                "Review all normal form definitions and ACID properties before the final exam.",
              ],
            ),
          ],
        ),
      ],
    ),
  ];

  static final List<ClassNote> classNotes = [
    ClassNote(
      id: "CN-01",
      courseCode: "CS3451",
      subject: "Database Management Systems",
      facultyName: "Dr. Meena Sundaram",
      department: "CSE",
      date: "Today, 10:15 AM",
      topic: "Transaction Management & ACID properties",
      summary:
          "Completed discussion on transaction states, conflict serializability, and draw precedence graph for testing serializable schedules.",
      keyTakeaways: [
        "A schedule is conflict serializable iff its precedence graph has no cycles.",
        "ACID guarantees atomicity using WAL (Write-Ahead Logging) and durability via checkpoints.",
        "Blind writes occur when a transaction writes without reading the item first.",
      ],
      homework:
          "Solve Exercise 14.3 from textbook: Draw precedence graph for schedule S with 4 transactions and state if it is serializable.",
      isRead: false,
      resources: [
        HandoutResource(
          title: "ACID & Serializability Infographic Handout.pdf",
          type: "pdf",
          url: "https://colossusiq.edu/handouts/acid-infographic.pdf",
        ),
        HandoutResource(
          title: "Precedence Graph interactive simulator",
          type: "link",
          url: "https://colossusiq.edu/tools/serializability-check",
        ),
      ],
    ),
    ClassNote(
      id: "CN-02",
      courseCode: "CS3452",
      subject: "Operating Systems",
      facultyName: "Prof. K. Ramesh",
      department: "CSE",
      date: "Yesterday",
      topic: "Dining Philosophers & Classical Synchronization",
      summary:
          "Analyzed deadlocks occurring with multiple shared resources. Implemented asymmetric philosopher pick-up solution and monitor abstraction.",
      keyTakeaways: [
        "Circular wait is broken by having philosopher 4 pick up right chopstick first.",
        "Semaphores require wait() and signal() atomic operations.",
      ],
      homework:
          "Submit code on GitHub repository for sleeping barber problem before Friday.",
      isRead: true,
      resources: [
        HandoutResource(
          title: "Semaphore Cheat Sheet & Code Snippets.pdf",
          type: "pdf",
          url: "https://colossusiq.edu/handouts/semaphores.pdf",
        ),
      ],
    ),
    ClassNote(
      id: "CN-03",
      courseCode: "CS3591",
      subject: "Computer Networks",
      facultyName: "Dr. S. Priya",
      department: "CSE",
      date: "3 days ago",
      topic: "Subnetting, CIDR & VLSM Calculation Practice",
      summary:
          "Practiced variable length subnet masking for campus multi-department allocation with minimal address wastage.",
      keyTakeaways: [
        "Number of usable hosts per subnet = 2^(32-prefix) - 2.",
        "Network address has all host bits 0; Broadcast address has all host bits 1.",
      ],
      homework: "Complete campus IP allocation plan worksheet.",
      isRead: true,
      resources: [
        HandoutResource(
          title: "Subnetting Master Practice Sheet.pdf",
          type: "pdf",
          url: "https://colossusiq.edu/handouts/subnetting.pdf",
        ),
      ],
    ),
  ];

  static final List<MockTest> mockTests = [
    MockTest(
      id: "TEST-DBMS-01",
      title: "DBMS IA-II Adaptive Mock Assessment",
      subject: "Database Management Systems",
      department: "CSE",
      durationMinutes: 20,
      totalQuestions: 5,
      passPercentage: 60,
      bestScore: 80,
      attemptsUsed: 1,
      certificateEnabled: true,
      certificateId: "CERT-2026-DBMS-8841",
      questions: [
        Question(
          id: "Q1",
          text: "Which of the following conditions ensures a decomposition is lossless-join for R into (R1, R2)?",
          options: [
            "(R1 ∩ R2) -> R1 or (R1 ∩ R2) -> R2",
            "(R1 ∪ R2) -> R1",
            "R1 ∩ R2 = ∅",
            "(R1 ∩ R2) -> (R1 ∪ R2)",
          ],
          correctOptionIndex: 0,
          explanation:
              "Lossless join requires that the common attributes between R1 and R2 must contain a candidate key for at least one of the decomposed relations.",
        ),
        Question(
          id: "Q2",
          text: "In BCNF, for every functional dependency X -> Y, what must hold true?",
          options: [
            "Y is a prime attribute",
            "X must be a superkey of the relation",
            "X must be a candidate key and Y must be single-valued",
            "Y is a subset of X or X is a prime attribute",
          ],
          correctOptionIndex: 1,
          explanation:
              "Boyce-Codd Normal Form strictly requires that for every non-trivial functional dependency X -> Y, X must be a superkey.",
        ),
        Question(
          id: "Q3",
          text: "What does the 'I' in ACID properties of transaction management signify?",
          options: [
            "Integrity",
            "Isolation",
            "Immutability",
            "Idempotence",
          ],
          correctOptionIndex: 1,
          explanation:
              "Isolation guarantees that concurrently executing transactions cannot observe each other's intermediate inconsistent states.",
        ),
        Question(
          id: "Q4",
          text: "Which protocol prevents deadlocks completely by acquiring all locks before execution starts?",
          options: [
            "Strict 2PL",
            "Conservative 2PL (Static 2PL)",
            "Rigorous 2PL",
            "Basic Timestamp Ordering",
          ],
          correctOptionIndex: 1,
          explanation:
              "Conservative 2PL requires a transaction to lock all required data items beforehand, preventing circular wait and deadlocks.",
        ),
        Question(
          id: "Q5",
          text: "If a precedence graph contains a directed cycle, the schedule is:",
          options: [
            "Conflict serializable",
            "Not conflict serializable",
            "Guaranteed deadlock-free",
            "Strict and recoverable",
          ],
          correctOptionIndex: 1,
          explanation:
              "By serializability theorem, a schedule S is conflict serializable if and only if its serialization/precedence graph has no directed cycles.",
        ),
      ],
    ),
    MockTest(
      id: "TEST-OS-02",
      title: "Operating Systems — Concurrency & Deadlocks",
      subject: "Operating Systems",
      department: "CSE",
      durationMinutes: 15,
      totalQuestions: 4,
      passPercentage: 50,
      bestScore: null,
      attemptsUsed: 0,
      certificateEnabled: false,
      questions: [
        Question(
          id: "Q1",
          text: "Which of the following is NOT one of the Coffman conditions for deadlocks?",
          options: [
            "Mutual Exclusion",
            "Hold and Wait",
            "Paging Overlap",
            "Circular Wait",
          ],
          correctOptionIndex: 2,
          explanation:
              "The 4 conditions are Mutual exclusion, Hold and wait, No preemption, and Circular wait.",
        ),
        Question(
          id: "Q2",
          text: "Banker's Algorithm is primarily used for deadlock:",
          options: [
            "Prevention",
            "Avoidance",
            "Detection",
            "Recovery",
          ],
          correctOptionIndex: 1,
          explanation:
              "Banker's Algorithm tests for safety by simulating the allocation for predetermined maximum possible amounts, hence avoidance.",
        ),
      ],
    ),
  ];

  static const PlacementReadinessData placementData = PlacementReadinessData(
    totalScore: 74,
    status: "Almost ready",
    dimensions: [
      ReadinessDimension(
        key: "quizAverage",
        label: "Department Quiz Average",
        weight: 25,
        rawScore: 82,
        points: 21,
      ),
      ReadinessDimension(
        key: "certificates",
        label: "Verified Certifications",
        weight: 20,
        rawScore: 3, // 3 certificates out of 4 target
        points: 15,
      ),
      ReadinessDimension(
        key: "aptitude",
        label: "Quantitative & Analytical Aptitude",
        weight: 15,
        rawScore: 78,
        points: 12,
      ),
      ReadinessDimension(
        key: "interview",
        label: "AI Mock Interview Score",
        weight: 25,
        rawScore: 68,
        points: 17,
      ),
      ReadinessDimension(
        key: "resume",
        label: "ATS Resume & Profile Score",
        weight: 15,
        rawScore: 60,
        points: 9,
      ),
    ],
    checks: [
      EligibilityCheck(
        title: "Total Readiness Score",
        requirement: "70 points or higher",
        currentValue: "74 points",
        isMet: true,
      ),
      EligibilityCheck(
        title: "Quiz & Academic Average",
        requirement: "75% or higher",
        currentValue: "82%",
        isMet: true,
        route: "/quizzes",
      ),
      EligibilityCheck(
        title: "Verified Skill Certificates",
        requirement: "At least 3 certificates",
        currentValue: "3 certificates",
        isMet: true,
        route: "/certificates",
      ),
      EligibilityCheck(
        title: "Technical Mock Interview",
        requirement: "Score 70 or higher",
        currentValue: "68 / 100",
        isMet: false,
        route: "/interview",
      ),
      EligibilityCheck(
        title: "ATS-Approved Resume",
        requirement: "Score 75 or higher",
        currentValue: "60 / 100",
        isMet: false,
        route: "/resume",
      ),
    ],
  );

  static final List<CertificateItem> certificates = [
    CertificateItem(
      id: "CERT-2026-DBMS-8841",
      title: "Relational DBMS & Advanced Normalization",
      department: "Computer Science & Engineering",
      grade: "A+",
      gradeLabel: "Distinction",
      marks: 24,
      total: 30,
      percentage: 80,
      issuedDate: "28 Sep 2026",
      verificationUrl: "https://colossusiq.edu/verify/CERT-2026-DBMS-8841",
    ),
    CertificateItem(
      id: "CERT-2026-CN-9122",
      title: "Computer Networks & Network Security Protocols",
      department: "Computer Science & Engineering",
      grade: "O",
      gradeLabel: "Outstanding",
      marks: 28,
      total: 30,
      percentage: 93,
      issuedDate: "15 Sep 2026",
      verificationUrl: "https://colossusiq.edu/verify/CERT-2026-CN-9122",
    ),
    CertificateItem(
      id: "CERT-2026-PYTHON-4410",
      title: "Modern Python & Data Structures Studio",
      department: "AI&DS",
      grade: "A",
      gradeLabel: "First Class",
      marks: 22,
      total: 30,
      percentage: 73,
      issuedDate: "02 Aug 2026",
      verificationUrl: "https://colossusiq.edu/verify/CERT-2026-PYTHON-4410",
    ),
  ];

  static final List<AssignmentItem> assignments = [
    AssignmentItem(
      id: "ASG-01",
      title: "ER Schema Design & Normalization to 3NF",
      course: "CS3451 DBMS",
      dueDate: "Tomorrow, 11:59 PM",
      submittedCount: 48,
      status: "Open",
      totalMarks: 50,
    ),
    AssignmentItem(
      id: "ASG-02",
      title: "Dining Philosophers Implementation using Semaphores",
      course: "CS3452 OS",
      dueDate: "Sunday, 11:59 PM",
      submittedCount: 22,
      status: "Open",
      totalMarks: 50,
    ),
    AssignmentItem(
      id: "ASG-03",
      title: "VLSM Subnet Calculation for 4 Campus Blocks",
      course: "CS3591 CN",
      dueDate: "25 Sep 2026",
      submittedCount: 64,
      status: "Graded",
      score: 46,
      totalMarks: 50,
    ),
  ];

  static final List<ClubItem> clubs = [
    ClubItem(
      id: "CLB-01",
      name: "Google Developer Student Club (GDSC)",
      category: "Technical",
      description:
          "Peer-to-peer developer community working on Web, Cloud, AI & Mobile Flutter projects.",
      memberCount: 340,
      leadName: "Rahul Sharma (Final Year CSE)",
      nextMeeting: "Thursday, 4:30 PM",
      isJoined: true,
    ),
    ClubItem(
      id: "CLB-02",
      name: "Colossus AI & Robotics Society",
      category: "Innovation",
      description:
          "Autonomous drones, robotics hardware, ROS, and computer vision research.",
      memberCount: 215,
      leadName: "Ananya Iyer (Pre-Final AI&DS)",
      nextMeeting: "Saturday, 10:00 AM",
      isJoined: false,
    ),
    ClubItem(
      id: "CLB-03",
      name: "Literary & Debating Society",
      category: "Cultural",
      description:
          "Model UN, parliamentary debates, creative writing, and public speaking workshops.",
      memberCount: 180,
      leadName: "Vikram Menon (B.A. English)",
      nextMeeting: "Wednesday, 3:30 PM",
      isJoined: false,
    ),
  ];

  static final List<SportItem> sports = [
    SportItem(
      id: "SPT-01",
      title: "Inter-Department Basketball Championship",
      category: "Sports",
      venue: "Main Indoor Sports Complex",
      date: "Oct 14 - Oct 18",
      status: "Trials open",
      registeredCount: 42,
    ),
    SportItem(
      id: "SPT-02",
      title: "Zonal Cricket Tournament 2026",
      category: "Sports",
      venue: "University Pavilion Ground",
      date: "Oct 24",
      status: "Active",
      registeredCount: 88,
    ),
    SportItem(
      id: "SPT-03",
      title: "Annual Badminton Open (Men & Women)",
      category: "Sports",
      venue: "Court A & B, Student Center",
      date: "Nov 02",
      status: "Trials open",
      registeredCount: 56,
    ),
  ];
}
