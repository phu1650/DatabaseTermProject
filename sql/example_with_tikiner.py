from tkinter.constants import END
import mysql.connector
from mysql.connector import Error
import tkinter as tk
from tkinter import Entry
from tkinter import Label
from tkinter import Button
from datetime import datetime

root = tk.Tk()
root.title("Outstagram")
root.option_add("*Font", "consolas 15")
root.geometry("1000x600")


def create_quote(string):
    return '"' + str(string) + '"'


def insert():
    my_connect = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="024595094+Aa",
        database="Outstagram"
    )
    my_cur = my_connect.cursor()

    user_command = "INSERT INTO user VALUES (" + create_quote(id.get())+"," + create_quote(
        national_id.get())+"," + create_quote(username.get())+","+create_quote(email.get())+","+create_quote(password.get())+")"
    my_cur.execute(user_command)

    customer_command = "INSERT INTO customer VALUES (" + \
        create_quote(id.get()) + \
        ","+create_quote(credit_card.get())+")"
    my_cur.execute(customer_command)

    now = datetime.now()  # current date and time
    time = now.strftime("%Y-%m-%d")

    id_command = "INSERT INTO user_national_id VALUES (" + create_quote(
        national_id.get())+"," + create_quote(time) + "," + create_quote(gender.get()) + ","+create_quote(firstname.get())+','+create_quote(lastname.get())+")"
    my_cur.execute(id_command)

    my_connect.commit()
    my_connect.close()


def find():
    my_connect = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="024595094+Aa",
        database="Outstagram"
    )
    my_cur = my_connect.cursor()
    my_cur.execute(
        "SELECT * FROM user AS U JOIN customer AS C JOIN user_national_id AS UID ON C.c_id = id AND U.national_id =  UID.national_id  WHERE username = '" + str(username.get()) + "'")
    records = my_cur.fetchall()
    print(records)

    # password.insert(END, records[0][4])
    email.delete(0, END)
    email.insert(END, records[0][3])
    firstname.delete(0, END)
    firstname.insert(END, records[0][10])
    lastname.delete(0, END)
    lastname.insert(END, records[0][11])
    national_id.delete(0, END)
    national_id.insert(END, records[0][1])
    birthdate.delete(0, END)
    birthdate.insert(END, records[0][8])
    gender.delete(0, END)
    gender.insert(END, records[0][9])
    credit_card.delete(0, END)
    credit_card.insert(END, records[0][6])
    id.delete(0, END)
    id.insert(END, records[0][5])

    my_connect.commit()
    my_connect.close()


def update():
    my_connect = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="024595094+Aa",
        database="Outstagram"
    )
    my_cur = my_connect.cursor()

    print(id.get())
    user_command = "UPDATE user SET password='" + str(password.get())+"', email = '" + str(
        email.get())+"' ,national_id = '" + str(national_id.get()) + "' WHERE username='"+username.get()+"'"
    my_cur.execute(user_command)

    customer_command = "UPDATE customer SET credit_card='" + \
        str(credit_card.get()) + \
        "' WHERE c_id ='"+str(id.get())+"'"
    my_cur.execute(customer_command)

    id_command = "UPDATE user_national_id SET gender = '" + str(
        gender.get())+"' ,firstname = '" + str(firstname.get()) + "' ,lastname = '" + str(lastname.get()) + "' WHERE national_id='"+str(national_id.get())+"'"
    my_cur.execute(id_command)

    my_connect.commit()
    my_connect.close()


def delete():
    my_connect = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="024595094+Aa",
        database="Outstagram"
    )
    my_cur = my_connect.cursor()
    my_cur.execute("DELETE FROM user where username = '" +
                   str(username.get()) + "'")

    records = my_cur.fetchall()

    print_records = ''
    for r in records:
        print_records += str(r[2]) + '\n'
    query_label = Label(root, text=print_records)
    query_label.grid(row=12, column=0, columnspan=2)

    my_connect.commit()
    my_connect.close()

    # ============= Create text box for input  =========


username = Entry(root, width=30)
username.grid(row=0, column=1, padx=20)

password = Entry(root, width=30)
password.grid(row=1, column=1, padx=20)

password_confirm = Entry(root, width=30)
password_confirm.grid(row=2, column=1, padx=20)

email = Entry(root, width=30)
email.grid(row=3, column=1, padx=20)

firstname = Entry(root, width=30)
firstname.grid(row=4, column=1, padx=20)

lastname = Entry(root, width=30)
lastname.grid(row=5, column=1, padx=20)

national_id = Entry(root, width=30)
national_id.grid(row=6, column=1, padx=20)

birthdate = Entry(root, width=30)
birthdate.grid(row=7, column=1, padx=20)

gender = Entry(root, width=30)
gender.grid(row=8, column=1, padx=20)

credit_card = Entry(root, width=30)
credit_card.grid(row=9, column=1, padx=20)

id = Entry(root, width=30)
id.grid(row=10, column=1, padx=20)


# ============ Create text label for the above text box =====
username_label = Label(root, text="Username :")
username_label.grid(row=0, column=0)

password_label = Label(root, text="Password :")
password_label.grid(row=1, column=0)

password_confirm_label = Label(root, text="Confirm Password :")
password_confirm_label.grid(row=2, column=0)

email_label = Label(root, text="Email :")
email_label.grid(row=3, column=0)

firstname_label = Label(root, text="Firstname :")
firstname_label.grid(row=4, column=0)

lastname_label = Label(root, text="Lastname :")
lastname_label.grid(row=5, column=0)

national_id_label = Label(root, text="National ID :")
national_id_label.grid(row=6, column=0)

birthdate_label = Label(root, text="Birthdate :")
birthdate_label.grid(row=7, column=0)

gender_label = Label(root, text="Gender :")
gender_label.grid(row=8, column=0)

credit_card_label = Label(root, text="Credit Card :")
credit_card_label.grid(row=9, column=0)

id_label = Label(root, text="ID :")
id_label.grid(row=10, column=0)

# ============ Create a query button ===================
insert_btn = Button(root, text="Insert", command=insert)
insert_btn.grid(row=11, column=0, columnspan=1,
                pady=10, padx=10, ipadx=50)

find_btn = Button(root, text="Find", command=find)
find_btn.grid(row=12, column=0, columnspan=1,
              pady=10, padx=10, ipadx=50)

update_btn = Button(root, text="Update", command=update)
update_btn.grid(row=13, column=0, columnspan=1,
                pady=10, padx=10, ipadx=50)

delete_btn = Button(root, text="Delete", command=delete)
delete_btn.grid(row=14, column=0, columnspan=1,
                pady=10, padx=10, ipadx=50)


root.mainloop()
