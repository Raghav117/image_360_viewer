import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_360_viewer/image_360_viewer.dart';

void main() {
  runApp(const Image360ViewerExampleApp());
}

class Image360ViewerExampleApp extends StatelessWidget {
  const Image360ViewerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image360Viewer Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  // Helper function to generate asset list
  List<String> _generateAssetList(
    String basePath,
    int count, {
    int step = 1,
    String fileExtension = 'png',
  }) {
    List<String> assets = [];
    for (int i = 1; i <= count; i += step) {
      String frameNumber = i.toString().padLeft(
        2,
        '0',
      ); // Pad with zero (01, 02, etc.)
      assets.add('$basePath$frameNumber.$fileExtension');
    }
    return assets;
  }

  // Different product categories for 360° demo
  int _selectedProduct = 0;
  final List<Map<String, dynamic>> _productCategories = [
    {
      'name': 'Under Armour 360° - All Frames',
      'description': 'Full rotation with all 71 local asset frames',
      'assetBasePath': 'assets/UnderArmour-',
      'frameCount': 71,
      'frameStep': 1,
      'fileExtension': 'jpg',
    },
    {
      'name': 'Under Armour 360° - Every 2nd Frame',
      'description': 'Balanced quality with 36 local frames',
      'assetBasePath': 'assets/UnderArmour-',
      'frameCount': 71,
      'frameStep': 2,
      'fileExtension': 'jpg',
    },
    {
      'name': 'Under Armour 360° - Every 4th Frame',
      'description': 'Quick loading with 18 local frames',
      'assetBasePath': 'assets/UnderArmour-',
      'frameCount': 71,
      'frameStep': 4,
      'fileExtension': 'jpg',
    },
  ];

  // Get current product asset list
  List<String> get _currentAssetList => _generateAssetList(
    _productCategories[_selectedProduct]['assetBasePath'] as String,
    _productCategories[_selectedProduct]['frameCount'] as int,
    step: _productCategories[_selectedProduct]['frameStep'] as int,
    fileExtension:
        _productCategories[_selectedProduct]['fileExtension'] as String? ??
        'png',
  );

  String get _currentProductName =>
      _productCategories[_selectedProduct]['name'] as String;
  String get _currentProductDescription =>
      _productCategories[_selectedProduct]['description'] as String;

  // Control states
  bool _autoRotate = true;
  bool _zoomEnabled = true;
  bool _gyroEnabled = false;
  bool _reverseOnEnd = false;
  bool _shadowEnabled = false;
  double _autoRotateSpeed = 600.0; // Slower default speed
  double _gyroSensitivity = 1.0; // New gyroscope sensitivity control

