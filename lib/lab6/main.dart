
import 'package:flutter/material.dart';

void main() {
runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
const ResponsiveMovieApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Responsive Movie',
theme: ThemeData(
useMaterial3: true,
colorScheme: ColorScheme.fromSeed(
seedColor: Colors.blue,
),
),
home: const HeroScreen(),
);
}
}

class HeroScreen extends StatelessWidget {
const HeroScreen({super.key});

@override
Widget build(BuildContext context) {
// Lấy kích thước màn hình
final screenWidth = MediaQuery.of(context).size.width;

// Breakpoint
final bool isWideScreen = screenWidth >= 800;

return Scaffold(
body: SafeArea(
child: Center(
child: Padding(
padding: EdgeInsets.symmetric(
horizontal: isWideScreen ? 60 : 24,
vertical: 24,
),
child: LayoutBuilder(
builder: (context, constraints) {
// Responsive hero height
final heroHeight =
constraints.maxWidth >= 800 ? 420.0 : 350.0;

return Container(
width: double.infinity,
height: heroHeight,
padding: EdgeInsets.all(
isWideScreen ? 48 : 24,
),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(24),
gradient: const LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
Colors.blue,
Colors.indigo,
],
),
),

child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment:
CrossAxisAlignment.center,
children: [
// Movie icon
Icon(
Icons.movie_creation_outlined,
size: isWideScreen ? 90 : 65,
color: Colors.white,
),

SizedBox(
height: isWideScreen ? 24 : 16,
),

// Heading
Text(
'Find a Movie',
textAlign: TextAlign.center,
style: TextStyle(
fontSize:
isWideScreen ? 42 : 30,
fontWeight: FontWeight.bold,
color: Colors.white,
),
),

const SizedBox(height: 12),

// Description
Text(
'Discover movies you will love',
textAlign: TextAlign.center,
style: TextStyle(
fontSize:
isWideScreen ? 20 : 16,
color: Colors.white70,
),
),

SizedBox(
height: isWideScreen ? 32 : 24,
),

// Responsive button
SizedBox(
width: isWideScreen ? 220 : 180,
height: isWideScreen ? 52 : 46,
child: ElevatedButton.icon(
onPressed: () {},
icon: const Icon(
Icons.search,
),
label: Text(
'Explore Movies',
style: TextStyle(
fontSize:
isWideScreen ? 17 : 14,
),
),
),
),
],
),
);
},
),
),
),
),
);
}
}
