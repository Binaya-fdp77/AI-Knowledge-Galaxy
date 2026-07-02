import 'package:flutter/material.dart';

/// Home page for "My EDU Dashboard" app.
/// Matches wireframe: header (menu / title / profile), a 2x2 grid of
/// feature cards (Upload, Chat, Quizzes, Progress), a full-width
/// Analysis card, and a bottom navigation bar.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.home_outlined, label: 'Home'),
    _NavItem(icon: Icons.upload_outlined, label: 'Upload'),
    _NavItem(icon: Icons.chat_bubble_outline, label: 'Chat'),
    _NavItem(icon: Icons.bar_chart_outlined, label: 'Progress'),
    _NavItem(icon: Icons.pie_chart_outline, label: 'Analysis'),
  ];

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    // TODO: hook up navigation to the corresponding screens.
  }

  void _onCardTap(String cardLabel) {
    // TODO: navigate to the relevant feature screen.
    debugPrint('Tapped: $cardLabel');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: const Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My EDU Dashboard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 24),
                ListTile(leading: Icon(Icons.home_outlined), title: Text('Home')),
                ListTile(leading: Icon(Icons.file_upload_outlined), title: Text('Upload')),
                ListTile(leading: Icon(Icons.chat_bubble_outline), title: Text('Chat')),
                ListTile(leading: Icon(Icons.quiz_outlined), title: Text('Quizzes')),
                ListTile(leading: Icon(Icons.show_chart), title: Text('Progress')),
                ListTile(leading: Icon(Icons.pie_chart_outline), title: Text('Analysis')),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black87),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'My EDU Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
                color: Colors.black87,
                size: 28,
              ),
              onPressed: () {
                // TODO: navigate to profile screen.
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2x2 grid: Upload, Chat, Quizzes, Progress
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.95,
                children: [
                  _DashboardCard(
                    icon: Icons.file_upload_outlined,
                    label: 'Upload',
                    onTap: () => _onCardTap('Upload'),
                  ),
                  _DashboardCard(
                    icon: Icons.chat_bubble_outline,
                    label: 'Chat',
                    onTap: () => _onCardTap('Chat'),
                  ),
                  _DashboardCard(
                    icon: Icons.quiz_outlined,
                    label: 'Quizzes',
                    onTap: () => _onCardTap('Quizzes'),
                  ),
                  _DashboardCard(
                    icon: Icons.show_chart,
                    label: 'Progress',
                    onTap: () => _onCardTap('Progress'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Full-width Analysis card
              _DashboardCard(
                icon: Icons.pie_chart_outline,
                label: 'Analysis',
                height: 160,
                onTap: () => _onCardTap('Analysis'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: _navItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  const _NavItem({required this.icon, required this.label});
}

/// Reusable dashboard feature card matching the wireframe style:
/// an icon, a label, and a couple of placeholder text lines.
class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double? height;

  const _DashboardCard({
    required this.icon,
    required this.label,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32, color: Colors.black87),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 14),
                // Placeholder text lines, as shown in the wireframe.
                _placeholderLine(width: double.infinity),
                const SizedBox(height: 6),
                _placeholderLine(width: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholderLine({required double width}) {
    return Container(
      height: 2,
      width: width,
      color: const Color(0xFFD5D5D5),
    );
  }
}