/* Populate database with sample data. */
/* name, date_of_birth, escape_attempts, neutered, weight_kg, species */
INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Agumon', '2020-02-03', 0, TRUE, 10.23);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Gabumon', '2018-11-15', 2, TRUE, 8);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Pikachu', '2021-01-07', 0, FALSE, 15.04);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Charmander', '2020-02-08', 0, FALSE, -11),
  ('Plantmon', '2021-11-15', 2, TRUE, -5.7),
  ('Squirtle', '1993-04-02', 3, FALSE, -12.13),
  ('Angemon', '2005-06-12', 1, TRUE, -45),
  ('Boarmon', '2005-06-07', 7, TRUE, 20.4),
  ('Blossom', '1998-10-13', 3, TRUE, 17),
  ('Ditto', '2022-05-14', 4, TRUE, 22);

-- Ownser
INSERT INTO
  owners (full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Species
INSERT INTO
  species (name)
VALUES
  ('Pokemon'),
  ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
UPDATE
  animals
SET
  species_id = 2
WHERE
  name LIKE '%mon';

-- All other animals are Pokemon
UPDATE
  animals
SET
  species_id = 2
WHERE
  species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Sam Smith'
  )
WHERE
  name = 'Agumon';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Jennifer Orwell'
  )
WHERE
  name IN ('Gabumon', 'Pikachu');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Bob'
  )
WHERE
  name IN ('Devimon', 'Plantmon');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Melody Pond'
  )
WHERE
  name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Dean Winchester'
  )
WHERE
  name IN ('Angemon', 'Boarmon');

-- Vets
INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO
  specializations
VALUES
  (1, 1),
  (3, 1),
  (3, 2),
  (4, 2);

CALL insert_visit('William Tatcher', 'Agumon', '2020-05-24');

CALL insert_visit('Stephanie Mendez', 'Agumon', '2020-06-22');

CALL insert_visit('William Tatcher', 'Agumon', '2020-05-24');

CALL insert_visit('Jack Harkness', 'Gabumon', '2021-02-02');

CALL insert_visit('Maisy Smith', 'Pikachu', '2020-01-05');

CALL insert_visit('Maisy Smith', 'Pikachu', '2020-03-08');

CALL insert_visit('Maisy Smith', 'Pikachu', '2020-05-14');

CALL insert_visit('Stephanie Mendez', 'Devimon', '2021-05-04');

CALL insert_visit('Jack Harkness', 'Charmander', '2021-02-24');

CALL insert_visit('Maisy Smith', 'Plantmon', '2019-12-21');

CALL insert_visit('William Tatcher', 'Plantmon', '2020-08-10');

CALL insert_visit('Maisy Smith', 'Plantmon', '2021-04-07');

CALL insert_visit('Stephanie Mendez', 'Squirtle', '2019-09-29');

CALL insert_visit('Jack Harkness', 'Angemon', '2020-10-03');

CALL insert_visit('Jack Harkness', 'Angemon', '2020-11-04');

CALL insert_visit('Maisy Smith', 'Boarmon', '2019-01-24');

CALL insert_visit('Maisy Smith', 'Boarmon', '2019-05-15');

CALL insert_visit('Maisy Smith', 'Boarmon', '2020-02-27');

CALL insert_visit('Maisy Smith', 'Boarmon', '2020-08-03');

CALL insert_visit('Stephanie Mendez', 'Blossom', '2020-05-24');

CALL insert_visit('William Tatcher', 'Blossom', '2021-01-11');