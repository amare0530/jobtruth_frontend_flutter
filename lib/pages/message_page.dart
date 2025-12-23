import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav.dart';

// --- 第一部分：訊息列表頁 (對應 Routes.dart) ---
class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  final List<Map<String, String>> chatList = const [
    {"company": "Google", "lastMsg": "關於軟體工程師面試邀請...", "time": "12/18", "logoText": "G", "color": "4285F4"},
    {"company": "台積電 (TSMC)", "lastMsg": "請問您下週二方便面談嗎？", "time": "12/16", "logoText": "T", "color": "ED1C24"},
    {"company": "蝦皮購物", "lastMsg": "恭喜您通過初審！", "time": "12/14", "logoText": "S", "color": "EE4D2D"},
    {"company": "聯發科技", "lastMsg": "感謝投遞，已進入審核流程。", "time": "12/10", "logoText": "M", "color": "231F20"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("訊息對話", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: chatList.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Color(int.parse("0xFF${chat['color']}")),
              child: Text(chat['logoText']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(chat['company']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(chat['time']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            subtitle: Text(chat['lastMsg']!, maxLines: 1, overflow: TextOverflow.ellipsis),
            onTap: () {
              // 🚀 點擊後跳轉到下面的聊天室
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(companyName: chat['company']!),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNav(selectedIndex: 2),
    );
  }
}

// --- 第二部分：具體聊天室頁面 (修正鍵盤與名字) ---
class ChatDetailPage extends StatefulWidget {
  final String companyName;
  const ChatDetailPage({super.key, required this.companyName});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  String _userName = "孟";

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _messages.addAll([
      {"text": "您好，我對貴司的職缺很有興趣！", "isMe": true, "time": "12/15 14:00"},
      {"text": "您好，感謝您的主動聯絡。", "isMe": false, "time": "12/15 15:30"},
      {"text": "我們初步審核過您的作品集，表現相當優異。", "isMe": false, "time": "12/15 15:31"},
    ]);
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String savedName = prefs.getString('saved_name') ?? "孟";
      _userName = savedName.isNotEmpty ? savedName[0] : "孟";
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
            Container(
              padding: EdgeInsets.only(
                left: 16, 
                right: 8, 
                top: 8, 
                bottom: MediaQuery.of(context).viewInsets.bottom + 8
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black12)),
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
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.send, color: Colors.blue), onPressed: _handleSend),
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
          child: Text(text, style: TextStyle(fontSize: 15, color: isMe ? Colors.white : Colors.black87)),
        ),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 8),
      ],
    );
  }
}