import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// =============================================================================
// CURRICULUM DATA MODELS
// =============================================================================

class CourseUnitDetail {
  final int number;
  final String title;
  final int hours;
  final String description;

  const CourseUnitDetail({
    required this.number,
    required this.title,
    required this.hours,
    required this.description,
  });
}

class CurriculumCustomUnitItem {
  final TextEditingController nameCtrl;
  final TextEditingController hoursCtrl;
  final TextEditingController topicsCtrl;

  CurriculumCustomUnitItem({
    required String name,
    required String hours,
    required String topics,
  })  : nameCtrl = TextEditingController(text: name),
        hoursCtrl = TextEditingController(text: hours),
        topicsCtrl = TextEditingController(text: topics);

  void dispose() {
    nameCtrl.dispose();
    hoursCtrl.dispose();
    topicsCtrl.dispose();
  }
}

class CurriculumCourse {
  final String code;
  final String name;
  final int semester;
  final String category; // 'BS', 'PC', 'ES', 'HS'
  final Color categoryColor;
  final String categoryFullName;
  final String ltp; // e.g. '0-0-4', '3-0-0', '3-1-0'
  final int lectureHours;
  final int tutorialHours;
  final int practicalHours;
  final int credits;
  final int unitCount;
  final int totalHours;
  final List<CourseUnitDetail> units;
  final List<String> outcomes;
  final List<String> references;

  const CurriculumCourse({
    required this.code,
    required this.name,
    required this.semester,
    required this.category,
    required this.categoryColor,
    required this.categoryFullName,
    required this.ltp,
    this.lectureHours = 3,
    this.tutorialHours = 0,
    this.practicalHours = 0,
    required this.credits,
    this.unitCount = 5,
    this.totalHours = 45,
    required this.units,
    required this.outcomes,
    required this.references,
  });
}

class CurriculumProgramme {
  final String id;
  final String title;
  final String regulation;
  final String version;
  final int semesters;
  final int courses;
  final String credits;
  final int syllabusWritten;
  final int totalSyllabus;
  final String updatedDate;
  final Map<int, List<CurriculumCourse>> semesterCourses;

  const CurriculumProgramme({
    required this.id,
    required this.title,
    required this.regulation,
    required this.version,
    required this.semesters,
    required this.courses,
    required this.credits,
    required this.syllabusWritten,
    required this.totalSyllabus,
    required this.updatedDate,
    required this.semesterCourses,
  });

  double get syllabusProgress =>
      totalSyllabus > 0 ? (syllabusWritten / totalSyllabus).clamp(0.0, 1.0) : 0.0;
}

// =============================================================================
// CURRICULUM STUDIO MASTER SCREEN
// =============================================================================
class CurriculumStudioScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const CurriculumStudioScreen({super.key, this.onBack});

  @override
  State<CurriculumStudioScreen> createState() => _CurriculumStudioScreenState();
}

class _CurriculumStudioScreenState extends State<CurriculumStudioScreen> {
  // View mode:
  // 0 = Programmes Overview (Image 1)
  // 1 = Programme Detail View (Image 2)
  // 2 = Course Roadmap View (Images from user: University curriculum & My own units)
  int _viewMode = 0;

  late CurriculumProgramme _selectedProgramme;
  int _selectedSemester = 1;

  // Search filter
  final TextEditingController _searchController = TextEditingController();

  // Roadmap Form State (Matches user screenshots exactly)
  int _roadmapSourceTab = 0; // 0 = University curriculum, 1 = My own units
  String _selectedRoadmapCurriculum = "B.Tech. Artificial Intelligence and Data Science (R2026)";
  String _selectedRoadmapCourse = "Sem 1 · AI101 Foundations of Artificial Intelligence & Machine Learning";
  final TextEditingController _roadmapSectionCtrl = TextEditingController(text: "III CSE A");
  DateTime _roadmapFirstClassDate = DateTime(2026, 11, 13);
  final Set<String> _roadmapDays = {"Mon", "Wed", "Fri"};
  bool _roadmapAddInternalAssessments = true;

  // My own units state
  final TextEditingController _customCourseTitleCtrl = TextEditingController();
  final List<CurriculumCustomUnitItem> _customUnits = [];

  // Master Programmes Database
  late final List<CurriculumProgramme> _programmes;

  // Curriculum to Courses Map for Dynamic Switching
  final Map<String, List<String>> _curriculumCoursesMap = {
    "B.Tech. Artificial Intelligence and Data Science (R2026)": [
      "Sem 1 · AI101 Foundations of Artificial Intelligence & Machine Learning",
      "Sem 1 · MA101 Matrices and Calculus (Maths - I)",
      "Sem 1 · CS102 Problem Solving & Python Programming",
    ],
    "B.E. Computer Science & Engineering (R2026)": [
      "Sem 1 · BS101 Physics and Chemistry Laboratory",
      "Sem 1 · CS101 Data Structures and Algorithms",
      "Sem 1 · CS102 Problem Solving & Python Programming",
      "Sem 1 · CS103 Python Programming Laboratory",
      "Sem 1 · CY101 Engineering Chemistry",
      "Sem 1 · HS101 Technical English",
      "Sem 1 · MA101 Matrices and Calculus (Maths - I)",
      "Sem 1 · PH101 Engineering Physics",
    ],
    "B.E. ECE (R2026)": [
      "Sem 1 · EC101 Circuit Analysis & Linear Networks",
      "Sem 1 · EC102 Semiconductor Devices & Analog Circuits",
      "Sem 1 · BS101 Physics and Chemistry Laboratory",
      "Sem 1 · MA101 Matrices and Calculus (Maths - I)",
    ],
  };