  // Generate a unique key based on current settings to force rebuild
  String get _viewerKey =>
      'viewer_${_selectedProduct}_${_autoRotate}_${_zoomEnabled}_${_gyroEnabled}_${_reverseOnEnd}_${_shadowEnabled}_${_autoRotateSpeed.round()}_${_gyroSensitivity}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Image360Viewer Demo'),
        elevation: 2,
      ),
      body: _buildInteractiveDemo(),
    );
  }

  Widget _buildInteractiveDemo() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎮 Interactive Controls',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use the switches below to control the 360° viewer behavior',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          // Product Selector
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📦 Select Product',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _productCategories.length,
                      itemBuilder: (context, index) {
                        final product = _productCategories[index];
                        final isSelected = index == _selectedProduct;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedProduct = index),
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Colors.blue
                                        : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  isSelected
                                      ? Colors.blue.shade50
                                      : Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(7),
                                    ),
                                    child: Image.asset(
                                      '${product['assetBasePath']}01.${product['fileExtension'] ?? 'png'}', // Show first frame of asset
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                color: Colors.grey.shade200,
                                                child: const Icon(
                                                  Icons.view_in_ar,
                                                  size: 40,
                                                ),
                                              ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['name'] as String,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              isSelected
                                                  ? Colors.blue
                                                  : Colors.black,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        product['description'] as String,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Current Product Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.blue.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.view_in_ar, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Now Viewing: $_currentProductName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        _currentProductDescription,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Debug Info Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Debug Info:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  'Type: Assets',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  'Count: ${_currentAssetList.length} images',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
                Text(
                  'First: ${_currentAssetList.isNotEmpty ? _currentAssetList.first : "None"}',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Status Indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              border: Border.all(color: Colors.green.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (_autoRotate)
                  _buildStatusChip(
                    'Auto Rotate',
                    Icons.rotate_right,
                    Colors.blue,
                  ),
                if (_zoomEnabled)
                  _buildStatusChip('Zoom', Icons.zoom_in, Colors.purple),
                if (_gyroEnabled)
                  _buildStatusChip(
                    'Gyro ${_gyroSensitivity.toStringAsFixed(1)}x',
                    Icons.screen_rotation,
                    Colors.orange,
                  ),
                if (_reverseOnEnd)
                  _buildStatusChip('Mirror', Icons.flip, Colors.teal),
                if (_shadowEnabled)
                  _buildStatusChip('Shadows', Icons.wb_sunny, Colors.amber),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 360 Viewer
          Container(
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image360Viewer.asset(
              key: ValueKey(_viewerKey),
              imageAssetList: _currentAssetList,
              autoRotate: _autoRotate,
              zoomEnabled: _zoomEnabled,
              gyroEnabled: _gyroEnabled,
              gyroSensitivity: _gyroSensitivity,
              reverseOnEnd: _reverseOnEnd,
              autoRotateSpeed: _autoRotateSpeed.round(),
              backgroundColor: Colors.grey.shade50,
              shadowIntensityByFrame:
                  _shadowEnabled
                      ? (frameIndex) {
                        final normalizedIndex =
                            frameIndex / _currentAssetList.length;
                        final angle = normalizedIndex * 2 * math.pi;
                        return (math.sin(angle) + 1) * 0.2;
                      }
                      : null,
              loadingWidget: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading assets...'),
                  ],
                ),
              ),
              errorWidget: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 48, color: Colors.red),
                    SizedBox(height: 8),
                    Text(
                      'Failed to load asset images',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Check if assets are properly configured',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Control Panel
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '⚙️ Controls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Auto Rotate Switch
                  _buildSwitchTile(
                    title: 'Auto Rotate',
                    subtitle: 'Automatically rotate the object',
                    value: _autoRotate,
                    onChanged: (value) => setState(() => _autoRotate = value),
                    icon: Icons.rotate_right,
                  ),

                  // Auto Rotate Speed Slider (only when auto rotate is on)
                  if (_autoRotate) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Auto-Rotate Speed: ${_autoRotateSpeed.round()}ms',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Slider(
                            value: _autoRotateSpeed,
                            min: 300,
                            max: 1500,
                            divisions: 24,
                            onChanged:
                                (value) =>
                                    setState(() => _autoRotateSpeed = value),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const Divider(),

                  // Zoom Switch
                  _buildSwitchTile(
                    title: 'Pinch to Zoom',
                    subtitle: 'Enable zoom functionality',
                    value: _zoomEnabled,
                    onChanged: (value) => setState(() => _zoomEnabled = value),
                    icon: Icons.zoom_in,
                  ),

                  const Divider(),

                  // Gyroscope Switch
                  _buildSwitchTile(
                    title: 'Gyroscope Control',
                    subtitle: 'Rotate with device tilt',
                    value: _gyroEnabled,
                    onChanged: (value) => setState(() => _gyroEnabled = value),
                    icon: Icons.screen_rotation,
                  ),

                  // Gyroscope Sensitivity Slider (only when gyroscope is on)
                  if (_gyroEnabled) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gyro Sensitivity: ${_gyroSensitivity.toStringAsFixed(1)}x',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Slider(
                            value: _gyroSensitivity,
                            min: 0.1,
                            max: 3.0,
                            divisions: 29,
                            onChanged:
                                (value) =>
                                    setState(() => _gyroSensitivity = value),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const Divider(),

                  // Reverse on End Switch
                  _buildSwitchTile(
                    title: 'Mirror Playback',
                    subtitle: 'Reverse direction at end',
                    value: _reverseOnEnd,
                    onChanged: (value) => setState(() => _reverseOnEnd = value),
                    icon: Icons.flip,
                  ),

                  const Divider(),

                  // Shadow Effect Switch
                  _buildSwitchTile(
                    title: 'Dynamic Shadows',
                    subtitle: 'Simulate lighting effects',
                    value: _shadowEnabled,
                    onChanged:
                        (value) => setState(() => _shadowEnabled = value),
                    icon: Icons.wb_sunny,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Instructions Card
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Text(
                        '360° Product View Demo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Swipe horizontally to rotate the product manually',
                  ),
                  const Text('• Pinch to zoom in/out (when enabled)'),
                  const Text(
                    '• Tilt device to rotate (when gyroscope enabled)',
                  ),
                  const Text('• Toggle switches to see different behaviors'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: Colors.amber.shade700,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'This demo uses local Under Armour asset images (71 frames) for fast loading and optimal performance. Switch between different frame rates to see the quality vs performance trade-offs.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, IconData icon, Color color) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      avatar: Icon(icon, color: Colors.white, size: 16),
      backgroundColor: color,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: value ? Colors.blue : Colors.grey),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(value: value, onChanged: onChanged),
      contentPadding: EdgeInsets.zero,
    );
  }
}
