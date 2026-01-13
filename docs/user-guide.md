# User Documentation

## 1. Purpose
This guide explains how staff can use the PostgreSQL database for student management, scheduling, attendance tracking, and reporting.

---

## 2. Setup Instructions
1. Ensure PostgreSQL is installed.
2. Create a database:

```sql
CREATE DATABASE education_center;
```

3. Run the schema and data scripts:

```bash
psql -d education_center -f sql/schema.sql
psql -d education_center -f sql/data.sql
```

---

## 3. Common Tasks

### 3.1 Add a Student
```sql
INSERT INTO student (first_name, last_name, date_of_birth, email, phone)
VALUES ('Amina', 'Ali', '2002-04-12', 'amina.ali@example.com', '+998901234567');
```

### 3.2 Create a Course and Group
```sql
INSERT INTO course (course_name, category, duration_weeks, fee)
VALUES ('Python Basics', 'Programming', 8, 750.00);

INSERT INTO "group" (course_id, teacher_id, schedule_day, start_time, end_time, start_date, end_date, room)
VALUES (1, 1, 'Monday', '18:00', '20:00', '2024-09-01', '2024-10-27', 'Room A');
```

### 3.3 Enroll a Student
```sql
INSERT INTO enrollment (student_id, group_id, enrolled_on, status)
VALUES (1, 1, CURRENT_DATE, 'active');
```

### 3.4 Record Attendance
```sql
INSERT INTO attendance (enrollment_id, session_date, attendance_status)
VALUES (1, '2024-09-02', 'present');
```

### 3.5 Record a Payment
```sql
INSERT INTO payment (enrollment_id, paid_on, amount, method)
VALUES (1, CURRENT_DATE, 250.00, 'card');
```

---

## 4. Running Reports
Use the queries in `sql/queries.sql` to generate management reports.

---

## 5. Troubleshooting
- Check constraint violations if inserts fail.
- Confirm IDs exist for foreign keys.
- Use `\d` in `psql` to inspect table structure.
