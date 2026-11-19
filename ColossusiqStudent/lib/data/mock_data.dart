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
              title: "Web Architecture & HTTP/HTTPS Protocols",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Introduction to Web Technologies",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: true,
              objectives: [
                "Understand client-server architecture, DNS resolution, and TCP/IP connectivity",
                "Analyze the anatomy of HTTP/1.1, HTTP/2, and HTTP/3 request-response cycles",
                "Master TLS/SSL handshakes, symmetric vs asymmetric encryption, and HTTPS security",
              ],
              body:
                  "The modern web is built upon distributed client-server systems communicating across standardized protocols.\n\n### 1. The Client-Server Model\nWhen a user enters a URL, the browser initiates DNS lookup to resolve the hostname into an IP address. A TCP three-way handshake (SYN, SYN-ACK, ACK) establishes a reliable connection before transmitting HTTP request packets.\n\n### 2. HTTP Protocol Evolution\n- **HTTP/1.1**: Persistent TCP connections with Keep-Alive, but susceptible to head-of-line blocking.\n- **HTTP/2**: Binary framing layer, multiplexed bidirectional streams over a single connection, and header compression (HPACK).\n- **HTTP/3**: Built on QUIC (UDP), eliminating TCP head-of-line blocking with faster zero-RTT connection establishment.\n\n### 3. HTTPS & TLS Handshake\nHTTPS encrypts the communication channel using Transport Layer Security (TLS). The browser verifies the server's X.509 digital certificate against trusted Certificate Authorities (CAs), negotiates a shared session key via Diffie-Hellman key exchange, and encrypts all subsequent payload traffic.",
              keyPoints: [
                "HTTP is stateless; authorization headers, cookies, and tokens maintain session context.",
                "DNS caching occurs at the browser, OS, router, and ISP recursive resolver layers.",
                "TLS handshakes authenticate the server identity and negotiate symmetric encryption keys.",
              ],
            ),
            Lesson(
              id: "WT-L3",
              title: "HTML5 Semantic Architecture & Accessibility",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Introduction to Web Technologies",
              chapterPart: "Chapter 1",
              chapterIndex: 1,
              isCompleted: true,
              objectives: [
                "Structure modern accessible web documents using HTML5 semantic elements",
                "Implement WAI-ARIA roles, landmark attributes, and screen-reader accessibility",
                "Optimize document headers with OpenGraph, responsive viewports, and SEO metadata",
              ],
              body:
                  "HTML5 introduces semantic tags that give structural meaning to web content beyond generic <div> containers.\n\n### 1. Semantic Document Tree\n- `<header>` & `<nav>`: Site branding, primary navigation landmarks.\n- `<main>`: The unique central content of the document (only one per page).\n- `<article>`: Self-contained, syndicateable composition (e.g. blog post, product card).\n- `<section>`: Thematic grouping of content, typically with a heading.\n- `<aside>`: Related sidebar content, footnotes, or contextual callouts.\n- `<footer>`: Author info, copyright, sitemap links, and disclosure policies.\n\n### 2. Web Accessibility (WCAG & ARIA)\nModern web engineering requires WCAG 2.1 AA compliance:\n- Always supply descriptive `alt` text on informative `<img>` elements.\n- Use proper heading hierarchies (`<h1>` through `<h6>`) without skipping levels.\n- Leverage ARIA attributes (`aria-expanded`, `aria-live`, `role=\"dialog\"`) for dynamic state changes.",
              keyPoints: [
                "Semantic markup improves screen reader navigation and search engine indexability.",
                "The viewport meta tag ensures proper scaling across mobile and desktop devices.",
                "Every accessible form input requires an explicitly associated <label> via for/id attributes.",
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
              title: "CSS Box Model, Flexbox & Grid Systems",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Basic Concepts & Terminology",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              isCompleted: true,
              objectives: [
                "Master the standard CSS Box Model vs border-box sizing calculations",
                "Build dynamic 1D component layouts using Flexbox axes and alignment",
                "Construct complex 2D responsive page layouts using CSS Grid templates",
              ],
              body:
                  "CSS controls the presentation, flow, and spatial arrangement of web elements.\n\n### 1. The CSS Box Model\nEvery rendered element consists of four concentric boxes:\n1. **Content**: Text, image, or child element bounding box.\n2. **Padding**: Transparent clearance between content and border.\n3. **Border**: The stroke encircling padding and content.\n4. **Margin**: Transparent clearance separating the element from neighbors.\nAlways declare `box-sizing: border-box;` so padding and border are included within specified width/height.\n\n### 2. Flexbox (One-Dimensional Layout)\n- **Main Axis & Cross Axis**: Governed by `flex-direction` (row/column).\n- **Alignment**: `justify-content` aligns along the main axis; `align-items` aligns along the cross axis.\n- **Flex Item Sizing**: `flex: flex-grow flex-shrink flex-basis` controls elasticity.\n\n### 3. CSS Grid (Two-Dimensional Layout)\nCSS Grid arranges elements in simultaneous rows and columns using `grid-template-columns: repeat(auto-fit, minmax(280px, 1fr))` for intrinsic responsiveness without media queries.",
              keyPoints: [
                "Margin collapse occurs between adjacent vertical block margins, taking the larger value.",
                "Flexbox is ideal for UI components (navbars, cards); CSS Grid is ideal for page scaffolding.",
                "The 'fr' unit represents a fraction of available space inside the grid container.",
              ],
            ),
            Lesson(
              id: "WT-L5",
              title: "Responsive Design & Mobile-First Breakpoints",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Basic Concepts & Terminology",
              chapterPart: "Chapter 2",
              chapterIndex: 2,
              isCompleted: true,
              objectives: [
                "Apply mobile-first responsive design strategies using min-width media queries",
                "Use modern CSS functions (clamp, calc, min, max) for fluid typography",
                "Serve responsive images with srcset, sizes, and the <picture> element",
              ],
              body:
                  "Responsive design ensures a seamless viewing experience across smart devices, tablets, and high-DPI displays.\n\n### 1. Mobile-First Media Queries\nAuthor base styles for small viewports first, then enhance progressively using `min-width` breakpoints:\n```css\n/* Mobile default */\n.card-grid { display: flex; flex-direction: column; }\n\n/* Tablet (>= 768px) */\n@media (min-width: 768px) {\n  .card-grid { display: grid; grid-template-columns: repeat(2, 1fr); }\n}\n\n/* Desktop (>= 1024px) */\n@media (min-width: 1024px) {\n  .card-grid { display: grid; grid-template-columns: repeat(4, 1fr); }\n}\n```\n\n### 2. Fluid Typography with clamp()\nDeclare `font-size: clamp(1rem, 2.5vw, 2.2rem);` to seamlessly scale text between defined minimum and maximum thresholds.",
              keyPoints: [
                "Mobile-first CSS minimizes stylesheet bloat and prevents layout regression on mobile devices.",
                "Relative units (rem, ch, %) should always be preferred over rigid pixel values for font sizes and margins.",
                "The <picture> element allows art direction and serving WebP/AVIF formats with PNG fallbacks.",
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
              title: "JavaScript ES6+ Syntax, Scopes & Closures",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Core Principles of Web Technologies",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              isCompleted: true,
              objectives: [
                "Understand variable hoisting and temporal dead zone with let, const, and var",
                "Master arrow functions, destructuring assignment, and spread/rest operators",
                "Analyze lexical scoping, execution contexts, and closure memory retention",
              ],
              body:
                  "Modern ECMAScript (ES6+) brings expressive syntax, immutable references, and predictable functional semantics to JavaScript.\n\n### 1. Scoping & Variable Declarations\n- `var`: Function-scoped, hoisted and initialized with `undefined`.\n- `let` & `const`: Block-scoped (`{}`), hoisted into the Temporal Dead Zone (TDZ) until evaluation.\n- Prefer `const` by default to prevent reassignment; use `let` only for loop counters and mutating states.\n\n### 2. Closures in Action\nA closure is the combination of a function bundled together with references to its surrounding lexical state:\n```javascript\nfunction createCounter(initial = 0) {\n  let count = initial; // Private enclosed state\n  return {\n    increment: () => ++count,\n    decrement: () => --count,\n    getCount: () => count\n  };\n}\nconst counter = createCounter(10);\ncounter.increment(); // 11\n```\nClosures power data encapsulation, factory functions, and stateful hooks.",
              keyPoints: [
                "Arrow functions do not bind their own 'this', 'arguments', or 'super' contexts.",
                "Destructuring allows extracting object properties and array elements with concise syntax.",
                "Closures retain access to outer variables even after the outer function has finished executing.",
              ],
            ),
            Lesson(
              id: "WT-L7",
              title: "Event Loop, Promises & Asynchronous Execution",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Core Principles of Web Technologies",
              chapterPart: "Chapter 3",
              chapterIndex: 3,
              isCompleted: true,
              objectives: [
                "Trace the JavaScript concurrency model: Call Stack, Web APIs, and Task Queues",
                "Compare Microtask (Promises, queueMicrotask) vs Macrotask (setTimeout, I/O) queues",
                "Write clean asynchronous workflows using Promise.all, Promise.race, and async/await",
              ],
              body:
                  "JavaScript is single-threaded; asynchronous concurrency is achieved through the browser event loop.\n\n### 1. The Event Loop Cycle\n1. **Call Stack**: Executes synchronous code frames sequentially.\n2. **Web APIs**: Browser handles timers, network requests, and DOM events concurrently in background threads.\n3. **Microtask Queue**: High priority queue (Promises, `queueMicrotask`) processed immediately after the call stack clears.\n4. **Macrotask Queue**: Lower priority queue (`setTimeout`, `setInterval`, user events) processed one per loop turn.\n\n### 2. Async/Await & Error Handling\n```javascript\nasync function loadUserData(userId) {\n  try {\n    const response = await fetch('/api/user/' + userId);\n    if (!response.ok) throw new Error('HTTP ' + response.status);\n    return await response.json();\n  } catch (error) {\n    console.error('Failed to load user:', error.message);\n  }\n}\n```",
              keyPoints: [
                "Microtasks always execute before the next render repaint and before the next macrotask.",
                "Promise.all rejects immediately if any promise fails; Promise.allSettled waits for all to conclude.",
                "Always handle rejected promises using catch() or try/catch around await statements.",
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
              title: "DOM Tree Navigation, Mutations & Dynamic Rendering",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Methods & Techniques",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              isCompleted: true,
              objectives: [
                "Traverse and manipulate DOM nodes using querySelector, parentNode, and children",
                "Create, insert, and remove elements efficiently using DocumentFragment",
                "Minimize browser reflow and repaint cycles during UI state updates",
              ],
              body:
                  "The Document Object Model (DOM) is an object-oriented representation of the web page that can be modified with JavaScript.\n\n### 1. Efficient DOM Selection & Mutation\n- `document.querySelector()` / `querySelectorAll()`: CSS selector matching.\n- `document.createElement()` & `element.append()`: Dynamic node creation.\n- `element.classList.toggle()`: Clean state styling without inline CSS strings.\n\n### 2. Preventing Performance Bottlenecks (Reflow vs Repaint)\n- **Reflow (Layout)**: Recalculating geometry, positions, and sizes of elements (triggered by `offsetWidth`, `clientHeight`, changing margins).\n- **Repaint**: Redrawing visual styles without altering geometry (color, visibility, background).\n- Use `document.createDocumentFragment()` to stage multiple elements in memory before mounting to the live DOM tree in a single operation.",
              keyPoints: [
                "DocumentFragment operates as a lightweight, in-memory DOM container that avoids layout thrashing.",
                "Batch style changes using CSS classes instead of repeatedly mutating element.style properties.",
                "textContent is faster and safer against XSS compared to innerHTML.",
              ],
            ),
            Lesson(
              id: "WT-L9",
              title: "Event Handling, Bubbling & Event Delegation",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Methods & Techniques",
              chapterPart: "Chapter 4",
              chapterIndex: 4,
              isCompleted: true,
              objectives: [
                "Understand the 3 phases of event propagation: capture, target, and bubble",
                "Implement event delegation for dynamic lists and memory efficiency",
                "Control browser behavior with preventDefault() and stopPropagation()",
              ],
              body:
                  "Browser events propagate through the DOM tree in two opposite directions: down through capturing and up through bubbling.\n\n### 1. Event Propagation Flow\n1. **Capturing Phase**: Event descends from `window` through ancestor elements down to the target.\n2. **Target Phase**: The event reaches the element where the interaction occurred.\n3. **Bubbling Phase**: The event bubbles up from the target back to `window`.\n\n### 2. Event Delegation Pattern\nInstead of attaching listeners to hundreds of individual table rows or list items, attach a single listener to their parent container:\n```javascript\ndocument.getElementById('student-list').addEventListener('click', (e) => {\n  const row = e.target.closest('tr');\n  if (row) {\n    const studentId = row.dataset.id;\n    viewStudentProfile(studentId);\n  }\n});\n```",
              keyPoints: [
                "Event delegation reduces memory consumption and automatically supports newly added dynamic elements.",
                "e.target represents the deepest clicked element; e.currentTarget is the element with the listener.",
                "event.preventDefault() stops default browser actions like form submission or anchor page jumps.",
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
              title: "Fetch API, AJAX & JSON Data Processing",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Client-Side Scripting & DOM",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              isCompleted: true,
              objectives: [
                "Execute asynchronous HTTP requests using window.fetch() and AbortController",
                "Configure request headers, authorization tokens, and HTTP payload methods",
                "Serialize and deserialize JSON payloads with error validation",
              ],
              body:
                  "Modern web clients communicate with remote web services using the Promise-based Fetch API.\n\n### 1. Full-Featured Fetch Implementation\n```javascript\nasync function postStudentGrade(courseId, payload) {\n  const controller = new AbortController();\n  const timeoutId = setTimeout(() => controller.abort(), 8000); // 8s timeout\n  \n  try {\n    const res = await fetch(`/api/courses/\${courseId}/grades`, {\n      method: 'POST',\n      headers: {\n        'Content-Type': 'application/json',\n        'Authorization': `Bearer \${sessionToken}`\n      },\n      body: JSON.stringify(payload),\n      signal: controller.signal\n    });\n    if (!res.ok) throw new Error(`Server returned status \${res.status}`);\n    return await res.json();\n  } finally {\n    clearTimeout(timeoutId);\n  }\n}\n```\n\n### 2. Handling HTTP Error Statuses\nRemember that fetch only rejects on network failures, not on HTTP 4xx or 5xx errors; you must explicitly check `response.ok`.",
              keyPoints: [
                "fetch() resolves on HTTP 404 and 500; always verify response.ok before parsing body.",
                "Use AbortController to cancel in-flight network requests when components unmount or search inputs change.",
                "Content-Type: application/json must be explicitly set when sending JSON bodies via POST/PUT.",
              ],
            ),
            Lesson(
              id: "WT-L11",
              title: "Browser Storage, Cookies & Client State Persistence",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Client-Side Scripting & DOM",
              chapterPart: "Chapter 5",
              chapterIndex: 5,
              isCompleted: true,
              objectives: [
                "Compare localStorage, sessionStorage, Cookies, and IndexedDB capabilities",
                "Implement secure token storage and session expiry patterns",
                "Safeguard client storage against Cross-Site Scripting (XSS) exploitation",
              ],
              body:
                  "Web applications store configuration, user preferences, and offline data across client storage mechanisms.\n\n### 1. Storage Comparison\n- **localStorage**: ~5MB, persists across browser restarts until cleared; synchronous key-value strings.\n- **sessionStorage**: ~5MB, scoped strictly to the current browser tab; erased when tab closes.\n- **HTTP Cookies**: ~4KB, sent automatically in HTTP request headers; support `HttpOnly`, `Secure`, and `SameSite=Strict` flags.\n- **IndexedDB**: Asynchronous NoSQL transactional object store capable of storing hundreds of megabytes of structured data offline.\n\n### 2. Security Best Practice\nNever store sensitive credentials or JWT auth tokens in `localStorage` because any third-party script injected via XSS can read `localStorage`. Use `HttpOnly` cookies for authentication tokens.",
              keyPoints: [
                "HttpOnly cookies cannot be accessed by client JavaScript, neutralizing XSS credential theft.",
                "SameSite=Strict cookies protect against Cross-Site Request Forgery (CSRF) exploits.",
                "Values stored in localStorage and sessionStorage are always serialized as strings.",
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
              title: "Node.js Runtime & Express Server Setup",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Server-Side & REST APIs",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              isCompleted: true,
              objectives: [
                "Understand Node.js asynchronous architecture and the V8 JavaScript engine",
                "Initialize Express.js web application routing and request handlers",
                "Configure environment variables, nodemon, and development tooling",
              ],
              body:
                  "Node.js enables running JavaScript outside the browser as a scalable, high-throughput server runtime.\n\n### 1. Node.js Architecture\nNode combines Google's V8 engine with **libuv**, providing a multi-platform C library that manages an event-driven loop and a thread pool for asynchronous file I/O, DNS queries, and network sockets.\n\n### 2. Express Server Scaffold\n```javascript\nconst express = require('express');\nconst app = express();\n\n// Built-in JSON body parser middleware\napp.use(express.json());\n\n// REST Endpoint\napp.get('/api/health', (req, res) => {\n  res.status(200).json({ status: 'UP', timestamp: new Date().toISOString() });\n});\n\nconst PORT = process.env.PORT || 5000;\napp.listen(PORT, () => console.log(`Server running on port \${PORT}`));\n```",
              keyPoints: [
                "Node.js is single-threaded for execution, but uses libuv thread pool for background I/O operations.",
                "process.env provides access to sensitive configurations without hardcoding keys in source files.",
                "Always modularize Express routes using express.Router() for scalable project structure.",
              ],
            ),
            Lesson(
              id: "WT-L13",
              title: "RESTful Architecture & Middleware Pipelines",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Server-Side & REST APIs",
              chapterPart: "Chapter 6",
              chapterIndex: 6,
              isCompleted: false,
              objectives: [
                "Design RESTful endpoints adhering to HTTP verb semantics and status codes",
                "Build custom Express authentication and request logging middleware",
                "Configure Cross-Origin Resource Sharing (CORS) policies",
              ],
              body:
                  "REST (Representational State Transfer) is an architectural style for stateless, cacheable web APIs.\n\n### 1. RESTful URI Conventions\n- `GET /api/courses` -> List all courses\n- `POST /api/courses` -> Create a new course (Returns 201 Created)\n- `GET /api/courses/:id` -> Retrieve specific course by ID\n- `PUT /api/courses/:id` -> Full replacement of course record\n- `PATCH /api/courses/:id` -> Partial field update\n- `DELETE /api/courses/:id` -> Remove course (Returns 204 No Content)\n\n### 2. Middleware Pipeline Execution\nExpress middleware functions take `(req, res, next)`. They execute sequentially before passing control via `next()`:\n```javascript\nconst authenticate = (req, res, next) => {\n  const token = req.headers.authorization?.split(' ')[1];\n  if (!token) return res.status(401).json({ error: 'Access denied: Token missing' });\n  // Validate token...\n  next();\n};\n```",
              keyPoints: [
                "Idempotency: GET, PUT, and DELETE must produce identical side-effects regardless of repetition.",
                "CORS preflight (OPTIONS request) verifies whether client origin is authorized before POST/PUT/DELETE.",
                "Centralized error-handling middleware must declare 4 arguments: (err, req, res, next).",
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
              title: "Database Connectivity: SQL, NoSQL & Connection Pools",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Database Integration",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              isCompleted: false,
              objectives: [
                "Connect Node.js backends to relational (PostgreSQL) and NoSQL (MongoDB) databases",
                "Implement database connection pooling to handle concurrent web traffic",
                "Prevent SQL injection attacks using parameterized queries and ORMs",
              ],
              body:
                  "Web applications require persistent data stores to record student rosters, grades, and course catalogs.\n\n### 1. SQL vs NoSQL Paradigms\n- **Relational (PostgreSQL/MySQL)**: Structured schemas, ACID transactions, foreign key relationships, complex joins.\n- **Document NoSQL (MongoDB)**: Flexible JSON-like BSON documents, horizontal sharding, rapid prototyping.\n\n### 2. Parameterized Queries vs SQL Injection\nNever concatenate unsanitized user strings into queries:\n```javascript\n// VULNERABLE: Direct concatenation allows ' OR '1'='1\nconst query = `SELECT * FROM users WHERE email = '\${userEmail}'`;\n\n// SECURE: Parameterized statement with placeholder\nconst query = 'SELECT * FROM users WHERE email = \$1';\nconst result = await db.query(query, [userEmail]);\n```\n\n### 3. Connection Pooling\nOpening a fresh database socket on every request introduces massive latency. Connection pools maintain pre-established connections that requests borrow and return immediately.",
              keyPoints: [
                "Connection pooling reuses active database sockets, reducing CPU and handshake overhead.",
                "Parameterized queries ensure user input is treated strictly as literal data, never executable code.",
                "Transactions guarantee ACID atomicity: all operations succeed or all rollback upon failure.",
              ],
            ),
            Lesson(
              id: "WT-L15",
              title: "Web Application Security: Authentication, JWT & Defense",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Database Integration",
              chapterPart: "Chapter 7",
              chapterIndex: 7,
              isCompleted: false,
              objectives: [
                "Implement password hashing using bcrypt with salt rounds",
                "Generate, sign, and verify JSON Web Tokens (JWT) for stateless auth",
                "Mitigate OWASP Top 10 web vulnerabilities (XSS, CSRF, Injection)",
              ],
              body:
                  "Web security requires defense-in-depth across the client, network, and server layers.\n\n### 1. Secure Password Storage\nNever store plaintext passwords in databases. Hash passwords using **bcrypt** with a minimum work factor of 10-12 salt rounds:\n```javascript\nconst salt = await bcrypt.genSalt(12);\nconst hashedPassword = await bcrypt.hash(plaintextPassword, salt);\n```\n\n### 2. JWT Authentication Anatomy\nA JSON Web Token consists of 3 base64url-encoded parts separated by dots:\n1. **Header**: Token type and cryptographic algorithm (e.g. HS256).\n2. **Payload**: Non-sensitive claims (user ID, role, expiration timestamp `exp`).\n3. **Signature**: Hash of header + payload created using the secret key to prevent tampering.\n\n### 3. OWASP Top Defenses\n- **XSS Defense**: Sanitize user inputs, set `Content-Security-Policy` (CSP) headers.\n- **CSRF Defense**: Use `SameSite=Strict` cookies and anti-CSRF challenge tokens.",
              keyPoints: [
                "JWT tokens are signed, not encrypted; never store sensitive data like passwords inside claims.",
                "bcrypt automatically includes the random salt within the resulting hash string.",
                "Helmet.js middleware sets critical security headers (CSP, HSTS, X-Frame-Options) in Express.",
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
              title: "Full-Stack Application Integration & Deployment",
              duration: "20m",
              layoutKind: "concepts",
              chapterTitle: "Course Revision & Assessment Prep",
              chapterPart: "Chapter 8",
              chapterIndex: 8,
              isCompleted: false,
              objectives: [
                "Integrate frontend client applications with backend REST microservices",
                "Manage multi-environment configuration using dotenv and production builds",
                "Deploy web applications using Docker containers and cloud infrastructure",
              ],
              body:
                  "Full-stack engineering connects client user interfaces to backend microservices, caching layers, and production hosting environments.\n\n### 1. End-to-End Request Lifecycle\n1. User triggers an action in the browser (e.g. submitting assignment).\n2. Client-side validation checks input constraints before network dispatch.\n3. Frontend issues an asynchronous `fetch()` request with Bearer JWT token.\n4. Reverse proxy (Nginx) routes request through HTTPS termination to backend.\n5. Express server middleware authenticates token, parses body, and invokes controller.\n6. Controller executes parameterized query on PostgreSQL cluster.\n7. Database returns rows; controller serializes response JSON with HTTP 200.\n8. Frontend updates reactive state and re-renders UI without reloading the page.\n\n### 2. Production Build Optimization\n- Bundle and minify JavaScript and CSS using modern bundlers (Vite/Webpack).\n- Enable Gzip / Brotli asset compression at the web server layer.",
              keyPoints: [
                "Never commit .env files to version control; use secret managers in CI/CD pipelines.",
                "A reverse proxy like Nginx protects application servers, balances load, and caches static assets.",
                "Immutable production builds ensure consistent behavior between staging and live environments.",
              ],
            ),
            Lesson(
              id: "WT-L17",
              title: "Performance Optimization, Lighthouse Audits & Final Prep",
              duration: "15m",
              layoutKind: "practice",
              chapterTitle: "Course Revision & Assessment Prep",
              chapterPart: "Chapter 8",
              chapterIndex: 8,
              isCompleted: false,
              objectives: [
                "Analyze Core Web Vitals: Largest Contentful Paint (LCP), Interaction to Next Paint (INP), and CLS",
                "Optimize critical rendering path with lazy loading and asset preloading",
                "Review comprehensive course checklist covering chapters 1 through 8",
              ],
              body:
                  "Web performance directly impacts user retention, accessibility, and search engine ranking.\n\n### 1. Google Core Web Vitals\n- **Largest Contentful Paint (LCP)**: Target < 2.5s. Measures perceived load speed of the primary content block.\n- **Interaction to Next Paint (INP)**: Target < 200ms. Measures responsiveness to user taps and clicks.\n- **Cumulative Layout Shift (CLS)**: Target < 0.1. Measures visual stability; avoid elements shifting unexpectedly as images load.\n\n### 2. Comprehensive Exam Review Checklist\n✓ HTTP/HTTPS protocols, status codes, and TLS certificates\n✓ HTML5 semantic structure and accessibility (WCAG)\n✓ CSS Box Model, Flexbox alignment, and CSS Grid templates\n✓ JavaScript ES6+, closures, and the asynchronous Event Loop\n✓ DOM traversal, event delegation, and DocumentFragment optimization\n✓ Fetch API, JSON handling, and secure client storage policies\n✓ Node.js event-driven runtime, Express middleware pipelines, and REST design\n✓ Database connection pooling, parameterized queries, and OWASP security",
              keyPoints: [
                "Always declare explicit width and height attributes on images to prevent CLS layout shifts.",
                "Defer non-critical JavaScript using 'defer' or 'async' script tags to prevent render-blocking.",
                "Code splitting and lazy loading route bundles significantly reduce initial bundle size.",
              ],
            ),
            Lesson(
              id: "WT-L18",
              title: "Final Exam Readiness & Certification Checklist",
              duration: "10m",
              layoutKind: "revision",
              chapterTitle: "Course Revision & Assessment Prep",
              chapterPart: "Chapter 8",
              chapterIndex: 8,
              isCompleted: false,
              objectives: [
                "Final verification of full-stack web engineering competencies",
                "Unlock the 30-question proctored course certification assessment",
              ],
              body:
                  "Congratulations! You have completed all 18 lessons across the Web Technologies curriculum.\n\n### Certification Assessment Overview\n- **Format**: 30 multiple-choice and scenario-based diagnostic questions.\n- **Passing Score**: 50% or higher to earn your verified course certificate.\n- **Grading Scale**:\n  • O (Outstanding): 90%+\n  • A+ (Excellent): 80%–89%\n  • A (Very Good): 70%–79%\n  • B (Good): 60%–69%\n  • C (Satisfactory): 50%–59%\n\nReview your notes, ensure you understand the key concepts from each chapter, and proceed when you are ready!",
              keyPoints: [
                "All 18 lessons successfully verified.",
                "Passing the final assessment issues a cryptographically verified certificate.",
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
