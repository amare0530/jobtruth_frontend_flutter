import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  // 模擬一些真實的對話資料
  final List<Map<String, String>> chatList = const [
    {
      "company": "Google",
      "lastMsg": "陳先生您好，關於軟體工程師職位，想約您下週二面試...",
      "time": "上午 10:30",
      "logoText": "G",
      "color": "4285F4" // Google Blue
    },
    {
      "company": "台積電 (TSMC)",
      "lastMsg": "您的專業技能與我們職缺非常匹配，請確認附件...",
      "time": "昨天",
      "logoText": "T",
      "color": "ED1C24" // TSMC Red
    },
    {
      "company": "蝦皮購物 (Shopee)",
      "lastMsg": "感謝您的投遞，我們已經收到您的履歷了！",
      "time": "12/21",
      "logoText": "S",
      "color": "EE4D2D" // Shopee Orange
    },
    {
      "company": "聯發科技 (MediaTek)",
      "lastMsg": "關於薪資福利的部分，已發送至您的電子信箱。",
      "time": "12/20",
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
        actions: [
          IconButton(icon: const Icon(Icons.done_all), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 頂部搜尋欄
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "搜尋聯絡人或公司",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // 訊息列表
          Expanded(
            child: ListView.separated(
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
                    child: Text(
                      chat['logoText']!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(chat['company']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(chat['time']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      chat['lastMsg']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  onTap: () {
                    // Demo 時可以點擊進入空對話框或顯示提示
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("正在進入與 ${chat['company']} 的對話...")),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(selectedIndex: 2), // 訊息頁在第 3 個 Tab (index 2)
    );
  }
}