CREATE TABLE IF NOT EXISTS resumen_diario (
  fecha DATE NOT NULL,
  cant_viajes INT,
  sum_ingr INT,
  prom_ingr INT,
  sum_mts INT,
  PRIMARY KEY (fecha)
);
