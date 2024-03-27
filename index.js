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


// Un endpoint /login pour l’authentification des utilisateurs
// Route pour la page de login
router.get('/login', (req, res) => {
  res.render('login');
});

// Route pour l'authentification
router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  const user = await User.findOne({ email }); // Rechercher l'utilisateur dans la base de données
  if (!user) {
    return res.status(401).json({ error: 'Utilisateur non trouvé' });  // Si l'utilisateur n'existe pas, retourner une erreur
  }
  const isPasswordValid = await bcrypt.compare(password, user.password); // Comparer le mot de passe saisi avec le mot de passe haché dans la base de données
  if (!isPasswordValid) {
    return res.status(401).json({ error: 'Mot de passe incorrect' }); // Si le mot de passe est incorrect, retourner une erreur
  }
  const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
    expiresIn: '1h',
  }); // Générer un token JWT
  res.json({ token }); // Envoyer le token à l'utilisateur
});

module.exports = router;

// Un endpoint /logout pour la déconnection des utilisateurs
router.get('/logout', (req, res) => {
  req.session.destroy();
  // Rediriger l'utilisateur vers la page d'accueil
  res.redirect('/');
});
module.exports = router;


// Un endpoint /register pour la création de comptes utilisateurs
router.get('/register', (req, res) => {
  res.render('register');
});

// Route pour la création de compte
router.post('/register', async (req, res) => {
  const { email, password, name } = req.body;

  // Vérifier si l'utilisateur existe déjà
  const userExists = await User.findOne({ email });
  if (userExists) {
    return res.status(400).json({ error: 'Utilisateur déjà existant' });
  } // Si l'utilisateur existe déjà, retourner une erreur

  const hashedPassword = await bcrypt.hash(password, 10);// Hacher le mot de passe
  const user = new User({
    email,
    password: hashedPassword,
    name,
  }); // Créer un nouvel utilisateur
  // Enregistrer l'utilisateur dans la base de données
  await user.save();
  // Générer un token JWT
  const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
    expiresIn: '1h',
  });

  // Envoyer le token à l'utilisateur
  res.json({ token });
});

module.exports = router;

router.get('/', function(req, res){
  getAllOrdinateurs().then(Ordinateurs => res.json(Ordinateurs))
})






app.listen(PORT, () => {
    console.log(`The server listens on http://localhost:${PORT}`);
  });