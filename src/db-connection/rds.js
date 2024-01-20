import mysql from "mysql"

export const connection = mysql.createConnection({
    host: process.env.RDS_ENDPOINT || "database-1.cxe4wge6g62v.us-east-2.rds.amazonaws.com",
    user: process.env.RDS_USER || "admin",
    port: 3306,
    password: "123asd123asd",
    connectTimeout: 10000
})

export const DB = ()=>{
    connection.connect(err => {
        if (err) throw err;
        console.log("connected to RDS...  :)")
        connection.query('CREATE DATABASE IF NOT EXISTS main;', (err) => {
            if (err) throw err
            console.log("Database created")
            connection.changeUser({ database: 'main'}, (err) => {
                if (err) throw err
                createTable()
            
            }) 
            
        });
    })
}


const createTable = ()=>{
    connection.query('CREATE TABLE IF NOT EXISTS users(id int NOT NULL AUTO_INCREMENT PRIMARY KEY, ip varchar(100));', err => {
        if (err) throw err
        console.log("table has been created")
    })
}