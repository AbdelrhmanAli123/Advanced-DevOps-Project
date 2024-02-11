import express, { request, response } from "express";
import { DB } from "./src/db-connection/rds.js"
import mysql from "mysql"
import { router } from "./src/modules/IPs/ip-routes.js";

const app = express()
 
app.get("/hello",(request,response)=>{
    response.status(200).json({
        message: "hello world"
    })
})

DB()

app.use(express.json())
app.use("/",router)
const port = process.env.PORT || 4445

app.listen(port,(err)=>{
    console.log(` Aplication is running on the poert ${port} `)
})
