import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;
  final Gradient gradient;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}
