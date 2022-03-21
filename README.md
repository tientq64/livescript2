# 1.4.5
- Báo lỗi khi accessor dùng arrow function, tại JS k hỗ trợ
- Sửa lỗi biến "isLoop" sai làm k compile đc range ký tự
- Sửa lỗi bind method trong class sai khi tên method là ký tự đặc biệt
- Chuyển các hàm import$, importAll$, in$, bind$, arrayFrom$, toString$, replace$, join$, split$, not$ thành hàm đơn giản, k dùng như hàm util nữa, những hàm k dùng nữa bị xóa bỏ
- Viết lại mấy hàm partial, tất cả đều là arrow function

# 1.4.4
- Range ký tự bây h sẽ dùng vòng lặp khi > 32 ký tự, k như trc tạo ra một mảng ký tự khổng lồ

# 1.4.3
- Sửa compile hàm static trong class k đúng
- Hàm mũi tên nếu có một tham số và k phải là spread thì tham số sẽ k có cặp dấu ngoặc
- Hàm dạng (+) sẽ bỏ gọi hàm bọc curry$ (k biết gọi hàm bọc để làm gì)

# 1.4.2
- Quên chưa build code 1.4.1

# 1.4.1
- Sửa lại hàm Literal.prototype.isString phát hiện sai

# 1.4.0
- Sửa và điều chỉnh lại cú pháp comment trong heregex có thể gây ra lỗi vòng lặp vô hạn
- Sửa interpolate bây h có thể là chỉ @ hoặc chỉ một chữ số

# 1.3.0
- Loại bỏ nhiều thư viện cục bộ k cần thiết, chủ yếu là mấy cái polyfill nodejs, prelude, vv.

# 1.2.2
- Sửa lỗi heregex khi trong comment gặp biến interpolate sẽ phân tích như regex; 1 dấu \ ở cuối bây h để đánh dấu để biết trailing space kết thúc ở đâu

# 1.2.1
- Sửa lỗi tham số spread của hàm bị mất dấu "..."

# 1.2.0
- Sửa lỗi chưa khai báo khi tham số hàm đc compile dưới dạng spread

# 1.1.12
- Thêm dấu ";" vào trc hàm bọc cao nhất

# 1.1.11
- Sửa index.ls

# 1.1.10
- Thêm trường "files" trong package.json

# 1.1.9
- Ko xóa ID_INTERPOLATE trong cli nữa

# 1.1.1
- Sửa compile code livescript từ bare true thành false trong cli

# 1.1.0
- Thêm cli chạy code livescript

# 1.0.6
- Thêm tùy chọn "Phiên bản gốc" trong trang web
- Sửa lỗi chạy code trong trang web

# 1.0.5
- Sửa hàm clone$ (toán tử ^^) về như ban đầu
- Thêm icon cho trang web

# 1.0.4
- Tạo trang web để biên dịch và chạy thử code
- Tạo [repo](https://github.com/tiencoffee/livescript2) trên Github
- Sửa flags RegExp từ [dgimsuy]{1,6} -> [dgimsuy]{1,7}

# 1.0.3
- Thêm hỗ trợ dấu ngoặc nhọn cho \u, phạm vi từ \u{0} -> \u{10ffff}

# 1.0.2
- Thêm once vào event DOMContentLoaded

# 1.0.1
- Thêm main trong package.json

# 1.0.0
- Tách ra từ package "tieens"
- Viết lại hàm LiveScript.load, từ xhr sang fetch
