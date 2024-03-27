const express = require('express');
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '@prisma/client';

const connectionString = process.env.DATABASE_URL;
const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });
const router = express.Router();
const {PrismaClient} = require('@PrismaClient');
const app = express(); 
const PORT = process.env.PORT || 8000;


// router.get('/', function(req, res){
//   getAllOrdinateurs().then(Ordinateurs => res.json(Ordinateurs))
// })






app.listen(PORT, () => {
    console.log(`The server listens on http://localhost:${PORT}`);
  });