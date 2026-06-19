import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const CaterConnectApp());
}

class CaterConnectApp extends StatelessWidget {
  const CaterConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cater Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B35),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFFF6B35),
          secondary: Color(0xFF2E7D32),
        ),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ==================== MODELS ====================

class TrustScore {
  final int overallScore;
  final double onTimePercentage;
  final int cancellationsLastYear;
  final int verifiedReviews;
  final double repeatCustomerRate;
  final int totalOrdersCompleted;

  const TrustScore({
    required this.overallScore,
    required this.onTimePercentage,
    required this.cancellationsLastYear,
    required this.verifiedReviews,
    required this.repeatCustomerRate,
    required this.totalOrdersCompleted,
  });

  String get trustLevel {
    if (overallScore >= 90) return 'Excellent';
    if (overallScore >= 75) return 'Good';
    if (overallScore >= 60) return 'Average';
    return 'Needs Improvement';
  }

  Color get trustColor {
    if (overallScore >= 90) return Colors.green;
    if (overallScore >= 75) return Colors.lightGreen;
    if (overallScore >= 60) return Colors.orange;
    return Colors.red;
  }
}

class Caterer {
  final String id;
  final String businessName;
  final String city;
  final double rating;
  final int reviewCount;
  final double pricePerPerson;
  final String description;
  final bool isVerified;
  final List<String> menuItems;
  final TrustScore trustScore;

  Caterer({
    required this.id,
    required this.businessName,
    required this.city,
    required this.rating,
    required this.reviewCount,
    required this.pricePerPerson,
    required this.description,
    required this.isVerified,
    this.menuItems = const [],
    required this.trustScore,
  });
}

class VendorProfile {
  final String id;
  final String fullName;
  final String businessName;
  final String cnicNumber;
  final String email;
  final List<String> phoneNumbers;
  final String businessAddress;
  final String city;
  final String accountNumber;
  final String bankName;
  final String accountTitle;
  final String cuisineType;
  final int experienceYears;
  final String description;
  final double pricePerPerson;
  final bool isVerified;
  final List<String> menuItems;
  final List<String> shopGalleryImages;
  final String profilePictureUrl;
  final String cnicPictureUrl;
  final String ownerPictureUrl;
  final DateTime dateOfBirth;
  final String gender;
  final TrustScore trustScore;

  VendorProfile({
    required this.id,
    required this.fullName,
    required this.businessName,
    required this.cnicNumber,
    required this.email,
    required this.phoneNumbers,
    required this.businessAddress,
    required this.city,
    required this.accountNumber,
    required this.bankName,
    required this.accountTitle,
    required this.cuisineType,
    required this.experienceYears,
    required this.description,
    required this.pricePerPerson,
    required this.isVerified,
    required this.menuItems,
    required this.shopGalleryImages,
    required this.profilePictureUrl,
    required this.cnicPictureUrl,
    required this.ownerPictureUrl,
    required this.dateOfBirth,
    required this.gender,
    required this.trustScore,
  });
}

class CartItem {
  final Caterer caterer;
  final int guestCount;
  final DateTime eventDate;
  final String eventType;
  final List<String> selectedMenuItems;
  final double totalPrice;

  CartItem({
    required this.caterer,
    required this.guestCount,
    required this.eventDate,
    required this.eventType,
    required this.selectedMenuItems,
    required this.totalPrice,
  });
}

class CartService {
  static List<CartItem> _cartItems = [];

  static List<CartItem> getCartItems() {
    return List.from(_cartItems);
  }

  static void addToCart(CartItem item) {
    _cartItems.add(item);
  }

  static void removeFromCart(int index) {
    _cartItems.removeAt(index);
  }

  static void clearCart() {
    _cartItems.clear();
  }

  static double getTotalPrice() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.totalPrice;
    }
    return total;
  }
}

