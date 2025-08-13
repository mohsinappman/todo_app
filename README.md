# 📱 Todo App - Flutter Task Management Application

A modern, feature-rich todo application built with Flutter, implementing Clean Architecture principles and powered by Supabase backend.

## 🌟 Features

### ✅ **Task Management**
- Create, read, update, and delete tasks
- Set task priorities (1-5 scale)
- Due date and time scheduling
- Task completion tracking
- Category-based organization

### 🏷️ **Category System**
- Custom categories with colors
- Category icons/images
- Filter tasks by category
- Category-based task organization

### 🔐 **Authentication**
- User registration and login
- Secure password validation
- Email-based authentication
- User session management

### 🎨 **User Interface**
- Modern Material Design 3
- Dark theme support
- Responsive design for all screen sizes
- Custom purple accent theme (#8687E7)
- Smooth animations and transitions

### 📊 **Data & Storage**
- Real-time data synchronization
- Offline-first architecture
- Cloud backup with Supabase
- User-specific data isolation

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a feature-based folder structure:

```
lib/
├── app/                    # App configuration
│   ├── router/            # Navigation setup
│   ├── themes/            # UI theming
│   └── config/            # App configuration
├── features/              # Feature modules
│   ├── auth/              # Authentication
│   ├── tasks/             # Task management
│   ├── category/          # Category management
│   └── base/              # Shared components
├── shared/                # Shared resources
│   ├── utils/             # Utilities & validators
│   ├── widgets/           # Reusable widgets
│   ├── state/             # Base state management
│   └── injections/        # Dependency injection
└── core/                  # Core infrastructure
    ├── di/                # Dependency injection
    ├── network/           # Network utilities
    └── exceptions/        # Error handling
```

### 🧱 **Design Patterns Used**
- **Clean Architecture** (Robert C. Martin)
- **Repository Pattern** for data access
- **BLoC Pattern** for state management
- **Dependency Injection** for loose coupling
- **Use Cases** for business logic
- **Factory Pattern** for object creation

## 🛠️ **Tech Stack**

### **Frontend**
- **Flutter 3.8.1+** - Cross-platform UI framework
- **Dart** - Programming language
- **BLoC/Cubit** - State management
- **GoRouter** - Declarative routing
- **ScreenUtil** - Responsive design

### **Backend**
- **Supabase** - Backend-as-a-Service
- **PostgreSQL** - Database
- **Row Level Security** - Data protection
- **Real-time subscriptions** - Live updates

### **Key Dependencies**
```yaml
dependencies:
  flutter_bloc: ^9.1.1          # State management
  supabase_flutter: ^2.9.1      # Backend integration
  go_router: ^16.1.0            # Navigation
  flutter_screenutil: ^5.9.3    # Responsive design
  google_fonts: ^6.3.0          # Typography
  image_picker: ^1.1.2          # Image selection
  syncfusion_flutter_datepicker: ^30.1.42  # Date picker
  flutter_dotenv: ^5.2.1        # Environment variables
```

## 🚀 **Getting Started**

### **Prerequisites**
- Flutter SDK (3.8.1 or later)
- Dart SDK (3.0.0 or later)
- Android Studio / VS Code
- Git

### **Installation**

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohsinappman/todo_app.git
   cd todo_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   Create a `.env` file in the root directory:
   ```env
   SUPABASE_URL=your_supabase_project_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### **Supabase Setup**

1. Create a new project at [supabase.com](https://supabase.com)

2. Create the following tables:

   **Users Table** (handled by Supabase Auth)
   
   **Categories Table**
   ```sql
   CREATE TABLE categories (
     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
     name VARCHAR(50) NOT NULL,
     color_hex VARCHAR(6) NOT NULL,
     image_url TEXT,
     user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );
   ```

   **Todos Table**
   ```sql
   CREATE TABLE todos (
     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
     title VARCHAR(100) NOT NULL,
     description TEXT,
     due_date TIMESTAMP WITH TIME ZONE,
     task_priority INTEGER CHECK (task_priority >= 1 AND task_priority <= 5),
     is_completed BOOLEAN DEFAULT FALSE,
     category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
     fk_user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
     updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );
   ```

3. **Set up Row Level Security (RLS)**
   ```sql
   -- Enable RLS
   ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
   ALTER TABLE todos ENABLE ROW LEVEL SECURITY;

   -- Categories policies
   CREATE POLICY "Users can view their own categories" ON categories
     FOR SELECT USING (auth.uid() = user_id);
   
   CREATE POLICY "Users can create their own categories" ON categories
     FOR INSERT WITH CHECK (auth.uid() = user_id);

   -- Todos policies
   CREATE POLICY "Users can view their own todos" ON todos
     FOR SELECT USING (auth.uid() = fk_user_id);
   
   CREATE POLICY "Users can create their own todos" ON todos
     FOR INSERT WITH CHECK (auth.uid() = fk_user_id);
   ```

## 📱 **App Structure**

### **Authentication Flow**
1. User opens app
2. Check authentication status
3. Redirect to login/signup or home screen
4. Handle session management

### **Task Management Flow**
1. User views task list (filtered by user)
2. Can create new tasks with categories
3. Set priorities and due dates
4. Mark tasks as complete/incomplete
5. Edit or delete existing tasks

### **Category Management Flow**
1. User creates custom categories
2. Assigns colors and optional icons
3. Associates tasks with categories
4. Filter tasks by category

## 🎨 **UI/UX Features**

- **Material Design 3** with custom theme
- **Purple accent color** (#8687E7) throughout the app
- **Dark theme** support
- **Responsive design** that works on phones and tablets
- **Smooth animations** and transitions
- **Custom form validation** with user-friendly error messages
- **Loading states** and error handling
- **Empty states** with helpful illustrations

## 🧪 **Testing**

### **Running Tests**
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### **Test Structure**
```
test/
├── unit/              # Unit tests
│   ├── usecases/     # Business logic tests
│   ├── repositories/ # Data layer tests
│   └── cubits/       # State management tests
├── widget/           # Widget tests
└── integration/      # Integration tests
```

## 📂 **Project Structure Details**

### **Feature Module Structure**
Each feature follows Clean Architecture:
```
features/auth/
├── data/
│   ├── models/           # Data transfer objects
│   ├── repositories/     # Repository implementations
│   └── datasources/      # API/local data sources
├── domain/
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository contracts
│   └── usecases/         # Business logic
└── presentation/
    ├── cubits/           # State management
    ├── pages/            # Screen widgets
    └── widgets/          # UI components
```

### **Shared Resources**
```
shared/
├── utils/
│   ├── validators.dart   # Form validation
│   ├── extensions.dart   # Dart extensions
│   └── constants.dart    # App constants
├── widgets/              # Reusable UI components
├── state/                # Base state classes
└── injections/           # Dependency injection setup
```

## 🔧 **Configuration**

### **Environment Setup**
- **Development**: Use local Supabase instance
- **Production**: Use hosted Supabase project
- **Environment variables** managed via `.env` file

### **Build Configurations**
```bash
# Debug build
flutter run --debug

# Release build
flutter build apk --release
flutter build ios --release
```

## 🚀 **Deployment**

### **Android**
```bash
flutter build apk --release
flutter build appbundle --release
```

### **iOS**
```bash
flutter build ios --release
```

### **Web**
```bash
flutter build web --release
```

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### **Code Style**
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex business logic
- Write tests for new features

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 **Author**

**Mohsin Appman**
- GitHub: [@mohsinappman](https://github.com/mohsinappman)

## 🙏 **Acknowledgments**

- Flutter team for the amazing framework
- Supabase team for the excellent backend platform
- Material Design team for the design guidelines
- Open source community for the helpful packages

## 📞 **Support**

If you encounter any issues or have questions:
1. Check the [Issues](https://github.com/mohsinappman/todo_app/issues) page
2. Create a new issue with detailed description
3. Contact the maintainer

---

**Made with ❤️ using Flutter and Supabase**
