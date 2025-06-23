import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum OrderType { BUY, SELL }

enum OrderStatus { COMPLETED, PENDING, CANCELLED, FAILED }

class OrderStock {
  final String symbol;
  final String name;

  const OrderStock({required this.symbol, required this.name});
}

class Order {
  final String id;
  final OrderType type;
  final OrderStock stock;
  final OrderStatus status;
  final int quantity;
  final double price;
  final double totalValue;
  final DateTime timestamp;

  const Order({
    required this.id,
    required this.type,
    required this.stock,
    required this.status,
    required this.quantity,
    required this.price,
    required this.totalValue,
    required this.timestamp,
  });
}

class OrderCard extends StatelessWidget {
  final Order order;
  final Function(Order) onTradeAgain;

  const OrderCard({super.key, required this.order, required this.onTradeAgain});

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(amount);
  }

  String _formatDate(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.COMPLETED:
        return Colors.green;
      case OrderStatus.PENDING:
        return Colors.orange;
      case OrderStatus.CANCELLED:
        return Colors.red;
      case OrderStatus.FAILED:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.COMPLETED:
        return Icons.check_circle_outline;
      case OrderStatus.PENDING:
        return Icons.access_time;
      case OrderStatus.CANCELLED:
        return Icons.cancel_outlined;
      case OrderStatus.FAILED:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      order.type == OrderType.BUY
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    order.type.name,
                    style: TextStyle(
                      color:
                          order.type == OrderType.BUY
                              ? Colors.green.shade600
                              : Colors.red.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.stock.symbol,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      order.stock.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Status indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getStatusIcon(order.status),
                      size: 14,
                      color: _getStatusColor(order.status),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      order.status.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(order.status),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Order details grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 0,
            crossAxisSpacing: 16,
            childAspectRatio: 3,
            children: [
              _buildDetailItem('Quantity', order.quantity.toString()),
              _buildDetailItem('Price', _formatCurrency(order.price)),
              _buildDetailItem(
                'Total Value',
                _formatCurrency(order.totalValue),
              ),
              _buildDetailItem('Time', _formatDate(order.timestamp)),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => onTradeAgain(order),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.grey.shade50,
                foregroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Trade Again',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
