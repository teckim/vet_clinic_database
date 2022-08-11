/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg REAL,
    species VARCHAR,
    PRIMARY KEY(id)
);

CREATE TABLE owners (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INTEGER,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

CREATE TABLE vets (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INTEGER,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id INTEGER,
    species_id INTEGER
);

CREATE TABLE visits (
    vet_id INTEGER,
    animal_id INTEGER,
    date DATE
);

ALTER TABLE
    animals DROP COLUMN species;

ALTER TABLE
    animals
ADD
    COLUMN species_id INTEGER;

ALTER TABLE
    animals
ADD
    COLUMN owner_id INTEGER;

ALTER TABLE
    animals
ADD
    FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE
    animals
ADD
    FOREIGN KEY (owner_id) REFERENCES owners (id);

ALTER TABLE
    specializations
ADD FOREIGN KEY (vet_id) REFERENCES vets (id),
ADD FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE
    visits
ADD FOREIGN KEY (vet_id) REFERENCES vets (id),
ADD FOREIGN KEY (animal_id) REFERENCES animals (id);