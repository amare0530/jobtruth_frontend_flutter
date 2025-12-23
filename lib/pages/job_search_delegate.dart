import 'package:flutter/material.dart';
import '../models/job.dart';
import 'job_detail_page.dart';

class JobSearchDelegate extends SearchDelegate<String> {
  // 引用 job.dart 裡的 200 筆資料
  final List<Job> jobs = allJobs;

  // 1. 右側：清除按鈕
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  // 2. 左側：返回按鈕
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  // 3. 搜尋結果顯示（按下確認後）
  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResultList();
  }

  // 4. 輸入時顯示的建議（一邊輸入一邊即時更新）
  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResultList();
  }

  // 🔹 統一處理搜尋過濾邏輯
  Widget _buildSearchResultList() {
    // 🚀 加強版過濾：同時比對標題、公司、地點，且不分大小寫
    final results = jobs.where((job) {
      final input = query.toLowerCase().trim(); // 去掉空格並轉小寫
      return job.title.toLowerCase().contains(input) || 
             job.company.toLowerCase().contains(input) ||
             job.location.toLowerCase().contains(input); // 👈 新增地點搜尋
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text("找不到相關職缺", style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final job = results[index];
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.work_outline, color: Colors.blue),
          ),
          title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          // 🚀 副標題現在會顯示：公司名稱 · 地點
          subtitle: Text("${job.company} · ${job.location}"), 
          trailing: const Icon(Icons.chevron_right, size: 20),
          onTap: () {
            // 點擊直接看詳情
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobDetailPage(jobId: job.id)),
            );
          },
        );
      },
    );
  }
}