/*Queries that provide answers to the questions from all projects.*/
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon';

SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-12-31';

SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE
  AND escape_attempts < 3;

SELECT
  date_of_birth
FROM
  animals
WHERE
  name IN ('Agumon', 'Pikachu');

SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

SELECT
  *
FROM
  animals
WHERE
  neutered = TRUE;

SELECT
  *
FROM
  animals
WHERE
  name <> 'Gabumon';

SELECT
  *
FROM
  animals
WHERE
  round(weight_kg :: numeric, 2) >= 10.23
  AND round(weight_kg :: numeric, 2) <= 17.3;

-- AGGREGATIONS AND GROUP BY
-- How many animals are there?
SELECT
  COUNT(*)
FROM
  animals;

-- How many animals have never tried to escape?
SELECT
  COUNT(*) AS "No: animals never escaped"
FROM
  animals
WHERE
  escape_attempts = 0;

-- What is the average weight of animals?
SELECT
  AVG(weight_kg) AS "average weight"
FROM
  animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
  neutered,
  COUNT(*)
FROM
  animals
GROUP BY
  neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT
  species,
  MIN(weight_kg) AS minimum,
  MAX(weight_kg) AS maximum
FROM
  animals
GROUP BY
  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
  species,
  ROUND(AVG(escape_attempts), 0) AS "average number of escape attempts"
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-12-31'
GROUP BY
  species;

-- What animals belong to Melody Pond?
SELECT
  animals.name
FROM
  animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
  animals.name
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
  owners.full_name,
  animals.name
FROM
  owners
  LEFT JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT
  COUNT(*) AS "No of animals",
  species.name
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
GROUP BY
  species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
  animals.id,
  animals.name,
  species.name,
  owners.full_name
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Jennifer Orwell'
  AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
  animals.id,
  animals.name,
  owners.full_name
FROM
  animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE
  animals.escape_attempts = 0;

AND owners.full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT
  owners.full_name,
  COUNT(*) AS "No of animals"
FROM
  owners
  LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY
  owners.full_name;

-- Who was the last animal seen by William Tatcher?
SELECT
  vets.name AS "Vet name",
  animals.name AS "Last visit animal",
  visits.date AS "Visit date"
FROM
  vets
  LEFT OUTER JOIN visits ON vets.id = visits.vet_id
  LEFT OUTER JOIN animals ON animals.id = visits.animal_id
WHERE
  vets.name = 'William Tatcher'
ORDER BY
  visits.date DESC
LIMIT
  1;

-- How many different animals did Stephanie Mendez see?
SELECT
  vets.name,
  COUNT(*) AS "animals visited"
FROM
  vets
  LEFT OUTER JOIN visits ON vets.id = visits.vet_id
  LEFT OUTER JOIN animals ON animals.id = visits.animal_id
WHERE
  vets.name = 'Stephanie Mendez'
GROUP BY
  vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT
  vets.name,
  species.name
FROM
  vets
  LEFT OUTER JOIN specializations ON vets.id = specializations.vet_id
  LEFT OUTER JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  vets.name AS "Vet name",
  animals.name AS "Animal name",
  visits.date AS "Visit date"
FROM
  animals
  LEFT OUTER JOIN visits ON animals.id = visits.animal_id
  LEFT OUTER JOIN vets ON vets.id = visits.vet_id
WHERE
  vets.name = 'Stephanie Mendez'
  AND visits.date BETWEEN '2020-04-01'
  AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT
  animals.name AS "Animal name",
  COUNT(*) AS "Visit times"
FROM
  visits
  RIGHT JOIN animals ON animals.id = visits.animal_id
GROUP BY
  animals.name
ORDER BY
  "Visit times" DESC
LIMIT
  1;

-- Who was Maisy Smith's first visit?
SELECT
  vets.name AS "Vet name",
  animals.name AS "Last visit animal",
  visits.date AS "Visit date"
FROM
  vets
  LEFT OUTER JOIN visits ON vets.id = visits.vet_id
  LEFT OUTER JOIN animals ON animals.id = visits.animal_id
WHERE
  vets.name = 'Maisy Smith'
ORDER BY
  visits.date
LIMIT
  1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  animals.name AS "Animal name",
  animals.date_of_birth AS "Date of birth",
  animals.escape_attempts AS "Escape attempts",
  animals.neutered AS "Neutered",
  animals.weight_kg AS "Weight (kg)",
  vets.name AS "Vet name",
  vets.age AS "Vet age",
  vets.date_of_graduation AS "Vet graduation date",
  visits.date AS "Date of visit"
FROM
  visits
  RIGHT JOIN animals ON animals.id = visits.animal_id
  RIGHT JOIN vets ON vets.id = visits.vet_id
ORDER BY
  visits.date DESC
LIMIT
  1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(*)
FROM
  visits
  RIGHT JOIN animals ON animals.id = visits.animal_id
  RIGHT JOIN vets ON vets.id = visits.vet_id
  LEFT JOIN specializations ON specializations.vet_id = vets.id
  LEFT JOIN species ON specializations.species_id = species.id
WHERE
  specializations.species_id <> animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
  species.name,
  COUNT(*)
FROM
  visits
  RIGHT JOIN animals ON animals.id = visits.animal_id
  RIGHT JOIN vets ON vets.id = visits.vet_id
  RIGHT JOIN species ON animals.species_id = species.id
WHERE
  vets.name = 'Maisy Smith'
GROUP BY
  species.name
ORDER BY
  count DESC
LIMIT
  1;