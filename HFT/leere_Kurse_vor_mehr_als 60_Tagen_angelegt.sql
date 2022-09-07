SELECT CONCAT('<a href="%%WWWROOT%%/course/view.php?id=', content.mid, '">',content.mf,'</a>') AS 'Course link'
,CONCAT('<a target="_blank" href="%%WWWROOT%%/course/index.php',CHAR(63),'categoryid=',content.ccat,'">',ccatname,'</a>') AS 'Kategorie'
,(SELECT group_concat(pp.name) FROM (SELECT x.id as id, rolesonparent.name as name FROM prefix_course_categories as x LEFT JOIN (SELECT
cc.id AS id,
cc.name AS category,
cc.depth, cc.path, r.name AS role,
usr.lastname AS name,
usr.firstname, usr.username, usr.email
FROM prefix_course_categories cc
INNER JOIN prefix_context cx ON cc.id = cx.instanceid
AND cx.contextlevel = '40'
INNER JOIN prefix_role_assignments ra ON cx.id = ra.contextid
INNER JOIN prefix_role r ON ra.roleid = r.id
INNER JOIN prefix_user usr ON ra.userid = usr.id
WHERE ra.roleid = 25
ORDER BY cc.depth, cc.path, usr.lastname, usr.firstname, r.name, cc.name) as rolesonparent on rolesonparent.id = x.id) as pp
WHERE pp.id = ccat ) as 'SG-Kursmanager' 
,(SELECT CONCAT('<a target="_blank" href="%%WWWROOT%%/course/index.php',CHAR(63),'categoryid=',x.id,'">',x.name,'</a>') FROM prefix_course_categories as x WHERE x.id = ccatparent) AS Kategorie2
,(SELECT group_concat(qq.name) FROM (SELECT x.id as id, rolesonparent.name as name FROM prefix_course_categories as x LEFT JOIN (SELECT
cc.id AS id,
cc.name AS category,
cc.depth, cc.path, r.name AS role,
usr.lastname AS name,
usr.firstname, usr.username, usr.email
FROM prefix_course_categories cc
INNER JOIN prefix_context cx ON cc.id = cx.instanceid
AND cx.contextlevel = '40'
INNER JOIN prefix_role_assignments ra ON cx.id = ra.contextid
INNER JOIN prefix_role r ON ra.roleid = r.id
INNER JOIN prefix_user usr ON ra.userid = usr.id
WHERE ra.roleid = 25
ORDER BY cc.depth, cc.path, usr.lastname, usr.firstname, r.name, cc.name) as rolesonparent on rolesonparent.id = x.id) as qq
WHERE qq.id = ccatparent ) as 'SG-Kursmanager2' 
,content.t AS 'Erstellt am'
,CONCAT('<a target="_blank" href="%%WWWROOT%%/user/index.php',CHAR(63),'id=',content.mid,'">Nutzer/innen</a>') AS 'Nutzer/innen'
FROM (
SELECT mc.fullname as mf,
  mc.id as mid,
  cat.id as ccat,
  cat.name as ccatname,
  cat.parent as ccatparent,
  FROM_UNIXTIME(mc.timecreated, '%Y-%m-%d') as t,
(SELECT COUNT(*)
FROM prefix_book AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS BOOKs,
(SELECT COUNT(*)
FROM prefix_resource AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS FILEs,
(SELECT COUNT(*)
FROM prefix_folder AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS FOLDERs,
(SELECT COUNT(*)
FROM prefix_label AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS LABELs,
(SELECT COUNT(*)
FROM prefix_imscp AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS IMS,
(SELECT COUNT(*)
FROM prefix_url AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS URLs,
(SELECT COUNT(*)
FROM prefix_page AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS pages,
(SELECT COUNT(*)
FROM prefix_assignment AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS assignment,
(SELECT COUNT(*)
FROM prefix_assign AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS assign,  
(SELECT COUNT(*)
FROM prefix_chat AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS chat,
(SELECT COUNT(*)
FROM prefix_choice AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS choice,
(SELECT COUNT(*)
FROM prefix_data AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS db,
(SELECT COUNT(*)
FROM prefix_feedback AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS feedback,
(SELECT COUNT(*)
FROM prefix_glossary AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS glossary,
(SELECT COUNT(*)
FROM prefix_lesson AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS lesson,
(SELECT COUNT(*)
FROM prefix_lti AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS lit,
(SELECT COUNT(*)
FROM prefix_quiz AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS quiz,
(SELECT COUNT(*)
FROM prefix_scorm AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS scrom,
(SELECT COUNT(*)
FROM prefix_survey AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS survey,
(SELECT COUNT(*)
FROM prefix_wiki AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS wiki,
(SELECT COUNT(*)
FROM prefix_workshop AS u
JOIN prefix_course AS c ON c.id = u.course
WHERE c.id LIKE mc.id 
) AS workshop,
(SELECT COUNT(*)
 FROM prefix_course_sections as cs
 JOIN prefix_course AS c ON c.id = cs.course
 WHERE c.id LIKE mc.id
 AND NOT cs.summary=''
 ) AS plaintext
FROM prefix_course AS mc
JOIN prefix_course_categories as cat on mc.category = cat.id
WHERE FROM_UNIXTIME(mc.timecreated, '%Y-%m-%d') < DATE_SUB(NOW(), INTERVAL 60 DAY)
HAVING BOOKs = 0 
AND FILEs = 0
AND FOLDERs = 0
AND LABELs = 0
AND IMS = 0
AND URLs = 0
AND pages = 0
AND quiz = 0
AND assignment = 0
AND assign = 0
AND chat = 0
AND choice = 0
AND db = 0
AND feedback = 0
AND glossary = 0
AND lesson = 0
AND lit = 0
AND quiz = 0
AND scrom = 0
AND survey = 0
AND wiki = 0
AND workshop = 0
AND plaintext = 0) as content
