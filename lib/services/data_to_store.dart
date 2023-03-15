String firebaseName ='';
List<String>subjects = ['Subject1','Subject2','Subject3','Subject4'];
int enrolledYear = 0;
List<int> yearOptions = [1,2,3,4,5];
List<bool> checked = [false,false,false,false,false,];





// Padding(
// padding: const EdgeInsets.only(left: 8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// const Text(
// 'In Which Year You Are In?',
// style: TextStyle(
// fontWeight: FontWeight.w500,
// ),
// textScaleFactor: 1.1,
// ),
// Row(
// children: [
// const Text('1.'),
// Checkbox(
// activeColor: Colors.white,
// checkColor: Colors.black,
// value: _isChecked1,
// onChanged: (value) {
// setState(() {
// _isChecked1 = value!;
// enrolledYear = 1;
// });
// }),
// const Text('2.'),
// Checkbox(
// activeColor: Colors.white,
// checkColor: Colors.black,
// value: _isChecked2,
// onChanged: (value) {
// setState(() {
// _isChecked2 = value!;
// enrolledYear = 2;
// });
// }),
// const Text('3.'),
// Checkbox(
// activeColor: Colors.white,
// checkColor: Colors.black,
// value: _isChecked3,
// onChanged: (value) {
// setState(() {
// _isChecked3 = value!;
// enrolledYear = 3;
// });
// }),
// const Text('4.'),
// Checkbox(
// activeColor: Colors.white,
// checkColor: Colors.black,
// value: _isChecked4,
// onChanged: (value) {
// setState(() {
// _isChecked4 = value!;
// enrolledYear = 4;
// });
// }),
// const Text('5.'),
// Checkbox(
// activeColor: Colors.white,
// checkColor: Colors.black,
// value: _isChecked5,
// onChanged: (value) {
// setState(() {
// _isChecked5 = value!;
// enrolledYear = 5;
// });
// }),
// ],
// ),
// ],
// ),
// ),