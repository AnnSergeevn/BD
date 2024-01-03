import psycopg2


def create_db(conn):
  # создание таблиц
  cur.execute("""
        CREATE TABLE IF NOT EXISTS сlient (
        id SERIAL PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        email TEXT NOT NULL);
        """)
  cur.execute("""
        CREATE TABLE IF NOT EXISTS telefone_сlient(
        id SERIAL PRIMARY KEY,
        client_id INTEGER NOT NULL REFERENCES сlient(id),
        phone CHAR(10));
        """)

  print("Table created successfully")

def del_table(conn):
    # удаление таблиц
    cur.execute("""
     DROP TABLE telefone_сlient;
     DROP TABLE сlient;
     """)


def add_client(conn, first_name, last_name, email, phones=None):
    print("Database opened successfully")

    cur.execute(
        'INSERT INTO сlient (first_name, last_name, email) VALUES (%s,%s,%s) RETURNING *;'
        , (first_name, last_name, email))
    res = cur.fetchone()
    return res


def add_phone(conn, client_id, phone):
  cur.execute(
    'INSERT INTO telefone_сlient (client_id, phone) VALUES (%s, %s) RETURNING *', (client_id, phone)
  )
  res = cur.fetchone()
  print(res)
  return res


def change_client(conn, client_id, first_name=None, last_name=None, email=None, phones=None):
    cur.execute("""
            UPDATE сlient SET first_name=%s, last_name=%s, email=%s WHERE id=%s;
            """, (first_name, last_name, email, client_id))

    cur.execute("""
            SELECT * FROM сlient;
            """)

    res = cur.fetchone()
    return res

def delete_phone(conn, client_id, phone):
    cur.execute("""
          DELETE FROM telefone_сlient WHERE id=%s;
          """, (conn,))
    cur.execute("""
          SELECT * FROM telefone_сlient;
          """)



def delete_client(conn, client_id):
  cur.execute("""
          SELECT * FROM сlient;
          """)
  print(cur.fetchall())  # запрос данных автоматически зафиксирует изменения


def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
  pass


with psycopg2.connect(database="netology_bd", user="postgres", password="netology") as conn:
  rows = []
  with conn.cursor() as cur:
      select_request = (input('Выберете число, чтобы реализовать следующие действия(добавить нового клиента-1;'
                              'добавить телефон для существующего клиента-2;изменить данные о клиенте-3;'
                              ' удалить телефон для существующего клиента-4;удалить существующего клиента-5;'
                              'найти клиента по его данным: имени, фамилии, email или телефону -6): '))


      create_db(conn)
      #del_table(conn)



      #data_сlient = add_client(conn, first_name, last_name, email)
      #data_phone = add_phone(conn,data_сlient[0],phone)

      if int(select_request) == 1:
          first_name = (input('Введите имя клиента: '))
          last_name = (input('Введите фамилию клиента: '))
          email = (input('Введите email клиента: '))
          add_client(conn, first_name, last_name, email)
      elif int(select_request) == 2:
          data_сlient = (input('Введите id клиента: '))
          phone = (input('Введите телефон клиента: '))
          add_phone(conn, data_сlient[0], phone)
          cur.execute("SELECT id, client_id, phone from telefone_сlient")
          phones = cur.fetchall()
          print(phones)
      elif int(select_request) == 3:
          data_сlient = (input('Введите id клиента: '))

          first_name = (input('Введите имя клиента для изменения: '))
          last_name = (input('Введите фамилию клиента для изменения: '))
          email = (input('Введите email клиента для изменения: '))
          cur.execute("SELECT id, first_name, last_name, email from сlient")

          rows = cur.fetchall()
          print(rows)
          for row in rows:

              if first_name and last_name and email:
                  change_client(conn, data_сlient, first_name, last_name, email);
              elif first_name and last_name:
                  change_client(conn, data_сlient, first_name, last_name, row[3]);
              elif first_name and email:
                  change_client(conn, data_сlient, first_name, row[2],email);
              elif last_name:
                  change_client(conn, data_сlient,row[1], last_name, row[3]);
              elif email:
                  change_client(conn, data_сlient, row[1], row[2], email);
              elif last_name and email:
                  change_client(conn, data_сlient,row[1],  row[2],  row[3]);
              elif first_name:
                  change_client(conn, data_сlient, first_name,  row[2],  row[3]);
              else:
                  change_client(conn, data_сlient, row[1],  row[2],  row[3]);
      else:
          data_сlient = (input('Введите id клиента: '))
          data_id_tel = (input('Введите id номера: '))
          cur.execute("SELECT id, client_id, phone from telefone_сlient")
          rows = cur.fetchall()
          print(rows)
          for row in rows:
             delete_phone(data_id_tel, data_сlient, row[2])





      cur.execute("SELECT id, first_name, last_name, email from сlient")
      rows = cur.fetchall()


      cur.execute("SELECT id, client_id, phone from telefone_сlient")
      phones = cur.fetchall()

      print(rows)
      print(phones)
      '''for row in rows:
            print("id =", row[0])
            print("first_name =", row[1])
            print("last_name =", row[2])
            print("email =", row[3])'''



print("Operation done successfully")

conn.close()
