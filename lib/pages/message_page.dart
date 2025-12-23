import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockMessages = [
      {"name": "Google Taiwan HR", "lastMsg": "關於您詢問的實習生專案細節...", "time": "14:20", "avatar": "G", "color": "4285F4"},
      {"name": "台積電 招募中心", "lastMsg": "您好，下週二下午 2 點方便線上初試嗎？", "time": "10:15", "avatar": "TS", "color": "ED1C24"},
      {"name": "數據坊實習生招募", "lastMsg": "感謝投遞，我們已將您的履歷移交至技術主管...", "time": "昨天", "avatar": "DF", "color": "FF9800"},
      {"name": "系統通知", "lastMsg": "恭喜！您與「前端工程實習生」配對成功！", "time": "昨天", "avatar": "S", "color": "9E9E9E"},
      {"name": "國泰金控 數據組", "lastMsg": "您的面試邀請已發送至電子信箱，請查收。", "time": "12/20", "avatar": "KH", "color": "00A94F"},
      {"name": "蝦皮購物 實習計畫", "lastMsg": "想進一步了解您的 Python 專案經驗...", "time": "12/18", "avatar": "S", "color": "EE4D2D"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('我的訊息'), centerTitle: true, elevation: 0),
      body: ListView.separated(
        itemCount: mockMessages.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final msg = mockMessages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(int.parse("0xFF${msg['color']} ")),
              child: Text(msg['avatar']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            title: Text(msg['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(msg['lastMsg']!, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text(msg['time']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('正在開啟與 ${msg['name']} 的對話...')),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNav(selectedIndex: 2), 
    );
  }
}