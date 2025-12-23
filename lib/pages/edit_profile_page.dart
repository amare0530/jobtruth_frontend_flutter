import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> currentData;

  const EditProfilePage({super.key, required this.currentData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _schoolController;
  late TextEditingController _skillsController;
  late Color _selectedColor;

  final List<Color> _colorOptions = [
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.deepPurple,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentData['name']);
    _schoolController = TextEditingController(text: widget.currentData['school']);
    _skillsController = TextEditingController(text: (widget.currentData['skills'] as List).join(', '));
    _selectedColor = widget.currentData['themeColor'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("編輯個人資料"),
        backgroundColor: _selectedColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("自定義主題顏色", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _colorOptions.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = _colorOptions[index]),
                    child: Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: 45,
                      decoration: BoxDecoration(
                        color: _colorOptions[index],
                        shape: BoxShape.circle,
                        border: _selectedColor == _colorOptions[index]
                            ? Border.all(color: Colors.black, width: 3)
                            : Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: _selectedColor == _colorOptions[index] 
                        ? const Icon(Icons.check, color: Colors.white) : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(_nameController, "姓名", "例如：孟軒"),
            const SizedBox(height: 20),
            _buildTextField(_schoolController, "學校 / 系所", "例如：國立臺北科技大學 - 資訊工程系"),
            const SizedBox(height: 20),
            _buildTextField(_skillsController, "專業技能", "請用逗號隔開 (Flutter, Python...)"),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'school': _schoolController.text,
                    'skills': _skillsController.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList(),
                    'themeColor': _selectedColor,
                  });
                },
                child: const Text("儲存變更", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        floatingLabelStyle: TextStyle(color: _selectedColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _selectedColor, width: 2),
        ),
      ),
    );
  }
}