-- 1. List students with their groups and course names
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    g.schedule_day,
    g.start_time,
    g.end_time,
    g.room
FROM enrollment e
JOIN student s ON s.student_id = e.student_id
JOIN "group" g ON g.group_id = e.group_id
JOIN course c ON c.course_id = g.course_id
ORDER BY s.last_name, c.course_name;

-- 2. Teacher workload (number of groups per teacher)
SELECT
    t.teacher_id,
    t.first_name,
    t.last_name,
    COUNT(g.group_id) AS groups_taught
FROM teacher t
LEFT JOIN "group" g ON g.teacher_id = t.teacher_id
GROUP BY t.teacher_id
ORDER BY groups_taught DESC;

-- 3. Revenue by course
SELECT
    c.course_name,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN enrollment e ON e.enrollment_id = p.enrollment_id
JOIN "group" g ON g.group_id = e.group_id
JOIN course c ON c.course_id = g.course_id
GROUP BY c.course_name
ORDER BY total_revenue DESC;

-- 4. Attendance rate by group
SELECT
    g.group_id,
    c.course_name,
    COUNT(*) FILTER (WHERE a.attendance_status = 'present')::DECIMAL
        / NULLIF(COUNT(*), 0) AS attendance_rate
FROM attendance a
JOIN enrollment e ON e.enrollment_id = a.enrollment_id
JOIN "group" g ON g.group_id = e.group_id
JOIN course c ON c.course_id = g.course_id
GROUP BY g.group_id, c.course_name
ORDER BY attendance_rate DESC;

-- 5. Students with unpaid balances (total paid < course fee)
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    c.fee,
    COALESCE(SUM(p.amount), 0) AS total_paid,
    (c.fee - COALESCE(SUM(p.amount), 0)) AS balance_due
FROM enrollment e
JOIN student s ON s.student_id = e.student_id
JOIN "group" g ON g.group_id = e.group_id
JOIN course c ON c.course_id = g.course_id
LEFT JOIN payment p ON p.enrollment_id = e.enrollment_id
GROUP BY s.student_id, c.course_name, c.fee
HAVING COALESCE(SUM(p.amount), 0) < c.fee
ORDER BY balance_due DESC;

-- 6. Group schedule list for management
SELECT
    g.group_id,
    c.course_name,
    t.first_name || ' ' || t.last_name AS teacher_name,
    g.schedule_day,
    g.start_time,
    g.end_time,
    g.start_date,
    g.end_date,
    g.room
FROM "group" g
JOIN course c ON c.course_id = g.course_id
JOIN teacher t ON t.teacher_id = g.teacher_id
ORDER BY g.start_date;
