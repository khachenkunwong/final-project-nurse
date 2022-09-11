# HosMobile2

โปรเจคจบ ของพยาบาล

## รายระเอียด

ความหมายของเครื่องหมาย

- :heavy_check_mark: คือ ทำเเล้ว
- :x: คือ ยังไม่ได้ทำเเละจำเป็นต้องทำ
- :warning: คือ ยังไม่ได้ทำและไม่จำเป็นต้องทำตอนนี้
- :hourglass:  คือ กำลังทำ

- $ คือ ค่าที่สามารถเปลี่ยนได้ตามการนำเข้า เช่น $nameGroup uame หรือ $nameGroup/uame หรือ all/$nameGroup ค่าที่จะเปลี่ยนคือ nameGroup

## หน้า ล็อกอิน

[![Login.png](https://i.postimg.cc/bwT7cPCv/Login.png)](https://postimg.cc/755s0Fyv)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 POST
    - :heavy_check_mark: เชื่อมกับ $url/api/auth/login
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - username (String)
            - password (String)

## หน้า สมัครสมาชิก

[![register.png](https://i.postimg.cc/wMd4Pbpz/register.png)](https://postimg.cc/S2DGYdR1)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 POST
    - :heavy_check_mark: เชื่อมกับ $url/api/auth/register
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - frist_name (String)
            - last_name (String)
            - email (String)
            - password (String)

## หน้า ยืนยันรหัสผ่าน

หน้านี้จะแสดงก็ต่อเมื่อ

1.เมื่อหลังจากกด [หน้าล็อกอิน](#หน้า-ล็อกอิน) ครั้งแรกหลัง [หน้าสมัครสมาชิก](#หน้า-สมัครสมาชิก)

2.เมื่อลืมรหัสผ่าน หลังจาก [หน้าหาอีเมลของคุณ](#หน้า-หาอีเมลของคุณ)

[![image.png](https://i.postimg.cc/SR21t2RB/image.png)](https://postimg.cc/K3b51Ynf)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 PATCH 
    - :warning: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - code (String) จำนวน 6 ตัว

## หน้า หาอีเมลของคุณ


[![image.png](https://i.postimg.cc/9MZHrntR/image.png)](https://postimg.cc/gXzT747m)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 (ไม่รู้)
    - :warning: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - email (String)

## หน้า เปลี่ยนรหัสผ่าน

[![image.png](https://i.postimg.cc/0N6sqQzC/image.png)](https://postimg.cc/DWKDr7dW)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 PATCH
    - :warning: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป    
            - password (String)

## หน้า รอการตรวจสอบจาก Admin

[![admin.png](https://i.postimg.cc/6QmB7P2t/admin.png)](https://postimg.cc/jWPpmZ4F)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 GET
    - :warning: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - verify_identity (Boolean)

## หน้า ตารางงาน

[![table-job.png](https://i.postimg.cc/NMFLSTTf/table-job.png)](https://postimg.cc/62s9G8YD)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 GET
    - :heavy_check_mark: เชื่อมกับ $url/api/group/schedule/me/all/$nameGroup *เสร็จแล้วเมื่อ (01/08/2565)*
        - ส่งค่าเพื่อไปขอข้อมูล
            - nameGroup (String)
            - token (String)
        - นำมาแสดง
            - frist_name (String)
            - last_name (String)
            - year (String)
            - month (String)
            - day (String)
            - group (String)
            - morning (int)
            - noon (int)
            - night (int)
            - count (int)
- 2 GET
    - :heavy_check_mark: เชื่อมกับ $url/api/group/schedule/without/me *เสร็จแล้วเมื่อ (31/07/2565)*
        - ส่งค่าเพื่อไปขอข้อมูล
            - nameGroup (String)
            - token (String)
        - นำมาแสดง
            - frist_name (String)
            - last_name (String)
            - year (String)
            - month (String)
            - day (String)
            - group (String)
            - morning (int)
            - noon (int)
            - night (int)
            - count (int)

#### ทำงานข้างหลังจะมองไม่เห็นผ่านหน้าจอ

-   POST
    - :heavy_check_mark: เชื่อมกับ $url/api/schedule/create
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - ตอนนี้ยังไม่มี

## หน้า ปฏิทินงาน

[![image.png](https://i.postimg.cc/qMmTzYCq/image.png)](https://postimg.cc/cr8jzFhG)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 GET
    - :heavy_check_mark: เชื่อมกับ $url/api/group/schedule/me/all/$nameGroup (รอเชื่อมต่อ)
        - ส่งค่าเพื่อไปขอข้อมูล
            - nameGroup (String)
            - token (String)
        - นำมาแสดง
            - frist_name (String)
            - last_name (String)
            - year (String)
            - month (String)
            - day (String)
            - group (String)
            - morning (int)
            - noon (int)
            - night (int)
            - count (int)
- 2 GET
    - :heavy_check_mark: เชื่อมกับ $url/api/group/schedule/without/me (nameGroup ใส่ตรงไหนใน part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - :x: nameGroup (String) (ต้องการเชื่อมด่วน)
            - token (String)
        - นำมาแสดง
            - frist_name (String)
            - last_name (String)
            - year (String)
            - month (String)
            - day (String)
            - group (String)
            - morning (int)
            - noon (int)
            - night (int)
            - count (int)


## หน้า แจ้งเตือน

1[![notification-3.png](https://i.postimg.cc/zvXQNz7j/notification-3.png)](https://postimg.cc/8J94BVqJ)

2[![notification-1.png](https://i.postimg.cc/QdWyhnQR/notification-1.png)](https://postimg.cc/Xr48gLD8)

3[![notification-2.png](https://i.postimg.cc/gJ4Mg9p6/notification-2.png)](https://postimg.cc/LYYBsbnH)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 GET (ดูภาที่ 1 , 2 มาเป็นตัวอย่างในการเขียน)
    - :hourglass: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - token (String)
        - นำมาแสดง
            - frist_name (String)
            - last_name (String)
            - actor (String) (actor ของแต่ละคน)
            - number_notifications (int) (จำนวนการแจ้งเตือนของแต่ละคน)
            - my_date (String) (แสดงวันที่ของฉันที่จะแลก)
            - my_month (String) (แสดงเดือนของฉันที่จะแลก)
            - my_year (String) (แสดงปีของฉันที่จะแลก)
            - my_nameGroup (String) (ทำไว้กรณีแลกเวรนอกกลุ่ม)
            - my_duty (`List[int]`) (ใน List คือ 0,1 ของ เช้า บ่าย ดึก ของวันที่แลกเวร) 
            - they_date (String) (แสดงวันที่ของคนที่จะมาแลกเวรด้วย)
            - they_month (String) (แสดงเดือนของคนที่จะมาแลกเวรด้วย)
            - they_year (String) (แสดงปีของคนที่จะมาแลกเวรด้วย)
            - they_nameGroup (String) (ทำไว้กรณีแลกเวรนอกกลุ่ม)
            - they_duty (`List[int]`) (ใน List คือ 0,1 ของ เช้า บ่าย ดึก ของวันที่แลกเวร) 
- 1 PATCH (ดูภาที่ 1 , 2 มาเป็นตัวอย่างในการเขียน)
    - :hourglass: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - frist_name (String)
            - last_name (String)
            - actor (String) (actor ของแต่ละคน)
            - number_notifications (int) (จำนวนการแจ้งเตือนของแต่ละคน)
            - my_date (String) (แสดงวันที่ของฉันที่จะแลก)
            - my_month (String) (แสดงเดือนของฉันที่จะแลก)
            - my_year (String) (แสดงปีของฉันที่จะแลก)
            - my_nameGroup (String) (ทำไว้กรณีแลกเวรนอกกลุ่ม)
            - my_duty (`List[int]`) (ใน List คือ 0,1 ของ เช้า บ่าย ดึก ของวันที่แลกเวร) 
            - they_date (String) (แสดงวันที่ของคนที่จะมาแลกเวรด้วย)
            - they_month (String) (แสดงเดือนของคนที่จะมาแลกเวรด้วย)
            - they_year (String) (แสดงปีของคนที่จะมาแลกเวรด้วย)
            - they_nameGroup (String) (ทำไว้กรณีแลกเวรนอกกลุ่ม)
            - they_duty (`List[int]`) (ใน List คือ 0,1 ของ เช้า บ่าย ดึก ของวันที่แลกเวร) 
- 1 PATCH (ดูภาที่ 3 มาเป็นตัวอย่างในการเขียน)
    - :hourglass: เชื่อมกับ (ยังไม่ part)
        - ส่งค่าเพื่อไปขอข้อมูล
            - ตอนนี้ยังไม่มี
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - nameGroup (String)

## หน้า หน้าโปรไฟล์

[![profile.png](https://i.postimg.cc/zfjztDGj/profile.png)](https://postimg.cc/TyKvh6mL)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 GET
    - :heavy_check_mark: เชื่อมกับ เชื่อมกับ $url/api/me/profile
        - ส่งค่าเพื่อไปขอข้อมูล
            - token (String)
        - นำมาแสดง
            - frist_name (String)
            - last_name (String)
            - email (String)
- 2 DELETE
    - :heavy_check_mark: เชื่อมกับ เชื่อมกับ $url/api/auth/logout
        - ส่งค่าเพื่อไปขอข้อมูล
            - token (String)
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - ตอนนี้ยังไม่มี

## หน้า แก้ไขโปรไฟล์

[![edit-profile.png](https://i.postimg.cc/Dy8gCznP/edit-profile.png)](https://postimg.cc/ppMzrR9m)

### Application Program Interface(API) ที่เชื่อมต่อ

- 1 PATCH
    - :heavy_check_mark: เชื่อมกับ $url/api/me/profile
        - ส่งค่าเพื่อไปขอข้อมูล
            - token (String)
        - นำมาแสดง
            - ตอนนี้ยังไม่มี
        - ส่งกลับไป
            - frist_name (String)
            - last_name (String)

## หน้า กลุ่ม

[![group.png](https://i.postimg.cc/sXss38ww/group.png)](https://postimg.cc/f326KH49)

### Application Program Interface(API) ที่เชื่อมต่อ

ตัวนี้ดึง part ซ้ำนะเพราะต้องเรียกใช้แยกกัน

- 1 GET
    - :heavy_check_mark: เชื่อมกับ เชื่อมกับ $url/api/group/me/member *เสร็จเมื่อ (28/07/2565)*
        - ส่งค่าเพื่อไปขอข้อมูล
            - token (String)
        - นำมาแสดง (ของหัวหน้ากลุ่ม)
            - frist_name (String)
            - last_name (String)
            - email (String)

- 1 GET
    - :heavy_check_mark: เชื่อมกับ เชื่อมกับ $url/api/group/me/member *เสร็จเมื่อ (28/07/2565)*
        - ส่งค่าเพื่อไปขอข้อมูล
            - token (String)
        - นำมาแสดง (สมาชิก)
            - frist_name (String)
            - last_name (String)
            - email (String)




# Version

จริงควรเริ่มที่เวอร์ชัน 0 แต่แก้ไม่ทั้นละ

V1.0 (code)

V1.1 (comment updata)

V1.2 (ทดสอบอัพเดตRRADME.md)

V1.3 (ทดสอบ updata emoji animation README.md)

v1.3.1 (อัพเดต README.md)

1.3.2 (อัพเดต README.md เหลืออีก 4 หน้าที่ยังไม่ได้เพิ่ม)

1.3.3 (อัพเดต README.md เหลืออีก 4 หน้าที่ยังไม่ได้เพิ่ม แก้ภาพ)

1.4 (อัพเดตเชื่อม api หน้า กลุ่มแล้วนำมาแสดง)

1.4.1 (อัพเดต README.md)

1.5 (แสดงเวรของเพื่อน)

1.5.1 (อัพเดต README.md)

1.5.2 (อัพเดต README.md)

1.6.0 (แสดงข้อมูลหน้าตารางงานและปฏิทิน)

1.6.1 (อัพเดต README.md)

1.6.2 (อัพเดต README.mdและเพิ่มฟังชันที่เชื่อมต่อกับแจ้งเตือน)

1.7 (อัพเดต README.mdและป้องกันหาย)

1.8 (แก้บัคหน้าอื้นๆและแสดงข้อมูลแจ้งเตือนแจ้งเตือน)