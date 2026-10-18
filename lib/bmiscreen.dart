import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  String _jenisKelamin = 'Laki-laki';
  double? _hasilBMI;
  String _keterangan = "Masukkan Data Anda!!!";

  void _hitungBMI() {
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbCm > 0) {
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);
        _hasilBMI = hasil;

        if (_jenisKelamin == 'Laki-laki') {
          if (hasil < 18.5) {
            _keterangan = "Kurus (Kekurangan Berat Badan)";
          } else if (hasil >= 18.5 && hasil < 25.0) {
            _keterangan = "Normal / Ideal ✨";
          } else if (hasil >= 25.0 && hasil < 30.0) {
            _keterangan = "Kelebihan Berat Badan";
          } else {
            _keterangan = "Obesitas";
          }
        } else {
          if (hasil < 18.0) {
            _keterangan = "Kurus (Kekurangan Berat Badan)";
          } else if (hasil >= 18.0 && hasil < 24.0) {
            _keterangan = "Normal / Ideal ✨";
          } else if (hasil >= 24.0 && hasil < 29.0) {
            _keterangan = "Kelebihan Berat Badan";
          } else {
            _keterangan = "Obesitas";
          }
        }
      } else {
        _hasilBMI = null;
        _keterangan = "Data Tidak Valid / Masukkan Angka Benar!!!";
      }
    });
  }

  void _resetForm() {
    setState(() {
      _bbController.clear();
      _tbController.clear();
      _hasilBMI = null;
      _keterangan = "Masukkan Data Anda!!!";
      _jenisKelamin = 'Laki-laki';
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI Pro',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Pilih Jenis Kelamin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.male, color: Colors.blue),
                          SizedBox(width: 5),
                          Text('Laki-laki'),
                        ],
                      ),
                      selected: _jenisKelamin == 'Laki-laki',
                      selectedColor: Colors.teal.shade100,
                      onSelected: (selected) {
                        setState(() {
                          _jenisKelamin = 'Laki-laki';
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ChoiceChip(
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.female, color: Colors.pink),
                          SizedBox(width: 5),
                          Text('Perempuan'),
                        ],
                      ),
                      selected: _jenisKelamin == 'Perempuan',
                      selectedColor: Colors.teal.shade100,
                      onSelected: (selected) {
                        setState(() {
                          _jenisKelamin = 'Perempuan';
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _bbController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.monitor_weight, color: Colors.teal),
                  labelText: 'Berat Badan (kg)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _tbController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.height, color: Colors.teal),
                  labelText: 'Tinggi Badan (cm)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _hitungBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Hitung BMI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: _resetForm,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.red, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Reset', style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.teal.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Hasil Analisis BMI :',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.teal),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _hasilBMI?.toStringAsFixed(1) ?? '0.0',
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _keterangan,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: _hasilBMI == null ? Colors.grey : Colors.teal.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}