# Delveria - Food Delivery Platform

**Version:** 1.0.0+3

Delveria is a comprehensive multi-role food delivery application built with Flutter. The platform supports four distinct user roles: Clients, Restaurant Owners, Delivery Agents, and Administrators, each with specialized features and interfaces.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features by Role](#features-by-role)
  - [Client Features](#1-client-features)
  - [Restaurant Owner Features](#2-restaurant-owner-features)
  - [Delivery Agent Features](#3-delivery-agent-features)
  - [Admin Features](#4-admin-features)
- [Core Features](#core-features)
- [Technical Stack](#technical-stack)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [Configuration](#configuration)
- [API Integration](#api-integration)
- [Localization](#localization)
- [State Management](#state-management)
- [Dependencies](#dependencies)

---

## 🎯 Overview

Delveria is a full-featured food delivery ecosystem that connects customers with restaurants and delivery agents. The application provides:

- **Multi-role authentication system** with role-based routing
- **Real-time order tracking** with status updates
- **Geolocation services** for nearby restaurant discovery
- **Payment integration** with Paymob gateway
- **Push notifications** via Firebase Cloud Messaging
- **Multi-language support** (English & Arabic)
- **Dark/Light theme** switching
- **Comprehensive admin dashboard** for platform management

---

## 🏗️ Architecture

### Design Pattern
- **BLoC (Business Logic Component)** pattern for state management
- **Repository Pattern** for data layer abstraction
- **Dependency Injection** using GetIt
- **Clean Architecture** principles with feature-based modularization

### Layer Structure
```
lib/
├── core/              # Shared utilities and configurations
├── features/          # Feature modules by user role
│   ├── client/
│   ├── ResturantOwner/
│   ├── deliveryAgent/
│   └── admin/
└── main.dart          # Application entry point
```

---

## 🎭 Features by Role

## 1. Client Features

### 1.1 Authentication & Onboarding
- **Onboarding Screen**: First-time user introduction with system data
- **User Registration**: Sign up with email, phone, and personal details
- **Login System**: Secure authentication with JWT tokens
- **OTP Verification**: Phone number verification via PIN code
- **Password Recovery**: Forgot password flow with OTP verification
- **Guest Mode**: Continue as guest without registration
- **Social Authentication**: Integration ready for social login

### 1.2 Home & Discovery
- **Nearby Restaurants**: Geolocation-based restaurant discovery
- **Promotional Sliders**: Carousel banners for featured restaurants
- **Category Browsing**: Filter restaurants by food categories
- **Search Functionality**: Real-time restaurant and item search
- **Rating Filter**: Sort restaurants by customer ratings
- **Price Filter**: Sort items by price (low to high, high to low)
- **Distance Calculation**: Shows restaurant distance from user location

### 1.3 Restaurant & Menu
- **Restaurant Details**: View restaurant info, ratings, and reviews
- **Menu Browsing**: Browse items by categories
- **Item Details**: View item descriptions, sizes, and toppings
- **Customization**: Select item sizes and add toppings
- **Item Search**: Search within restaurant menu
- **Availability Status**: Real-time item availability

### 1.4 Cart & Checkout
- **Add to Cart**: Add items with customizations
- **Cart Management**: Increase/decrease quantities, remove items
- **Cart Persistence**: Cart saved across sessions
- **Checkout Process**: Review order before payment
- **Address Selection**: Choose delivery address from saved addresses
- **Coupon System**: Apply discount coupons
- **Order Summary**: View itemized costs and totals

### 1.5 Payment
- **Paymob Integration**: Secure online payment gateway
- **Payment Token Generation**: Secure payment authentication
- **Payment Key**: Transaction-specific payment keys
- **Order Creation**: Link payment with order creation
- **Success Screen**: Order confirmation with details

### 1.6 Orders
- **Order History**: View all past and current orders
- **Order Details**: Detailed view of each order
- **Order Status Tracking**: Real-time status updates
  - Pending
  - Preparing
  - Ready for Pickup
  - Out for Delivery
  - Delivered
- **Reorder**: Quick reorder from past orders
- **Order Notifications**: Push notifications for status changes

### 1.7 Favorites
- **Add to Favorites**: Save favorite restaurants
- **Favorites List**: View all favorited restaurants
- **Remove from Favorites**: Manage favorite list

### 1.8 Addresses
- **Add Address**: Create new delivery addresses with map integration
- **Address List**: View all saved addresses
- **Set Default Address**: Mark primary delivery address
- **Edit Address**: Update address details
- **Delete Address**: Remove unwanted addresses
- **Google Maps Integration**: Pin location on map

### 1.9 Profile & Account
- **Account Information**: View and edit profile details
- **Profile Picture**: Upload and update profile image
- **Personal Details**: Name, email, phone number
- **Account Settings**: Manage account preferences

### 1.10 Reviews & Ratings
- **Add Review**: Rate and review restaurants
- **View Reviews**: See all restaurant reviews
- **Rating System**: 5-star rating system

### 1.11 Settings
- **Theme Toggle**: Switch between light and dark mode
- **Language Selection**: Switch between English and Arabic
- **Notifications**: Manage notification preferences
- **Logout**: Secure logout functionality

### 1.12 Profile Drawer
- **Quick Navigation**: Access to all profile features
- **User Info Display**: Show current user details
- **Menu Options**: Navigate to orders, favorites, addresses, settings

---

## 2. Restaurant Owner Features

### 2.1 Dashboard
- **Home Screen**: Overview of restaurant performance
- **Statistics**: View key metrics
  - Total orders
  - Revenue
  - Average rating
  - Active items
- **Recent Orders**: Quick view of latest orders
- **Performance Charts**: Visual data representation using fl_chart

### 2.2 Menu Management
- **Item Categories**: Organize items by categories
- **Create Category**: Add new item categories
- **View All Items**: List all menu items
- **Filter by Category**: View items by specific category
- **Item Status**: Enable/disable item availability

### 2.3 Item Management
- **Add Item**: Create new menu items
  - Upload item photo
  - Set name and description
  - Assign category
  - Define sizes with prices
  - Add toppings with prices
  - Set availability options
- **Edit Item**: Update existing item details
- **Delete Item**: Remove items from menu
- **Toggle Availability**: Enable/disable items

### 2.4 Order Management
- **New Orders**: View incoming orders
- **Order Details**: Complete order information
- **Order Actions**:
  - Accept Order
  - Mark as Preparing
  - Mark as Ready for Pickup
- **Order History**: View completed orders
- **Order Filtering**: Filter by status

### 2.5 Restaurant Profile
- **View Profile**: Restaurant information display
- **Edit Profile**: Update restaurant details
  - Restaurant name
  - Description
  - Contact information
  - Operating hours
  - Cover image
- **Toggle Restaurant Status**: Enable/disable restaurant availability

### 2.6 Reviews & Ratings
- **View Reviews**: See all customer reviews
- **Rating Analytics**: Average rating and distribution
- **Review Management**: Monitor customer feedback

### 2.7 Notifications
- **Order Notifications**: Real-time order alerts
- **Notification History**: View past notifications
- **Push Notifications**: Firebase Cloud Messaging integration

### 2.8 Settings
- **Restaurant Settings**: Configure restaurant preferences
- **Account Management**: Update owner account details
- **Theme & Language**: UI customization options

### 2.9 Bottom Navigation
- **Home**: Dashboard overview
- **Menu**: Menu management
- **Orders**: Order management
- **Profile**: Restaurant profile

---

## 3. Delivery Agent Features

### 3.1 Order Management
- **Available Orders**: View orders ready for delivery
- **Accept Order**: Accept delivery assignments
- **Active Deliveries**: View ongoing deliveries
- **Order Details**: Complete delivery information
  - Customer details
  - Delivery address
  - Order items
  - Restaurant location

### 3.2 Delivery Tracking
- **Update Order Status**: Change delivery status
  - Out for Delivery
  - Delivered
- **Location Tracking**: GPS-based tracking
- **Route Navigation**: Integration with map navigation

### 3.3 Order History
- **Completed Deliveries**: View delivery history
- **Earnings**: Track delivery earnings
- **Performance Metrics**: Delivery statistics

### 3.4 Profile
- **Agent Information**: View and edit profile
- **Availability Status**: Toggle online/offline status
- **Account Settings**: Manage preferences

---

## 4. Admin Features

### 4.1 Dashboard
- **Admin Home**: Platform overview
- **Key Metrics**:
  - Total users
  - Total restaurants
  - Total orders
  - Total delivery agents
  - Revenue statistics
- **Charts & Analytics**: Visual data representation
- **Recent Activity**: Latest platform activities

### 4.2 Restaurant Management
- **All Restaurants**: View all registered restaurants
- **Add Restaurant**: Create new restaurant accounts
  - Restaurant details
  - Owner information
  - Location setup
  - Category assignment
  - Upload images
- **Edit Restaurant**: Update restaurant information
- **Enable/Disable**: Control restaurant availability
- **Top Rated**: View highest-rated restaurants
- **Category Filter**: Filter restaurants by category
- **Search**: Find specific restaurants

### 4.3 User Management
- **All Users**: View all registered customers
- **User Details**: View user information
- **Ban/Unban Users**: Manage user access
- **User Statistics**: View user order history
- **Search Users**: Find specific users
- **Filter Users**: Sort by various criteria

### 4.4 Delivery Agent Management
- **All Agents**: View all delivery agents
- **Add Agent**: Create new agent accounts
  - Personal information
  - Contact details
  - Vehicle information
- **Agent Orders**: View orders assigned to each agent
- **Ban/Unban Agents**: Manage agent access
- **Agent Performance**: Track delivery metrics

### 4.5 Coupon Management
- **All Coupons**: View all discount coupons
- **Create Coupon**: Add new coupons
  - Coupon code
  - Discount type (percentage/fixed)
  - Discount value
  - Expiry date
  - Usage limits
- **Enable/Disable Coupons**: Control coupon availability
- **Coupon Analytics**: Track coupon usage

### 4.6 Slider Management
- **View Sliders**: All promotional banners
- **Add Slider**: Create new promotional slides
  - Upload banner image
  - Link to restaurant
- **Delete Slider**: Remove banners

### 4.7 Notifications
- **Send Notifications**: Push notifications to users
- **Notification History**: View sent notifications
- **Targeted Notifications**: Send to specific user groups

### 4.8 Order Monitoring
- **All Orders**: View all platform orders
- **Order Details**: Complete order information
- **Order Analytics**: Revenue and order statistics
- **Agent Assignment**: View order-agent assignments

### 4.9 Category Management
- **Super Categories**: Main food categories
- **Sub Categories**: Category subdivisions
- **Category Filtering**: Filter content by categories

### 4.10 Admin Drawer
- **Navigation Menu**: Quick access to all admin features
- **Profile**: Admin account management
- **Settings**: Platform configuration

---

## 🔧 Core Features

### Authentication System
- **JWT Token Management**: Secure token storage with flutter_secure_storage
- **Role-Based Access**: Automatic routing based on user role
- **Session Persistence**: Remember user login
- **Token Refresh**: Automatic token renewal

### Geolocation Services
- **GPS Integration**: Real-time location tracking with geolocator
- **Geocoding**: Convert addresses to coordinates and vice versa
- **Distance Calculation**: Calculate distance between locations
- **Google Maps**: Interactive map integration
- **Location Permissions**: Handle location permission requests

### Push Notifications
- **Firebase Cloud Messaging**: Real-time notifications
- **Local Notifications**: flutter_local_notifications integration
- **Notification Handling**: Background and foreground notification processing
- **Deep Linking**: Navigate to specific screens from notifications

### Payment Integration
- **Paymob Gateway**: Secure payment processing
- **Payment Flow**:
  1. Generate authentication token
  2. Create payment order
  3. Generate payment key
  4. Process payment
- **Transaction Security**: Encrypted payment data

### File Management
- **Image Upload**: File picker integration
- **Image Caching**: Cached network images for performance
- **Multi-part Upload**: Support for form data uploads

### Search & Filtering
- **Real-time Search**: Instant search results
- **Multiple Filters**: Category, price, rating filters
- **Search History**: Track recent searches

---

## 💻 Technical Stack

### Framework
- **Flutter SDK**: ^3.7.2
- **Dart**: Latest stable version

### State Management
- **flutter_bloc**: ^9.1.1 - BLoC pattern implementation
- **get_it**: ^8.0.3 - Dependency injection

### Networking
- **dio**: ^5.8.0+1 - HTTP client
- **retrofit**: ^4.4.2 - Type-safe REST client
- **pretty_dio_logger**: ^1.4.0 - Network logging

### Data Serialization
- **json_annotation**: ^4.9.0 - JSON serialization
- **freezed**: ^2.5.7 - Immutable data classes
- **json_serializable**: ^6.9.5 - Code generation

### Storage
- **shared_preferences**: ^2.5.3 - Local key-value storage
- **flutter_secure_storage**: ^9.2.4 - Secure token storage

### UI Components
- **flutter_screenutil**: ^5.9.3 - Responsive UI
- **google_fonts**: ^6.2.1 - Custom fonts
- **flutter_svg**: ^2.1.0 - SVG support
- **shimmer**: ^3.0.0 - Loading animations
- **loading_animation_widget**: ^1.3.0 - Loading indicators
- **carousel_slider**: ^5.1.1 - Image carousels
- **curved_navigation_bar**: ^1.0.6 - Bottom navigation
- **dotted_border**: ^3.1.0 - Decorative borders
- **styled_drop_down**: ^1.0.3 - Dropdown menus
- **awesome_snackbar_content**: ^0.1.7 - Snackbar notifications

### Forms & Input
- **custom_form_w**: ^2.0.7 - Custom form widgets
- **pin_code_fields**: ^8.0.1 - OTP input
- **pinput**: ^5.0.2 - PIN input
- **file_picker**: ^10.2.1 - File selection

### Maps & Location
- **geolocator**: ^14.0.2 - Location services
- **geocoding**: ^4.0.0 - Address conversion
- **google_maps_flutter**: ^2.13.1 - Google Maps
- **google_maps_url_extractor**: ^1.0.2 - URL parsing

### Firebase
- **firebase_core**: ^4.0.0 - Firebase initialization
- **firebase_messaging**: ^16.0.0 - Push notifications
- **flutter_local_notifications**: ^19.4.0 - Local notifications

### Utilities
- **intl**: ^0.20.2 - Internationalization
- **easy_localization**: ^3.0.8 - Localization
- **url_launcher**: ^6.3.2 - URL handling
- **cached_network_image**: ^3.4.1 - Image caching
- **fl_chart**: ^1.0.0 - Charts and graphs
- **font_awesome_flutter**: ^10.9.1 - Icon library
- **webview_flutter**: ^4.13.0 - WebView support
- **akedly**: ^0.0.4 - Additional utilities
- **http**: ^1.5.0 - HTTP requests

---

## 📁 Project Structure

```
delveria-development/
├── android/                 # Android platform files
├── ios/                     # iOS platform files
├── web/                     # Web platform files
├── linux/                   # Linux platform files
├── macos/                   # macOS platform files
├── windows/                 # Windows platform files
├── assets/
│   ├── fonts/              # Custom fonts (Bimini)
│   ├── icons/              # App icons
│   ├── images/             # Image assets
│   └── translation/        # Localization files (en.json, ar.json)
├── lib/
│   ├── core/
│   │   ├── di/            # Dependency injection setup
│   │   ├── func/          # Utility functions
│   │   │   ├── firebase_notifications.dart
│   │   │   ├── get_initial_route.dart
│   │   │   ├── permissions_function.dart
│   │   │   ├── push_notifications_func.dart
│   │   │   ├── show_snack_bar.dart
│   │   │   └── url_launcher.dart
│   │   ├── helper/        # Helper classes
│   │   │   ├── constants.dart
│   │   │   ├── extentions.dart
│   │   │   ├── images.dart
│   │   │   ├── shared_pref_helper.dart
│   │   │   └── strings.dart
│   │   ├── network/       # API configuration
│   │   │   ├── api_services.dart
│   │   │   ├── api_error_handler.dart
│   │   │   ├── api_result.dart
│   │   │   └── dio_factory.dart
│   │   ├── routing/       # Navigation
│   │   │   ├── app_router.dart
│   │   │   └── routes.dart
│   │   ├── theme/         # Theming
│   │   │   ├── color.dart
│   │   │   └── styles.dart
│   │   └── widgets/       # Reusable widgets
│   ├── features/
│   │   ├── client/
│   │   │   ├── auth/
│   │   │   │   ├── login/
│   │   │   │   ├── signUp/
│   │   │   │   └── otp/
│   │   │   ├── home/
│   │   │   ├── resturant/
│   │   │   ├── cart/
│   │   │   ├── orders/
│   │   │   ├── payment/
│   │   │   ├── fav/
│   │   │   ├── filter/
│   │   │   ├── adresses/
│   │   │   ├── accountInfo/
│   │   │   ├── reviews/
│   │   │   ├── settings/
│   │   │   ├── profileDrawer/
│   │   │   └── onboarding/
│   │   ├── ResturantOwner/
│   │   │   ├── home/
│   │   │   ├── menu/
│   │   │   ├── ordersResturantScreen/
│   │   │   ├── resturantProfile/
│   │   │   ├── resturantReviews/
│   │   │   ├── resturantNotification/
│   │   │   ├── settingsResturant/
│   │   │   └── bottomNavBarResturant.dart/
│   │   ├── deliveryAgent/
│   │   │   ├── data/
│   │   │   ├── logic/
│   │   │   └── ui/
│   │   └── admin/
│   │       ├── home/
│   │       ├── resturantAdmin/
│   │       ├── users/
│   │       ├── deliveryAgent/
│   │       ├── coupons/
│   │       ├── slider/
│   │       ├── notificationsAdmin/
│   │       ├── drawer/
│   │       └── adminBottomBar/
│   ├── generated/          # Generated files
│   ├── delveria_app.dart   # App widget
│   ├── firebase_options.dart
│   └── main.dart           # Entry point
├── test/                   # Unit tests
├── pubspec.yaml           # Dependencies
├── firebase.json          # Firebase configuration
├── flutter_launcher_icons.yaml
├── flutter_native_splash.yaml
└── README.md              # This file
```

### Feature Module Structure
Each feature follows a consistent structure:
```
feature_name/
├── data/
│   ├── models/           # Data models
│   └── repo/             # Repository implementation
├── logic/
│   └── cubit/            # BLoC/Cubit state management
└── ui/                   # UI screens and widgets
```

---

## 🚀 Setup & Installation

### Prerequisites
- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / Xcode
- Firebase account
- Paymob account (for payment integration)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd delveria-development
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Configure Firebase**
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/`
   - Update `firebase_options.dart` with your Firebase configuration

5. **Generate app icons**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

6. **Generate splash screen**
   ```bash
   flutter pub run flutter_native_splash:create
   ```

7. **Run the app**
   ```bash
   flutter run
   ```

---

## ⚙️ Configuration

### API Configuration
Update API base URL in `lib/core/network/api_constants.dart`:
```dart
class ApiConstants {
  static const String baseUrl = "YOUR_API_BASE_URL";
  // ... other endpoints
}
```

### Firebase Configuration
1. Create a Firebase project
2. Enable Firebase Cloud Messaging
3. Download configuration files
4. Update `firebase_options.dart`

### Paymob Configuration
Add Paymob credentials in your API configuration:
- API Key
- Integration ID
- IFrame ID

### App Icons
Update `flutter_launcher_icons.yaml`:
```yaml
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icons/logo_2_icon.png"
```

### Splash Screen
Update `flutter_native_splash.yaml` with your splash configuration.

---

## 🌐 API Integration

### API Services
The app uses Retrofit for type-safe API calls. All endpoints are defined in `lib/core/network/api_services.dart`.

### Key Endpoints
- **Authentication**: `/auth/login`, `/auth/register`
- **Restaurants**: `/restaurants/*`
- **Orders**: `/orders/*`
- **Cart**: `/cart/*`
- **Users**: `/users/*`
- **Agents**: `/agents/*`
- **Coupons**: `/coupon_codes/*`
- **Items**: `/items/*`
- **Addresses**: `/address/*`
- **Favorites**: `/favourites/*`
- **Reviews**: `/reviews/*`
- **Sliders**: `/sliders/*`
- **Notifications**: `/notifications/*`

### Error Handling
API errors are handled through `ApiErrorHandler` and `ApiResult` classes using the freezed package.

---

## 🌍 Localization

### Supported Languages
- English (en)
- Arabic (ar)

### Translation Files
- `assets/translation/en.json`
- `assets/translation/ar.json`

### Usage
```dart
Text('key'.tr())
```

### Changing Language
Language can be changed from the settings screen. The selection is persisted across app sessions.

---

## 🎨 State Management

### BLoC Pattern
The app uses flutter_bloc for state management:

1. **Cubit**: For simple state management
2. **Bloc**: For complex state with events

### Dependency Injection
GetIt is used for dependency injection. All dependencies are registered in `lib/core/di/dependancy_injection.dart`.

### Example Usage
```dart
final loginCubit = getIt<LoginCubit>();
```

---

## 📦 Dependencies

For a complete list of dependencies, see `pubspec.yaml`.

### Key Dependencies
- **flutter_bloc**: State management
- **dio & retrofit**: Networking
- **get_it**: Dependency injection
- **freezed**: Immutable models
- **firebase_messaging**: Push notifications
- **geolocator**: Location services
- **google_maps_flutter**: Maps integration
- **flutter_secure_storage**: Secure storage
- **easy_localization**: Multi-language support
- **cached_network_image**: Image caching
- **fl_chart**: Data visualization

---

## 🔐 Security

- **Secure Storage**: Sensitive data stored using flutter_secure_storage
- **JWT Tokens**: Secure authentication tokens
- **HTTPS**: All API calls use HTTPS
- **Payment Security**: PCI-compliant payment processing
- **Permission Handling**: Proper permission requests for location, storage, etc.

---

## 🧪 Testing

Run tests:
```bash
flutter test
```

---

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web (partial support)
- ✅ Windows
- ✅ macOS
- ✅ Linux

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

---

## 📄 License

This project is proprietary software. All rights reserved.

---

## 📞 Support

For support and queries, please contact the development team.

---

## 🔄 Version History

### Version 1.0.0+3 (Current)
- Multi-role authentication system
- Complete client ordering flow
- Restaurant management dashboard
- Delivery agent tracking
- Admin control panel
- Payment integration
- Push notifications
- Multi-language support

---

## 🎯 Roadmap

See `IMPROVEMENTS.md` for planned enhancements and optimizations.

---

**Built with ❤️ using Flutter**
