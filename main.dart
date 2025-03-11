import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const BeverageStoreApp());
}

class BeverageStoreApp extends StatelessWidget {
  const BeverageStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Arbaoui ',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFC107), // Yellow primary color
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC107), // Yellow seed color
          primary: const Color(0xFFFFC107), // Yellow primary
          secondary: const Color(0xFF212121), // Black secondary
          tertiary: const Color(0xFF757575), // Gray tertiary
          background: const Color(0xFFF7F9FC),
        ),
        fontFamily: 'Almarai',
        textTheme: const TextTheme(
          headlineMedium:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          titleLarge:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          bodyLarge: TextStyle(color: Color(0xFF212121)),
          bodyMedium: TextStyle(color: Color(0xFF212121)),
        ),
        cardTheme: CardTheme(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC107), // Yellow background
            foregroundColor: Colors.black, // Black text
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: Color(0xFFFFC107), width: 2), // Yellow focused border
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'SA'),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF212121),
              Color(0xFF424242)
            ], // Black to dark gray gradient
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.local_drink_rounded,
                            size: 70,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        ' متجر المشروبات',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        ' إدارة المخزون والمبيعات',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Models
enum UserRole { owner, branchDeputy }

class User {
  final String id;
  final String username;
  final String password;
  final UserRole role;
  final String? branchId;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    this.branchId,
  });
}

class Branch {
  final String id;
  final String name;
  final String location;
  final String deputyId;
  final List<DailyReport> reports;

  Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.deputyId,
    required this.reports,
  });

  double getTotalRevenue() {
    double total = 0;
    for (var report in reports) {
      for (var inventory in report.inventories) {
        final beverage =
            beverages.firstWhere((b) => b.id == inventory.beverageId);
        total += inventory.smallBottlesSold * beverage.smallBottlePrice;
        total += inventory.largeBottlesSold * beverage.largeBottlePrice;
      }
    }
    return total;
  }

  int getTotalSoldBottles() {
    int total = 0;
    for (var report in reports) {
      for (var inventory in report.inventories) {
        total += inventory.smallBottlesSold + inventory.largeBottlesSold;
      }
    }
    return total;
  }
}

class Beverage {
  String id;
  String name;
  double smallBottlePrice;
  double largeBottlePrice;

  Beverage({
    required this.id,
    required this.name,
    required this.smallBottlePrice,
    required this.largeBottlePrice,
  });
}

class BottleInventory {
  String beverageId;
  int smallBottlesPrevious;
  int largeBottlesPrevious;
  int smallBottlesPurchased;
  int largeBottlesPurchased;
  int smallBottlesLost;
  int largeBottlesLost;
  int smallBottlesRemaining;
  int largeBottlesRemaining;

  BottleInventory({
    required this.beverageId,
    required this.smallBottlesPrevious,
    required this.largeBottlesPrevious,
    required this.smallBottlesPurchased,
    required this.largeBottlesPurchased,
    required this.smallBottlesLost,
    required this.largeBottlesLost,
    required this.smallBottlesRemaining,
    required this.largeBottlesRemaining,
  });

  int get smallBottlesSold => (smallBottlesPrevious +
      smallBottlesPurchased -
      smallBottlesLost -
      smallBottlesRemaining);
  int get largeBottlesSold => (largeBottlesPrevious +
      largeBottlesPurchased -
      largeBottlesLost -
      largeBottlesRemaining);
}

class DailyReport {
  String id;
  DateTime date;
  DateTime lastEditTime;
  List<BottleInventory> inventories;

  DailyReport({
    required this.id,
    required this.date,
    required this.lastEditTime,
    required this.inventories,
  });

  bool get canEdit {
    final Duration difference = DateTime.now().difference(lastEditTime);
    return difference.inHours < 20;
  }

  // Update this report with values from another report
  void updateFrom(DailyReport other) {
    if (id == other.id) {
      lastEditTime = other.lastEditTime;
      inventories = other.inventories;
    }
  }
}

