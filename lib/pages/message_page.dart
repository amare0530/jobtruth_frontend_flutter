import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDetailPage extends StatefulWidget {
  final String companyName;
  const ChatDetailPage({super.key, required this.companyName});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  String _userName = "用戶";

  @override
  void initState() {
    super.initState();
    _loadUserName();
    // 預設幾條對話紀錄
    _messages.addAll([
      {"text": "您好，我對貴司的職缺很有興趣！", "isMe": true, "time": "12/15 14:00"},
      {"text": "您好，感謝您的主動聯絡。", "isMe": false, "time": "12/15 15:30"},
      {"text": "我們初步審核過您的作品集，表現相當優異。", "isMe": false, "time": "12/15 15:31"},
    ]);
  }

  // 🔹 抓取你在 ProfilePage 設定的名字
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String savedName = prefs.getString('saved_name') ?? "孟";
      _userName = savedName.isNotEmpty ? savedName[0] : "某"; // 取第一個字
      _messages.add({
        "text": "${_userName}先生您好，想約您下週二進行線上面談，請問方便嗎？",
        "isMe": false,
        "time": "12/16 10:00"
      });
    });
  }

  void _handleSend() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        "text": _controller.text,
        "isMe": true,
        "time": "現在",
      });
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.companyName, style: const TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      // 🚀 關鍵：讓內容在鍵盤彈出時自動調整
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildBubble(msg['text'], isMe: msg['isMe'], time: msg['time']);
                },
              ),
            ),
            // 🚀 修正底部輸入框：加上 Padding 避開系統導航列
            Container(
              padding: EdgeInsets.only(
                left: 16, 
                right: 8, 
                top: 8, 
                bottom: MediaQuery.of(context).viewInsets.bottom + 8 // 👈 這裡會隨鍵盤高度自動上推
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "輸入訊息...",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _handleSend(), // 按下 Enter 也能送出
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(String text, {required bool isMe, required String time}) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: isMe ? Colors.blue[600] : Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: Radius.circular(isMe ? 15 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 15),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 15, color: isMe ? Colors.white : Colors.black87),
          ),
        ),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 8),
      ],
    );
  }
}