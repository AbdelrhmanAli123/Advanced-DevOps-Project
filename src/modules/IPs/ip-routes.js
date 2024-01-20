import { Router } from "express";
import * as ip from './ip-controller.js'


export const router = Router()


router.get("/client-ip", ip.catchUserIP)
router.get("/client-ip/list", ip.listUsersIPs)