// Mock data
final List<User> users = [
  User(
    id: '1',
    username: 'owner',
    password: 'password',
    role: UserRole.owner,
  ),
  User(
    id: '2',
    username: 'deputy1',
    password: 'password',
    role: UserRole.branchDeputy,
    branchId: '1',
  ),
  User(
    id: '3',
    username: 'deputy2',
    password: 'password',
    role: UserRole.branchDeputy,
    branchId: '2',
  ),
];

final List<Beverage> beverages = [
  Beverage(
      id: '1', name: 'ليمون', smallBottlePrice: 100.0, largeBottlePrice: 150.0),
  Beverage(
      id: '2', name: 'فراولة', smallBottlePrice: 150.0, largeBottlePrice: 200.0),
  Beverage(
      id: '3', name: 'برتقال', smallBottlePrice: 150.0, largeBottlePrice: 200.0),
];

final List<DailyReport> reports = [
  DailyReport(
    id: '1',
    date: DateTime.now().subtract(const Duration(days: 1)),
    lastEditTime: DateTime.now().subtract(const Duration(hours: 5)),
    inventories: [
      BottleInventory(
        beverageId: '1',
        smallBottlesPrevious: 50,
        largeBottlesPrevious: 30,
        smallBottlesPurchased: 20,
        largeBottlesPurchased: 10,
        smallBottlesLost: 2,
        largeBottlesLost: 1,
        smallBottlesRemaining: 40,
        largeBottlesRemaining: 25,
      ),
      BottleInventory(
        beverageId: '2',
        smallBottlesPrevious: 40,
        largeBottlesPrevious: 25,
        smallBottlesPurchased: 15,
        largeBottlesPurchased: 10,
        smallBottlesLost: 1,
        largeBottlesLost: 0,
        smallBottlesRemaining: 35,
        largeBottlesRemaining: 20,
      ),
    ],
  ),
  DailyReport(
    id: '2',
    date: DateTime.now().subtract(const Duration(days: 2)),
    lastEditTime: DateTime.now().subtract(const Duration(hours: 30)),
    inventories: [
      BottleInventory(
        beverageId: '1',
        smallBottlesPrevious: 40,
        largeBottlesPrevious: 25,
        smallBottlesPurchased: 30,
        largeBottlesPurchased: 15,
        smallBottlesLost: 0,
        largeBottlesLost: 0,
        smallBottlesRemaining: 50,
        largeBottlesRemaining: 30,
      ),
    ],
  ),
];

final List<Branch> branches = [
  Branch(
    id: '1',
    name: 'فرع المدينة',
    location: 'وسط المدينة',
    deputyId: '2',
    reports: reports,
  ),
  Branch(
    id: '2',
    name: 'فرع الشمال',
    location: 'شمال المدينة',
    deputyId: '3',
    reports: [],
  ),
];

