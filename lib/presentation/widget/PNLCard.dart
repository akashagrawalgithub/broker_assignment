import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PNLCard extends StatelessWidget {
  final String title;
  final double unrealizedPnl;
  final double? realizedPnl;
  final double? todaysPnl;

  const PNLCard({
    super.key,
    required this.title,
    required this.unrealizedPnl,
    this.realizedPnl,
    this.todaysPnl,
  });

  String _formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(amount);
  }

  Widget _buildTrendIcon(bool isPositive) {
    return Icon(
      isPositive ? Icons.trending_up : Icons.trending_down,
      size: 16,
      color: isPositive ? Colors.green.shade600 : Colors.red.shade600,
    );
  }

  Widget _formatPnL(double amount) {
    final isPositive = amount >= 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTrendIcon(isPositive),
        const SizedBox(width: 4),
        Text(
          _formatCurrency(amount.abs()),
          style: TextStyle(
            color: isPositive ? Colors.green.shade600 : Colors.red.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPnLRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? Colors.black87 : Colors.grey.shade600,
          ),
        ),
        DefaultTextStyle(
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          ),
          child: _formatPnL(amount),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildPnLRow('Unrealized P&L', unrealizedPnl),
          if (realizedPnl != null) ...[
            const SizedBox(height: 16),
            _buildPnLRow('Realized P&L', realizedPnl!),
          ],
          if (todaysPnl != null) ...[
            const SizedBox(height: 16),
            _buildPnLRow('Today\'s P&L', todaysPnl!),
          ],
          if (realizedPnl != null) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildPnLRow(
              'Total P&L',
              unrealizedPnl + realizedPnl!,
              isTotal: true,
            ),
          ],
        ],
      ),
    );
  }
}
