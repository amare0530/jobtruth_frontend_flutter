import 'package:flutter/material.dart';
import '../services/job_service.dart';
import '../models/job.dart';
import '../widgets/bottom_nav.dart';
import 'job_detail_page.dart'; // 🚀 記得要匯入詳情頁

class JobSwipePage extends StatefulWidget {
  const JobSwipePage({super.key});

  @override
  JobSwipePageState createState() => JobSwipePageState();
}

class JobSwipePageState extends State<JobSwipePage> {
  final JobService _service = JobService();
  List<Job> _cards = [];
  int _index = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final jobs = await _service.fetchSwipeJobs();
    setState(() {
      _cards = jobs;
      _loading = false;
      _index = 0;
    });
  }

  void _like() async {
    if (_index >= _cards.length) return;
    await _service.likeJob(_cards[_index].id);
    setState(() {
      _index++;
    });
  }

  void _dislike() async {
    if (_index >= _cards.length) return;
    await _service.dislikeJob(_cards[_index].id);
    setState(() {
      _index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滑卡找實習', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNav(selectedIndex: 1),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _cards.isEmpty
              ? const Center(child: Text('目前沒有更多職缺'))
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: _index < _cards.length
                            ? GestureDetector(
                                // 🚀 創意實作：點擊卡片跳轉詳情
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetailPage(jobId: _cards[_index].id),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 8,
                                  shadowColor: Colors.black26,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                  margin: const EdgeInsets.all(20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // 標題
                                        Text(_cards[_index].title, 
                                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        const SizedBox(height: 12),
                                        // 公司名稱
                                        Text(_cards[_index].company, 
                                          style: TextStyle(fontSize: 18, color: Colors.blue[700], fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 8),
                                        // 地點
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(_cards[_index].location, style: const TextStyle(color: Colors.grey)),
                                          ],
                                        ),
                                        const Divider(height: 40, thickness: 1),
                                        // 內容簡介
                                        Expanded(
                                          child: SingleChildScrollView(
                                            // 讓點擊事件穿透，避免 SingleChildScrollView 攔截了卡片的點擊
                                            physics: const NeverScrollableScrollPhysics(),
                                            child: Text(
                                              _cards[_index].description,
                                              style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
                                              maxLines: 10,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        // 🚀 引導點擊的小提示
                                        const Center(
                                          child: Column(
                                            children: [
                                              Icon(Icons.keyboard_arrow_up, color: Colors.blue, size: 20),
                                              Text("點擊卡片查看 AI 分析與官網連結", 
                                                style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle_outline, size: 60, color: Colors.green),
                                    SizedBox(height: 16),
                                    Text('已經全部看完囉！', style: TextStyle(fontSize: 18, color: Colors.grey)),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    // 按鈕區
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 不喜歡按鈕
                          _buildActionButton(
                            icon: Icons.close,
                            color: Colors.red,
                            onPressed: _dislike,
                            heroTag: "dislike",
                          ),
                          // 喜歡按鈕
                          _buildActionButton(
                            icon: Icons.favorite,
                            color: Colors.pinkAccent,
                            onPressed: _like,
                            heroTag: "like",
                            isBig: true,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }

  // 封裝按鈕樣式，讓代碼更整潔
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required String heroTag,
    bool isBig = false,
  }) {
    return Container(
      width: isBig ? 70 : 60,
      height: isBig ? 70 : 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isBig ? color : Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: RawMaterialButton(
        shape: const CircleBorder(),
        onPressed: onPressed,
        child: Icon(icon, color: isBig ? Colors.white : color, size: isBig ? 35 : 30),
      ),
    );
  }
}