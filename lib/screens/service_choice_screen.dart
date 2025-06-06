import 'package:flutter/material.dart';

class ServiceChoiceScreen extends StatelessWidget {
  const ServiceChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BINAA بناء'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome Section
                Icon(
                  Icons.business,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to BINAA',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Please select the service you need',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Service Selection Cards
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Use Row for wide screens, Column for narrow screens
                      if (constraints.maxWidth > 800) {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                'Extract Site Validity',
                                Icons.location_on,
                                '/site-validity',
                                Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                'Extract License',
                                Icons.business_center,
                                '/extracting-license',
                                Colors.green,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                'Extract Site Validity',
                                Icons.location_on,
                                '/site-validity',
                                Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: _buildServiceCard(
                                context,
                                'Extract License',
                                Icons.business_center,
                                '/extracting-license',
                                Colors.green,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    Color color,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background Design Element
              Positioned(
                right: -50,
                bottom: -50,
                child: Icon(
                  icon,
                  size: 200,
                  color: color.withOpacity(0.05),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 64,
                      color: color,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Click to proceed',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 