# Test Plan and Evidence

## 1. Test Data Selection Criteria
- Includes multiple students in the same group.
- Covers multiple groups per course.
- Uses payments that are partial and full.
- Mix of attendance statuses (present, absent, late).

## 2. Functional Testing

| Test ID | Requirement | Test Steps | Expected Result | Actual Result |
| --- | --- | --- | --- | --- |
| FT-01 | Enroll student | Insert student + enrollment | Enrollment row created | Pass |
| FT-02 | Attach teacher to group | Insert group with teacher_id | Group created with FK | Pass |
| FT-03 | Record attendance | Insert attendance record | Attendance created | Pass |
| FT-04 | Record payment | Insert payment record | Payment created | Pass |
| FT-05 | Management report | Run revenue query | Aggregated totals | Pass |

## 3. Structural Testing

| Test ID | Requirement | Test Steps | Expected Result | Actual Result |
| --- | --- | --- | --- | --- |
| ST-01 | PK uniqueness | Insert duplicate email | Fails due to UNIQUE | Pass |
| ST-02 | FK integrity | Insert enrollment with invalid student_id | Fails due to FK | Pass |
| ST-03 | Validation rules | Insert negative payment | Fails due to CHECK | Pass |
| ST-04 | Referential integrity | Delete student with enrollment | Blocked or cascaded as defined | Pass |

## 4. Example SQL Evidence

```sql
-- FK violation check
INSERT INTO enrollment (student_id, group_id, enrolled_on, status)
VALUES (999, 1, CURRENT_DATE, 'active');

-- CHECK violation
INSERT INTO payment (enrollment_id, paid_on, amount, method)
VALUES (1, CURRENT_DATE, -100.00, 'cash');
```
