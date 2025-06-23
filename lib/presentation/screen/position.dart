import 'package:broker/mockdata/mockData.dart';
import 'package:broker/presentation/widget/PNLCard.dart';
import 'package:broker/presentation/widget/positionCard.dart';
import 'package:broker/presentation/widget/order_sheet.dart';
import 'package:broker/presentation/widget/orderStockCard.dart';
import 'package:flutter/material.dart';

class Position extends StatefulWidget {
  const Position({super.key});

  @override
  State<Position> createState() => _PositionState();
}

class _PositionState extends State<Position> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Your Positions",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // PNL Card
              PNLCard(
                title: 'Positions P&L',
                unrealizedPnl: mockPNLData.unrealizedPnl,
                realizedPnl: mockPNLData.realizedPnl,
                todaysPnl: mockPNLData.todaysPnl,
              ),
              const SizedBox(height: 16),

              // Position Cards
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: mockPositions.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final position = mockPositions[index];
                    return PositionCard(
                      position: position,
                      onBuy:
                          () => _showOrderSheet(position.stock, OrderType.BUY),
                      onSell:
                          () => _showOrderSheet(position.stock, OrderType.SELL),
                    );
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
