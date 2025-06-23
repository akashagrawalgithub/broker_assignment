import 'package:broker/mockdata/mockData.dart';
import 'package:broker/presentation/widget/PNLCard.dart';
import 'package:broker/presentation/widget/orderStockCard.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              // orders list
              PNLCard(
                title: 'Portfolio PNL',
                unrealizedPnl: mockPNLData.unrealizedPnl,
                realizedPnl: mockPNLData.realizedPnl,
                todaysPnl: mockPNLData.todaysPnl,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  itemCount: mockOrders.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = mockOrders[index];
                    return OrderCard(order: order, onTradeAgain: (order) {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
