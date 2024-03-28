-- CreateTable
CREATE TABLE "Ordinateur" (
    "Tag" TEXT NOT NULL,
    "Modele" TEXT NOT NULL,
    "Fabriquant" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Apprenant" (
    "matricule" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "postnom" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "fate_de_naissance" TIMESTAMP(3) NOT NULL,
    "adresse" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "ordinateurTag" TEXT,
    "cohorteCode" INTEGER
);

-- CreateTable
CREATE TABLE "Cohorte" (
    "Code" SERIAL NOT NULL,
    "Description" TEXT NOT NULL,
    "sessionId" INTEGER
);

-- CreateTable
CREATE TABLE "Session" (
    "Id" SERIAL NOT NULL,
    "Annee" TIMESTAMP(3) NOT NULL,
    "Type" TEXT NOT NULL,
    "Ville" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Coaches" (
    "Id" SERIAL NOT NULL,
    "Nom" TEXT NOT NULL,
    "prenom" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Telephone" TEXT NOT NULL,
    "Specialisation" TEXT NOT NULL,
    "sessionId" INTEGER,

    CONSTRAINT "Coaches_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "Etre_Gerer" (
    "Id" SERIAL NOT NULL,
    "CoachesId" INTEGER,
    "apprenantMatricule" TEXT
);

-- CreateTable
CREATE TABLE "Etre_Assigner" (
    "Id" SERIAL NOT NULL,
    "cohorteCode" INTEGER,
    "CoachesId" INTEGER
);

-- CreateIndex
CREATE UNIQUE INDEX "Ordinateur_Tag_key" ON "Ordinateur"("Tag");

-- CreateIndex
CREATE UNIQUE INDEX "Apprenant_matricule_key" ON "Apprenant"("matricule");

-- CreateIndex
CREATE UNIQUE INDEX "Apprenant_email_key" ON "Apprenant"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Cohorte_Code_key" ON "Cohorte"("Code");

-- CreateIndex
CREATE UNIQUE INDEX "Session_Id_key" ON "Session"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Coaches_Id_key" ON "Coaches"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Coaches_Email_key" ON "Coaches"("Email");

-- CreateIndex
CREATE UNIQUE INDEX "Etre_Gerer_Id_key" ON "Etre_Gerer"("Id");

-- CreateIndex
CREATE UNIQUE INDEX "Etre_Assigner_Id_key" ON "Etre_Assigner"("Id");

-- AddForeignKey
ALTER TABLE "Apprenant" ADD CONSTRAINT "Apprenant_ordinateurTag_fkey" FOREIGN KEY ("ordinateurTag") REFERENCES "Ordinateur"("Tag") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Apprenant" ADD CONSTRAINT "Apprenant_cohorteCode_fkey" FOREIGN KEY ("cohorteCode") REFERENCES "Cohorte"("Code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cohorte" ADD CONSTRAINT "Cohorte_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "Session"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Coaches" ADD CONSTRAINT "Coaches_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "Session"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Etre_Gerer" ADD CONSTRAINT "Etre_Gerer_CoachesId_fkey" FOREIGN KEY ("CoachesId") REFERENCES "Coaches"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Etre_Gerer" ADD CONSTRAINT "Etre_Gerer_apprenantMatricule_fkey" FOREIGN KEY ("apprenantMatricule") REFERENCES "Apprenant"("matricule") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Etre_Assigner" ADD CONSTRAINT "Etre_Assigner_cohorteCode_fkey" FOREIGN KEY ("cohorteCode") REFERENCES "Cohorte"("Code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Etre_Assigner" ADD CONSTRAINT "Etre_Assigner_CoachesId_fkey" FOREIGN KEY ("CoachesId") REFERENCES "Coaches"("Id") ON DELETE SET NULL ON UPDATE CASCADE;