  @override
  void initState() {
    super.initState();
    _initData();
    _selectedProgramme = _programmes[0];
    _customUnits.add(
      CurriculumCustomUnitItem(name: "Unit 1", hours: "9", topics: ""),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _roadmapSectionCtrl.dispose();
    _customCourseTitleCtrl.dispose();
    for (final u in _customUnits) {
      u.dispose();
    }
    super.dispose();
  }

  void _initData() {
    // -------------------------------------------------------------------------
    // 8 COURSES FOR B.E. COMPUTER SCIENCE & ENGINEERING (SEMESTER 1 - 23 CR)
    // -------------------------------------------------------------------------
    final List<CurriculumCourse> cseSem1Courses = [
      // 1. BS101
      const CurriculumCourse(
        code: "BS101",
        name: "Physics and Chemistry Laboratory",
        semester: 1,
        category: "BS",
        categoryColor: Color(0xFF3B82F6),
        categoryFullName: "Basic sciences",
        ltp: "0-0-4",
        lectureHours: 0,
        tutorialHours: 0,
        practicalHours: 4,
        credits: 2,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Spectroscopy & Optical Wave Interference",
            hours: 9,
            description:
                "Determination of wavelength of spectral lines using grating spectrometer, laser diffraction and numerical aperture of optical fibers.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Thermal & Electrical Transport Kinetics",
            hours: 9,
            description:
                "Thermal conductivity measurement via Lee's Disc method, Hall effect coefficient analysis and bandgap determination.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Volumetric Water Quality Characterization",
            hours: 9,
            description:
                "Estimation of total, permanent and temporary hardness of water by EDTA titrimetry, alkalinity and dissolved oxygen.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Electrochemical Cell EMF & Potentiometry",
            hours: 9,
            description:
                "Conductometric titration of strong acid against strong base, potentiometric estimation of ferrous ions.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Corrosion Dynamics & Materials Synthesis",
            hours: 9,
            description:
                "Spectrophotometric estimation of iron, determination of rate of corrosion using weight loss method, polymer synthesis.",
          ),
        ],
        outcomes: [
          "CO1: Calibrate and operate optical instruments including spectrometers and semiconductor lasers.",
          "CO2: Analyze electrochemical cell potentials, conductivities, and water quality parameters.",
          "CO3: Quantify material transport properties and rates of chemical decomposition.",
          "CO4: Synthesize standardized experimental reports with statistical error estimations.",
        ],
        references: [
          "1. Department of Physics & Chemistry Lab Manual, Anna University R2026.",
          "2. Vogel's Textbook of Quantitative Chemical Analysis, 6th Edition, Pearson.",
          "3. Practical Physics by G.L. Squires, Cambridge University Press.",
        ],
      ),

      // 2. CS101
      const CurriculumCourse(
        code: "CS101",
        name: "Data Structures and Algorithms",
        semester: 1,
        category: "PC",
        categoryColor: Color(0xFF1E2865),
        categoryFullName: "Professional core",
        ltp: "3-0-0",
        lectureHours: 3,
        tutorialHours: 0,
        practicalHours: 0,
        credits: 3,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Linear Data Structures - Stacks & Queues",
            hours: 9,
            description:
                "Abstract Data Types, dynamic arrays, singly and doubly linked lists, stack applications (infix-to-postfix, recursion), queue variants.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Non-Linear Structures - Trees & Heaps",
            hours: 9,
            description:
                "Binary Trees, BST operations, AVL tree balancing, B-trees, min/max priority heaps, traversal algorithms.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Graph Representations & Traversals",
            hours: 9,
            description:
                "Adjacency lists/matrices, BFS, DFS, topological sorting, connected components, Euler and Hamiltonian paths.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Shortest Path & Spanning Tree Algorithms",
            hours: 9,
            description:
                "Dijkstra's single source shortest path, Bellman-Ford, Floyd-Warshall, Prim's and Kruskal's minimum spanning tree algorithms.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Hashing, Sorting & Complexity Analysis",
            hours: 9,
            description:
                "Hash functions, open addressing, chaining, QuickSort, MergeSort, RadixSort, Big-O, Omega, Theta asymptotic analysis.",
          ),
        ],
        outcomes: [
          "CO1: Implement fundamental linear and non-linear abstract data types with memory safety.",
          "CO2: Design efficient search, insertion, and balancing algorithms for hierarchical tree structures.",
          "CO3: Formulate graph models for networked dependencies and compute optimal paths.",
          "CO4: Evaluate algorithmic time and space complexities using formal asymptotic bounds.",
        ],
        references: [
          "1. Mark Allen Weiss, \"Data Structures and Algorithm Analysis in C++\", 4th Edition, Pearson.",
          "2. Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest, Clifford Stein, \"Introduction to Algorithms\", 4th Edition, MIT Press.",
          "3. Robert Sedgewick, Kevin Wayne, \"Algorithms\", 4th Edition, Addison-Wesley.",
        ],
      ),

      // 3. CS102
      const CurriculumCourse(
        code: "CS102",
        name: "Problem Solving & Python Programming",
        semester: 1,
        category: "ES",
        categoryColor: Color(0xFFF59E0B),
        categoryFullName: "Engineering sciences",
        ltp: "3-0-0",
        lectureHours: 3,
        tutorialHours: 0,
        practicalHours: 0,
        credits: 3,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Computational Thinking & Algorithmic Design",
            hours: 9,
            description:
                "Problem formulation, pseudo-code, flowcharts, building blocks of Python: variables, expressions, statements, type conversions.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Control Flow & Procedural Abstraction",
            hours: 9,
            description:
                "Conditional branching (if-elif-else), definite and indefinite loops (while, for), function definitions, return parameters, scoping rules.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Composite Data Structures",
            hours: 9,
            description:
                "Lists, slicing, tuples, immutable sequences, dictionaries, set theory operations, list comprehensions, lambda expressions.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "File I/O, Exceptions & String Manipulation",
            hours: 9,
            description:
                "String formatting, regex patterns, text and binary file operations, exception handling try-except-finally, custom exceptions.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Modular Architecture & Standard Libraries",
            hours: 9,
            description:
                "Modules, packages, namespaces, Python Standard Library overview (math, os, sys, random), basic object-oriented classes and encapsulation.",
          ),
        ],
        outcomes: [
          "CO1: Formulate algorithmic solutions for computational problems using modular Python functions.",
          "CO2: Manipulate multi-dimensional list, dictionary, and tuple collections efficiently.",
          "CO3: Implement persistent storage workflows with robust exception error recovery.",
          "CO4: Construct maintainable Python packages leveraging standard library modules.",
        ],
        references: [
          "1. Allen B. Downey, \"Think Python: How to Think Like a Computer Scientist\", 2nd Edition, O'Reilly.",
          "2. John V. Guttag, \"Introduction to Computation and Programming Using Python\", MIT Press.",
          "3. Paul Barry, \"Head First Python\", 2nd Edition, O'Reilly Media.",
        ],
      ),

      // 4. CS103
      const CurriculumCourse(
        code: "CS103",
        name: "Python Programming Laboratory",
        semester: 1,
        category: "PC",
        categoryColor: Color(0xFF1E2865),
        categoryFullName: "Professional core",
        ltp: "0-0-4",
        lectureHours: 0,
        tutorialHours: 0,
        practicalHours: 4,
        credits: 2,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Basic Syntax & Arithmetic Logic Pipelines",
            hours: 9,
            description:
                "Development environment setup, scripting commands, quadratic equation solver, temperature conversion, prime generation.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "String Operations & Text Processing",
            hours: 9,
            description:
                "Palindrome checker, word count and frequency analysis, string encryption/decryption using Caesar cipher.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Data Structure Transformations",
            hours: 9,
            description:
                "Matrix addition and multiplication using lists of lists, dictionary phonebook lookup, set operations.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "File Handling & Record Processing",
            hours: 9,
            description:
                "CSV file parser, student grade report computation, logging timestamped events to file.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "GUI Prototyping & Capstone Mini-Project",
            hours: 9,
            description:
                "Basic Tkinter windowing, calculator app, automated web scraping script or data visualization.",
          ),
        ],
        outcomes: [
          "CO1: Execute interactive and compiled Python code within IDE environments.",
          "CO2: Develop command-line data processing tools for text and structured file formats.",
          "CO3: Debug and test algorithmic routines using Python unit testing frameworks.",
          "CO4: Deliver an end-to-end Python software solution adhering to PEP 8 standards.",
        ],
        references: [
          "1. Python Lab Practice Manual, Department of Computer Science & Engineering.",
          "2. Al Sweigart, \"Automate the Boring Stuff with Python\", No Starch Press.",
        ],
      ),

      // 5. CY101
      const CurriculumCourse(
        code: "CY101",
        name: "Engineering Chemistry",
        semester: 1,
        category: "BS",
        categoryColor: Color(0xFF3B82F6),
        categoryFullName: "Basic sciences",
        ltp: "3-0-0",
        lectureHours: 3,
        tutorialHours: 0,
        practicalHours: 0,
        credits: 3,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Water Technology & Desalination",
            hours: 9,
            description:
                "Hardness sources, boiler feed water troubles (scale, sludge, priming, foaming, caustic embrittlement), reverse osmosis, ion-exchange.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Surface Chemistry & Catalysis",
            hours: 9,
            description:
                "Adsorption isotherms (Freundlich, Langmuir), contact angle, enzyme catalysis, homogeneous and heterogeneous catalytic converters.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Phase Rule & Structural Alloys",
            hours: 9,
            description:
                "Gibbs phase rule terms, one component water system, two component Pb-Ag system, eutectic point, heat treatment of steel.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Energy Storage Systems & Batteries",
            hours: 9,
            description:
                "Primary vs secondary cells, lead-acid storage, nickel-cadmium, modern lithium-ion intercalation batteries, hydrogen-oxygen fuel cells.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Nano-materials & Engineering Polymers",
            hours: 9,
            description:
                "Carbon nanotubes, fullerenes, chemical vapor deposition, thermoplastics, thermosetting resins, conducting polymers (polyacetylene, polyaniline).",
          ),
        ],
        outcomes: [
          "CO1: Calculate water softening treatment dosages and prevent industrial boiler scaling.",
          "CO2: Analyze phase equilibria diagrams for metallurgical binary alloy systems.",
          "CO3: Explain electrochemical reaction mechanisms in modern energy storage devices.",
          "CO4: Recommend nano-materials and specialty polymers for advanced engineering applications.",
        ],
        references: [
          "1. P. C. Jain and Monica Jain, \"Engineering Chemistry\", 17th Edition, Dhanpat Rai Publishing.",
          "2. S. S. Dara and S. S. Umare, \"A Textbook of Engineering Chemistry\", S. Chand.",
        ],
      ),

      // 6. HS101
      const CurriculumCourse(
        code: "HS101",
        name: "Technical English",
        semester: 1,
        category: "HS",
        categoryColor: Color(0xFFEF4444),
        categoryFullName: "Humanities & social sciences",
        ltp: "3-0-0",
        lectureHours: 3,
        tutorialHours: 0,
        practicalHours: 0,
        credits: 3,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Grammar Foundations & Lexical Precision",
            hours: 9,
            description:
                "Tenses, subject-verb concord, compound nouns, prepositional phrases, technical vocabulary in context.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Technical Reading & Analytical Synthesis",
            hours: 9,
            description:
                "Skimming and scanning research abstracts, identifying central thesis, note-making, critical evaluation of engineering case studies.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Professional Written Communication",
            hours: 9,
            description:
                "Email etiquette, memo composition, formal letters of inquiry, incident reports, technical instruction manuals.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Oral Presentations & Group Discussion",
            hours: 9,
            description:
                "Verbal clarity, slide deck structure, participating in engineering debates, handling audience Q&A, active listening.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Technical Proposal & Report Drafting",
            hours: 9,
            description:
                "Structure of engineering feasibility reports, project proposals, referencing IEEE format, avoiding plagiarism.",
          ),
        ],
        outcomes: [
          "CO1: Express technical assertions with grammatical precision and appropriate engineering nomenclature.",
          "CO2: Read, interpret, and summarize complex research papers and technical whitepapers.",
          "CO3: Compose formal engineering correspondence, proposals, and project reports.",
          "CO4: Deliver structured presentations with compelling visual and verbal delivery.",
        ],
        references: [
          "1. Raman, Meenakshi & Sharma, Sangeeta, \"Technical Communication: Principles and Practice\", Oxford University Press.",
          "2. Rizvi, M. Ashraf, \"Effective Technical Communication\", Tata McGraw-Hill.",
        ],
      ),

      // 7. MA101
      const CurriculumCourse(
        code: "MA101",
        name: "Matrices and Calculus (Maths - I)",
        semester: 1,
        category: "BS",
        categoryColor: Color(0xFF3B82F6),
        categoryFullName: "Basic sciences",
        ltp: "3-1-0",
        lectureHours: 3,
        tutorialHours: 1,
        practicalHours: 0,
        credits: 4,
        totalHours: 60,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Matrices & Linear Transformations",
            hours: 12,
            description:
                "Characteristic equations, eigenvalues and eigenvectors, Cayley-Hamilton theorem, orthogonal transformation of symmetric matrices, quadratic forms.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Differential Calculus of Single Variable",
            hours: 12,
            description:
                "Representation of functions, limits, continuity, derivatives, mean value theorems, Taylor and Maclaurin expansions, indeterminate forms.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Functions of Several Variables",
            hours: 12,
            description:
                "Partial derivatives, total derivatives, Jacobians, Taylor series in two variables, extrema of functions, Lagrange multipliers method.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Multiple Integrals & Coordinate Systems",
            hours: 12,
            description:
                "Double integrals in cartesian and polar coordinates, change of order of integration, area between curves, triple integrals, volume evaluation.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Vector Calculus & Field Theorems",
            hours: 12,
            description:
                "Gradient, divergence and curl, directional derivatives, solenoidal and irrotational fields, Green's, Gauss divergence and Stokes theorems.",
          ),
        ],
        outcomes: [
          "CO1: Diagonalize square matrices and reduce quadratic forms to canonical forms.",
          "CO2: Apply differential calculus to locate maxima, minima and saddle points of multivariate systems.",
          "CO3: Evaluate double and triple integrals over complex planar and spatial domains.",
          "CO4: Compute flux and circulation integrals using Green's, Stokes' and Divergence theorems.",
        ],
        references: [
          "1. B. S. Grewal, \"Higher Engineering Mathematics\", 44th Edition, Khanna Publishers.",
          "2. Erwin Kreyszig, \"Advanced Engineering Mathematics\", 10th Edition, John Wiley & Sons.",
        ],
      ),

      // 8. PH101
      const CurriculumCourse(
        code: "PH101",
        name: "Engineering Physics",
        semester: 1,
        category: "BS",
        categoryColor: Color(0xFF3B82F6),
        categoryFullName: "Basic sciences",
        ltp: "3-0-0",
        lectureHours: 3,
        tutorialHours: 0,
        practicalHours: 0,
        credits: 3,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Oscillations, Waves & Fiber Optics",
            hours: 9,
            description:
                "Damped and forced harmonic oscillations, resonance, wave equation on a string, fiber optic principles, numerical aperture, attenuation.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Quantum Physics & Wave Mechanics",
            hours: 9,
            description:
                "Black body radiation, Compton effect, de Broglie matter waves, Heisenberg uncertainty principle, Schrödinger time-independent wave equation.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Laser Physics & Applications",
            hours: 9,
            description:
                "Spontaneous and stimulated emission, Einstein coefficients, population inversion, optical resonator, Nd:YAG and semiconductor diode lasers.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Semiconductor Physics & Transport",
            hours: 9,
            description:
                "Intrinsic and extrinsic semiconductors, carrier concentration, Fermi level, Hall effect, drift and diffusion currents, p-n junction diode.",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Superconductivity & Magnetic Materials",
            hours: 9,
            description:
                "Meissner effect, Type I and Type II superconductors, BCS theory overview, dia, para, and ferromagnetic domains, hysteresis.",
          ),
        ],
        outcomes: [
          "CO1: Solve wave propagation equations in acoustic, optical and mechanical waveguides.",
          "CO2: Model microscopic quantum phenomena using one-dimensional Schrödinger potentials.",
          "CO3: Analyze laser emission characteristics and operational modes for industrial applications.",
          "CO4: Determine electrical and magnetic transport parameters in semiconductor devices.",
        ],
        references: [
          "1. Arthur Beiser, \"Concepts of Modern Physics\", McGraw-Hill.",
          "2. Charles Kittel, \"Introduction to Solid State Physics\", 8th Edition, John Wiley & Sons.",
        ],
      ),
    ];

    // -------------------------------------------------------------------------
    // B.Tech. AI & DS (Matches Screenshot 2 from user!)
    // -------------------------------------------------------------------------
    final List<CurriculumCourse> aidsSem1Courses = [
      const CurriculumCourse(
        code: "AI101",
        name: "Foundations of Artificial Intelligence & Machine Learning",
        semester: 1,
        category: "PC",
        categoryColor: Color(0xFF1E2865),
        categoryFullName: "Professional core",
        ltp: "3-0-2",
        lectureHours: 3,
        tutorialHours: 0,
        practicalHours: 2,
        credits: 4,
        totalHours: 45,
        units: [
          CourseUnitDetail(
            number: 1,
            title: "Unit 1: Introduction to AI and Intelligent",
            hours: 9,
            description:
                "Overview of AI paradigms, agent environments, problem formulate state spaces, uninformed and informed heuristic search strategies, adversarial search, game trees, alpha-beta pruning, constraint satisfaction problems.",
          ),
          CourseUnitDetail(
            number: 2,
            title: "Unit 2: Problem Solving by Search",
            hours: 9,
            description:
                "Heuristic design, A*, IDA*, local search algorithms, genetic algorithms, constraint propagation, backtracking search for CSPs, forward checking, arc consistency.",
          ),
          CourseUnitDetail(
            number: 3,
            title: "Unit 3: Knowledge Representation",
            hours: 9,
            description:
                "Propositional and first-order predicate logic, inference rules, forward and backward chaining, resolution, ontologies, semantic networks, frame systems, probabilistic reasoning under uncertainty.",
          ),
          CourseUnitDetail(
            number: 4,
            title: "Unit 4: Introduction to Machine Lea",
            hours: 9,
            description:
                "Supervised, unsupervised, reinforcement learning basics; inductive bias, overfitting/underfitting, cross-validation, regularization, evaluation metrics (precision, recall, F1, ROC-AUC).",
          ),
          CourseUnitDetail(
            number: 5,
            title: "Unit 5: Supervised Learning Algorith",
            hours: 9,
            description:
                "Linear and logistic regression, decision trees, random forests, support vector machines, naive bayes classifiers, ensemble techniques (boosting, bagging, stacking), bias-variance tradeoff.",
          ),
        ],
        outcomes: [
          "CO1: Formulate search heuristics for complex constraint satisfaction and optimization problems.",
          "CO2: Apply probabilistic reasoning and logic resolution in uncertain domains.",
          "CO3: Construct, train, and evaluate supervised learning models on tabular datasets.",
          "CO4: Synthesize ensemble decision rules and validate bias-variance performance tradeoffs.",
        ],
        references: [
          "1. Stuart Russell and Peter Norvig, \"Artificial Intelligence: A Modern Approach\", 4th Edition, Pearson.",
          "2. Tom M. Mitchell, \"Machine Learning\", McGraw-Hill.",
          "3. Ethem Alpaydin, \"Introduction to Machine Learning\", MIT Press.",
        ],
      ),
    ];

    // -------------------------------------------------------------------------
    // THE 3 MASTER PROGRAMMES
    // -------------------------------------------------------------------------
    _programmes = [
      CurriculumProgramme(
        id: "prog_cse",
        title: "B.E. Computer Science & Engineering",
        regulation: "Regulation R2026",
        version: "Published · v9",
        semesters: 8,
        courses: 8,
        credits: "23",
        syllabusWritten: 8,
        totalSyllabus: 8,
        updatedDate: "Updated 13 Oct 2026 by University Super Admin",
        semesterCourses: {
          1: cseSem1Courses,
          2: [],
          3: [],
          4: [],
          5: [],
          6: [],
          7: [],
          8: [],
        },
      ),
      CurriculumProgramme(
        id: "prog_ece",
        title: "B.E. ECE",
        regulation: "Regulation R2026",
        version: "Published · v1",
        semesters: 8,
        courses: 58,
        credits: "155.5",
        syllabusWritten: 0,
        totalSyllabus: 58,
        updatedDate: "Updated 30 Oct 2026 by University Super Admin",
        semesterCourses: {
          1: [],
          2: [],
          3: [],
          4: [],
          5: [],
          6: [],
          7: [],
          8: [],
        },
      ),
      CurriculumProgramme(
        id: "prog_aids",
        title: "B.Tech. Artificial Intelligence and Data Science",
        regulation: "Regulation R2026",
        version: "Published · v1",
        semesters: 8,
        courses: 1,
        credits: "4",
        syllabusWritten: 1,
        totalSyllabus: 1,
        updatedDate: "Updated 8 Oct 2026 by University Super Admin",
        semesterCourses: {
          1: aidsSem1Courses,
          2: [],
          3: [],
          4: [],
          5: [],
          6: [],
          7: [],
          8: [],
        },
      ),
    ];
  }

  // ===========================================================================
  // NAVIGATION HANDLERS & MODAL TRIGGERS
  // ===========================================================================

  void _openProgramme(CurriculumProgramme prog) {
    setState(() {
      _selectedProgramme = prog;
      _selectedSemester = 1;
      _viewMode = 1;
    });
  }

  void _openPlanTeaching(CurriculumCourse course) {
    setState(() {
      _selectedRoadmapCurriculum = "${_selectedProgramme.title} (${_selectedProgramme.regulation.replaceAll('Regulation ', '')})";
      _selectedRoadmapCourse = "Sem ${course.semester} · ${course.code} ${course.name}";
      _viewMode = 2; // Transition to Course Roadmap Form
    });
  }

  void _openCourseSyllabusModal(CurriculumCourse course) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => _CourseSyllabusDetailModal(course: course),
    );
  }

  // ===========================================================================
  // BUILD METHOD (RESPONSIVE ROUTING)
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (_viewMode == 2) {
            // VIEW 2: COURSE ROADMAP FORM (MATCHES SCREENSHOTS 1 & 2)
            return _buildCourseRoadmapView(constraints);
          } else if (_viewMode == 1) {
            // VIEW 1: PROGRAMME DETAIL VIEW (MATCHING IMAGE 2)
            return _buildProgrammeDetailView(constraints);
          } else {
            // VIEW 0: CURRICULUM STUDIO OVERVIEW (MATCHING IMAGE 1)
            return _buildProgrammesOverview(constraints);
          }
        },
      ),
    );
  }

  // ===========================================================================
  // VIEW 0: CURRICULUM STUDIO OVERVIEW
  // ===========================================================================
  Widget _buildProgrammesOverview(BoxConstraints constraints) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroBanner(),
          const SizedBox(height: 20),
          Text(
            "Your university's published curricula. Open a programme to see each course's syllabus, and plan your teaching from it.",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xFF475569),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          _buildProgrammesGrid(constraints),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.layers_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "University",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF818CF8)),
                        const SizedBox(width: 6),
                        Text(
                          "Curriculum Studio",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865).withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF3B487A),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.layers_rounded,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A2352),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: const Color(0xFF38467D), width: 1),
                                  ),
                                  child: Text(
                                    "UNIVERSITY",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Curriculum Studio",
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Prepare programme curricula: semesters, courses, credits, L–T–P, syllabus units and course outcomes, drafted with AI and published to every college.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFFC7D2FE).withValues(alpha: 0.9),
                                height: 1.35,
                              ),
                            ),
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
    );
  }

  Widget _buildProgrammesGrid(BoxConstraints constraints) {
    final width = constraints.maxWidth;

    if (width >= 1020) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _programmes.map((prog) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildProgrammeCard(prog),
            ),
          );
        }).toList(),
      );
    } else if (width >= 660) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: _programmes.map((prog) {
          return SizedBox(
            width: (width - 48 - 16) / 2,
            child: _buildProgrammeCard(prog),
          );
        }).toList(),
      );
    } else {
      return Column(
        children: _programmes.map((prog) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildProgrammeCard(prog),
          );
        }).toList(),
      );
    }
  }

  Widget _buildProgrammeCard(CurriculumProgramme prog) {
    return InkWell(
      onTap: () => _openProgramme(prog),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.article_outlined,
                      size: 17,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFA7F3D0).withValues(alpha: 0.6),
                    ),
                  ),
                  child: Text(
                    prog.version,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0D9488),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              prog.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              prog.regulation,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Row(
                children: [
                  _buildStatTile("Semesters", "${prog.semesters}"),
                  _buildStatTile("Courses", "${prog.courses}"),
                  _buildStatTile("Credits", prog.credits),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Syllabus written",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Text(
                  "${prog.syllabusWritten}/${prog.totalSyllabus}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: prog.syllabusProgress,
                minHeight: 4,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              prog.updatedDate,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // VIEW 1: PROGRAMME DETAIL VIEW (MATCHING IMAGE 2)
  // ===========================================================================
  Widget _buildProgrammeDetailView(BoxConstraints constraints) {
    final prog = _selectedProgramme;
    final isDesktop = constraints.maxWidth >= 980;

    final courses = prog.semesterCourses[_selectedSemester] ?? [];

    int hsCredits = 0;
    int bsCredits = 0;
    int esCredits = 0;
    int pcCredits = 0;

    for (final c in courses) {
      if (c.category == 'HS') hsCredits += c.credits;
      if (c.category == 'BS') bsCredits += c.credits;
      if (c.category == 'ES') esCredits += c.credits;
      if (c.category == 'PC') pcCredits += c.credits;
    }

    final totalSemCredits = hsCredits + bsCredits + esCredits + pcCredits;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => setState(() => _viewMode = 0),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: Color(0xFF1E2865),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            prog.title,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFA7F3D0).withValues(alpha: 0.6),
                            ),
                          ),
                          child: Text(
                            prog.version,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0D9488),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${prog.regulation} · ${prog.semesters} semesters · ${prog.courses} courses · ${prog.credits} credits",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _buildCoursesTableSection(courses, totalSemCredits),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 3,
                  child: _buildCreditMixCard(
                    totalSemCredits: totalSemCredits,
                    hsCredits: hsCredits,
                    bsCredits: bsCredits,
                    esCredits: esCredits,
                    pcCredits: pcCredits,
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCoursesTableSection(courses, totalSemCredits),
                const SizedBox(height: 20),
                _buildCreditMixCard(
                  totalSemCredits: totalSemCredits,
                  hsCredits: hsCredits,
                  bsCredits: bsCredits,
                  esCredits: esCredits,
                  pcCredits: pcCredits,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCoursesTableSection(List<CurriculumCourse> courses, int totalCredits) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_selectedProgramme.semesters, (index) {
              final semNum = index + 1;
              final isSelected = _selectedSemester == semNum;
              final semCourses = _selectedProgramme.semesterCourses[semNum] ?? [];
              final semCr = semCourses.fold<int>(0, (sum, c) => sum + c.credits);

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => setState(() => _selectedSemester = semNum),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: const Color(0xFF1E2865).withValues(alpha: 0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                      ],
                    ),
                    child: Text(
                      "Sem $semNum ($semCr cr)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (courses.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Center(
                    child: Text(
                      "No published courses for Semester $_selectedSemester in this regulation yet.",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 800),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(const Color(0xFFFAF7F0)),
                      headingTextStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                      dataTextStyle: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF1E293B),
                      ),
                      horizontalMargin: 16,
                      columnSpacing: 18,
                      columns: const [
                        DataColumn(label: SizedBox(width: 65, child: Text("Code"))),
                        DataColumn(label: SizedBox(width: 230, child: Text("Course"))),
                        DataColumn(label: SizedBox(width: 50, child: Text("Cat."))),
                        DataColumn(label: SizedBox(width: 60, child: Text("L-T-P"))),
                        DataColumn(label: SizedBox(width: 55, child: Text("Credits"))),
                        DataColumn(label: SizedBox(width: 80, child: Text("Syllabus"))),
                        DataColumn(label: SizedBox(width: 100, child: Text("Plan teaching"))),
                        DataColumn(label: SizedBox(width: 50, child: Text("View"))),
                      ],
                      rows: courses.map((c) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                c.code,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            DataCell(
                              InkWell(
                                onTap: () => _openCourseSyllabusModal(c),
                                child: Text(
                                  c.name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: c.categoryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    c.category,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.5,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              Text(
                                c.ltp,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                "${c.credits}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFFA7F3D0).withValues(alpha: 0.6),
                                  ),
                                ),
                                child: Text(
                                  "${c.unitCount} units",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF0D9488),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              InkWell(
                                onTap: () => _openPlanTeaching(c),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                                  child: Text(
                                    "Plan teaching",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2563EB),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              InkWell(
                                onTap: () => _openCourseSyllabusModal(c),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                                  child: Text(
                                    "View",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF2563EB),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  "Semester $_selectedSemester: $totalCredits credits in ${courses.length} courses",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // CREDIT MIX SIDEBAR CARD
  // ===========================================================================
  Widget _buildCreditMixCard({
    required int totalSemCredits,
    required int hsCredits,
    required int bsCredits,
    required int esCredits,
    required int pcCredits,
  }) {
    final hasCredits = totalSemCredits > 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Credit mix",
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              Text(
                "$totalSemCredits credits in all",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: hasCredits
                  ? Row(
                      children: [
                        if (hsCredits > 0)
                          Expanded(
                            flex: hsCredits,
                            child: Container(color: const Color(0xFFEF4444)),
                          ),
                        if (bsCredits > 0)
                          Expanded(
                            flex: bsCredits,
                            child: Container(color: const Color(0xFF3B82F6)),
                          ),
                        if (esCredits > 0)
                          Expanded(
                            flex: esCredits,
                            child: Container(color: const Color(0xFFF59E0B)),
                          ),
                        if (pcCredits > 0)
                          Expanded(
                            flex: pcCredits,
                            child: Container(color: const Color(0xFF1E2865)),
                          ),
                      ],
                    )
                  : Container(color: const Color(0xFFE2E8F0)),
            ),
          ),
          const SizedBox(height: 16),
          _buildCreditMixRow("Humanities & social sciences", hsCredits, const Color(0xFFEF4444)),
          const SizedBox(height: 10),
          _buildCreditMixRow("Basic sciences", bsCredits, const Color(0xFF3B82F6)),
          const SizedBox(height: 10),
          _buildCreditMixRow("Engineering sciences", esCredits, const Color(0xFFF59E0B)),
          const SizedBox(height: 10),
          _buildCreditMixRow("Professional core", pcCredits, const Color(0xFF1E2865)),
        ],
      ),
    );
  }

  Widget _buildCreditMixRow(String label, int credits, Color dotColor) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF334155),
            ),
          ),
        ),
        Text(
          "$credits",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // VIEW 2: COURSE ROADMAP FORM (MATCHES SCREENSHOTS 1 & 2 EXACTLY)
  // ===========================================================================
  Widget _buildCourseRoadmapView(BoxConstraints constraints) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New course roadmap card (White, rounded, matches user screenshots)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New course roadmap",
                      style: GoogleFonts.poppins(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() => _viewMode = 1),
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                        child: const Icon(Icons.close_rounded, size: 18, color: Color(0xFF94A3B8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Pill Container with University curriculum | My own units
                // Exactly matching user screenshots 1 & 2!
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildRoadmapSourceTab(
                        title: "University curriculum",
                        isSelected: _roadmapSourceTab == 0,
                        isCustomAmber: false,
                        onTap: () => setState(() => _roadmapSourceTab = 0),
                      ),
                      const SizedBox(width: 4),
                      _buildRoadmapSourceTab(
                        title: "My own units",
                        isSelected: _roadmapSourceTab == 1,
                        isCustomAmber: true, // Matches golden/amber border in screenshot 1!
                        onTap: () => setState(() => _roadmapSourceTab = 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // TAB 0: UNIVERSITY CURRICULUM (SCREENSHOT 2)
                if (_roadmapSourceTab == 0) ...[
                  LayoutBuilder(
                    builder: (context, c) {
                      final isNarrow = c.maxWidth < 640;
                      if (isNarrow) {
                        return Column(
                          children: [
                            _buildCurriculumDropdown(),
                            const SizedBox(height: 16),
                            _buildCourseDropdown(),
                          ],
                        );
                      } else {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildCurriculumDropdown()),
                            const SizedBox(width: 16),
                            Expanded(child: _buildCourseDropdown()),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "5 units · 45 hours",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ] else ...[
                  // TAB 1: MY OWN UNITS (SCREENSHOT 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Course title",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _customCourseTitleCtrl,
                        style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Unit Cards List
                      ..._customUnits.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final unit = entry.value;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: unit.nameCtrl,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1E293B),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 60,
                                    child: TextField(
                                      controller: unit.hoursCtrl,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF1E293B),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_customUnits.length > 1) ...[
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _customUnits.removeAt(idx);
                                        });
                                      },
                                      icon: const Icon(Icons.remove_circle_outline_rounded, size: 20, color: Color(0xFF94A3B8)),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: unit.topicsCtrl,
                                maxLines: 2,
                                style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                                decoration: InputDecoration(
                                  hintText: "Topics, comma-separated",
                                  hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      // + Add unit button
                      InkWell(
                        onTap: () {
                          setState(() {
                            final nextNum = _customUnits.length + 1;
                            _customUnits.add(
                              CurriculumCustomUnitItem(name: "Unit $nextNum", hours: "9", topics: ""),
                            );
                          });
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.add_rounded, size: 18, color: Color(0xFF1E2865)),
                              const SizedBox(width: 4),
                              Text(
                                "Add unit",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E2865),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),

                // Class/section, First class on, Teaching days Row
                LayoutBuilder(
                  builder: (context, c) {
                    final isNarrow = c.maxWidth < 880;
                    if (isNarrow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildClassSectionField(),
                          const SizedBox(height: 16),
                          _buildFirstClassDateField(),
                          const SizedBox(height: 16),
                          _buildTeachingDaysSelector(),
                        ],
                      );
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: _buildClassSectionField()),
                          const SizedBox(width: 16),
                          Expanded(flex: 3, child: _buildFirstClassDateField()),
                          const SizedBox(width: 16),
                          Expanded(flex: 4, child: _buildTeachingDaysSelector()),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Checkbox & Build roadmap button row
                LayoutBuilder(
                  builder: (context, c) {
                    final isSmall = c.maxWidth < 680;

                    final checkboxWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _roadmapAddInternalAssessments,
                          activeColor: const Color(0xFF1E2865),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (val) {
                            setState(() => _roadmapAddInternalAssessments = val ?? true);
                          },
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              setState(() => _roadmapAddInternalAssessments = !_roadmapAddInternalAssessments);
                            },
                            child: Text(
                              "Add internal assessments after units 2 and 4",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );

                    final buildBtn = ElevatedButton(
                      onPressed: _buildRoadmapAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.alt_route_rounded, size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            "Build roadmap",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );

                    if (isSmall) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          checkboxWidget,
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: buildBtn,
                          ),
                        ],
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        checkboxWidget,
                        buildBtn,
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapSourceTab({
    required String title,
    required bool isSelected,
    required bool isCustomAmber,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: isCustomAmber ? const Color(0xFFD97706) : const Color(0xFFCBD5E1),
                  width: isCustomAmber ? 1.5 : 1.0,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  Widget _buildCurriculumDropdown() {
    final curOptions = [
      "B.Tech. Artificial Intelligence and Data Science (R2026)",
      "B.E. Computer Science & Engineering (R2026)",
      "B.E. ECE (R2026)",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Curriculum",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedRoadmapCurriculum,
              items: curOptions.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt,
                  child: Text(
                    opt,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedRoadmapCurriculum = val;
                    final list = _curriculumCoursesMap[val] ?? [];
                    if (list.isNotEmpty) {
                      _selectedRoadmapCourse = list.first;
                    }
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCourseDropdown() {
    final availableCourses = _curriculumCoursesMap[_selectedRoadmapCurriculum] ?? [
      _selectedRoadmapCourse,
    ];

    if (!availableCourses.contains(_selectedRoadmapCourse) && availableCourses.isNotEmpty) {
      _selectedRoadmapCourse = availableCourses.first;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Course",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedRoadmapCourse,
              items: availableCourses.map((opt) {
                return DropdownMenuItem<String>(
                  value: opt,
                  child: Text(
                    opt,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedRoadmapCourse = val);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassSectionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Class / section",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _roadmapSectionCtrl,
          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
          decoration: InputDecoration(
            hintText: "e.g. III CSE A",
            hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFirstClassDateField() {
    final dateStr = DateFormat("MM/dd/yyyy").format(_roadmapFirstClassDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "First class on",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _roadmapFirstClassDate,
              firstDate: DateTime(2025),
              lastDate: DateTime(2030),
            );
            if (picked != null) {
              setState(() => _roadmapFirstClassDate = picked);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateStr,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E293B)),
                ),
                const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF64748B)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeachingDaysSelector() {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Teaching days",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5,
            runSpacing: 6,
            children: days.map((day) {
              final isSelected = _roadmapDays.contains(day);
              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      if (_roadmapDays.length > 1) _roadmapDays.remove(day);
                    } else {
                      _roadmapDays.add(day);
                    }
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    day,
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _buildRoadmapAction() {
    final title = _roadmapSourceTab == 0
        ? _selectedRoadmapCourse
        : (_customCourseTitleCtrl.text.isNotEmpty ? _customCourseTitleCtrl.text : "Custom Course");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Teaching roadmap created successfully for $title! (${_roadmapDays.join(', ')})",
          style: GoogleFonts.poppins(fontSize: 12.5),
        ),
        backgroundColor: const Color(0xFF0D9488),
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() => _viewMode = 1);
  }
}

// =============================================================================
// COURSE SYLLABUS & OUTCOMES MODAL (MATCHING IMAGES 4 & 5 EXACTLY)
// =============================================================================
class _CourseSyllabusDetailModal extends StatelessWidget {
  final CurriculumCourse course;
  const _CourseSyllabusDetailModal({required this.course});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 760),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.code,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          course.name,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildReadonlyField("Code", course.code),
                      const SizedBox(height: 12),
                      _buildReadonlyField("Title", course.name),
                      const SizedBox(height: 14),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildMetaPill("Semester: ${course.semester}"),
                            const SizedBox(width: 8),
                            _buildMetaPill("Category: ${course.category}"),
                            const SizedBox(width: 8),
                            _buildMetaPill("L: ${course.lectureHours}"),
                            const SizedBox(width: 8),
                            _buildMetaPill("T: ${course.tutorialHours}"),
                            const SizedBox(width: 8),
                            _buildMetaPill("P: ${course.practicalHours}"),
                            const SizedBox(width: 8),
                            _buildMetaPill("Credits: ${course.credits}"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        "Syllabus · ${course.totalHours} hours",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...course.units.map((unit) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        unit.title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEEF2FF),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        "${unit.hours} hrs",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF4338CA),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  unit.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF475569),
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 14),

                      Text(
                        "Course outcomes (one per line)",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Text(
                          course.outcomes.join("\n"),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF1E293B),
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "Textbooks and references (one per line)",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Text(
                          course.references.join("\n"),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF1E293B),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                      elevation: 0,
                    ),
                    child: Text(
                      "Close",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadonlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetaPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF334155),
        ),
      ),
    );
  }
}

// =============================================================================
// SUBTLE BLUEPRINT GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _GridPaperPainter({required this.gridColor, this.step = 26.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
