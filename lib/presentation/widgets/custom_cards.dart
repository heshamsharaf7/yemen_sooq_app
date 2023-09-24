import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Controls the shadow depth
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adds rounded corners
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/map.JPG', // Add your own image
            fit: BoxFit.cover, // Adjust the image fitting
          ),
          ListTile(
            title: Text(
              'Card Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              'Card Subtitle',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          ButtonBar(
            children: [
              InkWell(
                child: Text(
                  'ACTION 1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Add your action here
                },
              ),
              InkWell(
                child: Text(
                  'ACTION 2',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Add your action here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}