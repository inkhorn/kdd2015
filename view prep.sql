CREATE VIEW num_enroll_train AS (
SELECT username, COUNT(*) AS num_courses FROM enrollment_train
GROUP BY username);

CREATE VIEW num_enroll_test AS (
SELECT username, COUNT(*) AS num_courses FROM enrollment_test
GROUP BY username);

CREATE VIEW course_pop_train AS (
SELECT course_id, COUNT(*) AS num_students FROM enrollment_train
GROUP BY course_id);

CREATE VIEW course_pop_test AS (
SELECT course_id, COUNT(*) AS num_students FROM enrollment_test
GROUP BY course_id);

#SELECT CONCAT('
#SELECT enrollment_id, ', GROUP_CONCAT(DISTINCT CONCAT('\nCOUNT(CASE WHEN logged_event= "',
#logged_event, '" THEN enrollment_id ELSE NULL END) AS ', logged_event)), '
#FROM log_train GROUP BY enrollment_id')
#FROM log_train;


CREATE VIEW event_train_ctab AS (SELECT enrollment_id, 
COUNT(CASE WHEN logged_event= "navigate" THEN enrollment_id ELSE NULL END) AS navigate,
COUNT(CASE WHEN logged_event= "access" THEN enrollment_id ELSE NULL END) AS access,
COUNT(CASE WHEN logged_event= "problem" THEN enrollment_id ELSE NULL END) AS problem,
COUNT(CASE WHEN logged_event= "page_close" THEN enrollment_id ELSE NULL END) AS page_close,
COUNT(CASE WHEN logged_event= "video" THEN enrollment_id ELSE NULL END) AS video,
COUNT(CASE WHEN logged_event= "discussion" THEN enrollment_id ELSE NULL END) AS discussion,
COUNT(CASE WHEN logged_event= "wiki" THEN enrollment_id ELSE NULL END) AS wiki
FROM log_train GROUP BY enrollment_id);

CREATE VIEW event_train_ctab_avg_etime AS (SELECT enrollment_id, 
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS navigate_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS access_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS problem_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS page_close_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS video_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS discussion_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS wiki_avg_etime
FROM log_train GROUP BY enrollment_id);

CREATE VIEW event_train_avg_etime AS (SELECT enrollment_id,
from_unixtime(AVG(UNIX_TIMESTAMP(tstamp))) AS avg_etime
FROM log_train GROUP BY enrollment_id);

