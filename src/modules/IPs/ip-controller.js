import { connection } from "../../db-connection/rds.js";

export const catchUserIP = (req,res)=>{
    const userIP = req.ip.replace(/^::ffff:/, '')
        connection.query(`INSERT INTO users SET ?`, {
            ip: userIP
        }, (err)=> {
            if (err){
                console.error('Error inserting record:', err);
                return res.status(500).send('Internal Server Error');
            }else{     
                console.log('1 record inserted');
                res.end('Hi bro, this is a devops task');
            }
    
        })
}



export const listUsersIPs = (req,res)=>{
    connection.query(`SELECT * FROM main.users`, (err,result) => {
        if (err){
            console.error('Error inserting record:', err);
            return res.status(500).send('Internal Server Error');
        }else{
            res.status(200).json({
            status: "successful",
            data: result
            })
         }
    });
}