// ==================== SPLASH SCREEN ====================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B35), Color(0xFFFF8F65)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 70,
                  color: Color(0xFFFF6B35),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Cater Connect',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'AI-Powered Verified Catering Services',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 60),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== ONBOARDING SCREEN ====================

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'icon': Icons.verified,
      'title': 'AI + Human Verification',
      'description': 'Dual verification system - AI scans your CNIC, then human admin confirms for maximum security',
      'color': const Color(0xFFFF6B35),
    },
    {
      'icon': Icons.shield,
      'title': 'Trust Score System',
      'description': 'See vendor trust scores based on on-time delivery, cancellation history, and verified reviews',
      'color': const Color(0xFF2E7D32),
    },
    {
      'icon': Icons.restaurant_menu,
      'title': 'Caterer Sets Own Price',
      'description': 'Caterers list their services at their own specified cost. You choose what fits your budget',
      'color': const Color(0xFF1565C0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> data = _onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: (data['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          data['icon'] as IconData,
                          size: 80,
                          color: data['color'] as Color,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        data['title'] as String,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        data['description'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthScreen()),
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Row(
                  children: List.generate(
                    _onboardingData.length,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentPage == index
                            ? const Color(0xFFFF6B35)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage == _onboardingData.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: Text(
                    _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== AUTHENTICATION SCREEN ====================

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 50,
                  color: Color(0xFFFF6B35),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _isLogin ? 'Welcome Back!' : 'Create Account',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _isLogin
                    ? 'Sign in to book verified caterers'
                    : 'Join Cater Connect - AI Verified Platform',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_isLogin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VendorRegistrationScreen(),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainScreen()),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _isLogin ? 'Sign In' : 'Sign Up as Vendor',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLogin ? "Don't have an account? " : "Already have an account? ",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin ? 'Sign Up' : 'Sign In',
                      style: const TextStyle(
                        color: Color(0xFFFF6B35),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(icon, color: const Color(0xFFFF6B35)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
    );
  }
}

// ==================== VENDOR REGISTRATION SCREEN ====================

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({super.key});

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Basic Information
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _businessAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cuisineTypeController = TextEditingController();
  final TextEditingController _experienceYearsController = TextEditingController();
  final TextEditingController _pricePerPersonController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // Contact Numbers
  List<String> _phoneNumbers = [''];
  final List<TextEditingController> _phoneControllers = [TextEditingController()];

  // Payment Information
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountTitleController = TextEditingController();

  // Menu Items
  List<String> _menuItems = [];
  final TextEditingController _menuItemController = TextEditingController();

  // Images
  String _profilePictureUrl = '';
  String _cnicPictureUrl = '';
  String _ownerPictureUrl = '';
  List<String> _shopGalleryImages = [];

  // Dropdown/Selection
  String _selectedGender = 'Male';
  DateTime _selectedDob = DateTime.now().subtract(const Duration(days: 365 * 25));

  // Loading states
  bool _isUploadingProfile = false;
  bool _isUploadingCnic = false;
  bool _isUploadingOwnerPic = false;
  bool _isUploadingShopPic = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _cnicController.dispose();
    _businessAddressController.dispose();
    _cityController.dispose();
    _descriptionController.dispose();
    _cuisineTypeController.dispose();
    _experienceYearsController.dispose();
    _pricePerPersonController.dispose();
    _dobController.dispose();
    _accountNumberController.dispose();
    _bankNameController.dispose();
    _accountTitleController.dispose();
    _menuItemController.dispose();
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Registration'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              _buildSectionHeader(Icons.person, 'Profile Picture'),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: _isUploadingProfile ? null : _uploadProfilePicture,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      border: Border.all(color: const Color(0xFFFF6B35), width: 2),
                    ),
                    child: _isUploadingProfile
                        ? const Center(child: CircularProgressIndicator())
                        : (_profilePictureUrl.isEmpty
                        ? const Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                        : ClipOval(
                      child: Image.network(
                        _profilePictureUrl,
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 50),
                      ),
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Basic Information Section
              _buildSectionHeader(Icons.info_outline, 'Basic Information'),
              const SizedBox(height: 16),

              _buildTextField('Full Name *', _fullNameController, Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField('Business Name *', _businessNameController, Icons.business),
              const SizedBox(height: 16),
              _buildTextField('Email Address *', _emailController, Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              _buildTextField('CNIC Number *', _cnicController, Icons.badge_outlined, keyboardType: TextInputType.number),
              const SizedBox(height: 16),

              // Date of Birth
              InkWell(
                onTap: _selectDob,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date of Birth *',
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFFFF6B35)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _dobController.text.isEmpty ? 'Select date' : _dobController.text,
                    style: TextStyle(color: _dobController.text.isEmpty ? Colors.grey : Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Gender
              const Text('Gender *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male', style: TextStyle(color: Colors.black87)),
                      value: 'Male',
                      groupValue: _selectedGender,
                      onChanged: (value) => setState(() => _selectedGender = value!),
                      activeColor: const Color(0xFFFF6B35),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female', style: TextStyle(color: Colors.black87)),
                      value: 'Female',
                      groupValue: _selectedGender,
                      onChanged: (value) => setState(() => _selectedGender = value!),
                      activeColor: const Color(0xFFFF6B35),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _buildTextField('Business Address *', _businessAddressController, Icons.location_on_outlined, maxLines: 2),
              const SizedBox(height: 16),
              _buildTextField('City *', _cityController, Icons.location_city),
              const SizedBox(height: 16),

              // Contact Numbers Section
              _buildSectionHeader(Icons.phone, 'Contact Numbers'),
              const SizedBox(height: 8),
              ..._buildPhoneNumberFields(),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _addPhoneNumber,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Another Contact Number'),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFFFF6B35)),
              ),
              const SizedBox(height: 24),

              // Payment Information Section
              _buildSectionHeader(Icons.payment, 'Payment Information'),
              const SizedBox(height: 16),
              _buildTextField('Account Number *', _accountNumberController, Icons.account_balance, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField('Bank Name *', _bankNameController, Icons.account_balance_wallet),
              const SizedBox(height: 16),
              _buildTextField('Account Title *', _accountTitleController, Icons.person),
              const SizedBox(height: 24),

              // Business Details Section
              _buildSectionHeader(Icons.restaurant, 'Business Details'),
              const SizedBox(height: 16),
              _buildTextField('Cuisine Type *', _cuisineTypeController, Icons.restaurant_menu),
              const SizedBox(height: 16),
              _buildTextField('Years of Experience *', _experienceYearsController, Icons.work_outline, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField('Price Per Person (PKR) *', _pricePerPersonController, Icons.attach_money, keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildTextField('Business Description *', _descriptionController, Icons.description_outlined, maxLines: 3),
              const SizedBox(height: 24),

              // Menu Items Section
              _buildSectionHeader(Icons.menu_book, 'Menu Items'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _menuItemController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Add menu item',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addMenuItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B35),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _menuItems.map((item) => Chip(
                  key: ValueKey(item),
                  label: Text(item, style: const TextStyle(color: Colors.black87)),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () => _removeMenuItem(item),
                  backgroundColor: const Color(0xFFFF6B35).withOpacity(0.1),
                )).toList(),
              ),
              const SizedBox(height: 24),

              // Images Section
              _buildSectionHeader(Icons.image, 'Verification Images'),
              const SizedBox(height: 16),

              // CNIC Picture
              const Text('CNIC Picture (Front) *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _isUploadingCnic ? null : _uploadCnicPicture,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _cnicPictureUrl.isEmpty ? Colors.red : const Color(0xFFFF6B35), width: 2),
                  ),
                  child: _isUploadingCnic
                      ? const Center(child: CircularProgressIndicator())
                      : (_cnicPictureUrl.isEmpty
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload, size: 40, color: Colors.red.shade300),
                      const SizedBox(height: 8),
                      Text('Tap to upload CNIC image', style: TextStyle(fontSize: 12, color: Colors.red.shade700)),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(_cnicPictureUrl, fit: BoxFit.cover),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(Icons.check_circle, size: 24, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              const SizedBox(height: 16),

              // Owner Picture
              const Text('Owner Picture *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _isUploadingOwnerPic ? null : _uploadOwnerPicture,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    border: Border.all(color: const Color(0xFFFF6B35), width: 2),
                  ),
                  child: _isUploadingOwnerPic
                      ? const Center(child: CircularProgressIndicator())
                      : (_ownerPictureUrl.isEmpty
                      ? const Icon(Icons.person_add, size: 40, color: Colors.grey)
                      : ClipOval(
                    child: Image.network(_ownerPictureUrl, fit: BoxFit.cover, width: 100, height: 100),
                  )),
                ),
              ),
              const SizedBox(height: 16),

              // Shop Gallery Images
              const Text('Shop Pictures', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _isUploadingShopPic ? null : _addShopImage,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: _isUploadingShopPic
                            ? const Center(child: CircularProgressIndicator())
                            : const Icon(Icons.add_photo_alternate, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ..._shopGalleryImages.map((url) => Stack(
                      key: ValueKey(url),
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          right: 6,
                          child: GestureDetector(
                            onTap: () => _removeShopImage(url),
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                              child: const Icon(Icons.close, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _saveVendorProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Complete Registration', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color(0xFFFF6B35)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: const Color(0xFFFF6B35)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  List<Widget> _buildPhoneNumberFields() {
    List<Widget> fields = [];
    for (int i = 0; i < _phoneNumbers.length; i++) {
      fields.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _phoneControllers[i],
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: 'Contact Number ${i + 1}${i == 0 ? ' *' : ''}',
                    prefixIcon: const Icon(Icons.phone_outlined, color: Color(0xFFFF6B35)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (i == 0 && (value == null || value.isEmpty)) {
                      return 'Please enter primary contact number';
                    }
                    return null;
                  },
                ),
              ),
              if (i > 0)
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () => _removePhoneNumber(i),
                ),
            ],
          ),
        ),
      );
    }
    return fields;
  }

  void _addPhoneNumber() {
    setState(() {
      _phoneNumbers.add('');
      _phoneControllers.add(TextEditingController());
    });
  }

  void _removePhoneNumber(int index) {
    setState(() {
      _phoneNumbers.removeAt(index);
      _phoneControllers[index].dispose();
      _phoneControllers.removeAt(index);
    });
  }

  Future<void> _selectDob() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDob,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDob) {
      setState(() {
        _selectedDob = picked;
        _dobController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _addMenuItem() {
    if (_menuItemController.text.isNotEmpty) {
      setState(() {
        _menuItems.add(_menuItemController.text);
        _menuItemController.clear();
      });
    }
  }

  void _removeMenuItem(String item) {
    setState(() {
      _menuItems.remove(item);
    });
  }

  void _uploadProfilePicture() async {
    setState(() => _isUploadingProfile = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _profilePictureUrl = 'https://randomuser.me/api/portraits/men/${Random().nextInt(100)}.jpg';
      _isUploadingProfile = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile picture uploaded'), backgroundColor: Colors.green));
  }

  void _uploadCnicPicture() async {
    setState(() => _isUploadingCnic = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _cnicPictureUrl = 'https://picsum.photos/400/250?random=${DateTime.now().millisecondsSinceEpoch}';
      _isUploadingCnic = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('CNIC picture uploaded'), backgroundColor: Colors.green));
  }

  void _uploadOwnerPicture() async {
    setState(() => _isUploadingOwnerPic = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _ownerPictureUrl = 'https://randomuser.me/api/portraits/men/${Random().nextInt(100)}.jpg';
      _isUploadingOwnerPic = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Owner picture uploaded'), backgroundColor: Colors.green));
  }

  void _addShopImage() async {
    setState(() => _isUploadingShopPic = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _shopGalleryImages.add('https://picsum.photos/200/150?random=${_shopGalleryImages.length}');
      _isUploadingShopPic = false;
    });
  }

  void _removeShopImage(String url) {
    setState(() {
      _shopGalleryImages.remove(url);
    });
  }

  void _saveVendorProfile() {
    List<String> phoneNumbers = [];
    for (var controller in _phoneControllers) {
      if (controller.text.isNotEmpty) {
        phoneNumbers.add(controller.text);
      }
    }

    if (_cnicPictureUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload CNIC picture for verification'), backgroundColor: Colors.red),
      );
      return;
    }

    if (_formKey.currentState!.validate() && _dobController.text.isNotEmpty && phoneNumbers.isNotEmpty) {
      final trustScore = TrustScore(
        overallScore: 0,
        onTimePercentage: 0,
        cancellationsLastYear: 0,
        verifiedReviews: 0,
        repeatCustomerRate: 0,
        totalOrdersCompleted: 0,
      );

      final vendorProfile = VendorProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fullName: _fullNameController.text,
        businessName: _businessNameController.text,
        cnicNumber: _cnicController.text,
        email: _emailController.text,
        phoneNumbers: phoneNumbers,
        businessAddress: _businessAddressController.text,
        city: _cityController.text,
        accountNumber: _accountNumberController.text,
        bankName: _bankNameController.text,
        accountTitle: _accountTitleController.text,
        cuisineType: _cuisineTypeController.text,
        experienceYears: int.parse(_experienceYearsController.text),
        description: _descriptionController.text,
        pricePerPerson: double.parse(_pricePerPersonController.text),
        isVerified: false,
        menuItems: _menuItems,
        shopGalleryImages: _shopGalleryImages,
        profilePictureUrl: _profilePictureUrl,
        cnicPictureUrl: _cnicPictureUrl,
        ownerPictureUrl: _ownerPictureUrl,
        dateOfBirth: _selectedDob,
        gender: _selectedGender,
        trustScore: trustScore,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VendorCnicVerificationScreen(vendorProfile: vendorProfile),
        ),
      );
    }
  }
}

// ==================== VENDOR CNIC VERIFICATION SCREEN ====================

class VendorCnicVerificationScreen extends StatefulWidget {
  final VendorProfile vendorProfile;

  const VendorCnicVerificationScreen({super.key, required this.vendorProfile});

  @override
  State<VendorCnicVerificationScreen> createState() => _VendorCnicVerificationScreenState();
}

class _VendorCnicVerificationScreenState extends State<VendorCnicVerificationScreen> {
  bool _isAiVerifying = false;
  bool _aiVerificationComplete = false;
  bool _aiVerificationSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CNIC Verification'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Verification Process:\n1. AI scans your CNIC\n2. Admin manually verifies\n3. Business license verification',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text('CNIC Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.vendorProfile.cnicPictureUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.credit_card, size: 50, color: Colors.grey)),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text('CNIC Number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                widget.vendorProfile.cnicNumber,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),

            if (!_aiVerificationComplete)
              ElevatedButton(
                onPressed: _startAiVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isAiVerifying
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                    : const Text('Start AI Verification', style: TextStyle(color: Colors.white)),
              ),

            if (_aiVerificationComplete) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _aiVerificationSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(_aiVerificationSuccess ? Icons.check_circle : Icons.error, color: _aiVerificationSuccess ? Colors.green : Colors.red),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _aiVerificationSuccess
                            ? 'AI Verification passed! Your profile is pending admin approval.'
                            : 'AI Verification failed! Please check your CNIC image quality.',
                        style: TextStyle(color: _aiVerificationSuccess ? Colors.green : Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_aiVerificationSuccess)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.hourglass_empty, color: Colors.orange),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pending Admin Verification', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                                SizedBox(height: 4),
                                Text('Your vendor account has been submitted for admin verification. This usually takes 2-3 business days.', style: TextStyle(fontSize: 12, color: Colors.orange)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen())),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Continue to Dashboard', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  void _startAiVerification() async {
    setState(() => _isAiVerifying = true);
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isAiVerifying = false;
      _aiVerificationComplete = true;
      _aiVerificationSuccess = widget.vendorProfile.cnicNumber.length >= 13;
    });
  }
}

