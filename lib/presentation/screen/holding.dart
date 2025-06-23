import 'package:broker/mockdata/mockData.dart';
import 'package:broker/presentation/widget/investmentSummaryCard.dart';
import 'package:broker/presentation/widget/stockCard.dart';
import 'package:broker/presentation/widget/draggable_fab.dart';
import 'package:broker/presentation/widget/orderStockCard.dart';
import 'package:broker/presentation/widget/order_sheet.dart';
import 'package:flutter/material.dart';

class HoldingScreen extends StatefulWidget {
  const HoldingScreen({super.key});

  @override
  State<HoldingScreen> createState() => _HoldingScreenState();
}

class _HoldingScreenState extends State<HoldingScreen> {
  void _showOrderSheet(Stock stock, OrderType orderType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: OrderSheet(stock: stock, orderType: orderType),
          ),
    );
  }

  void _handleOrderTypeSelected(OrderType orderType) {
    // Get the first stock from holdings if available
    final Stock? selectedStock =
        mockHoldings.isNotEmpty
            ? mockHoldings.first.stock
            : mockStocks.isNotEmpty
            ? mockStocks.first
            : null;

    if (selectedStock != null) {
      _showOrderSheet(selectedStock, orderType);
    }
  }

  void _handleStockMenuPressed(Stock stock) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                  ),
                  title: const Text('Buy'),
                  onTap: () {
                    Navigator.pop(context);
                    _showOrderSheet(stock, OrderType.BUY);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                  ),
                  title: const Text('Sell'),
                  onTap: () {
                    Navigator.pop(context);
                    _showOrderSheet(stock, OrderType.SELL);
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Holdings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              SummaryCard(
                totalInvestment: 100000,
                totalCurrentValue: 110000,
                totalReturns: 10000,
                totalReturnsPercent: 10,
              ),
              SizedBox(height: 8),
              // holdings list
              Expanded(
                child: ListView.builder(
                  itemCount: mockHoldings.length,
                  itemBuilder:
                      (context, index) => StockCard(
                        stock: mockHoldings[index].stock,
                        holding: mockHoldings[index],
                        onMenuPressed:
                            () => _handleStockMenuPressed(
                              mockHoldings[index].stock,
                            ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: DraggableFAB(
        onOrderTypeSelected: _handleOrderTypeSelected,
      ),
    );
  }
}
