# Data Dictionary

## STUDENT
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| student_id | SERIAL | PK | Unique student identifier |
| first_name | VARCHAR(50) | NOT NULL | Student first name |
| last_name | VARCHAR(50) | NOT NULL | Student last name |
| date_of_birth | DATE | NOT NULL | DOB |
| email | VARCHAR(120) | NOT NULL, UNIQUE | Contact email |
| phone | VARCHAR(20) | NOT NULL | Contact phone |
| created_at | TIMESTAMP | NOT NULL, DEFAULT now() | Created timestamp |

## TEACHER
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| teacher_id | SERIAL | PK | Unique teacher identifier |
| first_name | VARCHAR(50) | NOT NULL | Teacher first name |
| last_name | VARCHAR(50) | NOT NULL | Teacher last name |
| email | VARCHAR(120) | NOT NULL, UNIQUE | Teacher email |
| phone | VARCHAR(20) | NOT NULL | Phone number |
| hire_date | DATE | NOT NULL | Hire date |

## COURSE
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| course_id | SERIAL | PK | Unique course ID |
| course_name | VARCHAR(100) | NOT NULL, UNIQUE | Course name |
| category | VARCHAR(50) | NOT NULL | Course category |
| duration_weeks | INT | NOT NULL, CHECK > 0 | Duration in weeks |
| fee | NUMERIC(10,2) | NOT NULL, CHECK >= 0 | Course fee |

## GROUP
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| group_id | SERIAL | PK | Unique group ID |
| course_id | INT | FK -> course | Course reference |
| teacher_id | INT | FK -> teacher | Teacher reference |
| schedule_day | VARCHAR(15) | NOT NULL | Day of week |
| start_time | TIME | NOT NULL | Start time |
| end_time | TIME | NOT NULL | End time |
| start_date | DATE | NOT NULL | Start date |
| end_date | DATE | NOT NULL | End date |
| room | VARCHAR(50) | NOT NULL | Room name |

## ENROLLMENT
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| enrollment_id | SERIAL | PK | Unique enrollment ID |
| student_id | INT | FK -> student | Student reference |
| group_id | INT | FK -> group | Group reference |
| enrolled_on | DATE | NOT NULL | Enrollment date |
| status | VARCHAR(10) | NOT NULL, CHECK in (active, completed, cancelled) | Status |

## ATTENDANCE
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| attendance_id | SERIAL | PK | Unique attendance ID |
| enrollment_id | INT | FK -> enrollment | Enrollment reference |
| session_date | DATE | NOT NULL | Session date |
| attendance_status | VARCHAR(10) | NOT NULL, CHECK in (present, absent, late) | Attendance status |

## PAYMENT
| Column | Type | Constraints | Description |
| --- | --- | --- | --- |
| payment_id | SERIAL | PK | Unique payment ID |
| enrollment_id | INT | FK -> enrollment | Enrollment reference |
| paid_on | DATE | NOT NULL | Payment date |
| amount | NUMERIC(10,2) | NOT NULL, CHECK > 0 | Payment amount |
| method | VARCHAR(20) | NOT NULL | Payment method |
