library(sqldf)

######################################
#CARGA DE LAS TABLAS 
######################################
library(readr)
LN_QR15 <- read.table("~/dwh-local/LN_QRoo2015.csv", header = FALSE, sep = "\t")
LN_QR15 <- read.csv("~/dwh-local/LN_QR15.csv", sep = ",")
BD_QRoo_2016

View(LN_QR15)
colnames(LN_QR16)



catCargoPartido <- read_csv("~/dwh-local/catCargoPartido.csv")




#CUANTAS PERSONAS DISTINTAS HAY
#CRUZAN ALGUNAS PERSONAS CON LA TABLA DE AUDITORIA Y ESTRUCTURA?
#MAPA DE GEOLOCALIZACIÓN YA QUE TIENEN CP
#CONTEO DE LOS QUE VOTARON EN 13 Y 15, INFERENCIA DE LOS QUE VOTARIAN EN 16
#AGRUPAR POR CODIGO_POSTAL ENTIDAD DISTRITO_FED DISTRITO_LOCAL MUNICIPIO SECCION LOCALIDAD

#===========================================METADATA===========================================

cuenta<- sqldf('SELECT VOTO_2015, count(*) FROM LN_QR16 GROUP BY VOTO_2015')
#1,062,899 registros

sqldf('SELECT COUNT(DISTINCT(CLAVE)) ELECTORES FROM LN_QR16')
#1,055,660 distintos

sqldf('SELECT CLAVE, count(*) CUENTA FROM LN_QR16 GROUP BY CLAVE ORDER BY CUENTA DESC')
#TODOS SON DISTINTOS. SOLO HAY 7239 REGISTROS EN NULO

sqldf('SELECT count(distinct(IFEClavePadron)) FROM CedEstructuraQR16')

num_formatos <- sqldf('SELECT IFEClave, count(*) Formatos FROM CedEstructuraQR16 GROUP BY IFEClave ORDER BY Formatos DESC')
View(num_formatos)

sqldf('select count(*) from num_formatos where CUENTA>20')
#ESTE ES EL BUENO PARA DISTINGUIR LAS CLAVES ÚNICAS
#AHORA HAY QUE VER, POR QUE HAY PERSONAS QUE TIENEN 245 VECES IFE

#MNJMLS91011423H400

caso245 <- sqldf('SELECT * FROM CedEstructuraQR16 WHERE IFEClave="MNJMLS91011423H400"')
View(caso245)
#idcontribuyente nos dice cuales son las personas distintas sin importar si tienen o no credencial o estan en la lista nominal

IFEClavePadron  #QUIEN SABE QUE MADRE SEA ESTO, TIENE VALORES MUY RAROS
IFEClave  #ESTA ES LA CLAVE CQUE SIRVE PARA LIGAR
FolioNacional

sqldf('SELECT promovido, count(IFEClave) cuenta FROM CedEstructuraQR16 GROUP BY promovido')

##EJERCICIO DE CRUCE
ife_promovidos <- sqldf('SELECT IFEClave, max(promovido) promovido FROM CedEstructuraQR16 GROUP BY IFEClave')
ife_promovidos0 <- sqldf('SELECT IFEClave, min(promovido) promovido FROM CedEstructuraQR16 GROUP BY IFEClave')
sqldf('SELECT COUNT(*) FROM ife_promovidos')
#el valor promovido no es determinante

LN_QR16

joinLN_estructura <- sqldf('SELECT * FROM LN_QR16 A, ife_promovidos B WHERE A.CLAVE=B.IFEClave')
sqldf('select count(*) from joinLN_estructura')
#410,734



###FACTOR DE IDENTIDAD PRIISTA
recibirInformacion
tendenciaPolitica
ciudadanoAcepto
votariaDiputado
votariaGobernador
#voto_2015

IFES13 <- read_csv("~/dwh-local/IFES13.csv")
IFES15 <- read_csv("~/dwh-local/IFES15.csv")
IFES16 <- read_csv("~/dwh-local/IFES16.csv")

sqldf('select count(*) from IFES15, IFES16 where IFE16=IFE15')
#sqldf('select count(*) from IFES13, IFES15 where IFE13=IFE15')
sqldf('select count(*) from IFES13, IFES16 where IFE13=IFE16')
#sqldf('select count(*) from IFES13, IFES15, IFES16 where IFE16=IFE15 and IFE16=IFE13')


195930+176998

#DE QUE DOMENSIONES PROVIENENEN LAS 195,206 PERSONAS CON ALTA IDENTIDAD PRI
#los globales de dimensiones son
.481 territorial
.014 partido
.425 redes
.08 circulo

