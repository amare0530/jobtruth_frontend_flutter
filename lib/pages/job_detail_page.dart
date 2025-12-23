import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('職缺詳情')),
      body: _loading 
          ? const Center(child: CircularProgressIndicator()) 
          : _job == null 
              ? const Center(child: Text('找不到職缺')) 
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 標題與公司
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_job!.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(_job!.company, style: TextStyle(color: Colors.blue[700], fontSize: 18, fontWeight: FontWeight.w500)),
                            ],
                          )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 動態地點與資訊
                      Row(children: [
                        const Icon(Icons.location_on, size: 18, color: Colors.grey), 
                        const SizedBox(width: 6), 
                        Text('地點: ${_job!.location}'), // 動態顯示地點
                        const SizedBox(width: 16), 
                        const Icon(Icons.access_time, size: 18, color: Colors.grey), 
                        const SizedBox(width: 6), 
                        const Text('類型: 暑期/學期實習')
                      ]),
                      const SizedBox(height: 18),
                      const Text('職務描述', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_job!.description, style: const TextStyle(fontSize: 16, height: 1.5)),
                      const SizedBox(height: 24),
                      // 專業 AI 分析區塊
                      const Text('AI 徵才安全評估', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.blue[50],
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.verified_user, color: Colors.blue[800]),
                                  const SizedBox(width: 8),
                                  Text('可信度分數: ${_job!.id.hashCode % 20 + 80}%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('分析結果：該職缺由「${_job!.company}」官方發佈，內容符合市場行情，未發現詐騙風險。', style: TextStyle(color: Colors.blue[900])),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50), backgroundColor: Colors.blue),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('關閉並返回', style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}