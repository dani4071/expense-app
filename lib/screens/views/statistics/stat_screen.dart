import 'dart:math';

import 'package:expense_tracker/screens/views/statistics/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class statScreen extends StatelessWidget {
  const statScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Icon(CupertinoIcons.list_bullet_below_rectangle, size: 25,),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 7.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Income", style: TextStyle(color: Colors.black),)),
                      ),
                    ),
                    const SizedBox(width: 2,),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.tertiary,
                            ],
                            transform: const GradientRotation(pi / 4),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Text("Expenses", style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            
            const Text("01 Jan 2024 - 02 Apr 2027"),
            const SizedBox(height: 10,),
            const Text("\$450000", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: myChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
