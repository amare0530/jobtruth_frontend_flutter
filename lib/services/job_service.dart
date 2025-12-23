import '../models/job.dart';
import 'dart:math';

class JobService {
  // 🔹 列表頁：從 50 筆中隨機抓 10 筆
  Future<List<Job>> fetchJobs({String? keyword}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    // 每次都重新洗牌，保證跳轉回來時順序改變
    List<Job> pool = List.from(allJobs);
    pool.shuffle(); 
    
    // 如果有關鍵字，就簡單過濾（選做，增加 Demo 真實度）
    if (keyword != null && keyword.isNotEmpty) {
      return pool.where((j) => j.title.contains(keyword) || j.company.contains(keyword)).toList();
    }
    
    return pool.take(10).toList(); 
  }

  // 🔹 滑卡頁：從 50 筆中隨機抓 15 筆，且順序與列表頁獨立
  Future<List<Job>> fetchSwipeJobs() async {
    List<Job> pool = List.from(allJobs);
    pool.shuffle(); 
    return pool.take(15).toList(); 
  }

  // 🔹 詳情頁：直接根據 ID 找資料（不隨機，確保點進去是對的）
  Future<Job> fetchJobById(String id) async {
    return allJobs.firstWhere(
      (j) => j.id == id, 
      orElse: () => allJobs[0]
    );
  }

  // Like/Dislike 保持原樣...
  Future<void> likeJob(String id) async { /* Post to API */ }
  Future<void> dislikeJob(String id) async { /* Post to API */ }
}