import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List produk bakery
  final List<Map<String, dynamic>> _produkList = [];

  // Controller input
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  // Tambah produk baru
  void _tambahProduk() {
    _namaController.clear();
    _hargaController.clear();
    _stokController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: _hargaController,
              decoration: const InputDecoration(labelText: 'Harga (Rp)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stokController,
              decoration: const InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
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
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  // Edit produk
  void _editProduk(int index) {
    final produk = _produkList[index];
    _namaController.text = produk['nama'];
    _hargaController.text = produk['harga'].toString();
    _stokController.text = produk['stok'].toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: _hargaController,
              decoration: const InputDecoration(labelText: 'Harga (Rp)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stokController,
              decoration: const InputDecoration(labelText: 'Stok'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _produkList[index] = {
                  'nama': _namaController.text,
                  'harga': int.parse(_hargaController.text),
                  'stok': int.parse(_stokController.text),
                };
              });
              Navigator.pop(context);
            },
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
        title: const Text('Hapus Produk'),
        content: const Text('Yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _produkList.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  // Logout
  void _logout() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Bakery Cafe'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: _tambahProduk,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _produkList.isEmpty
            ? const Center(
          child: Text(
            'Belum ada produk ditambahkan 🍞',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        )
            : ListView.builder(
          itemCount: _produkList.length,
          itemBuilder: (context, index) {
            final produk = _produkList[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  produk['nama'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Harga: Rp${produk['harga']} | Stok: ${produk['stok']}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => _editProduk(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
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
