# Broker Platform App

A full-stack trading application that provides a seamless experience for managing multiple stock broker accounts, tracking holdings, orders, and positions. This Flutter-based application offers an intuitive interface for stock trading with real-time updates and comprehensive portfolio management.

## Features

### 1. Multi-Broker Login System 
- Multiple broker selection interface similar to Smallcase
- Secure authentication system
- Handles various API responses:
  - 200: Successful login with redirect to main dashboard
  - 400: Invalid credentials error handling
  - 500: Server error management with user-friendly messages

### 2. Navigation & Core Screens
The app features three main screens accessible through a bottom navigation bar:

#### Holdings Screen
- Displays current stock holdings
- Shows quantity, average price, and current market value
- Real-time profit/loss tracking

#### Orderbook Screen
- Comprehensive order history
- Unrealized/Realized PNL card
- Detailed transaction records
- Filter and sort capabilities

#### Positions Screen
- Active trades monitoring
- Real-time PNL tracking
- Position details including entry price and current market price

### 3. Trading Features

#### Order Pad
- Intuitive Buy/Sell interface
- Color-coded UI:
  - Green theme for Buy orders
  - Red theme for Sell orders
- Standard broker order pad layout
- Quick order execution

#### Floating Action Button (FAB)
- Draggable floating button for quick trading
- Expands to show Buy/Sell options
- Smart stock selection:
  - Automatically selects top-listed stock from current screen
  - Falls back to alphabetically first stock if no stocks are listed

## Technical Implementation

### Architecture
- Clean Architecture pattern
- Separation of concerns with organized directory structure:
  - `core/`: Core utilities and common functionality
  - `domain/`: Business logic and entities
  - `presentation/`: UI components and screens
  - `mockdata/`: Simulated API responses

### State Management
- Efficient state management for real-time updates
- Responsive UI with smooth transitions

### API Integration
Mock API implementations for:
- Holdings data
- Orderbook data
- Position data
- Authentication and broker selection

<img src="https://github.com/user-attachments/assets/81a56f55-bec3-40bd-b7e0-a6bf1896b06b" width="200"/>
<img src="https://github.com/user-attachments/assets/c83a546e-c521-4443-b1c1-3b8c2c346e42" width="200"/>
<img src="https://github.com/user-attachments/assets/76888f31-0183-41ed-8c57-39a0965cd7f6" width="200"/>
<img src="https://github.com/user-attachments/assets/ffac50ec-a45f-4f68-9743-7dc50c631fbc" width="200"/>
<img src="https://github.com/user-attachments/assets/c928331f-9797-4c1f-8d11-36df0c940c02" width="200"/>
<img src="https://github.com/user-attachments/assets/575d21cc-a7e6-4a90-8ea4-56d33ecd0e8e" width="200"/>
<img src="https://github.com/user-attachments/assets/8e6b84be-6cbe-4102-bdee-271ff79e9e62" width="200"/>

