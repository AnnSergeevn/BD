import psycopg2

with psycopg2.connect(database="netology_bd", user="postgres", password="netology") as conn:
  with conn.cursor() as cur:
    # удаление таблиц
    cur.execute("""
    DROP TABLE telefone_klient;
    DROP TABLE klient;
    """)
    print("Database opened successfully")

    # создание таблиц
    cur.execute("""
       CREATE TABLE IF NOT EXISTS klient (
       id SERIAL PRIMARY KEY,
       first_name TEXT NOT NULL,
       second_name TEXT NOT NULL,
       email TEXT NOT NULL);
       """)
    cur.execute("""
       CREATE TABLE IF NOT EXISTS telefone_klient(
       id SERIAL PRIMARY KEY,
       telefone CHAR(10),
       klient_id INTEGER NOT NULL REFERENCES klient(id)
       );
       """)

    print("Table created successfully")
    conn.commit()  # фиксируем в БД


    print("Database opened successfully")

    cur.execute(
      "INSERT INTO klient (first_name,second_name,email) VALUES ('Abel', 'Abel', 'Abel@mail.ru')"
    )
    cur.execute(
      "INSERT INTO klient (first_name,second_name,email) VALUES ('Joel', 'Joel', 'Joel@mail.ru')"
    )
    cur.execute(
      "INSERT INTO klient (first_name,second_name,email) VALUES ('Antony', 'Antony', 'Antony@mail.ru')"
    )
    cur.execute(
      "INSERT INTO klient (first_name,second_name,email) VALUES ('Alice', 'Alice', 'Alice@mail.ru')"
    )

    cur.execute(
      "INSERT INTO telefone_klient (telefone, klient_id) VALUES ('+7896', '1')"
    )

    cur.execute(
      "INSERT INTO telefone_klient (telefone, klient_id) VALUES ('+7856', '1')"
    )
    cur.execute(
      "INSERT INTO telefone_klient (telefone, klient_id) VALUES ('+7896', '2')"
    )
    cur.execute(
      "INSERT INTO telefone_klient (telefone, klient_id) VALUES ('+7896654', '3')"
    )
    cur.execute(
      "INSERT INTO telefone_klient (telefone, klient_id) VALUES ('+78967654', '3')"
    )
    cur.execute(
     "INSERT INTO telefone_klient (telefone, klient_id) VALUES ('+7896754', '3')"
    )

    conn.commit()
    print("Records inserted successfully")

    print("Database opened successfully")
    cur = conn.cursor()
    cur.execute("SELECT * from telefone_klient;")

    print(cur.fetchall())

    print("Operation done successfully")


conn.close()