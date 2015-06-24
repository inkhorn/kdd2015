CREATE TABLE final_output AS (
SELECT DISTINCT a.*, c.about, c.chapter, c.course, c.course_info, c.html, c.outlink,
c.problem AS num_problems, c.sequential, c.static_tab, c.vertical, c.video AS num_videos, c.combinedopenended, c.p,
d.navigate, d.access, d.problem, d.page_close, d.video, d.discussion, d.wiki, e.navigate_avg_etime,
e.access_avg_etime, e.problem_avg_etime, e.page_close_avg_etime, e.video_avg_etime, e.discussion_avg_etime,
e.wiki_avg_etime, f.navigate_min_etime_unix, f.access_min_etime_unix, f.problem_min_etime_unix, 
f.page_close_min_etime_unix, f.video_min_etime_unix, f.discussion_min_etime_unix, f.wiki_min_etime_unix,
g.navigate_max_etime_unix, g.access_max_etime_unix, g.problem_max_etime_unix, 
g.page_close_max_etime_unix, g.video_max_etime_unix, g.discussion_max_etime_unix, g.wiki_max_etime_unix,
h.navigate_total_etime_unix, h.access_total_etime_unix, h.problem_total_etime_unix, 
h.page_close_total_etime_unix, h.video_total_etime_unix, h.discussion_total_etime_unix, h.wiki_total_etime_unix,
i.username, i.num_courses, j.num_students, k.num_children FROM truth_train AS a 
LEFT JOIN enrollment_train AS b ON a.enrollment_id = b.enrollment_id
LEFT JOIN course_components AS c ON b.course_id = c.course_id
LEFT JOIN event_train_ctab AS d ON a.enrollment_id = d.enrollment_id
LEFT JOIN event_train_ctab_avg_etime AS e ON a.enrollment_id = e.enrollment_id
LEFT JOIN event_train_ctab_min_etime_unix AS f ON a.enrollment_id = f.enrollment_id
LEFT JOIN event_train_ctab_max_etime_unix AS g ON a.enrollment_id = g.enrollment_id
LEFT JOIN event_train_ctab_total_etime_unix AS h ON a.enrollment_id = h.enrollment_id
LEFT JOIN num_enroll_train AS i ON b.username = i.username
LEFT JOIN course_pop_train AS j ON b.course_id = j.course_id
LEFT JOIN course_children AS k on b.course_id = k.course_id);

CREATE TABLE final_output_test AS (
SELECT DISTINCT b.enrollment_id, c.about, c.chapter, c.course, c.course_info, c.html, c.outlink,
c.problem AS num_problems, c.sequential, c.static_tab, c.vertical, c.video AS num_videos, c.combinedopenended, c.p,
d.navigate, d.access, d.problem, d.page_close, d.video, d.discussion, d.wiki, e.navigate_avg_etime,
e.access_avg_etime, e.problem_avg_etime, e.page_close_avg_etime, e.video_avg_etime, e.discussion_avg_etime,
e.wiki_avg_etime, f.navigate_min_etime_unix, f.access_min_etime_unix, f.problem_min_etime_unix, 
f.page_close_min_etime_unix, f.video_min_etime_unix, f.discussion_min_etime_unix, f.wiki_min_etime_unix,
g.navigate_max_etime_unix, g.access_max_etime_unix, g.problem_max_etime_unix, 
g.page_close_max_etime_unix, g.video_max_etime_unix, g.discussion_max_etime_unix, g.wiki_max_etime_unix,
h.navigate_total_etime_unix, h.access_total_etime_unix, h.problem_total_etime_unix, 
h.page_close_total_etime_unix, h.video_total_etime_unix, h.discussion_total_etime_unix, h.wiki_total_etime_unix,
i.username, i.num_courses, j.num_students, k.num_children FROM enrollment_test AS b 
LEFT JOIN course_components AS c ON b.course_id = c.course_id
LEFT JOIN event_test_ctab AS d ON b.enrollment_id = d.enrollment_id
LEFT JOIN event_test_ctab_avg_etime AS e ON b.enrollment_id = e.enrollment_id
LEFT JOIN event_test_ctab_min_etime_unix AS f ON b.enrollment_id = f.enrollment_id
LEFT JOIN event_test_ctab_max_etime_unix AS g ON b.enrollment_id = g.enrollment_id
LEFT JOIN event_test_ctab_total_etime_unix AS h ON b.enrollment_id = h.enrollment_id
LEFT JOIN num_enroll_test AS i ON b.username = i.username
LEFT JOIN course_pop_test AS j ON b.course_id = j.course_id
LEFT JOIN course_children AS k on b.course_id = k.course_id);
