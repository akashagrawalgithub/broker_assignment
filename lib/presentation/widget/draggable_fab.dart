import 'package:flutter/material.dart';
import 'package:broker/mockdata/mockData.dart';
import 'package:broker/presentation/widget/orderStockCard.dart';

class DraggableFAB extends StatefulWidget {
  final Function(OrderType) onOrderTypeSelected;

  const DraggableFAB({super.key, required this.onOrderTypeSelected});

  @override
  State<DraggableFAB> createState() => _DraggableFABState();
}

class _DraggableFABState extends State<DraggableFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;
  Offset _offset = const Offset(0, 0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Buy and Sell options
        if (_isExpanded) ...[
          Positioned(
            right: 16 + _offset.dx,
            bottom: 140 + _offset.dy,
            child: ScaleTransition(
              scale: _expandAnimation,
              child: FloatingActionButton.extended(
                heroTag: 'buy_fab',
                onPressed: () {
                  widget.onOrderTypeSelected(OrderType.BUY);
                  _toggleExpanded();
                },
                backgroundColor: Colors.green,
                label: const Text('Buy', style: TextStyle(color: Colors.white)),
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 16 + _offset.dx,
            bottom: 80 + _offset.dy,
            child: ScaleTransition(
              scale: _expandAnimation,
              child: FloatingActionButton.extended(
                heroTag: 'sell_fab',
                onPressed: () {
                  widget.onOrderTypeSelected(OrderType.SELL);
                  _toggleExpanded();
                },
                backgroundColor: Colors.red,
                label: const Text(
                  'Sell',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.remove, color: Colors.white),
              ),
            ),
          ),
        ],
        // Main FAB
        Positioned(
          right: 16 + _offset.dx,
          bottom: 16 + _offset.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _offset += details.delta;
              });
            },
            child: FloatingActionButton(
              onPressed: _toggleExpanded,
              backgroundColor: Colors.blue,
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: _isExpanded ? 0.125 : 0,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
