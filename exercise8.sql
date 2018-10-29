# 1. NULL, INNER JOIN, LEFT JOIN, RIGHT JOIN

SELECT teacher.name
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id
WHERE teacher.dept IS NULL;

# 2.

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
   ON (teacher.dept=dept.id);

# 3.

SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
   ON (teacher.dept=dept.id);

# 4.

SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
   ON (teacher.dept=dept.id);

# 5.

SELECT teacher.name, COALESCE(teacher.mobile, '07986 444 2266')
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;

# 6.

SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id;

# 7.

SELECT COUNT(teacher.name), COUNT(teacher.mobile)
FROM teacher;

# 8.

SELECT dept.name, COUNT(teacher.name)
FROM teacher RIGHT JOIN dept ON teacher.dept = dept.id
GROUP BY dept.name;

# 9.

SELECT teacher.name,
  CASE WHEN dept.id < 3 THEN 'Sci'
       ELSE 'Art'
  END
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id

# 10.

SELECT teacher.name,
  CASE WHEN dept.id < 3 AND dept.id >  0 THEN 'Sci'
            WHEN dept.id = 3 THEN 'Art'
            ELSE 'None'
  END
FROM teacher LEFT JOIN dept ON teacher.dept = dept.id


# 8+ Examples

# 1. Check out one row

SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science';

# 2. Calculate how many agree or strongly agree

SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score >= 100;

# 3. Unhappy Computer Students

SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND subject='(8) Computer Science'
   AND score < 50;

# 4. More Computing or Creative Students?

SELECT subject, SUM(response)
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;


# 5. Strongly Agree Numbers

SELECT subject, SUM(response*A_STRONGLY_AGREE/100)
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

# 6. Strongly Agree, Percentage

SELECT subject, ROUND(SUM(A_STRONGLY_AGREE*response)/SUM(response), 0)
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

# 7. Scores for Institutions in Manchester

SELECT institution, ROUND(SUM(score*response)/SUM(response), 0)
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
GROUP BY institution
ORDER BY institution;

# 8. Number of Computing Students in Manchester

SELECT institution, SUM(sample),
  SUM(CASE WHEN subject = '(8) Computer Science' THEN sample END)
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
 GROUP BY institution;