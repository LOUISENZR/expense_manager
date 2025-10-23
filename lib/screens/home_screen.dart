import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _produkList = [];

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  // Tambah produk
  void _tambahProduk() {
    _namaController.clear();
    _hargaController.clear();
    _stokController.clear();

    _showProdukDialog(title: 'Tambah Produk', onConfirm: () {
      if (_namaController.text.isNotEmpty &&
          _hargaController.text.isNotEmpty &&
          _stokController.text.isNotEmpty) {
        setState(() {
          _produkList.add({
            'nama': _namaController.text,
            'harga': int.parse(_hargaController.text),
            'stok': int.parse(_stokController.text),
          });
        });
        Navigator.pop(context);
      }
    });
  }

  // Edit produk
  void _editProduk(int index) {
    final produk = _produkList[index];
    _namaController.text = produk['nama'];
    _hargaController.text = produk['harga'].toString();
    _stokController.text = produk['stok'].toString();

    _showProdukDialog(
      title: 'Edit Produk',
      onConfirm: () {
        setState(() {
          _produkList[index] = {
            'nama': _namaController.text,
            'harga': int.parse(_hargaController.text),
            'stok': int.parse(_stokController.text),
          };
        });
        Navigator.pop(context);
      },
    );
  }

  // Template dialog tambah/edit produk
  void _showProdukDialog({required String title, required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B1442).withValues(alpha: 0.95),
        title: Text(
          title,
          style: const TextStyle(
              color: Colors.amberAccent, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_namaController, 'Nama Produk'),
            const SizedBox(height: 8),
            _buildTextField(_hargaController, 'Harga (Rp)',
                keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            _buildTextField(_stokController, 'Stok',
                keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amberAccent.shade100,
              foregroundColor: Colors.black87,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // Hapus produk
  void _hapusProduk(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B1442).withValues(alpha: 0.95),
        title: const Text(
          'Hapus Produk',
          style: TextStyle(color: Colors.amberAccent),
        ),
        content: const Text(
          'Yakin ingin menghapus produk ini?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _produkList.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // Logout
  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }


  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0F2E),
      appBar: AppBar(
        title: const Text(
          'Bakery Admin Dashboard',
          style: TextStyle(color: Colors.amberAccent),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1B1442),
        elevation: 4,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: Colors.amberAccent),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent.shade100,
        onPressed: _tambahProduk,
        child: const Icon(Icons.add, color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _produkList.isEmpty
            ? const Center(
          child: Text(
            'Belum ada produk ditambahkan 🍞',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        )
            : ListView.builder(
          itemCount: _produkList.length,
          itemBuilder: (context, index) {
            final produk = _produkList[index];
            return Card(
              color: const Color(0xFF3A1E64).withValues(alpha: 0.7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  produk['nama'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent),
                ),
                subtitle: Text(
                  'Harga: Rp${produk['harga']} | Stok: ${produk['stok']}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:
                      const Icon(Icons.edit, color: Colors.orangeAccent),
                      onPressed: () => _editProduk(index),
                    ),
                    IconButton(
                      icon:
                      const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _hapusProduk(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
