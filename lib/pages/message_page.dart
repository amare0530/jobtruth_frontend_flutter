import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav.dart';

// --- 第一部分：訊息列表頁 ---
class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  final List<Map<String, String>> chatList = const [
    {"company": "統一超商 (7-11)", "lastMsg": "關於儲備幹部計畫...", "time": "12/23", "logoText": "7", "color": "F58220"},
    {"company": "誠品書店", "lastMsg": "誠摯邀請您參與面試。", "time": "12/22", "logoText": "E", "color": "374A3D"},
    {"company": "王品集團", "lastMsg": "感謝您的投遞，初步審核已通過。", "time": "12/20", "logoText": "W", "color": "E60012"},
    {"company": "雄獅旅遊", "lastMsg": "請問您對旅遊顧問職缺還有興趣嗎？", "time": "12/18", "logoText": "L", "color": "0096D7"},
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

// --- 第二部分：具體聊天室頁面 (擴充 AI 腳本版) ---
class ChatDetailPage extends StatefulWidget {
  final String companyName;
  const ChatDetailPage({super.key, required this.companyName});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  String _userName = "孟";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String savedName = prefs.getString('saved_name') ?? "孟";
    String? savedChat = prefs.getString('chat_${widget.companyName}');
    
    setState(() {
      _userName = savedName.isNotEmpty ? savedName[0] : "孟";
      if (savedChat != null) {
        _messages = List<Map<String, dynamic>>.from(json.decode(savedChat));
      } else {
        _messages = [
          {"text": "您好，我對貴司的職缺很有興趣！", "isMe": true, "time": "12/15 14:00"},
          {"text": "您好，感謝您的主動聯絡。", "isMe": false, "time": "12/15 15:30"},
          {"text": "${_userName}先生您好，想約您下週二面談，請問方便嗎？", "isMe": false, "time": "12/16 10:00"},
        ];
      }
    });
  }

  Future<void> _saveChat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_${widget.companyName}', json.encode(_messages));
  }

  // 🚀 大擴充：AI 自動回覆腳本庫
  void _simulateAiReply(String userText) {
    Map<String, List<String>> aiBank = {
      "agree": [
        "太好了！我馬上幫您備註這個時間，請留意後續的面試邀約通知。",
        "沒問題，我已將此時段同步給部門主管，屆時期待與您碰面！",
        "收到！那我們就約定那個時段，我會提前幫您安排好訪客證。"
      ],
      "salary": [
        "關於薪資待遇，我們提供具競爭力的月薪與年終獎金，具體細節面談時主管會詳細說明。",
        "我們公司有完善的調薪機制，面試時 HR 也會跟您介紹各項福利（如彈性工時、午餐補助）。",
        "薪資部分會根據您的資歷與專案表現進行評估，面試時可以進一步溝通。"
      ],
      "location": [
        "辦公室鄰近捷運站，步行約 5 分鐘即可抵達，交通非常便利。",
        "地址在台北市商務中心，如果您開車過來，大樓地下室有特約停車場可使用。",
        "您可以導航至公司大樓，一樓大廳櫃檯可以領取訪客感應卡。"
      ],
      "outfit": [
        "面試穿著建議以「商務休閒」為主即可，不必太拘束，展現專業感與自信最重要。",
        "我們公司文化比較活潑，穿著得體、舒適即可，不需要穿全套西裝。",
        "建議穿著輕便襯衫，當天放輕鬆來跟我們聊聊即可！"
      ],
      "prepare": [
        "面試當天建議準備 1-2 個您最引以為傲的專案分享，這會讓主管對您更有印象。",
        "建議可以先研究一下我們的產品線，面談時可以針對功能優化提出您的看法。",
        "除了專業能力，我們也會想了解您的團隊協作經驗。放輕鬆表現即可！"
      ],
      "thanks": [
        "不客氣，非常期待與您有進一步合作的機會！",
        "祝您有愉快的一天，有任何問題隨時再跟我說。",
        "別客氣，我是您的求職助手，希望能幫您順利錄取！"
      ],
      "default": [
        "收到您的訊息了，我會先轉達給負責的部門主管審核。",
        "了解，我已記錄下您的回覆，HR 預計在 24 小時內會給您反饋。",
        "好的，請問除了這個之外，還有其他我可以協助您的嗎？"
      ]
    };

    String reply;
    final int seed = DateTime.now().millisecond % 3; // 隨機挑選回覆版本

    // 關鍵字偵測邏輯
    if (userText.contains("方便") || userText.contains("可以") || userText.contains("好的")) {
      reply = aiBank["agree"]![seed];
    } else if (userText.contains("薪水") || userText.contains("錢") || userText.contains("待遇") || userText.contains("福利")) {
      reply = aiBank["salary"]![seed];
    } else if (userText.contains("地址") || userText.contains("在哪") || userText.contains("交通") || userText.contains("怎麼走")) {
      reply = aiBank["location"]![seed];
    } else if (userText.contains("穿") || userText.contains("服裝") || userText.contains("準備")) {
      reply = aiBank["outfit"]![seed];
    } else if (userText.contains("考什麼") || userText.contains("內容") || userText.contains("面試")) {
      reply = aiBank["prepare"]![seed];
    } else if (userText.contains("謝謝") || userText.contains("感") || userText.contains("ok")) {
      reply = aiBank["thanks"]![seed];
    } else {
      reply = aiBank["default"]![seed];
    }

    // 模擬思考延遲：打字越多想越久 (增加真實感)
    int delay = 800 + (userText.length * 50);
    if (delay > 2500) delay = 2500;

    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        setState(() {
          _messages.add({
            "text": reply, 
            "isMe": false, 
            "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}"
          });
        });
        _saveChat();
      }
    });
  }

  void _handleSend() {
    if (_controller.text.trim().isEmpty) return;
    String userText = _controller.text;
    setState(() {
      _messages.add({"text": userText, "isMe": true, "time": "現在"});
    });
    _controller.clear();
    _saveChat();
    _simulateAiReply(userText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.companyName, style: const TextStyle(fontSize: 16)),
            Row(
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                const SizedBox(width: 4),
                const Text("AI 招聘助理線上中", style: TextStyle(fontSize: 10, color: Colors.green)),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "請輸入您的問題...",
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
          child: Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black87)),
        ),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 8),
      ],
    );
  }
}