16429 son de circulos orimarios
93% de estructura 20666*.93 =19219
16429+19219

#entonces
195206-35648

159558 provienen de tierra y redes
159558*.53 tierra
159558*.469 redes
84565
74832

.425/.906 +.481/.906

#===========================================FACTOR DE IDENTIDAD PRIISTA===========================================

#SOURCE a
#llave ifeclave
bup_QR16_dist <- read_csv("~/dwh-local/BD_QRoo_2016_corta.csv")
colnames(bup_QR16_dist)
colnames(bup_QR16_dist)[10] <- "ocupacionBUP"
sqldf('select count(*) from bup_QR16_dist')
View(bup_QR16_dist)

#SOURCE b
#llave ifeclave
personas_formatos <- sqldf('select ifeclave, count(idcedestructura) formatos from bup_QR16 group by ifeclave order by formatos desc')
write.table(personas_formatos, file = "~/dwh-local/personas_formatos.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "")

#etiquetado en excel nivel de priismo por cantidad de formatos que tiene
#231,897 personas tienen un formato, los demás tienen más de dos
#1,871 personas tienen más de 10 formatos
#se etiquetaron a las 420,000 personas distintas por el número de formatos que tienen
#se vuelve a cargar
personas_formatos_factor <- read_csv("~/dwh-local/personas_formatos.csv")
colnames(personas_formatos_factor)
colnames(personas_formatos_factor)[1] <- "ife2"
sqldf('select count(*) from bup_QR16_dist')

#SOURCE c
#llave IFE
FuncionariosQR16 <- read_csv("~/dwh-local/FuncionariosQR16corta.csv")
colnames(FuncionariosQR16)
colnames(FuncionariosQR16)[5] <- "localidadFUN"

sqldf('select count(*) from FuncionariosQR16 where tieneINEFUN=1')
sqldf('select count(distinct(IFE)) from FuncionariosQR16 where tieneINEFUN=1')
62946-52758  #todos menos los distintos
65254-62946
#la base limpia de funcionarios tiene la marca que pertenecen al círculo primario, resultan 65,254 hubieron 6mil que estaban batidos en la base
sqldf('select NombreOrganizacion, count(IFE) cuenta from FuncionariosQR16 group by NombreOrganizacion order by cuenta desc')

#SOURCE d
#llave CLAVE
LN_QR16 <- read_csv("~/dwh-local/LN_QR16.csv")
View(LN_QR16)
colnames(LN_QR16)
colnames(LN_QR16)[1] <- "CLAVE"
LN_QR16corta <- sqldf('select CLAVE, LUGAR_NACIMIENTO, SEXO, OCUPACION, CODIGO_POSTAL, ENTIDAD, DISTRITO_FED, DISTRITO_LOCAL, MUNICIPIO, SECCION, LOCALIDAD, VOTO_2013, VOTO_2015 from LN_QR16')
sqldf('select count(*) from LN_QR16corta')

LN_QR15 <- read_csv("~/dwh-local/LN_QR15.csv")

#SOURCE e
FactorBUP_QR16 <- read_csv("~/dwh-local/FactorBUP_QR16.csv")
colnames(FactorBUP_QR16)
sqldf('select count(*) from FactorBUP_QR16')

####JOIM

BUP2 <- sqldf('
select * from bup_QR16_dist a 
left join personas_formatos_factor b on a.ifeclave=b.ife2
left join FuncionariosQR16 c on a.ifeclave=c.IFE
left join LN_QR16corta d on a.ifeclave=d.CLAVE
left join FactorBUP_QR16 e on a.ifeclave=e.ifeclaveFactor
')
colnames(BUP2)

test1 <- sqldf('select ifeclave, DL, sexoBUP, ocupacionBUP
      ,CLAVE, DISTRITO_LOCAL, SEXO, OCUPACION from BUP2 where PrimerContacto=1 and CLAVE >0')
View(test1)

sqldf('select count(*), OCUPACION from BUP2 where PrimerContacto=1 group by OCUPACION')

#TENEMOS QUE HACER UNA MARCA DE TERRITORIAL Y NO TERRITORIAL



#los que provienen de circulo primario
sqldf('select count(*) from BUP2 where CirculoPrimario=1')/sqldf('select count(*) from FuncionariosQR16 where CirculoPrimario=1')

sqldf('select count(*) from BUP2 where cualSector>0')


write.table(BUP2, file = "~/dwh-local/BUP2.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "")


#SOURCE final
FactorBUP_QR16 <- read_csv("~/dwh-local/FactorBUP_QR16.csv")
colnames(FactorBUP_QR16)
sqldf('select count(*) from FactorBUP_QR16')

#factores en orden
#recibirInformacion	tendenciaPolitica	ciudadanoAcepto	votariaDiputado	votariaGobernador	factorIdentidad


##BUP2-MODELO ES LA TABLA QUE TIENE EL MODELO PROBABILISTICO, LA QUE HACE EL CALCULO
#BUP_QR16 ES LA CONSUMIBLE, ESTA SE CONECTA A TABLEAU
#BD_QROO_2016 ES LA TABLA DE HECHOS DE 9TI ACORTADA


factorIDEN <- read_csv("~/dwh-local/factorIDEN.csv")
hist(factorIDEN$factorIdentidadCalculo)
hist(factorIDEN$factorIdentidadTopado)
hist(factorIDEN$factorIdentidadAjustado)
hist(factorIDEN$factorFormatos)


#catálogos necesarios
municipio
estados
estado civil
nivel de estudios
cargo partidista
cual sector
estructura pri
parte estructura
partidos politicos


#suponiendo que todas las personas con 60% priistas o mas fueran a votar resultan 211,672 justo las votaciones


##FUENTES DE INFORMACION CON LAS QUE NO SE PUDO TRABAJAR

#llave
censoSolidaridad14 <- read_csv("~/dwh-local/censoSolidaridad14corta.csv")
View(censoSolidaridad14)
colnames(censoSolidaridad14)
#solo se rescataron 68,341 de censo solidaridad
#solo pegaron a la BUP 1,906 o sea 2,7%

#preguntar a 9TI el catálogo de los sectores


###las variables de cedestructura no sirven para trabajar
CedEstructuraQR16 <- read_csv("~/dwh-local/CedEstructuraQR16.csv")
CedEstructuraDetalleQR16 <- read_csv("~/dwh-local/CedEstructuraDetalleQR16.csv")
CedAuditoriaQR16 <- read_csv("~/dwh-local/CedAuditoriaQR16.csv")
#en CedEstructuraQR16
colnames(CedEstructuraDetalleQR16)
colnames(CedAuditoriaQR16)

View(CedAuditoriaQR16)
sqldf('select count(distinct(IdContribuyente)), IdTipoFormato from CedEstructuraDetalleQR16 group by IdTipoFormato')

sqldf('select distinct(claveIFE), comentario from CedAuditoriaQR16 where comentario>0')


sqldf('select count(distinct(IdAuditoria)) from CedAuditoriaQR16')
#SE AUDITARON A 30,000 PERSONAS


sqldf('select distinct(IdTipoFormato) from CedEstructuraDetalleQR16')
#20468

intento_estructura <- sqldf('select distinct(idcedestructura) from CedEstructuraDetalleQR16 where otroMayorEdad>0')
test3 <- sqldf('select distinct(idcedestructura) from BUP2')
colnames(BUP2)
tryjoin <- sqldf('select a.idcedestructura tablamadre, b.idcedestructura bup from test3 a, intento_estructura b where a.idcedestructura=b.idcedestructura')
sqldf('select count(*) from tryjoin')
##lo más cercano a la gente del formato 2 que es el territorial 194,381

sqldf('select count(*) from BUP2 where tareasPRI>0')


sqldf('select count(distinct(telParticular)) from CedAuditoriaQR16')

test <- sqldf('select distinct(IFEClave), lugarNacimiento, 
              estadoNacimiento, practicaDeporte, deporte, nivelSocioeconomico from CedEstructuraQR16')


##intentos de mapeo
cpMexico <- read_csv("~/dwh-local/cpMexico.csv")
colnames(cpMexico)
cpmex <- sqldf ('select POSTALCODE, avg(Latitude)  Latitude, avg(Longitude) Longitude from cpMexico group by POSTALCODE ')
View(cpmex)

write.table(cpmex, file = "~/dwh-local/cpmex.csv", append = FALSE, quote = TRUE, sep = ",", eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "")


#que onda con las variables estadoNacimiento,  esas

###variables definitivas de la base que consume el tableau
Número de Formato
Clave IFE

Ubicación
Distrito Local
Distrito Federal
Sección
Municipio
Localidad
Código Postal

Demografía
Género
Edad
Estado Civil

Características
Nivel de Estudios
Estado de Nacimiento
Ocupación

Relativos al partido
Cargo Partidista
Organización o Sector
Estructura
Circulo Primario
Afiliado al Partido

Comportamiento Electoral
Votó PRI 13
Votó PRI 15
Identificación con partido
Declaró Votaría PRI

Variables Creadas
Número de Formatos
Factor de Identidad PRI
Votó PRI 16



PARTIDO
21,876
CIRCULOS
33,631
420002-33631-21876
364495/420002

