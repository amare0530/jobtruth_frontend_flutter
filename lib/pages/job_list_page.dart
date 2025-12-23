import 'package:flutter/material.dart';
import '../services/job_service.dart';
import '../models/job.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/job_card.dart';
import 'job_search_delegate.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  JobListPageState createState() => JobListPageState();
}


class JobListPageState extends State<JobListPage> {
  final JobService _service = JobService();
  List<Job> _jobs = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final jobs = await _service.fetchJobs();
      setState(() {
        _jobs = jobs;
        _loading = false;
      });
    } catch (e) {
      setState(() { _loading = false; });
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('找工作'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search), 
            onPressed: () {
              // 🚀 啟動你同學說的那套搜尋功能
              showSearch(
                context: context,
                delegate: JobSearchDelegate(),
              );
            }
          )
        ],
      ),
      body: _loading ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(
        onRefresh: _load,
        child: ListView.builder(
          itemCount: _jobs.length,
          itemBuilder: (ctx, i) => JobCard(job: _jobs[i]),
        ),
      ),
      bottomNavigationBar: const BottomNav(selectedIndex: 0),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shuffle),
        onPressed: () => Navigator.pushNamed(context, '/swipe'),
      ),
    );
  }
}
