BEGIN;

CREATE TABLE student (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE teacher (
    teacher_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL
);

CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    duration_weeks INT NOT NULL CHECK (duration_weeks > 0),
    fee NUMERIC(10,2) NOT NULL CHECK (fee >= 0)
);

CREATE TABLE "group" (
    group_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL REFERENCES course(course_id) ON DELETE RESTRICT,
    teacher_id INT NOT NULL REFERENCES teacher(teacher_id) ON DELETE RESTRICT,
    schedule_day VARCHAR(15) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    room VARCHAR(50) NOT NULL,
    CHECK (end_time > start_time),
    CHECK (end_date >= start_date)
);

CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
    group_id INT NOT NULL REFERENCES "group"(group_id) ON DELETE CASCADE,
    enrolled_on DATE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('active', 'completed', 'cancelled')),
    UNIQUE (student_id, group_id)
);

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL REFERENCES enrollment(enrollment_id) ON DELETE CASCADE,
    session_date DATE NOT NULL,
    attendance_status VARCHAR(10) NOT NULL CHECK (attendance_status IN ('present', 'absent', 'late')),
    UNIQUE (enrollment_id, session_date)
);

CREATE TABLE payment (
    payment_id SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL REFERENCES enrollment(enrollment_id) ON DELETE CASCADE,
    paid_on DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    method VARCHAR(20) NOT NULL
);

CREATE INDEX idx_group_course ON "group"(course_id);
CREATE INDEX idx_group_teacher ON "group"(teacher_id);
CREATE INDEX idx_enrollment_student ON enrollment(student_id);
CREATE INDEX idx_enrollment_group ON enrollment(group_id);
CREATE INDEX idx_attendance_enrollment ON attendance(enrollment_id);
CREATE INDEX idx_payment_enrollment ON payment(enrollment_id);

COMMIT;
