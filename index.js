import express from "express";
import { connection } from "./src/db-connection/rds.js"
import mysql from "mysql"

const app = express()
 
// connection()


app.use(express.json())

const port = process.env.PORT || 4000

app.listen((err)=>{
    console.log(` Aplication is running on the poert ${port} `)
})