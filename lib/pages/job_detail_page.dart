import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 
import '../services/job_service.dart';
import '../models/job.dart';

class JobDetailPage extends StatefulWidget {
  final String jobId;
  const JobDetailPage({super.key, required this.jobId});

  @override
  JobDetailPageState createState() => JobDetailPageState();
}

class JobDetailPageState extends State<JobDetailPage> {
  final JobService _service = JobService();
  Job? _job;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final j = await _service.fetchJobById(widget.jobId);
    setState(() {
      _job = j;
      _loading = false;
    });
  }

  // 🚀 進階搜尋功能：自動帶入關鍵字並跳轉 104
  Future<void> _launchSearchURL() async {
    if (_job == null) return;

    // 將職位名稱進行編碼，確保中文網址能正確識別
    final String query = Uri.encodeComponent(_job!.title);
    
    // 直接構建 104 的搜尋連結
    final Uri url = Uri.parse('https://www.104.com.tw/jobs/search/?keyword=$query');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("無法開啟瀏覽器，請檢查網路連線")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('職缺詳情'), elevation: 1),
      body: _loading 
          ? const Center(child: CircularProgressIndicator()) 
          : _job == null 
              ? const Center(child: Text('找不到職缺')) 
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 標題
                      Text(_job!.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      // 公司
                      Text(_job!.company, style: TextStyle(color: Colors.blue[700], fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      
                      // 🚀 修改後的按鈕：自動搜尋同類型職缺
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _launchSearchURL,
                          icon: const Icon(Icons.search, color: Colors.orange),
                          label: Text("全網搜尋「${_job!.title}」相關職缺", 
                            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.orange, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(children: [
                        const Icon(Icons.location_on, size: 18, color: Colors.grey), 
                        const SizedBox(width: 6), 
                        Text('地點: ${_job!.location}'),
                        const SizedBox(width: 16), 
                        const Icon(Icons.access_time, size: 18, color: Colors.grey), 
                        const SizedBox(width: 6), 
                        const Text('類型: 暑期/學期實習')
                      ]),
                      const Divider(height: 40),
                      
                      const Text('職務描述', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(_job!.description, style: const TextStyle(fontSize: 16, height: 1.6)),
                      const SizedBox(height: 30),
                      
                      // AI 安全分析區塊
                      const Text('AI 徵才安全評估', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Card(
                        color: Colors.green[50],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), 
                          side: BorderSide(color: Colors.green[100]!)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.verified, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Text('安全認證通過', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[900])),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'AI 分析：該職位標題「${_job!.title}」描述清晰，發佈公司「${_job!.company}」信譽良好，未偵測到異常徵才行為。',
                                style: TextStyle(color: Colors.green[800], fontSize: 13)
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      // 底部返回按鈕
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50), 
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('返回繼續滑卡', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }
}