
/*
Comparto mi sintaxis en STATA sobre la replica de los indicadores presentados en la ERESTEL 2021 
laminas 101, 102 y 103.
*/

Link de la ppt: https://repositorio.osiptel.gob.pe/handle/20.500.12630/808


** ruta
global ruta "C:\Users\JOSE\Desktop\Bases_erestel"
cd $ruta


// Lamina 101 PPT 2021: Uso de Internet según Variables Socioeconómicas
*************************************************************************

foreach x in 16 18 19 21 {
	
	use personasOSIPTEL20`x'.dta,clear

	di "**** Año 20`x' ****"

	di " Por Edad "
  
	recode q5 (12/17=1 12a17) (18/23=2 18a23) (24/29=3 24a29) (30/35=4 30a35) (36/45=5 36a45) (46/50=6 46a50) (51/max=7 51amáx), g(redad)
	tab redad u1 [iw=fact_exp],nofreq row  
  
	di " Por Genero "
	tab q4 u1 [iw=fact_exp],nofreq row 

	di " Por NSE " // Nivel socieconomico
  
	recode nse (1/2=1 ab) (3=3 c) (4/5=4 de), g(rnse)
	tab rnse u1 [iw=fact_exp] , nofreq row 

}




//Láminas 102 y 103 PPT2021 versión larga: USOS DE INTERNET SEGÚN TIPO DE CONEXIÓN, PUNTOS DE ACCESO
*****************************************************************************************************


// Base 2018 - 2021

* Ámbito : Perú
*-----------------------------------------
  
foreach x in 18 19 21 {
    
	use personasOSIPTEL20`x'.dta,clear

	
	di "****** AÑO 20`x' *********"
	
	di "Conexion de cel/tablet pagada"
	
	gener u4_89=0 if u1==1
	replace u4_89=1 if u1==1 & (u4_8==1 | u4_9==1)
	tab  u4_89 [iw=fact_exp]
	
	
	di "Conexión fija dentro de la vivienda PC/laptop"

	tab  u4_1       [iw=fact_exp] 
	
	di "Cabina publica"

	tab  u4_10      [iw=fact_exp] 

	di "Trabajo (PC)"

	tab  u4_4   [iw=fact_exp] 
	
	
	di "Conexión desde celular/tablet (gratuito, via WiFi de terceros o públicos)"

	tab  u4_3   [iw=fact_exp] 
	 
	
	di "Centro de estudios"

	tab  u4_5   [iw=fact_exp] 
	 
 	
	di "Familiares, vecinos o amigos"

	tab  u4_6    [iw=fact_exp]
	 
	 
	di "Conexión desde laptop (gratuito, via WiFi de terceros o públicos)"

	tab  u4_2   [iw=fact_exp] 
	 
 
	di "Conexión con módem USB desde PC/laptop pagado"

	tab  u4_7   [iw=fact_exp] 
	 

}


* Ámbito : Lima metrp , Resto Urb y Amb rural
*----------------------------------------------

/* 
   1 Lima metrpop
   2 Resto Urbano
   3 Ambito Rural 
*/


foreach y in 1 2 3 {
    
	foreach x in 18 19 21 {
    
	use personasOSIPTEL20`x'.dta,clear

	di "******** ÁMBITO `y' ********"
	di "****** AÑO 20`x' *********"
	
	di "Conexion de cel/tablet pagada"
	
	gener u4_89=0 if u1==1
	replace u4_89=1 if u1==1 & (u4_8==1 | u4_9==1)
	tab ambito u4_89 [iw=fact_exp] if ambito==`y', nofreq row
	
	
	di "Conexión fija dentro de la vivienda PC/laptop"

	tab ambito u4_1       [iw=fact_exp] if ambito==`y', nofreq row

	
	di "Cabina publica"

	tab ambito u4_10      [iw=fact_exp] if ambito==`y', nofreq row


	di "Conexión desde celular/tablet (gratuito, via WiFi de terceros o públicos)"

	tab ambito u4_3   [iw=fact_exp] if ambito==`y', nofreq row
	 
	 
	di "Trabajo (PC)"

	tab ambito u4_4   [iw=fact_exp] if ambito==`y', nofreq row
	
	
 	di "Familiares, vecinos o amigos"

	tab ambito u4_6    [iw=fact_exp] if ambito==`y', nofreq row
	 
	 
	di "Centro de estudios"

	tab ambito u4_5   [iw=fact_exp] if ambito==`y', nofreq row
	 
	 
	di "Conexión desde laptop (gratuito, via WiFi de terceros o públicos)"

	tab ambito u4_2   [iw=fact_exp] if ambito==`y' , nofreq row
	 
 
	di "Conexión con módem USB desde PC/laptop pagado"

	tab ambito u4_7   [iw=fact_exp] if ambito==`y', nofreq row
	 

}
}



****************************** FIN :D


 
