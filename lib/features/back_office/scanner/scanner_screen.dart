import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tickety/core/theme/app_theme.dart';
import '../../../core/mcp_mock/mcp_mock_client.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final code = barcodes.first.rawValue!;
      setState(() => _isProcessing = true);

      try {
        final api = ref.read(mcpClientProvider);
        final success = await api.validateTicketByQR(code);

        if (!mounted) return;
        
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.surfaceContainerLowest,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(success ? 'Valide !' : 'Billet Invalide', style: Theme.of(context).textTheme.headlineSmall),
            content: Text(
              success ? 'Accès autorisé.' : 'Le billet a déjà été scanné ou est introuvable.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) setState(() => _isProcessing = false);
                  });
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation Billet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
          ),
          if (_isProcessing)
            Container( // Loader
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator(color: AppColors.surface)),
            ),
           // "No line" overlay mask can optionally be drawn here
           Center(
             child: Container(
               width: 300,
               height: 300,
               decoration: BoxDecoration(
                 border: Border.all(color: AppTheme.outlineGhostBorder, width: 4),
                 borderRadius: BorderRadius.circular(16)
               ),
             ),
           )
        ],
      ),
    );
  }
}
