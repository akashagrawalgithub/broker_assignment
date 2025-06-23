import 'package:broker/mockdata/mockData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final Holding? holding;
  final VoidCallback? onTap;
  final VoidCallback? onMenuPressed;

  const StockCard({
    super.key,
    required this.stock,
    this.holding,
    this.onTap,
    this.onMenuPressed,
  });

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = stock.change >= 0;
    final changeColor =
        isPositive ? Colors.green.shade600 : Colors.red.shade600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stock.symbol,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: onMenuPressed,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                Text(
                  stock.name,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                if (holding != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${holding!.quantity} shares • Avg: ${formatCurrency(holding!.avgPrice)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          formatCurrency(stock.price),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 14,
                              color: changeColor,
                            ),
                            Text(
                              '${formatCurrency(stock.change.abs())} (${stock.changePercent.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                fontSize: 12,
                                color: changeColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (holding != null)
                      Text(
                        formatCurrency(holding!.currentValue),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (holding != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8, bottom: 16),
            child: Row(
              children: [
                Text(
                  'Returns',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 8),
                Text(
                  formatCurrency(holding!.totalReturn),
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        holding!.totalReturn >= 0
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '(${holding!.totalReturnPercent.toStringAsFixed(2)}%)',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        holding!.totalReturn >= 0
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
