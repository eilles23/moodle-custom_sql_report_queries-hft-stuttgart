SELECT cc.id, CONCAT('<a target="_blank" href="%%WWWROOT%%/course/view.php',CHAR(63),'id=',cc.id,'">',cc.fullname,'</a>') AS 'Kursname'
,cc.Cotrainer as 'Co-Trainer'
,cc.Trainer as 'Trainer'
,CONCAT('<a target="_blank" href="%%WWWROOT%%/course/index.php',CHAR(63),'categoryid=',cc.category,'">',cat.name,'</a>') AS 'Kategorie'
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
WHERE pp.id = cat.id ) as 'SG-Kursmanager' 
,(SELECT CONCAT('<a target="_blank" href="%%WWWROOT%%/course/index.php',CHAR(63),'categoryid=',x.id,'">',x.name,'</a>') FROM prefix_course_categories as x WHERE x.id = cat.parent) AS Kategorie2
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
WHERE pp.id = cat.parent ) as 'SG-Kursmanager2' 
FROM (SELECT c.id, c.visible, c.fullname, c.category, ctx.path, 
	  Count(CASE WHEN ra.roleid = 5 THEN 1 END) AS Teilnehmer,
	  Count(CASE WHEN ra.roleid = 3 THEN 1 END) AS Trainer,
	  Count(CASE WHEN ra.roleid = 19 THEN 1 END) AS Cotrainer
	  FROM prefix_role_assignments AS ra
	  JOIN prefix_context AS ctx ON ra.contextid = ctx.id
	  RIGHT JOIN prefix_course as c ON ctx.instanceid = c.id GROUP BY c.fullname) AS cc
JOIN prefix_course_categories as cat on cc.category = cat.id
WHERE Teilnehmer = 0  AND cc.visible = 1
ORDER BY cc.fullname ASC
