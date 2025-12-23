import 'package:flutter/material.dart';
import '../services/job_service.dart';
import '../models/job.dart';
import '../widgets/bottom_nav.dart';

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
    setState(() { _index++; });
  }

  void _dislike() async {
    if (_index >= _cards.length) return;
    await _service.dislikeJob(_cards[_index].id);
    setState(() { _index++; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('滑卡找實習')),
      // 如果這裡報紅線，請把 const 刪掉
      bottomNavigationBar: BottomNav(selectedIndex: 1),
      body: _loading 
          ? const Center(child: CircularProgressIndicator()) 
          : _cards.isEmpty 
              ? const Center(child: Text('目前沒有更多職缺')) 
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: _index < _cards.length 
                            ? Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.all(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_cards[_index].title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 10),
                                      Text(_cards[_index].company, style: TextStyle(fontSize: 18, color: Colors.blue[700])),
                                      const SizedBox(height: 5),
                                      Text('📍 ${_cards[_index].location}', style: const TextStyle(color: Colors.grey)),
                                      const Divider(height: 30),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(_cards[_index].description, style: const TextStyle(fontSize: 16, height: 1.5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ) 
                            : const Center(child: Text('已經全部看完囉！')),
                      ),
                    ),
                    // 按鈕區
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            heroTag: "dislike",
                            backgroundColor: Colors.white,
                            onPressed: _dislike,
                            child: const Icon(Icons.close, color: Colors.red, size: 30),
                          ),
                          FloatingActionButton(
                            heroTag: "like",
                            backgroundColor: Colors.pinkAccent,
                            onPressed: _like,
                            child: const Icon(Icons.favorite, color: Colors.white, size: 30),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}