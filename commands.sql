SELECT name FROM grade;

SELECT name FROM emotion;

SELECT COUNT(title) FROM poem;

SELECT name FROM author
ORDER BY name ASC;

SELECT name FROM author
ORDER BY name ASC
LIMIT 76;

SELECT author.name, grade.name FROM author
JOIN grade
ON author.gradeid = grade.id
ORDER BY author.name ASC
LIMIT 76;

SELECT Count(string_to_array(poem.text, ' ')) + 1 AS wordCount FROM poem;

SELECT author.name, grade.name, gender.name FROM author
JOIN grade
ON author.gradeid = grade.id
JOIN gender
ON gender.id = author.genderid
ORDER BY author.name ASC
LIMIT 76;

SELECT title, text FROM poem
ORDER BY LENGTH(text) ASC
LIMIT 1;

SELECT COUNT(author.name) FROM author
JOIN grade
ON author.gradeid = grade.id
WHERE grade.name = '3rd Grade';

SELECT COUNT(author.name) FROM author
JOIN grade
ON grade.id = author.gradeid
WHERE grade.name = '1st Grade' OR grade.name = '2nd Grade' OR grade.name = '3rd Grade';

SELECT COUNT(poem) FROM poem
JOIN author
ON author.id = poem.authorid
JOIN grade
ON author.gradeid = grade.id
WHERE grade.name = '4th Grade';

SELECT COUNT(poem), grade.name FROM poem
JOIN author
ON author.id = poem.authorid
JOIN grade
ON author.gradeid = grade.id
GROUP BY grade.name;

SELECT COUNT(author), grade.name FROM author
JOIN grade
ON author.gradeid = grade.id
GROUP BY grade.name
ORDER BY grade.name ASC;

CREATE OR REPLACE FUNCTION
getWordCount(str TEXT)
RETURNS int
LANGUAGE plpgsql
AS
$$
DECLARE
wordCount int:= 0;
s char;
BEGIN
FOR i IN 1..Length(str) LOOP
    s:= Substring(str, i, 1);
	IF s = ' '
    THEN wordCount:= wordCount + 1;
	  END IF;
    END LOOP;
RETURN wordCount;
END;
$$;

SELECT getWordCount(poem.title) AS wordCount, poem.title FROM poem
GROUP BY poem.title
ORDER BY wordCount DESC
LIMIT 1;