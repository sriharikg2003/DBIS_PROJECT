import psycopg2
import sys

try:
    conn = psycopg2.connect(
        database="moviedb",
        host="localhost",
        user="postgres",
        password="1234",
        port=5432,
    )
except:
    sys.exit("Failed to connect to the database")


cursor = conn.cursor()
# Question 1
act_id = input("Enter actor id: ")
first_name = input("Enter First Name: ")
last_name = input("Enter Last Name: ")
gender = input("Enter Gender: ")

query = f"select * from actor where act_id={act_id};"

cursor.execute(query)
rows = cursor.fetchall()

if len(rows) != 0:
    print("Actor ID already exists")
else:
    try:
        query2 = f"INSERT INTO actor values({act_id},'{first_name}','{last_name}','{gender}');"
        cursor.execute(query2)
        conn.commit()
        print("Actor details inserted into the actor table successfully")
    except psycopg2.DatabaseError as error:
        conn.rollback()
        sys.exit(
            error
        )  # Ending the program here if error occurs because there is no point in executing Question 2

# Question 2
no_of_movies = int(input("Enter the number of movies: "))
mov_ids = []
roles = []

for i in range(no_of_movies):
    mov_id = input(f"Enter movie id of movie number {i+1}: ")
    role = input(f"Enter role of the actor in movie number {i+1}: ")
    mov_ids.append(mov_id)
    roles.append(role)

for i in range(len(mov_ids)):
    mov_id = mov_ids[i]
    role = roles[i]
    movie_exists_query = f"select * from movie where mov_id = {mov_id};"
    cursor.execute(movie_exists_query)
    movie_res = cursor.fetchall()
    if len(movie_res) == 0:
        sys.exit(
            f"Movie number {i+1} is not present in the database. Database is not updated"
        )
    else:
        try:
            insert_query = f"INSERT into movie_cast values({act_id},{mov_id},'{role}');"
            cursor.execute(insert_query)
        except psycopg2.DatabaseError as error:
            conn.rollback()
            sys.exit(error)

# This will execute only if all valyes are successfully inserted (there is no exception)
conn.commit()
print("Database update successfull")

conn.close()
cursor.close()
