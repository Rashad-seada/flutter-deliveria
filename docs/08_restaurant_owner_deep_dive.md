# Restaurant Owner Features - Deep Dive

## Overview
The Restaurant Owner module allows restaurant owners to manage their business operations, including menu management, order processing, and performance monitoring.

## Key Components

### 1. Dashboard (`RestaurantDashboard`)
- **Location**: `lib/features/ResturantOwner/home/ui/resturant_owner_home.dart`
- **Functionality**:
    - **Status Toggle**: Switch restaurant availability (Open/Closed).
    - **Statistics**: View total orders, net revenue, and customer feedback rating.
    - **Charts**: Visual representation of orders over the last week.
    - **Reviews**: Summary of recent customer reviews.
    - **Popular Items**: Display of top-selling items.
- **State Management**: `ResturantDataCubit` fetches dashboard data and handles the open/close toggle.

### 2. Menu Management (`MenuScreen`)
- **Location**: `lib/features/ResturantOwner/menu/ui/menu_screen.dart`
- **Functionality**:
    - **View Items**: List all menu items with search functionality.
    - **Layout**: Toggle between vertical and horizontal views.
    - **Filtering**: Filter items by category.
- **State Management**: `MenuResturantCubit` manages UI state (layout toggle), while `ItemCubit` handles data fetching.

### 3. Item Editor (`EditYourItemScreen`)
- **Location**: `lib/features/ResturantOwner/menu/ui/edit_your_item.dart`
- **Functionality**:
    - **Create/Edit**: Add new items or modify existing ones.
    - **Details**: Set name, description, and upload photos.
    - **Variants**: Add multiple sizes (e.g., Small, Medium, Large) with specific prices.
    - **Toppings**: Add optional toppings with prices.
    - **Categories**: Assign items to specific categories.
    - **Spicy Option**: Toggle for spicy/normal variations.
- **State Management**: `ItemCubit` handles form validation, image selection, and API calls for creating/updating items.

### 4. Order Management (`OrdersResturantScreen`)
- **Location**: `lib/features/ResturantOwner/ordersResturantScreen/ui/orders_resturant_screen.dart`
- **Functionality**:
    - **Tabs**: Separate views for "New Orders" and "All Orders".
    - **Filtering**: Filter orders by date range.
    - **Details**: View full order details including customer info, items, and special instructions.
    - **Actions**: Accept, reject, or update order status (Preparing, Ready).
- **State Management**: `OrdersResturantCubit` fetches orders and handles status updates.

### 5. Profile Management (`ResturantProfile`)
- **Location**: `lib/features/ResturantOwner/resturantProfile/resturant_profile.dart`
- **Functionality**:
    - **View Info**: Display restaurant name, address, phone, and operating hours.
    - **Edit Mode**: Update profile details and upload new logo/cover images.
    - **Opening Hours**: Configure opening and closing times.
- **State Management**: `ResturantProfileDataCubit` manages profile data and updates.

## Data Flow
1.  **UI Layer**: Widgets trigger events (e.g., button clicks, page loads).
2.  **Logic Layer (Cubits)**:
    -   Cubits receive events and call Repository methods.
    -   They emit states (Loading, Success, Failure) back to the UI.
3.  **Data Layer (Repositories)**:
    -   Repositories (`ResturantDataRepo`, `ItemsRepo`, etc.) communicate with the API via `Dio` and `Retrofit`.
    -   They handle data serialization/deserialization using `json_serializable` models.
