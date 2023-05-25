
* Indicadores TIC según brecha de genero
*-------------------------------------
* Ruta de directorio: 
global ruta "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases"

* Cambiamos la ruta
cd $ruta
*-------------

Fuente: ERESTEL 2015 - 2021
Bases: https://repositorio.osiptel.gob.pe/handle/20.500.12630/327
Reportes: https://repositorio.osiptel.gob.pe/handle/20.500.12630/808

*================================================
* Tasa de acceso a Smartphone a nivel personas 
*================================================

// ERESTEL: 2015 - 2021 

foreach x in 15 16 18 19 21 { 
		
	use OSIPTEL_personas20`x'.dta,clear

	//Personas (a partir de 12 aÃ±os) que tienen celular pero que no es smartphone (o no saben)
	gener PersonaConSmart=0 if (v2==2 | v2==3)  
	
	//Personas (a partir de 12 aÃ±os) que tienen un celular smartphone   
	replace PersonaConSmart=1 if v2==1 

	//Personas (a partir de 12 aÃ±os) que no tienen celular
	replace PersonaConSmart=0 if v1==2 


	di "*** Año 20`x' ***"
	
	di "Nivel absoluto"
	di "--------------"
	tab  q4 PersonaConSmart  [iw=fact_exp]

	di "Nivel Relativo"
	di "--------------"
	tab  q4 PersonaConSmart  [iw=fact_exp], nofreq row 
			
}


*---------------------------------------------------------------------------------------------------
/* 2_ Desagregación según género de cada equipo TIC (computadora, laptop, Tablet y smartphone) según 
variables socioeconómicas (nivel educativo, grupo etario, nivel socioeconómico, lengua materna, 
condición de discapacidad, ámbito geográfico, regiones). */
*---------------------------------------------------------------------------------------------------


* Jalamos caracteristicas de la base a nivel personas hacia nivel de hogares
*============================================================================


foreach x in 12 13 14 15 16 18 19 21 {

	di "------- AÑO 20`x' --------"

	use OSIPTEL_personas20`x'.dta , clear
	destring ficha , replace
	sort ficha 
	drop if q3!=1
	save "jefe_hog20`x'" , replace

	use "OSIPTEL_hogares20`x'.dta" , clear
	destring ficha , replace
	sort ficha 
	merge ficha using "jefe_hog20`x'"
	drop if _merge!=3
	save OSIPTEL_unido20`x'.dta ,replace
	erase jefe_hog20`x'.dta

}




*===========================
* Homogenizamos las bases
*===========================

// ERESTEL 2014 - 2016

foreach x in 14 15 16 {
	
	di "Año 20`x' **********"
	
	use Base_lamina20`x'.dta, clear
	
	clonevar computadora=p133 
	clonevar tablet=p136 
	clonevar laptop=p134 
	clonevar cq9=q9_1 
	
	save Base_lamina20`x'.dta, replace

}


// ERESTEL 2018 - 2019

foreach x in 18 19 {
	
	use Base_lamina20`x'.dta, clear
	
	clonevar computadora=p13_2_02 
	clonevar tablet=p13_2_05 
	clonevar laptop=p13_2_03 
	clonevar cq9=q9_1 
	
	save Base_lamina20`x'.dta, replace

}


// ERESTEL 2021 

foreach x in 21 {
	
	use Base_lamina20`x'.dta, clear
	
	clonevar computadora=p13_3_1 
	clonevar tablet=p13_6_1 
	clonevar laptop=p13_4_1 
	clonevar cq9=q9_1 
	
	save Base_lamina20`x'.dta, replace

}


*==========================================
* Tenencia de Computadora, Laptop y Tablet:
*==========================================

*====================
** Segun estudios
*=====================

// ERESTEL 2015 - 2021
foreach y in computadora laptop tablet {
	
	foreach x in 15 16 18 19 21 {
	
	di "Equipo: `y' ********"
	di ""
	di "Año 20`x' **********"
	
	use Base_lamina20`x'.dta, clear
	
	recode `y' (1=1 "Si") (2=0 "No") (3=0) , g(r`y')
	recode cq9 (1/4=1 "A lo más primaria") (5/6=5 "Secundaria") (7/11 = 7 "Superior") , g(estudios)

	di "Con factor de expansion"
	di "========================"
	
	di "Hombre"
	di "==================="
	
	tab estudios r`y' [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	
	tab estudios r`y' [iw=fact_exp] if q4==2, nofreq row
	
}

	di "Minimo 1 servicio"
	di "=================="
	
	gen dispo=0 if computadora!=0
	replace dispo=1 if computadora==1 | laptop==1 | tablet==1
	
	di "Con factor de expansion"
	di "========================"
	
	di "Hombre"
	di "==================="
	
	tab estudios dispo [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	
	tab estudios dispo [iw=fact_exp] if q4==2, nofreq row

}




*====================
* Grupo etario
*====================


