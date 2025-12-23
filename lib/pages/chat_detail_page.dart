import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
  final String companyName;
  const ChatDetailPage({super.key, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(companyName, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildBubble("您好，我對貴司的職缺很有興趣！", isMe: true, time: "12/15 14:00"),
                _buildBubble("陳先生您好，感謝您的主動聯絡。", isMe: false, time: "12/15 15:30"),
                _buildBubble("我們初步審核過您的作品集，表現相當優異。", isMe: false, time: "12/15 15:31"),
                _buildBubble("想跟您約個時間進行線上初試，請問下週二方便嗎？", isMe: false, time: "12/16 10:00"),
              ],
            ),
          ),
          // 底部輸入框
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "輸入訊息...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.send, color: Colors.blue), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(String text, {required bool isMe, required String time}) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 10),
      ],
    );
  }
}