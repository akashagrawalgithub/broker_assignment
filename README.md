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

