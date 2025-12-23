import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'chat_detail_page.dart'; // 🚀 記得引用剛寫好的頁面

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  final List<Map<String, String>> chatList = const [
    {
      "company": "Google",
      "lastMsg": "關於軟體工程師面試，已發送邀請函至信箱。",
      "time": "12/18",
      "logoText": "G",
      "color": "4285F4"
    },
    {
      "company": "台積電 (TSMC)",
      "lastMsg": "請問您下週二下午 2:00 方便進行線上面談嗎？",
      "time": "12/16",
      "logoText": "T",
      "color": "ED1C24"
    },
    {
      "company": "蝦皮購物 (Shopee)",
      "lastMsg": "恭喜您通過初審！請填寫基本資料表。",
      "time": "12/14",
      "logoText": "S",
      "color": "EE4D2D"
    },
    {
      "company": "聯發科技 (MediaTek)",
      "lastMsg": "感謝您的投遞，目前已進入內部審核流程。",
      "time": "12/10",
      "logoText": "M",
      "color": "231F20"
    },
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
          final Color avatarColor = Color(int.parse("0xFF${chat['color']}"));

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: avatarColor,
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
              // 🚀 點擊後跳轉到聊天室
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