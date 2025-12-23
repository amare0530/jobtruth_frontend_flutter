import 'package:flutter/material.dart';
import '../models/job.dart';
import '../pages/job_detail_page.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(job.company),
      trailing: IconButton(icon: Icon(job.liked ? Icons.favorite : Icons.favorite_border, color: Colors.pink), onPressed: () {}),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailPage(jobId: job.id)));
      },
    );
  }
}