// ERESTEL 2015 - 2021

foreach y in computadora laptop tablet {
	
	foreach x in 15 16 18 19 21 {
	
	di "Equipo: `y' ********"
	di ""
	di "Año 20`x' **********"
	
	use Base_lamina20`x'.dta, clear
	
	recode q5 (0/14=0) (15/29=1 "Jovenes") (30/59=2 "Adultos") (60/max=3 "A. Mayores") , g(redad)
	recode `y' (1=1 "Si") (2=0 "No") (3=0) , g(r`y')
	
	
	di "Con factor de expansion"
	di "========================"
	
	di "Hombre"
	di "==================="
	
	tab redad `y' [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	
	tab redad `y' [iw=fact_exp] if q4==2, nofreq row
	
}
	
	di "LOS 3 SERVICIOS"
	di "================="
	
	gen dispo=0 if computadora!=0
	replace dispo=1 if computadora==1 | laptop==1 | tablet==1
	
	di "Con factor de expansion"
	di "========================="
	
	di "Hombre"
	di "==================="
	
	tab redad dispo [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	
	tab redad dispo [iw=fact_exp] if q4==2, nofreq row
	
}


*===========================
* Nivel socioeconómico
*===========================


// ERESTEL 2015 - 2021

foreach y in computadora laptop tablet {
	
	foreach x in 15 16 18 19 21 {
	
	di "Equipo: `y' ********"
	di ""
	di "Año 20`x' **********"
	
	use Base_lamina20`x'.dta, clear
	
	recode nse (1/3=1 "ABC") (4/5=3 "DE"), gen(rnse)
	recode `y' (1=1 "Si") (2=0 "No") (3=0) , g(r`y')


	di "Con factor de expansion"
	di "========================"
	
	di "Hombre"
	di "==================="
	
	tab rnse `y' [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	
	tab rnse `y' [iw=fact_exp] if q4==2, nofreq row
	

}


	di "LOS 3 SERVICIOS"
	di "****************"	
	
	gen dispo=0 if computadora!=0
	replace dispo=1 if computadora==1 | laptop==1 | tablet==1
	
	di "Con factor de expansion"
	di "======================="
	
	di "Hombre"
	di "==================="
	
	tab rnse dispo [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	
	tab rnse dispo [iw=fact_exp] if q4==2, nofreq row
	
}




*=================
* Lengua materna
*=================

// ERESTEL 2015 - 2021

foreach y in computadora laptop tablet {
	
	foreach x in 15 16 18 19 21 {
	
	di "Equipo: `y' ********"
	di ""
	di "Año 20`x' **********"
	
	use Base_lamina20`x'.dta, clear
	
	recode q6 (1=1 "Castellano") (2=2 "Quechua") (3=3 "Aymara") (4/max=4 "Otro") , g(rq6)
	recode `y' (1=1 "Si") (2=0 "No") (3=0) , g(r`y')

	di "Con factor de expansion"
	di "======================="
	
	di "Hombre"
	di "==================="
	tab rq6 `y' [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="	
	tab rq6 `y' [iw=fact_exp] if q4==2, nofreq row
	
}
	
	di "LOS 3 SERVICIOS"
	di "****************"
	
	gen dispo=0 if computadora!=0
	replace dispo=1 if computadora==1 | laptop==1 | tablet==1
	
	di "Con fact_exp"
	di "==============="
	
	di "Hombre"
	di "==================="
	tab rq6 dispo [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	tab rq6 dispo [iw=fact_exp] if q4==2, nofreq row
	

}



*=========================
* Condición de discapacidad
*=========================


// ERESTEL 2019 - 2021

foreach y in computadora laptop tablet {
	
	foreach x in 19 21 {
	
	di "Equipo: `y' ********"
	di ""
	di "Año 20`x' **********"
	
	use Base_lamina20`x'.dta, clear
	
	gen discap =0 if q11_1!=.
	replace discap=1 if q11_1==1 | q11_2==1 | q11_3==1 | q11_4==1 | q11_5==1 | q11_6==1
	recode `y' (1=1 "Si") (2=0 "No") (3=0) , g(r`y')

	
	di "Con factor de expansion"
	di "======================"
	
	di "Hombre"
	di "==================="
	tab discap `y' [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	tab discap `y' [iw=fact_exp] if q4==2, nofreq row
	
}
	*-----------------------
	
	di "LOS 3 SERVICIOS"
	di "****************"	
	
	gen dispo=0 if computadora!=0
	replace dispo=1 if computadora==1 | laptop==1 | tablet==1
	
	di "Con factor de expansion"
	di "======================="
	
	di "Hombre"
	di "==================="
	tab discap dispo [iw=fact_exp] if q4==1, nofreq row
	
	di "Mujer" 
	di "================="
	tab discap dispo [iw=fact_exp] if q4==2, nofreq row

}


***************************** FIN :D
	
	
	
	
	
	
	
	