// Screens
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      final username = _usernameController.text;
      final password = _passwordController.text;

      final user = users.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => User(
          id: '',
          username: '',
          password: '',
          role: UserRole.branchDeputy,
        ),
      );

      setState(() {
        _isLoading = false;
      });

      if (user.id.isEmpty) {
        setState(() {
          _errorMessage = 'اسم المستخدم أو كلمة المرور غير صحيحة';
        });
        return;
      }

      if (user.role == UserRole.owner) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OwnerDashboardScreen(user: user),
          ),
        );
      } else {
        final branch = branches.firstWhere(
          (branch) => branch.id == user.branchId,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DeputyDashboardScreen(
              user: user,
              branch: branch,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF212121),
              Color(0xFF424242)
            ], // Black to dark gray gradient
            stops: [0.3, 0.7],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.local_drink_rounded,
                            size: 60,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'مرحباً بك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'سجل دخولك للوصول إلى حسابك',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'اسم المستخدم',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'كلمة المرور',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              obscureText: true,
                              textAlign: TextAlign.right,
                            ),
                            if (_errorMessage != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline,
                                        color: Colors.red[700], size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        _errorMessage!,
                                        style:
                                            TextStyle(color: Colors.red[700]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _login,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                minimumSize: const Size(double.infinity, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(fontSize: 18),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'استخدم "owner" للمالك أو "deputy1" لنائب الفرع\nكلمة المرور: "password"',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
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

class OwnerDashboardScreen extends StatelessWidget {
  final User user;

  const OwnerDashboardScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.logout, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'لوحة تحكم المالك',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF212121),
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(context),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'الفروع',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final branch = branches[index];
                return _buildBranchCard(context, branch);
              },
              childCount: branches.length,
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 100),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBranchDialog(context);
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    // Calculate total revenue and sales from all branches
    double totalRevenue = 0;
    int totalSales = 0;

    for (var branch in branches) {
      totalRevenue += branch.getTotalRevenue();
      totalSales += branch.getTotalSoldBottles();
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              const Color(0xFF212121),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.insights, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'ملخص المبيعات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  context,
                  'إجمالي المبيعات',
                  '$totalSales قارورة',
                  Icons.shopping_bag_outlined,
                ),
                _buildSummaryItem(
                  context,
                  'إجمالي الإيرادات',
                  '${totalRevenue.toStringAsFixed(2)} DA',
                  Icons.attach_money,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  context,
                  ' عدد الفروع',
                  '${branches.length}',
                  Icons.store_outlined,
                ),
                _buildSummaryItem(
                  context,
                  ' أنواع المشروبات',
                  '${beverages.length}',
                  Icons.local_drink_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      BuildContext context, String title, String value, IconData icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchCard(BuildContext context, Branch branch) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BranchDetailsScreen(branch: branch),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.store,
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branch.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'الموقع: ${branch.location}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBranchStat(
                      context,
                      'المبيعات',
                      '${branch.getTotalSoldBottles()}',
                      Icons.shopping_cart_outlined,
                      Theme.of(context).colorScheme.tertiary,
                    ),
                    _buildBranchStat(
                      context,
                      'الإيرادات',
                      branch.getTotalRevenue().toStringAsFixed(0),
                      Icons.attach_money,
                      Theme.of(context).colorScheme.secondary,
                    ),
                    _buildBranchStat(
                      context,
                      'التقارير',
                      '${branch.reports.length}',
                      Icons.assignment_outlined,
                      Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranchStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(icon, color: color, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _showAddBranchDialog(BuildContext context) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_business,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'إضافة فرع جديد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم الفرع',
                  prefixIcon: Icon(Icons.store),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'موقع الفرع',
                  prefixIcon: Icon(Icons.location_on),
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('إلغاء'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Add new branch logic would go here
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('تم إضافة الفرع بنجاح'),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('إضافة'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BranchDetailsScreen extends StatelessWidget {
  final Branch branch;

  const BranchDetailsScreen({
    Key? key,
    required this.branch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                branch.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF212121),
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ' تقارير الفرع',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          branch.reports.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد تقارير لهذا الفرع بعد',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final report = branch.reports[index];
                      return _buildReportCard(context, report);
                    },
                    childCount: branch.reports.length,
                  ),
                ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, DailyReport report) {
    double totalRevenue = 0;
    int totalSales = 0;

    for (var inventory in report.inventories) {
      final beverage =
          beverages.firstWhere((b) => b.id == inventory.beverageId);
      totalRevenue += inventory.smallBottlesSold * beverage.smallBottlePrice;
      totalRevenue += inventory.largeBottlesSold * beverage.largeBottlePrice;
      totalSales += inventory.smallBottlesSold + inventory.largeBottlesSold;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportDetailsPage(report: report),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(report.date),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'آخر تعديل: ${DateFormat('HH:mm').format(report.lastEditTime)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: report.canEdit
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            report.canEdit ? Icons.edit : Icons.lock,
                            size: 14,
                            color: report.canEdit
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            report.canEdit ? 'يمكن التعديل' : 'مغلق',
                            style: TextStyle(
                              fontSize: 12,
                              color: report.canEdit
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildReportStat(
                      context,
                      'المبيعات',
                      '$totalSales',
                      Icons.shopping_cart_outlined,
                      Theme.of(context).colorScheme.tertiary,
                    ),
                    _buildReportStat(
                      context,
                      'الإيرادات',
                      totalRevenue.toStringAsFixed(0),
                      Icons.attach_money,
                      Theme.of(context).colorScheme.secondary,
                    ),
                    _buildReportStat(
                      context,
                      'الأنواع',
                      '${report.inventories.length}',
                      Icons.category_outlined,
                      Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(icon, color: color, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class DeputyDashboardScreen extends StatefulWidget {
  final User user;
  final Branch branch;

  const DeputyDashboardScreen({
    Key? key,
    required this.user,
    required this.branch,
  }) : super(key: key);

  @override
  State<DeputyDashboardScreen> createState() => _DeputyDashboardScreenState();
}

class _DeputyDashboardScreenState extends State<DeputyDashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _pages = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _pages.add(ReportsPage());
    _pages.add(AddReportPage());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فرع ${widget.branch.name}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _animation,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.assessment, 'التقارير'),
                _buildNavItem(1, Icons.add_circle, 'إضافة تقرير'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  void _refreshReports() {
    setState(() {
      // This forces a rebuild of the widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                '  تقارير المبيعات',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF212121),
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCard(context),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ' التقارير السابقة',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          reports.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد تقارير بعد',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final report = reports[index];
                      return _buildReportCard(context, report, index);
                    },
                    childCount: reports.length,
                  ),
                ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    // Calculate total revenue from all reports
    double totalRevenue = 0;
    int totalSales = 0;

    for (var report in reports) {
      for (var inventory in report.inventories) {
        final beverage =
            beverages.firstWhere((b) => b.id == inventory.beverageId);
        totalRevenue += inventory.smallBottlesSold * beverage.smallBottlePrice;
        totalRevenue += inventory.largeBottlesSold * beverage.largeBottlePrice;
        totalSales += inventory.smallBottlesSold + inventory.largeBottlesSold;
      }
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              const Color(0xFF212121),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.insights, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'ملخص المبيعات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  context,
                  'إجمالي المبيعات',
                  '$totalSales قارورة',
                  Icons.shopping_bag_outlined,
                ),
                _buildSummaryItem(
                  context,
                  'إجمالي الإيرادات',
                  '${totalRevenue.toStringAsFixed(2)} DA',
                  Icons.attach_money,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem(
                  context,
                  'عدد التقارير',
                  '${reports.length}',
                  Icons.assignment_outlined,
                ),
                _buildSummaryItem(
                  context,
                  'أنواع المشروبات',
                  '${beverages.length}',
                  Icons.local_drink_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      BuildContext context, String title, String value, IconData icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, DailyReport report, int index) {
    double totalRevenue = 0;
    int totalSales = 0;

    for (var inventory in report.inventories) {
      final beverage =
          beverages.firstWhere((b) => b.id == inventory.beverageId);
      totalRevenue += inventory.smallBottlesSold * beverage.smallBottlePrice;
      totalRevenue += inventory.largeBottlesSold * beverage.largeBottlePrice;
      totalSales += inventory.smallBottlesSold + inventory.largeBottlesSold;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportDetailsPage(report: report),
              ),
            ).then((_) => _refreshReports());
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(report.date),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'آخر تعديل: ${DateFormat('HH:mm').format(report.lastEditTime)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: report.canEdit
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            report.canEdit ? Icons.edit : Icons.lock,
                            size: 14,
                            color: report.canEdit
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            report.canEdit ? 'يمكن التعديل' : 'مغلق',
                            style: TextStyle(
                              fontSize: 12,
                              color: report.canEdit
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildReportStat(
                      context,
                      'المبيعات',
                      '$totalSales',
                      Icons.shopping_cart_outlined,
                      Theme.of(context).colorScheme.tertiary,
                    ),
                    _buildReportStat(
                      context,
                      'الإيرادات',
                      totalRevenue.toStringAsFixed(0),
                      Icons.attach_money,
                      Theme.of(context).colorScheme.secondary,
                    ),
                    _buildReportStat(
                      context,
                      'الأنواع',
                      '${report.inventories.length}',
                      Icons.category_outlined,
                      Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReportStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(icon, color: color, size: 20),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class ReportDetailsPage extends StatefulWidget {
  final DailyReport report;

  const ReportDetailsPage({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  late DailyReport report;

  @override
  void initState() {
    super.initState();
    report = widget.report;
  }

  @override
  Widget build(BuildContext context) {
    double totalRevenue = 0;
    int totalSales = 0;

    for (var inventory in widget.report.inventories) {
      final beverage =
          beverages.firstWhere((b) => b.id == inventory.beverageId);
      totalRevenue += inventory.smallBottlesSold * beverage.smallBottlePrice;
      totalRevenue += inventory.largeBottlesSold * beverage.largeBottlePrice;
      totalSales += inventory.smallBottlesSold + inventory.largeBottlesSold;
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              if (widget.report.canEdit)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditReportPage(report: widget.report),
                        ),
                      ).then((_) {
                        // Force rebuild to reflect changes
                        setState(() {});
                      });
                    },
                  ),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'تقرير ${DateFormat('yyyy-MM-dd').format(widget.report.date)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF212121),
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHeaderStat(
                          'المبيعات',
                          '$totalSales قارورة',
                          Icons.shopping_cart_outlined,
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        _buildHeaderStat(
                          'الإيرادات',
                          '${totalRevenue.toStringAsFixed(2)} DA',
                          Icons.attach_money,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReportInfoCard(context),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'تفاصيل المخزون',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final inventory = widget.report.inventories[index];
                final beverage =
                    beverages.firstWhere((b) => b.id == inventory.beverageId);
                return _buildInventoryCard(context, inventory, beverage);
              },
              childCount: widget.report.inventories.length,
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportInfoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'معلومات التقرير',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            _buildInfoRow(
              context,
              'التاريخ',
              DateFormat('yyyy-MM-dd').format(widget.report.date),
              Icons.calendar_today,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              'آخر تعديل',
              DateFormat('yyyy-MM-dd HH:mm').format(widget.report.lastEditTime),
              Icons.access_time,
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              'حالة التقرير',
              widget.report.canEdit ? 'يمكن التعديل' : 'مغلق',
              widget.report.canEdit ? Icons.edit : Icons.lock,
              color: widget.report.canEdit
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryCard(
      BuildContext context, BottleInventory inventory, Beverage beverage) {
    final smallRevenue = inventory.smallBottlesSold * beverage.smallBottlePrice;
    final largeRevenue = inventory.largeBottlesSold * beverage.largeBottlePrice;
    final totalRevenue = smallRevenue + largeRevenue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.local_drink,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        beverage.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${totalRevenue.toStringAsFixed(2)} DA',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildBottleTypeCard(
                      context,
                      'القوارير الصغيرة',
                      inventory.smallBottlesPrevious,
                      inventory.smallBottlesPurchased,
                      inventory.smallBottlesLost,
                      inventory.smallBottlesRemaining,
                      inventory.smallBottlesSold,
                      smallRevenue,
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildBottleTypeCard(
                      context,
                      'القوارير الكبيرة',
                      inventory.largeBottlesPrevious,
                      inventory.largeBottlesPurchased,
                      inventory.largeBottlesLost,
                      inventory.largeBottlesRemaining,
                      inventory.largeBottlesSold,
                      largeRevenue,
                      Theme.of(context).colorScheme.tertiary,
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

  Widget _buildBottleTypeCard(
    BuildContext context,
    String title,
    int previous,
    int purchased,
    int lost,
    int remaining,
    int sold,
    double revenue,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          _buildInventoryItem('المخزون السابق', previous),
          _buildInventoryItem('المشتريات', purchased),
          _buildInventoryItem('المفقود', lost),
          _buildInventoryItem('المتبقي', remaining),
          const Divider(),
          _buildInventoryItem('المبيعات', sold, isBold: true),
          _buildInventoryItem(
            'الإيرادات',
            0,
            customValue: '${revenue.toStringAsFixed(2)} DA',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(String label, int value,
      {bool isBold = false, String? customValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            customValue ?? value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class EditReportPage extends StatefulWidget {
  final DailyReport report;

  const EditReportPage({Key? key, required this.report}) : super(key: key);

  @override
  State<EditReportPage> createState() => _EditReportPageState();
}

class _EditReportPageState extends State<EditReportPage> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, BottleInventory> _inventories = {};
  late bool _canEdit;

  @override
  void initState() {
    super.initState();
    _canEdit = widget.report.canEdit;

    // Create a deep copy of the inventories for editing
    for (var inventory in widget.report.inventories) {
      _inventories[inventory.beverageId] = BottleInventory(
        beverageId: inventory.beverageId,
        smallBottlesPrevious: inventory.smallBottlesPrevious,
        largeBottlesPrevious: inventory.largeBottlesPrevious,
        smallBottlesPurchased: inventory.smallBottlesPurchased,
        largeBottlesPurchased: inventory.largeBottlesPurchased,
        smallBottlesLost: inventory.smallBottlesLost,
        largeBottlesLost: inventory.largeBottlesLost,
        smallBottlesRemaining: inventory.smallBottlesRemaining,
        largeBottlesRemaining: inventory.largeBottlesRemaining,
      );
    }
  }

  void _saveReport() {
    if (_formKey.currentState!.validate()) {
      // Update the report with new values
      final updatedReport = DailyReport(
        id: widget.report.id,
        date: widget.report.date,
        lastEditTime: DateTime.now(), // Update the last edit time
        inventories: _inventories.values.toList(),
      );

      // Find and update the report in the reports list
      final index = reports.indexWhere((r) => r.id == widget.report.id);
      if (index != -1) {
        reports[index] = updatedReport;

        // Update the original report reference to reflect changes
        widget.report.lastEditTime = updatedReport.lastEditTime;
        widget.report.inventories = updatedReport.inventories;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم تحديث التقرير بنجاح'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_canEdit ? _buildCannotEditView() : _buildEditForm(),
    );
  }

  Widget _buildCannotEditView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_clock,
                size: 50,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'لا يمكن تعديل هذا التقرير',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'لقد مر أكثر من 20 ساعة على إنشاء التقرير',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('العودة'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 180.0,
          floating: false,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.save, color: Colors.white),
                ),
                onPressed: _saveReport,
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'تعديل تقرير ${DateFormat('yyyy-MM-dd').format(widget.report.date)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF212121),
                        Theme.of(context).colorScheme.primary,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: -50,
                  top: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -30,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'تفاصيل المخزون',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _inventories.length,
                    itemBuilder: (context, index) {
                      final beverageId = _inventories.keys.elementAt(index);
                      final inventory = _inventories[beverageId]!;
                      final beverage =
                          beverages.firstWhere((b) => b.id == beverageId);

                      return _buildInventoryEditCard(
                          context, beverage, inventory, index);
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _saveReport,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save),
                        SizedBox(width: 8),
                        Text(
                          'حفظ التعديلات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryEditCard(
    BuildContext context,
    Beverage beverage,
    BottleInventory inventory,
    int index,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  beverage.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildBottleTypeEditInputs(
                    context,
                    'القوارير الصغيرة',
                    inventory.smallBottlesPrevious,
                    inventory.smallBottlesPurchased,
                    inventory.smallBottlesLost,
                    inventory.smallBottlesRemaining,
                    (value) =>
                        setState(() => inventory.smallBottlesPurchased = value),
                    (value) =>
                        setState(() => inventory.smallBottlesLost = value),
                    (value) =>
                        setState(() => inventory.smallBottlesRemaining = value),
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBottleTypeEditInputs(
                    context,
                    'القوارير الكبيرة',
                    inventory.largeBottlesPrevious,
                    inventory.largeBottlesPurchased,
                    inventory.largeBottlesLost,
                    inventory.largeBottlesRemaining,
                    (value) =>
                        setState(() => inventory.largeBottlesPurchased = value),
                    (value) =>
                        setState(() => inventory.largeBottlesLost = value),
                    (value) =>
                        setState(() => inventory.largeBottlesRemaining = value),
                    Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottleTypeEditInputs(
    BuildContext context,
    String title,
    int previous,
    int purchased,
    int lost,
    int remaining,
    Function(int) onPurchasedChanged,
    Function(int) onLostChanged,
    Function(int) onRemainingChanged,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المخزون السابق:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                previous.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStyledEditTextField(
            'المشتريات',
            purchased.toString(),
            (value) => onPurchasedChanged(int.tryParse(value) ?? 0),
          ),
          const SizedBox(height: 12),
          _buildStyledEditTextField(
            'المفقود',
            lost.toString(),
            (value) => onLostChanged(int.tryParse(value) ?? 0),
          ),
          const SizedBox(height: 12),
          _buildStyledEditTextField(
            'المتبقي',
            remaining.toString(),
            (value) => onRemainingChanged(int.tryParse(value) ?? 0),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledEditTextField(
    String label,
    String initialValue,
    Function(String) onChanged,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      keyboardType: TextInputType.number,
      initialValue: initialValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        if (int.tryParse(value) == null) {
          return 'يرجى إدخال رقم صحيح';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

class AddReportPage extends StatefulWidget {
  const AddReportPage({Key? key}) : super(key: key);

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _canAddReport = true;
  String? _cannotAddReportReason;
  List<Beverage> _selectedBeverages = [];
  final Map<String, BottleInventory> _inventories = {};
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _checkIfCanAddReport();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkIfCanAddReport() {
    if (reports.isNotEmpty) {
      final lastReport = reports.first;
      final Duration difference = DateTime.now().difference(lastReport.date);
      if (difference.inHours < 20) {
        setState(() {
          _canAddReport = false;
          _cannotAddReportReason =
              'لا يمكن إضافة تقرير جديد إلا بعد مرور 20 ساعة من التقرير السابق';
        });
      }
    }
  }

  void _addBeverage(Beverage beverage) {
    if (!_selectedBeverages.contains(beverage)) {
      setState(() {
        _selectedBeverages.add(beverage);

        // Get previous inventory values
        int smallPrevious = 0;
        int largePrevious = 0;

        if (reports.isNotEmpty) {
          final lastReport = reports.first;
          final previousInventory = lastReport.inventories.firstWhere(
            (inv) => inv.beverageId == beverage.id,
            orElse: () => BottleInventory(
              beverageId: beverage.id,
              smallBottlesPrevious: 0,
              largeBottlesPrevious: 0,
              smallBottlesPurchased: 0,
              largeBottlesPurchased: 0,
              smallBottlesLost: 0,
              largeBottlesLost: 0,
              smallBottlesRemaining: 0,
              largeBottlesRemaining: 0,
            ),
          );

          smallPrevious = previousInventory.smallBottlesRemaining;
          largePrevious = previousInventory.largeBottlesRemaining;
        }

        _inventories[beverage.id] = BottleInventory(
          beverageId: beverage.id,
          smallBottlesPrevious: smallPrevious,
          largeBottlesPrevious: largePrevious,
          smallBottlesPurchased: 0,
          largeBottlesPurchased: 0,
          smallBottlesLost: 0,
          largeBottlesLost: 0,
          smallBottlesRemaining: 0,
          largeBottlesRemaining: 0,
        );
      });
    }
  }

  void _removeBeverage(Beverage beverage) {
    setState(() {
      _selectedBeverages.remove(beverage);
      _inventories.remove(beverage.id);
    });
  }

  void _saveReport() {
    if (_formKey.currentState!.validate()) {
      final newReport = DailyReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        lastEditTime: DateTime.now(),
        inventories: _inventories.values.toList(),
      );

      // In a real app, save to database
      reports.insert(0, newReport);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('تم حفظ التقرير بنجاح'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(16),
        ),
      );

      setState(() {
        _selectedBeverages = [];
        _inventories.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'إضافة تقرير جديد',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF212121),
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: -50,
                    top: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: -30,
                    bottom: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: !_canAddReport
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_clock,
                            size: 50,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _cannotAddReportReason ??
                              'لا يمكن إضافة تقرير جديد حالياً',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'يرجى المحاولة لاحقاً',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : FadeTransition(
                    opacity: _animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(_animation),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildBeverageSelectionCard(context),
                              const SizedBox(height: 24),
                              if (_selectedBeverages.isNotEmpty) ...[
                                Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'تفاصيل المخزون',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _selectedBeverages.length,
                                  itemBuilder: (context, index) {
                                    final beverage = _selectedBeverages[index];
                                    final inventory =
                                        _inventories[beverage.id]!;

                                    return _buildInventoryInputCard(
                                        context, beverage, inventory, index);
                                  },
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: _saveReport,
                                  style: ElevatedButton.styleFrom(
                                    minimumSize:
                                        const Size(double.infinity, 56),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.save),
                                      SizedBox(width: 8),
                                      Text(
                                        'حفظ التقرير',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 100),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeverageSelectionCard(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.local_drink,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'اختر المشروبات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'المشروبات المتاحة',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: beverages.map((beverage) {
                final isSelected = _selectedBeverages.contains(beverage);
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: FilterChip(
                    label: Text(beverage.name),
                    selected: isSelected,
                    showCheckmark: false,
                    avatar: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 18,
                          )
                        : Icon(
                            Icons.local_drink_outlined,
                            color: Colors.grey[600],
                            size: 18,
                          ),
                    backgroundColor: Colors.white,
                    selectedColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[800],
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[300]!,
                      ),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        _addBeverage(beverage);
                      } else {
                        _removeBeverage(beverage);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const AddBeverageDialog(),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('إضافة مشروب جديد'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).colorScheme.primary,
                elevation: 0,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryInputCard(
    BuildContext context,
    Beverage beverage,
    BottleInventory inventory,
    int index,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      beverage.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: Colors.red[400],
                      size: 20,
                    ),
                  ),
                  onPressed: () => _removeBeverage(beverage),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildBottleTypeInputs(
                    context,
                    'القوارير الصغيرة',
                    inventory.smallBottlesPrevious,
                    (value) =>
                        setState(() => inventory.smallBottlesPurchased = value),
                    (value) =>
                        setState(() => inventory.smallBottlesLost = value),
                    (value) =>
                        setState(() => inventory.smallBottlesRemaining = value),
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBottleTypeInputs(
                    context,
                    'القوارير الكبيرة',
                    inventory.largeBottlesPrevious,
                    (value) =>
                        setState(() => inventory.largeBottlesPurchased = value),
                    (value) =>
                        setState(() => inventory.largeBottlesLost = value),
                    (value) =>
                        setState(() => inventory.largeBottlesRemaining = value),
                    Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottleTypeInputs(
    BuildContext context,
    String title,
    int previous,
    Function(int) onPurchasedChanged,
    Function(int) onLostChanged,
    Function(int) onRemainingChanged,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المخزون السابق:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                previous.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStyledTextField(
            'المشتريات',
            '0',
            (value) => onPurchasedChanged(int.tryParse(value) ?? 0),
          ),
          const SizedBox(height: 12),
          _buildStyledTextField(
            'المفقود',
            '0',
            (value) => onLostChanged(int.tryParse(value) ?? 0),
          ),
          const SizedBox(height: 12),
          _buildStyledTextField(
            'المتبقي',
            '0',
            (value) => onRemainingChanged(int.tryParse(value) ?? 0),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledTextField(
    String label,
    String initialValue,
    Function(String) onChanged,
  ) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      keyboardType: TextInputType.number,
      initialValue: initialValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        if (int.tryParse(value) == null) {
          return 'يرجى إدخال رقم صحيح';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

class AddBeverageDialog extends StatefulWidget {
  const AddBeverageDialog({Key? key}) : super(key: key);

  @override
  State<AddBeverageDialog> createState() => _AddBeverageDialogState();
}

class _AddBeverageDialogState extends State<AddBeverageDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _smallPriceController = TextEditingController();
  final _largePriceController = TextEditingController();

  void _addBeverage() {
    if (_formKey.currentState!.validate()) {
      final newBeverage = Beverage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        smallBottlePrice: double.parse(_smallPriceController.text),
        largeBottlePrice: double.parse(_largePriceController.text),
      );

      // In a real app, save to database
      beverages.add(newBeverage);

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _smallPriceController.dispose();
    _largePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'إضافة مشروب جديد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المشروب',
                  prefixIcon: Icon(Icons.local_drink_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المشروب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _smallPriceController,
                decoration: const InputDecoration(
                  labelText: 'سعر القارورة الصغيرة',
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: 'DA',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال السعر';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _largePriceController,
                decoration: const InputDecoration(
                  labelText: 'سعر القارورة الكبيرة',
                  prefixIcon: Icon(Icons.attach_money),
                  suffixText: 'DA',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال السعر';
                  }
                  if (double.tryParse(value) == null) {
                    return 'يرجى إدخال رقم صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('إلغاء'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addBeverage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    child: const Text('إضافة'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
