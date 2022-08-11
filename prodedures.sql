CREATE
OR REPLACE PROCEDURE insert_visit(vet_name VARCHAR, animal_name VARCHAR, date DATE)
LANGUAGE SQL 
BEGIN ATOMIC
INSERT INTO
  visits
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = vet_name
    ),
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = animal_name
    ),
    date
  );

END;