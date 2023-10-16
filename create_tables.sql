CREATE TABLE IF NOT EXISTS trips (
  trip_id INT NOT NULL,
  user_id INT NOT NULL,
  vehicle_id INT NOT NULL,
  booking_time TIMESTAMP NOT NULL,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  status_id VARCHAR(25) NOT NULL,
  travel_dist BIGINT,
  price_amount FLOAT,
  price_tax FLOAT,
  price_total FLOAT,
  start_lat FLOAT,
  start_lon FLOAT,
  end_lat FLOAT,
  end_lon FLOAT,
  PRIMARY KEY (trip_id),
  CONSTRAINT fk_users
      FOREIGN KEY(user_id)
    REFERENCES users(user_id),
  CONSTRAINT fk_vehicles
      FOREIGN KEY(vehicle_id)
    REFERENCES vehicles(vehicle_id)
);

CREATE TABLE IF NOT EXISTS users (
  user_id INT NOT NULL,
  rut_user VARCHAR(10),
  name_user TEXT,
  membership_id INT,
  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS vehicles (
  vehicle_id INT NOT NULL,
  patente VARCHAR(7),
  marca TEXT,
  modelo TEXT,
  PRIMARY KEY (vehicle_id)
);
