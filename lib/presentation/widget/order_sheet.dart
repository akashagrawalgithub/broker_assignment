import 'package:broker/mockdata/mockData.dart';
import 'package:broker/presentation/widget/orderStockCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderSheet extends StatefulWidget {
  final Stock stock;
  final OrderType orderType;

  const OrderSheet({super.key, required this.stock, required this.orderType});

  @override
  State<OrderSheet> createState() => _OrderSheetState();
}

class _OrderSheetState extends State<OrderSheet> {
  bool _isMarketOrder = true;
  final TextEditingController _quantityController = TextEditingController(
    text: '1',
  );
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.stock.price.toString();
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(amount);
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? widget.stock.price;

    final newOrder = Order(
      id: (mockOrders.length + 1).toString(),
      type: widget.orderType,
      stock: OrderStock(symbol: widget.stock.symbol, name: widget.stock.name),
      status: OrderStatus.PENDING,
      quantity: quantity,
      price: price,
      totalValue: quantity * price,
      timestamp: DateTime.now(),
    );

    // Add to mock orders
    mockOrders.insert(0, newOrder);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.stock.changePercent >= 0;
    final isBuy = widget.orderType == OrderType.BUY;
    final actionColor = isBuy ? Colors.green : Colors.red;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? widget.stock.price;
    final totalValue = quantity * price;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.show_chart, color: Colors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${isBuy ? 'BUY' : 'SELL'} ${widget.stock.symbol}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: actionColor,
                      ),
                    ),
                    Text(
                      widget.stock.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Price',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              Row(
                children: [
                  Text(
                    formatCurrency(widget.stock.price),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isPositive
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '(${widget.stock.changePercent.toStringAsFixed(2)}%)',
                      style: TextStyle(
                        fontSize: 12,
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Order Type',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap:
                        () => setState(() {
                          _isMarketOrder = true;
                          _priceController.text = widget.stock.price.toString();
                        }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _isMarketOrder ? Colors.blue : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Market',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _isMarketOrder
                                  ? Colors.white
                                  : Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isMarketOrder = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            !_isMarketOrder ? Colors.blue : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Limit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              !_isMarketOrder
                                  ? Colors.white
                                  : Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Quantity',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      final currentValue =
                          int.tryParse(_quantityController.text) ?? 0;
                      _quantityController.text = (currentValue + 1).toString();
                      setState(() {});
                    },
                    child: const Icon(Icons.arrow_drop_up),
                  ),
                  InkWell(
                    onTap: () {
                      final currentValue =
                          int.tryParse(_quantityController.text) ?? 0;
                      if (currentValue > 1) {
                        _quantityController.text =
                            (currentValue - 1).toString();
                        setState(() {});
                      }
                    },
                    child: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
            ),
            onChanged: (value) => setState(() {}),
          ),
          if (!_isMarketOrder) ...[
            const SizedBox(height: 24),
            Text(
              'Price',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                prefixText: '₹ ',
              ),
              onChanged: (value) => setState(() {}),
            ),
          ],
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Value',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                Text(
                  formatCurrency(totalValue),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: actionColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '${isBuy ? 'BUY' : 'SELL'} ${widget.stock.symbol}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
