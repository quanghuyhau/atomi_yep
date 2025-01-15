import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cubits/vote/vote_cubit.dart';
import '../home/home_screen.dart';

class EnterInputName extends StatefulWidget {
  const EnterInputName({super.key});

  @override
  State<EnterInputName> createState() => _EnterInputNameState();
}

class _EnterInputNameState extends State<EnterInputName> {
  final _nameController = TextEditingController();
  bool _isNameValid = false;
  final _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _checkExistingName();
  }

  Future<void> _checkExistingName() async {
    final prefs = await _prefs;
    final savedName = prefs.getString('voter_name');
    if (savedName != null && savedName.isNotEmpty) {
      context.read<VoteCubit>().updateVoterName(savedName);
      _navigateToHome();
    }
  }

  void _validateName(String value) {
    setState(() {
      _isNameValid = value.trim().length >= 2;
    });
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      final prefs = await _prefs;
      await prefs.setString('voter_name', name);
      context.read<VoteCubit>().updateVoterName(name);
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text(
                'Chào mừng bạn!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Vui lòng nhập tên của bạn để tiếp tục',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      onChanged: _validateName,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Tên của bạn',
                        labelStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15,
                        ),
                        hintText: 'Nhập tên của bạn',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lưu ý: Tên này sẽ được sử dụng cho tất cả các lần bình chọn',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _isNameValid ? _saveName : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  disabledBackgroundColor: Colors.grey[300],
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Tiếp tục',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isNameValid ? Colors.white : Colors.grey[600],
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
