import 'package:atomi_yep/main.dart';
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
  String? _employeeCode;
  List<Map<String, dynamic>> _searchResults = [];

  final List<Map<String, dynamic>> _employeeList = [
    {"id": 0, "employeeCode": "170001", "employeeName": "Phạm Quang Đệ"},
    {"id": 1, "employeeCode": "180002", "employeeName": "Dương Quang Sơn	"},
    {
      "id": 2,
      "employeeCode": "180006",
      "employeeName": "Nguyễn Thị Bích Hạnh	"
    },
    {"id": 3, "employeeCode": "180009", "employeeName": "Vũ Duy Nghĩa	"},
    {"id": 4, "employeeCode": "200005", "employeeName": "Đào Thị Ngân	"},
    {"id": 5, "employeeCode": "200007", "employeeName": "Đinh Văn Hưng	"},
    {"id": 6, "employeeCode": "210007", "employeeName": "Nguyễn Minh Cầu	"},
    {"id": 7, "employeeCode": "210019", "employeeName": "Trịnh Xuân Quân	"},
    {"id": 8, "employeeCode": "210034", "employeeName": "Vũ Ngọc Chiến	"},
    {"id": 9, "employeeCode": "220005", "employeeName": "Ngô Minh Hạnh	"},
    {
      "id": 10,
      "employeeCode": "220035",
      "employeeName": "Trần Phạm Quỳnh Như	"
    },
    {"id": 11, "employeeCode": "220044", "employeeName": "Đinh Tuấn Anh	"},
    {"id": 12, "employeeCode": "220053", "employeeName": "Vũ Trường Quang	"},
    {"id": 13, "employeeCode": "220055", "employeeName": "Nguyễn Văn Tài	"},
    {"id": 14, "employeeCode": "220061", "employeeName": "Nguyễn Đồng Tiến	"},
    {"id": 15, "employeeCode": "220082", "employeeName": "Nguyễn Lan Hương	"},
    {"id": 16, "employeeCode": "220086", "employeeName": "Vũ Hồng Nhị	"},
    {
      "id": 17,
      "employeeCode": "220089",
      "employeeName": "Phạm Thị Thanh Nhàn	"
    },
    {"id": 18, "employeeCode": "230008", "employeeName": "Phạm Quang Trung	"},
    {"id": 19, "employeeCode": "230011", "employeeName": "Lưu Chí Kiên	"},
    {
      "id": 20,
      "employeeCode": "230015",
      "employeeName": "Nguyễn Thị Thanh Huyền	"
    },
    {"id": 21, "employeeCode": "230024", "employeeName": "Nguyễn Hồng Sơn	"},
    {"id": 22, "employeeCode": "230038", "employeeName": "Nguyễn Văn Hưởng	"},
    {"id": 23, "employeeCode": "230053", "employeeName": "Nguyễn Văn Hiến	"},
    {"id": 24, "employeeCode": "230054", "employeeName": "Nguyễn Thiên Hoàng	"},
    {"id": 25, "employeeCode": "230057", "employeeName": "Man Thị Thu Hà	"},
    {"id": 26, "employeeCode": "230077", "employeeName": "Nhâm Mạnh Tuyền	"},
    {"id": 27, "employeeCode": "230084", "employeeName": "Trần Văn Thức	"},
    {"id": 28, "employeeCode": "230088", "employeeName": "Nguyễn Sinh Công	"},
    {"id": 29, "employeeCode": "230089", "employeeName": "Phạm Xuân An	"},
    {"id": 30, "employeeCode": "230095", "employeeName": "Nguyễn Hồng Sơn	"},
    {"id": 31, "employeeCode": "230096", "employeeName": "Nguyễn Tuấn Anh	"},
    {
      "id": 32,
      "employeeCode": "230101",
      "employeeName": "Nguyễn Thị Thảo Trang	"
    },
    {"id": 33, "employeeCode": "230102", "employeeName": "Lữ Thị Tuyết Hương	"},
    {"id": 34, "employeeCode": "230103", "employeeName": "Lê Thị Kim Oanh	"},
    {"id": 35, "employeeCode": "230104", "employeeName": "Phạm Ngọc Hùng	"},
    {"id": 36, "employeeCode": "230107", "employeeName": "Hoàng Tiến Việt	"},
    {"id": 37, "employeeCode": "240004", "employeeName": "Nguyễn Sỹ Phi Long	"},
    {"id": 38, "employeeCode": "240005", "employeeName": "Chu Tuấn Dũng	"},
    {"id": 39, "employeeCode": "240008", "employeeName": "Trần Thu Huyền	"},
    {"id": 40, "employeeCode": "240009", "employeeName": "Phạm Đức Trường	"},
    {"id": 41, "employeeCode": "240011", "employeeName": "Đỗ Trọng Lịch	"},
    {"id": 42, "employeeCode": "240012", "employeeName": "Dương Thị Khánh Mỹ	"},
    {"id": 43, "employeeCode": "240014", "employeeName": "Chử Văn Sơn	"},
    {"id": 44, "employeeCode": "240017", "employeeName": "Vũ Đình Huy	"},
    {"id": 45, "employeeCode": "240022", "employeeName": "Lê Thị Hương Ly	"},
    {
      "id": 46,
      "employeeCode": "240031",
      "employeeName": "Hoàng Hoa Tôn Anh Nguyên	"
    },
    {"id": 47, "employeeCode": "240034", "employeeName": "Nguyễn Tống Lộc	"},
    {"id": 48, "employeeCode": "240038", "employeeName": "Lê Văn Ước	"},
    {"id": 49, "employeeCode": "240043", "employeeName": "Vũ Kiều Linh	"},
    {
      "id": 50,
      "employeeCode": "240048",
      "employeeName": "Nguyễn Thị Hương Ly	"
    },
    {"id": 51, "employeeCode": "240050", "employeeName": "Nguyễn Thị Thủy	"},
    {"id": 52, "employeeCode": "240052", "employeeName": "Lê Văn Thăng	"},
    {"id": 53, "employeeCode": "240054", "employeeName": "Nguyễn Văn Hội	"},
    {"id": 54, "employeeCode": "240063", "employeeName": "Trịnh Vinh Toàn	"},
    {"id": 55, "employeeCode": "240064", "employeeName": "Đỗ Thị Bích Ngọc	"},
    {"id": 56, "employeeCode": "240065", "employeeName": "Hoàng Ngọc Hân	"},
    {"id": 57, "employeeCode": "240066", "employeeName": "Mai Phương Loan	"},
    {"id": 58, "employeeCode": "240067", "employeeName": "Vương Viết Đạt	"},
    {"id": 59, "employeeCode": "240069", "employeeName": "Phạm Thị Hồng	"},
    {"id": 60, "employeeCode": "240075", "employeeName": "Tống Phương Anh	"},
    {"id": 61, "employeeCode": "240080", "employeeName": "Hà Duy Tráng	"},
    {"id": 62, "employeeCode": "240081", "employeeName": "Hán Thị Hải Yến	"},
    {"id": 63, "employeeCode": "240083", "employeeName": "Phạm Thị Thủy	"},
    {"id": 64, "employeeCode": "240084", "employeeName": "Lý Thị Hòa	"},
    {"id": 65, "employeeCode": "240086", "employeeName": "Trần An Bình	"},
    {"id": 66, "employeeCode": "240091", "employeeName": "Lê Văn Công	"},
    {"id": 67, "employeeCode": "240093", "employeeName": "Nguyễn Đức Thành	"},
    {"id": 68, "employeeCode": "240094", "employeeName": "Nguyễn Tuấn Anh	"},
    {"id": 69, "employeeCode": "240098", "employeeName": "Phạm Hoàng Hải	"},
    {"id": 70, "employeeCode": "240099", "employeeName": "Nguyễn Bá Cương	"},
    {"id": 71, "employeeCode": "240100", "employeeName": "Nguyễn Thùy Dung	"},
    {"id": 72, "employeeCode": "240101", "employeeName": "Đỗ Đức Thắng	"},
    {"id": 73, "employeeCode": "240102", "employeeName": "Phạm Duy Linh	"},
    {"id": 74, "employeeCode": "240105", "employeeName": "Trần Thị Ngọc Thúy	"},
    {"id": 75, "employeeCode": "240107", "employeeName": "Trần Quang Huy	"},
    {"id": 76, "employeeCode": "240108", "employeeName": "Nguyễn Thế Thái	"},
    {"id": 77, "employeeCode": "240110", "employeeName": "Nguyễn Đăng Tùng	"},
    {"id": 78, "employeeCode": "240111", "employeeName": "Nguyễn Bảo Lâm	"},
    {"id": 79, "employeeCode": "240112", "employeeName": "Đỗ Thị Trang	"},
    {"id": 80, "employeeCode": "240114", "employeeName": "Đàm Văn Công Duy	"},
    {"id": 81, "employeeCode": "240115", "employeeName": "Lê Đức Long	"},
    {
      "id": 82,
      "employeeCode": "240116",
      "employeeName": "Phạm Thị Phương Thảo	"
    },
    {"id": 83, "employeeCode": "240119", "employeeName": "Tào Phương Quỳnh	"},
    {"id": 84, "employeeCode": "240122", "employeeName": "Bùi Thị Hiền	"},
    {"id": 85, "employeeCode": "240124", "employeeName": "Trần Thành Nhiên	"},
    {"id": 86, "employeeCode": "240125", "employeeName": "Nguyễn Mạnh Cường	"},
    {"id": 87, "employeeCode": "240126", "employeeName": "Đỗ Thị Huệ	"},
    {"id": 88, "employeeCode": "240127", "employeeName": "Hoàng Đỗ Quân	"},
    {"id": 89, "employeeCode": "240128", "employeeName": "Trần Văn Quý	"},
    {"id": 90, "employeeCode": "240130", "employeeName": "Trương Thị Mỹ Hoa	"},
    {"id": 91, "employeeCode": "240137", "employeeName": "Đồng Duy Thường	"},
    {"id": 92, "employeeCode": "240138", "employeeName": "Tạ Đức Nghĩa	"},
    {"id": 93, "employeeCode": "240140", "employeeName": "Hồ Minh Quân	"},
    {"id": 94, "employeeCode": "240141", "employeeName": "Phạm Ngọc Nhật	"},
    {"id": 95, "employeeCode": "240142", "employeeName": "Nguyễn Thị Mến	"},
    {"id": 96, "employeeCode": "240143", "employeeName": "Bùi Quí Long	"},
    {"id": 97, "employeeCode": "240144", "employeeName": "Phạm Thị Ngọc Thảo	"},
    {"id": 98, "employeeCode": "240145", "employeeName": "Lưu Lê Thái Sơn	"},
    {"id": 99, "employeeCode": "240152", "employeeName": "Đào Đình Hà	"},
    {"id": 100, "employeeCode": "240153", "employeeName": "Nguyễn Nhật Minh	"},
    {"id": 101, "employeeCode": "240155", "employeeName": "Nguyễn Hồng Minh	"},
    {"id": 102, "employeeCode": "240156", "employeeName": "Nguyễn Duy Lâm	"},
    {"id": 103, "employeeCode": "240159", "employeeName": "Vũ Minh Thu	"},
    {
      "id": 104,
      "employeeCode": "240160",
      "employeeName": "Nguyễn Đức Hoài Lam	"
    },
    {"id": 105, "employeeCode": "240162", "employeeName": "Nguyễn Đình Đạt	"},
    {"id": 106, "employeeCode": "240165", "employeeName": "Phạm Hồng Phúc	"},
    {
      "id": 107,
      "employeeCode": "240166",
      "employeeName": "Quán Thị Hồng Linh	"
    },
    {"id": 108, "employeeCode": "240170", "employeeName": "Nguyễn Duy Khiêm	"},
    {"id": 109, "employeeCode": "240171", "employeeName": "Nguyễn Văn Học	"},
    {"id": 110, "employeeCode": "240172", "employeeName": "Nguyễn Khắc Huy	"},
    {
      "id": 111,
      "employeeCode": "240173",
      "employeeName": "Nguyễn Thị Lệ Quyên	"
    },
    {
      "id": 112,
      "employeeCode": "240174",
      "employeeName": "Chu Thị Hồng Nhung	"
    },
    {"id": 113, "employeeCode": "240175", "employeeName": "Nguyễn Mai Huyền	"},
    {"id": 114, "employeeCode": "240178", "employeeName": "Hoàng Bá Chức	"},
    {
      "id": 115,
      "employeeCode": "240179",
      "employeeName": "Nguyễn Trọng Thành	"
    },
    {"id": 116, "employeeCode": "240180", "employeeName": "Trần Xuân Ninh	"},
    {"id": 117, "employeeCode": "240181", "employeeName": "Lương Hồng Phong	"},
    {"id": 118, "employeeCode": "240182", "employeeName": "Nguyễn Duy Phúc	"},
    {"id": 119, "employeeCode": "240183", "employeeName": "Nguyễn Tiến Trung	"},
    {"id": 120, "employeeCode": "240185", "employeeName": "Phạm Thủy Nhâm	"},
    {"id": 121, "employeeCode": "240186", "employeeName": "Đặng Văn Hiến	"},
    {"id": 122, "employeeCode": "240187", "employeeName": "Đinh Công Mạnh	"},
    {"id": 123, "employeeCode": "240188", "employeeName": "Nguyễn Thị Thủy	"},
    {
      "id": 124,
      "employeeCode": "240189",
      "employeeName": "Trần Phạm Quang Huy	"
    },
    {
      "id": 125,
      "employeeCode": "240190",
      "employeeName": "Dương Thị Thanh Huyền	"
    },
    {"id": 126, "employeeCode": "250001", "employeeName": "Đỗ Hữu Phúc	"},
    {"id": 127, "employeeCode": "240191", "employeeName": "Phạm Thị Liễu	"},
    {"id": 128, "employeeCode": "240192", "employeeName": "Hoàng Ngọc Anh	"},
    {"id": 129, "employeeCode": "250002", "employeeName": "Đoàn Đình Hiệp	"},
    {"id": 130, "employeeCode": "240193", "employeeName": "Nguyễn Hữu Chí	"},
    {"id": 131, "employeeCode": "240194", "employeeName": "Nguyễn Quang Dũng	"},
    {
      "id": 132,
      "employeeCode": "240195",
      "employeeName": "Trần Thị Ánh Quỳnh	"
    },
    {"id": 133, "employeeCode": "250004", "employeeName": "Lê Hoàng Thạch	"},
  ];

  @override
  void initState() {
    super.initState();
    // _checkExistingName();
  }

  Future<void> _checkExistingName() async {
    final prefs = await _prefs;
    final savedName = prefs.getString('voter_name');
    final savedCode = prefs.getString('employee_code');

    if (savedName != null && savedName.isNotEmpty && savedCode != null) {
      context.read<VoteCubit>().updateVoterName(savedName);
      context.read<VoteCubit>().updateVoterCode(savedCode);
      _navigateToHome();
    }
  }

  void _validateName(String value) {
    final searchTerm = value.trim().toLowerCase();
    setState(() {
      if (searchTerm.isEmpty) {
        _searchResults = [];
        _isNameValid = false;
        _employeeCode = null;
      } else {
        _searchResults = _employeeList.where((emp) {
          final name = emp['employeeName'].toString().toLowerCase();
          final code = emp['employeeCode'].toString().toLowerCase();
          return name.contains(searchTerm) || code.contains(searchTerm);
        }).toList();

        final exactMatch = _employeeList.firstWhere(
          (emp) {
            final name = emp['employeeName'].toString().toLowerCase();
            final code = emp['employeeCode'].toString().toLowerCase();
            return name == searchTerm || code == searchTerm;
          },
          orElse: () => {'employeeCode': null},
        );

        _employeeCode = exactMatch['employeeCode'];
        _isNameValid = _employeeCode != null;
      }
    });
  }

  Future<void> _saveName() async {
    final name = _nameController.text.trim();
    if (_isNameValid && _employeeCode != null) {
      final prefs = await _prefs;
      await prefs.setString('voter_name', name);
      await prefs.setString('employee_code', _employeeCode!);
      context.read<VoteCubit>().updateVoterName(_employeeCode ?? "");
      userCodeSave = _employeeCode ?? "";
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
      body: SingleChildScrollView(
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
              'Vui lòng nhập đầy đủ họ tên của bạn để tiếp tục',
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
                      labelText: 'Họ và tên',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15,
                      ),
                      hintText: 'Nhập đầy đủ họ tên của bạn',
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
                  if (_searchResults.isNotEmpty && !_isNameValid)
                    Container(
                      height: 200,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final employee = _searchResults[index];
                          return ListTile(
                            title: Text(
                              employee['employeeName'],
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              'Mã NV: ${employee['employeeCode']}',
                              style: TextStyle(fontSize: 12),
                            ),
                            onTap: () {
                              setState(() {
                                _nameController.text = employee['employeeName'];
                                _employeeCode = employee['employeeCode'];
                                _isNameValid = true;
                                _searchResults = [];
                              });
                              _nameController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset: _nameController.text.length),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  SizedBox(height: 16),
                  if (_employeeCode != null)
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Mã nhân viên: $_employeeCode',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_nameController.text.isNotEmpty &&
                      !_isNameValid &&
                      _searchResults.isEmpty)
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Không tìm thấy tên nhân viên',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    'Lưu ý: Vui lòng nhập chính xác và đầy đủ họ tên như trong danh sách nhân viên',
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
            SizedBox(height: 40),
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
    );
  }
}
