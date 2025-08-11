class Validators {
  // Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  // Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    return null;
  }

  // Simple password validation (for less strict requirements)
  static String? simplePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  // Confirm password validation
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  // Required field validation
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  // Task title validation
  static String? taskTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Task title is required';
    }
    
    if (value.trim().length < 3) {
      return 'Task title must be at least 3 characters long';
    }
    
    if (value.trim().length > 100) {
      return 'Task title cannot exceed 100 characters';
    }
    
    return null;
  }

  // Task description validation
  static String? taskDescription(String? value) {
    if (value != null && value.trim().length > 500) {
      return 'Description cannot exceed 500 characters';
    }
    return null;
  }

  // Category name validation
  static String? categoryName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Category name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Category name must be at least 2 characters long';
    }
    
    if (value.trim().length > 50) {
      return 'Category name cannot exceed 50 characters';
    }
    
    // Check for special characters (allow only letters, numbers, and spaces)
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value.trim())) {
      return 'Category name can only contain letters, numbers, and spaces';
    }
    
    return null;
  }

  // Name validation (for user full name)
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    if (value.trim().length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    
    // Check for valid name characters (letters and spaces)
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }

  // Phone number validation
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove all non-digit characters
    final cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (cleanedValue.length < 10 || cleanedValue.length > 15) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  // URL validation
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional in most cases
    }
    
    final urlRegExp = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    
    if (!urlRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  // Numeric validation
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    
    return null;
  }

  // Priority validation (1-5 range)
  static String? priority(String? value) {
    if (value == null || value.isEmpty) {
      return 'Priority is required';
    }
    
    final priority = int.tryParse(value);
    if (priority == null) {
      return 'Priority must be a number';
    }
    
    if (priority < 1 || priority > 5) {
      return 'Priority must be between 1 and 5';
    }
    
    return null;
  }

  // Date validation
  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    
    try {
      final date = DateTime.parse(value);
      if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        return 'Date cannot be in the past';
      }
    } catch (e) {
      return 'Please enter a valid date';
    }
    
    return null;
  }

  // Length validation
  static String? length(
    String? value, {
    int? minLength,
    int? maxLength,
    String? fieldName,
  }) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (minLength != null && value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }
    
    if (maxLength != null && value.length > maxLength) {
      return '${fieldName ?? 'This field'} cannot exceed $maxLength characters';
    }
    
    return null;
  }

  // Custom validation combiner
  static String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  // Hex color validation
  static String? hexColor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Color is required';
    }
    
    // Remove # if present
    final cleanValue = value.replaceAll('#', '');
    
    if (!RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(cleanValue)) {
      return 'Please enter a valid hex color (e.g., FF5722)';
    }
    
    return null;
  }
}

// Extension for easy validation
extension ValidationExtension on String? {
  String? get validateEmail => Validators.email(this);
  String? get validatePassword => Validators.password(this);
  String? get validateSimplePassword => Validators.simplePassword(this);
  String? get validateRequired => Validators.required(this);
  String? get validateTaskTitle => Validators.taskTitle(this);
  String? get validateTaskDescription => Validators.taskDescription(this);
  String? get validateCategoryName => Validators.categoryName(this);
  String? get validateName => Validators.name(this);
  String? get validatePhoneNumber => Validators.phoneNumber(this);
  String? get validateUrl => Validators.url(this);
  String? get validateNumeric => Validators.numeric(this);
  String? get validatePriority => Validators.priority(this);
  String? get validateDate => Validators.date(this);
  String? get validateHexColor => Validators.hexColor(this);
}
