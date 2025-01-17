import 'package:atomi_yep/models/event.dart';
import 'package:atomi_yep/screens/voting/voting_screen.dart';
import 'package:flutter/material.dart';
class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          if (event.status == 'active') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VotingScreen(event: event),
              ),
            );
          } else {
            _showCustomToast(context, event.status);

          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getStatusColor(event.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.event,
                  color: _getStatusColor(event.status),
                  size: 32,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getStatusText(event.status),
                      style: TextStyle(
                        color: _getStatusColor(event.status),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Đang diễn ra';
      case 'pending':
        return 'Sắp diễn ra';
      case 'closed':
        return 'Đã kết thúc';
      default:
        return 'Không xác định';
    }
  }

  String _getStatusMessage(String status) {
    switch (status) {
      case 'pending':
        return 'Sự kiện chưa bắt đầu';
      case 'closed':
        return 'Sự kiện đã kết thúc';
      default:
        return 'Không thể bình chọn lúc này';
    }
  }

   _showCustomToast(BuildContext context, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  status == 'pending' ? Icons.access_time : Icons.event_busy,
                  color: status == 'pending' ? Colors.orange : Colors.grey,
                  size: 40,
                ),
                const SizedBox(height: 16),
                Text(
                  status == 'pending' ? 'Sự kiện chưa bắt đầu' : 'Sự kiện đã kết thúc',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: status == 'pending' ? Colors.orange : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  status == 'pending'
                      ? 'Vui lòng quay lại sau khi sự kiện bắt đầu'
                      : 'Cảm ơn bạn đã quan tâm đến sự kiện',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: status == 'pending' ? Colors.orange : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    'Đóng',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}