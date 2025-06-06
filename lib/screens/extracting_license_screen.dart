import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/document_upload_card.dart';

class ExtractingLicenseScreen extends StatefulWidget {
  const ExtractingLicenseScreen({super.key});

  @override
  State<ExtractingLicenseScreen> createState() => _ExtractingLicenseScreenState();
}

class _ExtractingLicenseScreenState extends State<ExtractingLicenseScreen> with SingleTickerProviderStateMixin {
  XFile? _idImage;
  XFile? _empowermentImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploadingId = false;
  bool _isUploadingEmpowerment = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(bool isId) async {
    try {
      setState(() {
        if (isId) {
          _isUploadingId = true;
        } else {
          _isUploadingEmpowerment = true;
        }
      });

      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          if (isId) {
            _idImage = pickedFile;
          } else {
            _empowermentImage = pickedFile;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        if (isId) {
          _isUploadingId = false;
        } else {
          _isUploadingEmpowerment = false;
        }
      });
    }
  }

  void _handleSubmit() {
    // Get the list of uploaded files
    final List<String> uploadedFiles = [
      if (_idImage != null) 'National ID',
      if (_empowermentImage != null) 'Empowerment Document',
    ];

    // Show success message with the list of uploaded files
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Successfully uploaded: ${uploadedFiles.join(", ")}',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );

    // Reset the form
    setState(() {
      _idImage = null;
      _empowermentImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasAnyFile = _idImage != null || _empowermentImage != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracting License'),
        centerTitle: true,
        actions: [
          // Add navigation to Site Validity screen
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: () {
              Navigator.pushNamed(context, '/site-validity');
            },
            tooltip: 'Check Site Validity',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'License Extraction Request',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Upload your documents to proceed with your construction permit request',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 800) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DocumentUploadCard(
                                title: 'National ID',
                                webImageFile: _idImage,
                                isUploading: _isUploadingId,
                                onUploadPressed: () => _pickImage(true),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: DocumentUploadCard(
                                title: 'Empowerment Document',
                                webImageFile: _empowermentImage,
                                isUploading: _isUploadingEmpowerment,
                                onUploadPressed: () => _pickImage(false),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            DocumentUploadCard(
                              title: 'National ID',
                              webImageFile: _idImage,
                              isUploading: _isUploadingId,
                              onUploadPressed: () => _pickImage(true),
                            ),
                            const SizedBox(height: 24),
                            DocumentUploadCard(
                              title: 'Empowerment Document',
                              webImageFile: _empowermentImage,
                              isUploading: _isUploadingEmpowerment,
                              onUploadPressed: () => _pickImage(false),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  // File Status Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey[200]!,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              _idImage != null ? Icons.check_circle : Icons.circle_outlined,
                              color: _idImage != null ? Colors.green : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'National ID',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              _empowermentImage != null ? Icons.check_circle : Icons.circle_outlined,
                              color: _empowermentImage != null ? Colors.green : Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Empowerment Document',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: hasAnyFile ? _handleSubmit : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        disabledBackgroundColor: Colors.grey[300],
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.grey[600],
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        hasAnyFile 
                            ? 'Submit Uploaded Files' 
                            : 'Upload at least one file to submit',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 