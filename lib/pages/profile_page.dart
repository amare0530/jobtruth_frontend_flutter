import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottom_nav.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "孟軒";
  String school = "國立臺北科技大學 - 資訊工程系";
  List<String> skills = ["Flutter", "Python", "SQL", "UI/UX"];
  Color themeColor = Colors.pink;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('saved_name') ?? "孟軒";
      school = prefs.getString('saved_school') ?? "國立臺北科技大學 - 資訊工程系";
      skills = prefs.getStringList('saved_skills') ?? ["Flutter", "Python", "SQL", "UI/UX"];
      int? colorValue = prefs.getInt('saved_color');
      if (colorValue != null) themeColor = Color(colorValue);
    });
  }

  Future<void> _saveToDisk(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_name', data['name']);
    await prefs.setString('saved_school', data['school']);
    await prefs.setStringList('saved_skills', List<String>.from(data['skills']));
    await prefs.setInt('saved_color', (data['themeColor'] as Color).value);
  }

  // 🚀 優化後的對話框：確保 context 使用正確
  void _showJobSearchTips(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.lightbulb, color: Colors.orange),
            const SizedBox(width: 10),
            Text("如何有效找工作？", style: TextStyle(color: themeColor, fontSize: 18)),
          ],
        ),
        content: const SingleChildScrollView(
          child: ListBody(
            children: [
              Text("1. **優化個人履歷**：確保 PDF 是最新版本。", style: TextStyle(height: 1.6)),
              SizedBox(height: 10),
              Text("2. **善用專業技能**：標籤越精準，配對率越高。", style: TextStyle(height: 1.6)),
              SizedBox(height: 10),
              Text("3. **主動與 HR 溝通**：配對後別害羞，主動打招呼。", style: TextStyle(height: 1.6)),
              SizedBox(height: 10),
              Text("4. **關注優質企業**：優先看信譽良好的公司。", style: TextStyle(height: 1.6)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // 使用對話框自己的 ctx 關閉
            child: Text("我知道了", style: TextStyle(color: themeColor, fontWeight: FontWeight.bold)),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: themeColor,
                child: CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(
                    "https://ui-avatars.com/api/?name=$name&size=128&background=${themeColor.value.toRadixString(16).substring(2)}&color=fff"
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Text(school, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn("已投遞", "15"),
                _buildStatColumn("配對成功", "8"),
                _buildStatColumn("面試邀請", "3"),
              ],
            ),
            const SizedBox(height: 25),
            _buildSectionTitle("專業技能"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: skills.map((s) => Chip(
                  label: Text(s, style: TextStyle(color: themeColor)),
                  backgroundColor: themeColor.withOpacity(0.1),
                )).toList(),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("系統設定與支援"),
            
            // 編輯按鈕
            _buildProfileTile(
              Icons.settings, 
              "個人資料編輯", 
              subtitle: "修改姓名與主題色", 
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(currentData: {
                      'name': name, 'school': school, 'skills': skills, 'themeColor': themeColor,
                    }),
                  ),
                );
                if (result != null) {
                  setState(() {
                    name = result['name']; school = result['school'];
                    skills = result['skills']; themeColor = result['themeColor'];
                  });
                  _saveToDisk(result);
                }
              }
            ),
            
            // 🚀 修正點：加上 Builder 確保 context 正確傳遞
            Builder(
              builder: (innerContext) => _buildProfileTile(
                Icons.help_outline, 
                "幫助與支援", 
                subtitle: "如何有效找工作？點我查看秘訣",
                onTap: () {
                  print("觸發對話框"); // 可以在 Debug Console 看到是否有執行
                  _showJobSearchTips(innerContext);
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(selectedIndex: 3),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themeColor)),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: themeColor)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildProfileTile(IconData icon, String title, {String? subtitle, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: themeColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 13)) : null,
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap, // 確保 onTap 被正確連接
    );
  }
}