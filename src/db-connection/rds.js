


import mysql from "mysql"

export const connection = mysql.createConnection({
    host: process.env.RDS_ENDPOINT,
    user: process.env.RDS_USER,
    password: process.env.RDS_PASSWORD
})

const DB = ()=>{
    connection.connect(err => {
        if (err) throw err;
        console.log("connected to RDS...  :)")
        connection.query('CREATE DATABASE IF NOT EXISTS main;', (err) => {
            if (err) throw err
            console.log("Database created")
            connection.changeUser({ database: 'mydb'}, (err) => {
                if (err) throw err
                createTable()
            
            }) 
            
        });
    })
}


const createTable = ()=>{
    connection.query('CREATE TABLE IF NOT EXISTS users(id int NOT NULL AUTO_INCREMENT, ip varchar(100));', err => {
        if (err) throw err
    })
}