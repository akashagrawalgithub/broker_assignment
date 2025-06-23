import 'package:flutter/material.dart';
import 'package:broker/presentation/widget/orderStockCard.dart';

class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
  });
}

class Holding {
  final Stock stock;
  final int quantity;
  final double avgPrice;
  final double currentValue;
  final double totalReturn;
  final double totalReturnPercent;

  Holding({
    required this.stock,
    required this.quantity,
    required this.avgPrice,
    required this.currentValue,
    required this.totalReturn,
    required this.totalReturnPercent,
  });
}

class Position {
  final Stock stock;
  final int quantity;
  final double avgPrice;
  final double currentPrice;
  final double pnl;
  final double pnlPercent;
  final String type;

  Position({
    required this.stock,
    required this.quantity,
    required this.avgPrice,
    required this.currentPrice,
    required this.pnl,
    required this.pnlPercent,
    required this.type,
  });
}

class PNLData {
  final double unrealizedPnl;
  final double realizedPnl;
  final double totalPnl;
  final double todaysPnl;

  PNLData({
    required this.unrealizedPnl,
    required this.realizedPnl,
    required this.totalPnl,
    required this.todaysPnl,
  });
}

final mockStocks = [
  Stock(
    symbol: 'RELIANCE',
    name: 'Reliance Industries Ltd',
    price: 2456.80,
    change: 45.60,
    changePercent: 1.89,
  ),
  Stock(
    symbol: 'TCS',
    name: 'Tata Consultancy Services',
    price: 3678.90,
    change: -23.45,
    changePercent: -0.63,
  ),
  Stock(
    symbol: 'HDFCBANK',
    name: 'HDFC Bank Ltd',
    price: 1567.45,
    change: 12.30,
    changePercent: 0.79,
  ),
  Stock(
    symbol: 'INFY',
    name: 'Infosys Ltd',
    price: 1456.78,
    change: -8.90,
    changePercent: -0.61,
  ),
  Stock(
    symbol: 'HINDUNILVR',
    name: 'Hindustan Unilever Ltd',
    price: 2234.56,
    change: 34.67,
    changePercent: 1.58,
  ),
  Stock(
    symbol: 'ICICIBANK',
    name: 'ICICI Bank Ltd',
    price: 987.65,
    change: 15.43,
    changePercent: 1.59,
  ),
  Stock(
    symbol: 'SBIN',
    name: 'State Bank of India',
    price: 567.89,
    change: -4.56,
    changePercent: -0.80,
  ),
  Stock(
    symbol: 'BHARTIARTL',
    name: 'Bharti Airtel Ltd',
    price: 876.54,
    change: 21.32,
    changePercent: 2.49,
  ),
];

final mockHoldings = [
  Holding(
    stock: mockStocks[0],
    quantity: 50,
    avgPrice: 2400.00,
    currentValue: 122840,
    totalReturn: 2840,
    totalReturnPercent: 2.37,
  ),
  Holding(
    stock: mockStocks[1],
    quantity: 25,
    avgPrice: 3700.00,
    currentValue: 91972.5,
    totalReturn: -527.5,
    totalReturnPercent: -0.57,
  ),
  Holding(
    stock: mockStocks[2],
    quantity: 75,
    avgPrice: 1550.00,
    currentValue: 117558.75,
    totalReturn: 1308.75,
    totalReturnPercent: 1.12,
  ),
  Holding(
    stock: mockStocks[4],
    quantity: 30,
    avgPrice: 2200.00,
    currentValue: 67036.8,
    totalReturn: 1036.8,
    totalReturnPercent: 1.57,
  ),
];

final mockOrders = [
  Order(
    id: '1',
    type: OrderType.BUY,
    stock: OrderStock(symbol: mockStocks[0].symbol, name: mockStocks[0].name),
    status: OrderStatus.COMPLETED,
    quantity: 10,
    price: 2456.80,
    totalValue: 24568.00,
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  Order(
    id: '2',
    type: OrderType.SELL,
    stock: OrderStock(symbol: mockStocks[1].symbol, name: mockStocks[1].name),
    status: OrderStatus.PENDING,
    quantity: 5,
    price: 3678.90,
    totalValue: 18394.50,
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  Order(
    id: '3',
    type: OrderType.BUY,
    stock: OrderStock(symbol: mockStocks[2].symbol, name: mockStocks[2].name),
    status: OrderStatus.COMPLETED,
    quantity: 15,
    price: 1567.45,
    totalValue: 23511.75,
    timestamp: DateTime.now().subtract(const Duration(hours: 4)),
  ),
  Order(
    id: '4',
    type: OrderType.SELL,
    stock: OrderStock(symbol: mockStocks[3].symbol, name: mockStocks[3].name),
    status: OrderStatus.CANCELLED,
    quantity: 8,
    price: 1456.78,
    totalValue: 11654.24,
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  Order(
    id: '5',
    type: OrderType.BUY,
    stock: OrderStock(symbol: mockStocks[4].symbol, name: mockStocks[4].name),
    status: OrderStatus.FAILED,
    quantity: 20,
    price: 2234.56,
    totalValue: 44691.20,
    timestamp: DateTime.now().subtract(const Duration(hours: 6)),
  ),
];

final mockPositions = [
  Position(
    stock: mockStocks[5],
    quantity: 100,
    avgPrice: 980.00,
    currentPrice: 987.65,
    pnl: 765,
    pnlPercent: 0.78,
    type: 'LONG',
  ),
  Position(
    stock: mockStocks[6],
    quantity: 200,
    avgPrice: 575.00,
    currentPrice: 567.89,
    pnl: -1422,
    pnlPercent: -1.24,
    type: 'LONG',
  ),
  Position(
    stock: mockStocks[7],
    quantity: 50,
    avgPrice: 850.00,
    currentPrice: 876.54,
    pnl: 1327,
    pnlPercent: 3.12,
    type: 'LONG',
  ),
];

final mockPNLData = PNLData(
  unrealizedPnl: 4673.05,
  realizedPnl: 2456.78,
  totalPnl: 7129.83,
  todaysPnl: 1234.56,
);