CREATE VIEW event_train_ctab_avg_etime_unix AS (SELECT enrollment_id, 
AVG(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_avg_etime_unix,
AVG(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_avg_etime_unix,
AVG(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_avg_etime_unix,
AVG(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_avg_etime_unix,
AVG(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_avg_etime_unix,
AVG(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_avg_etime_unix,
AVG(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_avg_etime_unix
FROM log_train GROUP BY enrollment_id);

CREATE VIEW event_train_ctab_min_etime_unix AS (SELECT enrollment_id, 
MIN(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_min_etime_unix,
MIN(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_min_etime_unix,
MIN(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_min_etime_unix,
MIN(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_min_etime_unix,
MIN(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_min_etime_unix,
MIN(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_min_etime_unix,
MIN(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_min_etime_unix
FROM log_train GROUP BY enrollment_id);

CREATE VIEW event_train_ctab_max_etime_unix AS (SELECT enrollment_id, 
MAX(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_max_etime_unix,
MAX(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_max_etime_unix,
MAX(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_max_etime_unix,
MAX(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_max_etime_unix,
MAX(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_max_etime_unix,
MAX(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_max_etime_unix,
MAX(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_max_etime_unix
FROM log_train GROUP BY enrollment_id);

DROP VIEW event_train_ctab_total_etime_unix;
# Unixtime /60/60/24 = Num Days
CREATE VIEW event_train_ctab_total_etime_unix AS (SELECT enrollment_id, 
MAX(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_total_etime_unix,
MAX(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_total_etime_unix,
MAX(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_total_etime_unix,
MAX(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_total_etime_unix,
MAX(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_total_etime_unix,
MAX(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_total_etime_unix,
MAX(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_total_etime_unix
FROM log_train GROUP BY enrollment_id);

CREATE VIEW event_test_ctab AS (SELECT enrollment_id, 
COUNT(CASE WHEN logged_event= "navigate" THEN enrollment_id ELSE NULL END) AS navigate,
COUNT(CASE WHEN logged_event= "access" THEN enrollment_id ELSE NULL END) AS access,
COUNT(CASE WHEN logged_event= "problem" THEN enrollment_id ELSE NULL END) AS problem,
COUNT(CASE WHEN logged_event= "page_close" THEN enrollment_id ELSE NULL END) AS page_close,
COUNT(CASE WHEN logged_event= "video" THEN enrollment_id ELSE NULL END) AS video,
COUNT(CASE WHEN logged_event= "discussion" THEN enrollment_id ELSE NULL END) AS discussion,
COUNT(CASE WHEN logged_event= "wiki" THEN enrollment_id ELSE NULL END) AS wiki
FROM log_test GROUP BY enrollment_id);

CREATE VIEW event_test_ctab_avg_etime AS (SELECT enrollment_id, 
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS navigate_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS access_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS problem_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS page_close_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS video_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS discussion_avg_etime,
FROM_UNIXTIME(AVG(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END)) AS wiki_avg_etime
FROM log_test GROUP BY enrollment_id);

CREATE VIEW event_test_avg_etime AS (SELECT enrollment_id,
from_unixtime(AVG(UNIX_TIMESTAMP(tstamp))) AS avg_etime
FROM log_test GROUP BY enrollment_id);

CREATE VIEW event_test_ctab_avg_etime_unix AS (SELECT enrollment_id, 
AVG(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_avg_etime_unix,
AVG(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_avg_etime_unix,
AVG(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_avg_etime_unix,
AVG(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_avg_etime_unix,
AVG(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_avg_etime_unix,
AVG(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_avg_etime_unix,
AVG(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_avg_etime_unix
FROM log_test GROUP BY enrollment_id);

CREATE VIEW event_test_ctab_min_etime_unix AS (SELECT enrollment_id, 
MIN(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_min_etime_unix,
MIN(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_min_etime_unix,
MIN(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_min_etime_unix,
MIN(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_min_etime_unix,
MIN(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_min_etime_unix,
MIN(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_min_etime_unix,
MIN(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_min_etime_unix
FROM log_test GROUP BY enrollment_id);

CREATE VIEW event_test_ctab_max_etime_unix AS (SELECT enrollment_id, 
MAX(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_max_etime_unix,
MAX(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_max_etime_unix,
MAX(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_max_etime_unix,
MAX(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_max_etime_unix,
MAX(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_max_etime_unix,
MAX(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_max_etime_unix,
MAX(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_max_etime_unix
FROM log_test GROUP BY enrollment_id);

# Unixtime /60/60/24 = Num Days
CREATE VIEW event_test_ctab_total_etime_unix AS (SELECT enrollment_id, 
MAX(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "navigate" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS navigate_total_etime_unix,
MAX(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "access" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS access_total_etime_unix,
MAX(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "problem" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS problem_total_etime_unix,
MAX(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "page_close" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS page_close_total_etime_unix,
MAX(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "video" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS video_total_etime_unix,
MAX(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "discussion" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS discussion_total_etime_unix,
MAX(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) - MIN(CASE WHEN logged_event= "wiki" THEN UNIX_TIMESTAMP(tstamp) ELSE NULL END) AS wiki_total_etime_unix
FROM log_test GROUP BY enrollment_id);

#SELECT CONCAT('
#SELECT course_id, ', GROUP_CONCAT(DISTINCT CONCAT('\nCOUNT(CASE WHEN category= "',
#category, '" THEN category ELSE NULL END) AS ', category)), '
#FROM object GROUP BY course_id')
#FROM object;

CREATE VIEW course_components AS (
SELECT course_id, 
COUNT(CASE WHEN category= "about" THEN category ELSE NULL END) AS about,
COUNT(CASE WHEN category= "chapter" THEN category ELSE NULL END) AS chapter,
COUNT(CASE WHEN category= "course" THEN category ELSE NULL END) AS course,
COUNT(CASE WHEN category= "course_info" THEN category ELSE NULL END) AS course_info,
COUNT(CASE WHEN category= "html" THEN category ELSE NULL END) AS html,
COUNT(CASE WHEN category= "outlink" THEN category ELSE NULL END) AS outlink,
COUNT(CASE WHEN category= "problem" THEN category ELSE NULL END) AS problem,
COUNT(CASE WHEN category= "sequential" THEN category ELSE NULL END) AS sequential,
COUNT(CASE WHEN category= "static_tab" THEN category ELSE NULL END) AS static_tab,
COUNT(CASE WHEN category= "vertical" THEN category ELSE NULL END) AS vertical,
COUNT(CASE WHEN category= "video" THEN category ELSE NULL END) AS video,
COUNT(CASE WHEN category= "combinedopenended" THEN category ELSE NULL END) AS combinedopenended,
COUNT(CASE WHEN category= "peergrading" THEN category ELSE NULL END) AS p
FROM object GROUP BY course_id);


CREATE VIEW course_children AS (
SELECT course_id, SUM(length(children) - length(replace(children, " ", "")) + 1) AS num_children
FROM object
GROUP BY course_id);
