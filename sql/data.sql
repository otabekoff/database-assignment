BEGIN;

INSERT INTO student (first_name, last_name, date_of_birth, email, phone)
VALUES
    ('Aziza', 'Karimova', '2001-03-14', 'aziza.karimova@example.com', '+998901112233'),
    ('Bekzod', 'Tursunov', '2000-11-02', 'bekzod.tursunov@example.com', '+998901223344'),
    ('Dilshod', 'Nazarov', '1999-07-29', 'dilshod.nazarov@example.com', '+998901334455'),
    ('Madina', 'Rustamova', '2002-05-09', 'madina.rustamova@example.com', '+998901445566');

INSERT INTO teacher (first_name, last_name, email, phone, hire_date)
VALUES
    ('Saida', 'Abdullaeva', 'saida.abdullaeva@example.com', '+998909876543', '2022-01-10'),
    ('Kamol', 'Rakhimov', 'kamol.rakhimov@example.com', '+998907654321', '2021-08-15');

INSERT INTO course (course_name, category, duration_weeks, fee)
VALUES
    ('Python Basics', 'Programming', 8, 750.00),
    ('IELTS Prep', 'Language', 10, 900.00),
    ('Data Analytics', 'Professional', 12, 1200.00);

INSERT INTO "group" (course_id, teacher_id, schedule_day, start_time, end_time, start_date, end_date, room)
VALUES
    (1, 1, 'Monday', '18:00', '20:00', '2024-09-02', '2024-10-28', 'Room A'),
    (2, 2, 'Wednesday', '17:30', '19:30', '2024-09-04', '2024-11-06', 'Room B'),
    (3, 1, 'Saturday', '10:00', '12:30', '2024-09-07', '2024-11-30', 'Room C');

INSERT INTO enrollment (student_id, group_id, enrolled_on, status)
VALUES
    (1, 1, '2024-08-25', 'active'),
    (2, 1, '2024-08-25', 'active'),
    (3, 2, '2024-08-27', 'active'),
    (4, 3, '2024-08-29', 'active');

INSERT INTO attendance (enrollment_id, session_date, attendance_status)
VALUES
    (1, '2024-09-02', 'present'),
    (1, '2024-09-09', 'late'),
    (2, '2024-09-02', 'present'),
    (3, '2024-09-04', 'absent'),
    (4, '2024-09-07', 'present');

INSERT INTO payment (enrollment_id, paid_on, amount, method)
VALUES
    (1, '2024-08-25', 250.00, 'card'),
    (1, '2024-09-10', 250.00, 'card'),
    (2, '2024-08-25', 750.00, 'cash'),
    (3, '2024-08-27', 450.00, 'transfer'),
    (4, '2024-08-29', 600.00, 'card');

COMMIT;
