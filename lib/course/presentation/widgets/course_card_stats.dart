import 'package:flutter/material.dart';
import 'package:biddabari/course/presentation/widgets/course_stat_chip.dart';

class CourseCardStats extends StatelessWidget {
  final int durationInMonths;
  final int totalClasses;
  final int totalExams;
  final bool isLive;

  const CourseCardStats({
    super.key,
    required this.durationInMonths,
    required this.totalClasses,
    required this.totalExams,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 6.0,
      children: [
        // Duration Stat
        CourseStatChip(
          icon: Icons.calendar_month_outlined,
          label:
              '$durationInMonths ${durationInMonths == 1 ? 'Month' : 'Months'}',
          color: const Color(0xFF0284C7),
          backgroundColor: const Color(0xFFF0F9FF),
        ),

        // Total Class Stat
        CourseStatChip(
          icon: Icons.ondemand_video_rounded,
          label: '$totalClasses Classes',
          color: const Color(0xFF059669),
          backgroundColor: const Color(0xFFECFDF5),
        ),

        // Total Exam Stat
        CourseStatChip(
          icon: Icons.assignment_outlined,
          label: '$totalExams Exams',
          color: const Color(0xFF7C3AED),
          backgroundColor: const Color(0xFFF5F3FF),
        ),

        // Live Mode Stat Indicator
        if (isLive)
          const CourseStatChip(
            icon: Icons.sensors_rounded,
            label: 'Live Batch',
            color: Color(0xFFDC2626),
            backgroundColor: Color(0xFFFEF2F2),
          ),
      ],
    );
  }
}