// ==================== TRUST SCORE CARD (COMPLETELY FIXED) ====================

class TrustScoreCard extends StatelessWidget {
  final TrustScore trustScore;

  const TrustScoreCard({super.key, required this.trustScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [trustScore.trustColor.withOpacity(0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: trustScore.trustColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield, size: 16, color: trustScore.trustColor),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  'Trust Score: ${trustScore.overallScore}/100',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: trustScore.trustColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: trustScore.trustColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trustScore.trustLevel,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: trustScore.trustColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Icon(Icons.schedule, size: 12, color: Colors.grey.shade600),
                    const SizedBox(height: 2),
                    Text(
                      '${trustScore.onTimePercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('On-Time', style: TextStyle(fontSize: 7, color: Colors.grey.shade500)),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Icon(Icons.cancel_outlined, size: 12, color: Colors.grey.shade600),
                    const SizedBox(height: 2),
                    Text(
                      '${trustScore.cancellationsLastYear}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    Text('Cancel', style: TextStyle(fontSize: 7, color: Colors.grey.shade500)),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Icon(Icons.verified_user, size: 12, color: Colors.grey.shade600),
                    const SizedBox(height: 2),
                    Text(
                      '${trustScore.verifiedReviews}',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Reviews', style: TextStyle(fontSize: 7, color: Colors.grey.shade500)),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Icon(Icons.favorite, size: 12, color: Colors.grey.shade600),
                    const SizedBox(height: 2),
                    Text(
                      '${trustScore.repeatCustomerRate.toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    Text('Repeat', style: TextStyle(fontSize: 7, color: Colors.grey.shade500)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              value: trustScore.overallScore / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(trustScore.trustColor),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 3),

          Center(
            child: Text(
              '${trustScore.totalOrdersCompleted}+ orders',
              style: TextStyle(fontSize: 8, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }
}
// ==================== MAIN SCREEN ====================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Caterer> _caterers = [
    Caterer(
      id: '1',
      businessName: 'Royal Feast Catering',
      city: 'Lahore',
      rating: 4.8,
      reviewCount: 234,
      pricePerPerson: 550,
      description: 'Premium catering service with 10+ years experience',
      isVerified: true,
      menuItems: ['Chicken Biryani', 'Chicken Karahi', 'Seekh Kabab', 'Garlic Naan'],
      trustScore: TrustScore(overallScore: 94, onTimePercentage: 98.5, cancellationsLastYear: 2, verifiedReviews: 234, repeatCustomerRate: 76, totalOrdersCompleted: 1250),
    ),
    Caterer(
      id: '2',
      businessName: 'Desi Dastarkhwan',
      city: 'Karachi',
      rating: 4.9,
      reviewCount: 189,
      pricePerPerson: 450,
      description: 'Authentic Pakistani cuisine',
      isVerified: true,
      menuItems: ['Mutton Biryani', 'Chicken Handi', 'Beef Kabab', 'Butter Naan'],
      trustScore: TrustScore(overallScore: 96, onTimePercentage: 99.2, cancellationsLastYear: 1, verifiedReviews: 189, repeatCustomerRate: 82, totalOrdersCompleted: 890),
    ),
    Caterer(
      id: '3',
      businessName: 'Gourmet Express',
      city: 'Islamabad',
      rating: 4.7,
      reviewCount: 156,
      pricePerPerson: 650,
      description: 'Modern cuisine with international flavors',
      isVerified: true,
      menuItems: ['Grilled Chicken', 'Pasta Alfredo', 'Steak', 'Garlic Bread'],
      trustScore: TrustScore(overallScore: 88, onTimePercentage: 95.3, cancellationsLastYear: 4, verifiedReviews: 156, repeatCustomerRate: 68, totalOrdersCompleted: 567),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showExitAppDialog();
        return false;
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(caterers: _caterers),
            SearchScreen(caterers: _caterers),
            const BookingsScreen(),
            const CartScreen(),
            const VendorProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFFF6B35),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined), activeIcon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Bookings'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  void _showExitAppDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(onPressed: () => SystemNavigator.pop(), child: const Text('Exit', style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }
}

// ==================== HOME SCREEN ====================

class HomeScreen extends StatelessWidget {
  final List<Caterer> caterers;

  const HomeScreen({super.key, required this.caterers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cater Connect'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()))),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await Future.delayed(const Duration(seconds: 1)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Find trusted caterers for your event', style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(caterers: caterers))),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade500),
                      const SizedBox(width: 12),
                      Text('Search by caterer, cuisine, or city...', style: TextStyle(color: Colors.grey.shade500)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Why Trust Cater Connect?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildAIFeatureCard(Icons.verified, 'CNIC Verified', 'AI + Human verification')),
                  Expanded(child: _buildAIFeatureCard(Icons.shield, 'Trust Score', 'Based on real performance')),
                  Expanded(child: _buildAIFeatureCard(Icons.attach_money, 'Fair Pricing', 'Caterers set own prices')),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured Caterers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  TextButton(onPressed: () {}, child: const Text('See All', style: TextStyle(color: Color(0xFFFF6B35)))),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 380,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: caterers.length,
                  itemBuilder: (context, index) => CatererCard(caterer: caterers[index]),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Recommended For You', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              ...caterers.map((caterer) => Padding(padding: const EdgeInsets.only(bottom: 12), child: CatererListItem(caterer: caterer))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIFeatureCard(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFFF6B35).withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, size: 28, color: const Color(0xFFFF6B35)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(description, style: TextStyle(fontSize: 10, color: Colors.grey.shade600), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// ==================== CATERER CARD ====================

class CatererCard extends StatelessWidget {
  final Caterer caterer;

  const CatererCard({super.key, required this.caterer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.restaurant, size: 50, color: Colors.grey)),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: caterer.isVerified ? Colors.green : Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(caterer.isVerified ? Icons.verified : Icons.pending, size: 12, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(caterer.isVerified ? 'Verified' : 'Pending', style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caterer.businessName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Color(0xFFFFB800)),
                    const SizedBox(width: 4),
                    Text('${caterer.rating}', style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                    const SizedBox(width: 4),
                    Text('(${caterer.reviewCount} reviews)', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 8),
                TrustScoreCard(trustScore: caterer.trustScore),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price per person', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                        Text('PKR ${caterer.pricePerPerson}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFF6B35))),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatererDetailScreen(caterer: caterer))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('View', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CATERER LIST ITEM ====================

class CatererListItem extends StatelessWidget {
  final Caterer caterer;

  const CatererListItem({super.key, required this.caterer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 1))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CatererDetailScreen(caterer: caterer))),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                  child: Center(child: Icon(Icons.restaurant, size: 30, color: Colors.grey.shade400)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(caterer.businessName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87))),
                          if (caterer.isVerified) const Icon(Icons.verified, size: 14, color: Colors.green),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Color(0xFFFFB800)),
                          const SizedBox(width: 2),
                          Text('${caterer.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
                          const SizedBox(width: 6),
                          Text('• ${caterer.reviewCount} reviews', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(color: caterer.trustScore.trustColor.withOpacity(0.1), borderRadius: BorderRadius.circular(3)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.shield, size: 8, color: caterer.trustScore.trustColor),
                                const SizedBox(width: 2),
                                Text('${caterer.trustScore.overallScore}', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: caterer.trustScore.trustColor)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.location_on, size: 12, color: Colors.grey.shade500),
                          const SizedBox(width: 2),
                          Text(caterer.city, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                          const SizedBox(width: 12),
                          Text('PKR ${caterer.pricePerPerson}/person', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFFFF6B35))),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== CATERER DETAIL SCREEN ====================

class CatererDetailScreen extends StatefulWidget {
  final Caterer caterer;

  const CatererDetailScreen({super.key, required this.caterer});

  @override
  State<CatererDetailScreen> createState() => _CatererDetailScreenState();
}

class _CatererDetailScreenState extends State<CatererDetailScreen> {
  int _guestCount = 50;
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 7));
  String _selectedEventType = 'Wedding';
  List<String> _selectedMenuItems = [];

  @override
  void initState() {
    super.initState();
    _selectedMenuItems = List.from(widget.caterer.menuItems.take(2));
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.caterer.pricePerPerson * _guestCount;

    return Scaffold(
      appBar: AppBar(title: Text(widget.caterer.businessName), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
              child: const Center(child: Icon(Icons.restaurant, size: 80, color: Colors.grey)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Icon(Icons.verified, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text('CNIC Verified (AI + Human)', style: TextStyle(color: Colors.green, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFB800)),
                const SizedBox(width: 4),
                Text('${widget.caterer.rating} (${widget.caterer.reviewCount} reviews)', style: const TextStyle(color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 12),
            Text(widget.caterer.description, style: const TextStyle(color: Colors.black87)),
            const SizedBox(height: 16),
            TrustScoreCard(trustScore: widget.caterer.trustScore),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Book This Caterer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 16),
                  const Text('Number of Guests', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (_guestCount > 10) setState(() => _guestCount -= 10);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                        child: Text('$_guestCount', style: const TextStyle(fontSize: 16, color: Colors.black87)),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() => _guestCount += 10);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Event Date', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _selectDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 20, color: Color(0xFFFF6B35)),
                          const SizedBox(width: 12),
                          Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}', style: const TextStyle(fontSize: 14, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Event Type', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedEventType,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                    items: const [
                      DropdownMenuItem(value: 'Wedding', child: Text('Wedding', style: TextStyle(color: Colors.black87))),
                      DropdownMenuItem(value: 'Birthday', child: Text('Birthday', style: TextStyle(color: Colors.black87))),
                      DropdownMenuItem(value: 'Corporate', child: Text('Corporate', style: TextStyle(color: Colors.black87))),
                      DropdownMenuItem(value: 'Engagement', child: Text('Engagement', style: TextStyle(color: Colors.black87))),
                      DropdownMenuItem(value: 'Other', child: Text('Other', style: TextStyle(color: Colors.black87))),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => _selectedEventType = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Select Menu Items', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 8),
                  ...widget.caterer.menuItems.map((item) => CheckboxListTile(
                    key: ValueKey(item),
                    title: Text(item, style: const TextStyle(color: Colors.black87)),
                    value: _selectedMenuItems.contains(item),
                    onChanged: (checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedMenuItems.add(item);
                        } else {
                          _selectedMenuItems.remove(item);
                        }
                      });
                    },
                    activeColor: const Color(0xFFFF6B35),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  )),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Price per person:', style: TextStyle(color: Colors.black87)),
                            Text('PKR ${widget.caterer.pricePerPerson}', style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Guests:', style: TextStyle(color: Colors.black87)),
                            Text('$_guestCount', style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Price:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text('PKR ${totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFFF6B35))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final cartItem = CartItem(
                      caterer: widget.caterer,
                      guestCount: _guestCount,
                      eventDate: _selectedDate,
                      eventType: _selectedEventType,
                      selectedMenuItems: _selectedMenuItems,
                      totalPrice: widget.caterer.pricePerPerson * _guestCount,
                    );
                    CartService.addToCart(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart!'), backgroundColor: Colors.green));
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFF6B35),
                    side: const BorderSide(color: Color(0xFFFF6B35)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _showBookingDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Book Now', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) setState(() => _selectedDate = picked);
  }

  void _showBookingDialog(BuildContext context) {
    double totalPrice = widget.caterer.pricePerPerson * _guestCount;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please confirm your booking details:', style: TextStyle(color: Colors.black87)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Text('Total Amount: PKR ${totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                    const SizedBox(height: 4),
                    Text('Event: $_selectedEventType', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                    Text('Guests: $_guestCount', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Icon(Icons.shield, size: 16, color: widget.caterer.trustScore.trustColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Trust Score: ${widget.caterer.trustScore.overallScore}/100 - ${widget.caterer.trustScore.trustLevel}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: widget.caterer.trustScore.trustColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking confirmed! You will be contacted by the caterer.'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
              child: const Text('Confirm Booking', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// ==================== SEARCH SCREEN ====================

class SearchScreen extends StatefulWidget {
  final List<Caterer> caterers;

  const SearchScreen({super.key, required this.caterers});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCity = 'All';
  int _minTrustScore = 0;

  List<String> get cities {
    Set<String> citySet = {'All'};
    for (var caterer in widget.caterers) citySet.add(caterer.city);
    return citySet.toList();
  }

  List<Caterer> get _filteredCaterers {
    var filtered = widget.caterers;
    if (_selectedCity != 'All') filtered = filtered.where((c) => c.city == _selectedCity).toList();
    if (_minTrustScore > 0) filtered = filtered.where((c) => c.trustScore.overallScore >= _minTrustScore).toList();
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((c) =>
      c.businessName.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          c.city.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    }
    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Caterers'), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  hintText: 'Search by name or city...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFFFF6B35)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text('Filter by city:', style: TextStyle(color: Colors.black87)),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedCity,
                  items: cities.map((city) => DropdownMenuItem(value: city, child: Text(city, style: const TextStyle(color: Colors.black87)))).toList(),
                  onChanged: (value) => setState(() => _selectedCity = value!),
                ),
                const SizedBox(width: 16),
                const Text('Min Trust:', style: TextStyle(color: Colors.black87)),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: _minTrustScore,
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Any', style: TextStyle(color: Colors.black87))),
                    DropdownMenuItem(value: 70, child: Text('70+', style: TextStyle(color: Colors.black87))),
                    DropdownMenuItem(value: 80, child: Text('80+', style: TextStyle(color: Colors.black87))),
                    DropdownMenuItem(value: 90, child: Text('90+', style: TextStyle(color: Colors.black87))),
                  ],
                  onChanged: (value) => setState(() => _minTrustScore = value!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredCaterers.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CatererListItem(caterer: _filteredCaterers[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== BOOKINGS SCREEN ====================

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings'), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, index) => BookingCard(
          booking: BookingData(
            catererName: index == 0 ? 'Royal Feast Catering' : 'Desi Dastarkhwan',
            eventType: index == 0 ? 'Wedding' : 'Birthday',
            eventDate: DateTime.now().add(Duration(days: index == 0 ? 14 : 21)),
            guestCount: index == 0 ? 150 : 50,
            totalPrice: index == 0 ? 82500 : 22500,
            bookingStatus: index == 0 ? 'confirmed' : 'pending',
            trustScore: index == 0 ? 94 : 96,
          ),
        ),
      ),
    );
  }
}

class BookingData {
  final String catererName;
  final String eventType;
  final DateTime eventDate;
  final int guestCount;
  final double totalPrice;
  final String bookingStatus;
  final int trustScore;

  BookingData({
    required this.catererName,
    required this.eventType,
    required this.eventDate,
    required this.guestCount,
    required this.totalPrice,
    required this.bookingStatus,
    required this.trustScore,
  });
}

class BookingCard extends StatelessWidget {
  final BookingData booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    Color statusColor = booking.bookingStatus == 'confirmed' ? Colors.green : Colors.orange;
    Color trustColor = booking.trustScore >= 90 ? Colors.green : (booking.trustScore >= 75 ? Colors.lightGreen : Colors.orange);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(booking.catererName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(booking.bookingStatus.toUpperCase(), style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.event, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(booking.eventType, style: const TextStyle(color: Colors.black87)),
              const SizedBox(width: 16),
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text('${booking.eventDate.day}/${booking.eventDate.month}/${booking.eventDate.year}', style: const TextStyle(color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.people, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text('${booking.guestCount} guests', style: const TextStyle(color: Colors.black87)),
              const SizedBox(width: 16),
              const Icon(Icons.attach_money, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text('PKR ${booking.totalPrice.toStringAsFixed(0)}', style: const TextStyle(color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: trustColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: trustColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.shield, size: 14, color: trustColor),
                const SizedBox(width: 8),
                Expanded(child: Text('Vendor Trust Score: ${booking.trustScore}/100', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: trustColor))),
              ],
            ),
          ),
          if (booking.bookingStatus == 'confirmed') ...[
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => _showCompletionDialog(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35), minimumSize: const Size(double.infinity, 40)),
              child: const Text('Mark as Completed', style: TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Service Completion'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Have you received and approved the catering service?', style: TextStyle(color: Colors.black87)),
              SizedBox(height: 12),
              Text('This will mark your booking as completed.', style: TextStyle(color: Colors.black87)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showCompletionSuccess(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Yes, Complete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showCompletionSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(children: [Icon(Icons.check_circle, color: Colors.green), SizedBox(width: 8), Text('Booking Completed!')]),
          content: const Text('Thank you for using Cater Connect. Please leave a review for this caterer.', style: TextStyle(color: Colors.black87)),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
        );
      },
    );
  }
}

// ==================== CART SCREEN (FIXED) ====================

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartService.getCartItems();
    final totalPrice = CartService.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                setState(() => CartService.clearCart());
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cart cleared'), backgroundColor: Colors.orange));
              },
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey)),
            SizedBox(height: 8),
            Text('Add items from caterer details', style: TextStyle(color: Colors.grey)),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  key: ValueKey(index),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.restaurant, size: 40, color: Colors.grey),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.caterer.businessName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                              const SizedBox(height: 4),
                              Text('${item.eventType} • ${item.guestCount} guests', style: const TextStyle(color: Colors.black87)),
                              const SizedBox(height: 4),
                              Text('Date: ${item.eventDate.day}/${item.eventDate.month}/${item.eventDate.year}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text('Items: ${item.selectedMenuItems.join(', ')}', style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text('Total: PKR ${item.totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF6B35))),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () => setState(() => CartService.removeFromCart(index)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                    Text('PKR ${totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFF6B35))),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('All vendors are verified by AI + Human verification', style: TextStyle(fontSize: 12, color: Colors.blue), textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm All Bookings'),
                          content: const Text('You are about to confirm all items in your cart. The vendors will be notified of your booking.', style: TextStyle(color: Colors.black87)),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                            ElevatedButton(
                              onPressed: () {
                                setState(() => CartService.clearCart());
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('All bookings confirmed! You will be contacted by the caterers.'), backgroundColor: Colors.green),
                                );
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
                              child: const Text('Confirm All', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== VENDOR PROFILE SCREEN ====================

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  final VendorProfile _demoVendorProfile = VendorProfile(
    id: '1',
    fullName: 'Ahmed Hassan',
    businessName: 'Royal Feast Catering',
    cnicNumber: '12345-6789012-3',
    email: 'ahmed.hassan@caterconnect.com',
    phoneNumbers: ['+92 300 1234567', '+92 321 7654321'],
    businessAddress: '123 Main Boulevard, Gulberg, Lahore',
    city: 'Lahore',
    accountNumber: '1234567890123456',
    bankName: 'HBL Bank',
    accountTitle: 'Ahmed Hassan',
    cuisineType: 'Pakistani, Chinese, BBQ',
    experienceYears: 8,
    description: 'Premium catering service with 10+ years experience in wedding and corporate events.',
    pricePerPerson: 550,
    isVerified: true,
    menuItems: ['Chicken Biryani', 'Chicken Karahi', 'Seekh Kabab', 'Garlic Naan', 'Mutton Handi', 'Fruit Salad'],
    shopGalleryImages: [
      'https://picsum.photos/200/150?random=1',
      'https://picsum.photos/200/150?random=2',
      'https://picsum.photos/200/150?random=3',
    ],
    profilePictureUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    cnicPictureUrl: 'https://picsum.photos/400/250?random=100',
    ownerPictureUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    dateOfBirth: DateTime(1985, 5, 15),
    gender: 'Male',
    trustScore: TrustScore(
      overallScore: 94,
      onTimePercentage: 98.5,
      cancellationsLastYear: 2,
      verifiedReviews: 234,
      repeatCustomerRate: 76,
      totalOrdersCompleted: 1250,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _showEditInfoDialog(),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header with Profile Picture
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFFF6B35).withOpacity(0.1), Colors.white],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(_demoVendorProfile.profilePictureUrl),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _demoVendorProfile.businessName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _demoVendorProfile.fullName,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.verified, size: 16, color: Colors.green),
                            SizedBox(width: 4),
                            Text('Verified Vendor', style: TextStyle(color: Colors.green, fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text('${_demoVendorProfile.trustScore.overallScore}/100', style: const TextStyle(color: Colors.blue, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Trust Score Card
            TrustScoreCard(trustScore: _demoVendorProfile.trustScore),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              children: [
                Expanded(child: _buildStatCard(Icons.work, 'Experience', '${_demoVendorProfile.experienceYears}+ Years')),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(Icons.people, 'Events', '1,250+')),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard(Icons.reviews, 'Reviews', '${_demoVendorProfile.trustScore.verifiedReviews}')),
              ],
            ),
            const SizedBox(height: 24),

            // Personal Information
            _buildSectionHeader(Icons.person, 'Personal Information'),
            const SizedBox(height: 12),
            _buildInfoCard([
              _buildInfoRow(Icons.person_outline, 'Full Name', _demoVendorProfile.fullName),
              _buildInfoRow(Icons.badge_outlined, 'CNIC Number', _demoVendorProfile.cnicNumber),
              _buildInfoRow(Icons.email_outlined, 'Email', _demoVendorProfile.email),
              _buildInfoRow(Icons.phone_outlined, 'Contact Numbers', _demoVendorProfile.phoneNumbers.join(', ')),
              _buildInfoRow(Icons.calendar_today, 'Date of Birth', '${_demoVendorProfile.dateOfBirth.day}/${_demoVendorProfile.dateOfBirth.month}/${_demoVendorProfile.dateOfBirth.year}'),
              _buildInfoRow(Icons.female, 'Gender', _demoVendorProfile.gender),
            ]),
            const SizedBox(height: 20),

            // Business Information
            _buildSectionHeader(Icons.business, 'Business Information'),
            const SizedBox(height: 12),
            _buildInfoCard([
              _buildInfoRow(Icons.storefront, 'Business Name', _demoVendorProfile.businessName),
              _buildInfoRow(Icons.location_on, 'Business Address', _demoVendorProfile.businessAddress),
              _buildInfoRow(Icons.location_city, 'City', _demoVendorProfile.city),
              _buildInfoRow(Icons.restaurant_menu, 'Cuisine Type', _demoVendorProfile.cuisineType),
              _buildInfoRow(Icons.attach_money, 'Price Per Person', 'PKR ${_demoVendorProfile.pricePerPerson}'),
              _buildInfoRow(Icons.description, 'Description', _demoVendorProfile.description, maxLines: 2),
            ]),
            const SizedBox(height: 20),

            // Payment Information
            _buildSectionHeader(Icons.payment, 'Payment Information'),
            const SizedBox(height: 12),
            _buildInfoCard([
              _buildInfoRow(Icons.credit_card, 'Account Number', _demoVendorProfile.accountNumber),
              _buildInfoRow(Icons.account_balance, 'Bank Name', _demoVendorProfile.bankName),
              _buildInfoRow(Icons.person, 'Account Title', _demoVendorProfile.accountTitle),
            ]),
            const SizedBox(height: 20),

            // Menu Items
            _buildSectionHeader(Icons.menu_book, 'Menu Items'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _demoVendorProfile.menuItems.map((item) => Chip(
                  label: Text(item, style: const TextStyle(color: Colors.white)),
                  backgroundColor: const Color(0xFFFF6B35),
                )).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Shop Gallery
            _buildSectionHeader(Icons.photo_library, 'Shop Gallery'),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _demoVendorProfile.shopGalleryImages.length,
                itemBuilder: (context, index) => Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(_demoVendorProfile.shopGalleryImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Owner Picture
            _buildSectionHeader(Icons.person, 'Owner Picture'),
            const SizedBox(height: 12),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_demoVendorProfile.ownerPictureUrl),
              ),
            ),
            const SizedBox(height: 20),

            // CNIC Document
            _buildSectionHeader(Icons.credit_card, 'CNIC Document'),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                _demoVendorProfile.cnicPictureUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),

            // Logout Button
            OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text('Logout', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: const Color(0xFFFF6B35)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color(0xFFFF6B35)),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          SizedBox(width: 120, child: Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade700))),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit profile feature will allow you to update:', style: TextStyle(color: Colors.black87)),
              SizedBox(height: 12),
              Text('• Personal Information', style: TextStyle(color: Colors.black87)),
              Text('• Business Details', style: TextStyle(color: Colors.black87)),
              Text('• Payment Information', style: TextStyle(color: Colors.black87)),
              Text('• Menu Items', style: TextStyle(color: Colors.black87)),
              Text('• Gallery Images', style: TextStyle(color: Colors.black87)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit feature coming soon!'), backgroundColor: Colors.orange),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
              child: const Text('Edit Now', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?', style: TextStyle(color: Colors.black87)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}