// Lámina 6 del PPT2021 ERESTEL:

// Fuente: https://repositorio.osiptel.gob.pe/handle/20.500.12630/808

// PERÚ: EQUIPAMIENTO TIC EN EL HOGAR"
**************************************

global ruta "XXXXXXX"
cd $ruta

*ACCESO A TELEVISIÓN
*========================

//Año 2016
   
  use hogaresOSIPTEL2016.dta,clear
	tab p131 ambito [iw=fact_exp], nofreq col

//Año 2018-2021

foreach x in 18 19 21 {
    
	di "**** AÑO 20`x' **** "
	use hogaresOSIPTEL20`x'.dta,clear 
	tab p13_1 ambito [iw=fact_exp], nofreq col
	di "*********************"
	
}


**ACCESO A RADIO
*================

// Año 2016

  use hogaresOSIPTEL2016.dta,clear
	tab p132 ambito [iw=fact_exp], nofreq col
	
// Año 2018-2019

foreach x in 18 19 {
    
	di "**** AÑO 20`x' **** "
	use hogaresOSIPTEL20`x'.dta,clear 
	tab p13_2_01 ambito [iw=fact_exp], nofreq col
	di "*********************"
	
}
	
// Año 2021

   use hogaresOSIPTEL2021.dta,clear
	tab p13_2_1 ambito [iw=fact_exp], nofreq col


*===================================
*ACCESO A COMPUTADORA DE ESCRITORIO
*====================================


//Año 2016

    use hogaresOSIPTEL2016.dta,clear
	tab p133 ambito [iw=fact_exp], nofreq col
	
//Año 2018-2019

foreach x in 18 19 {
	
    di "**** AÑO 20`x' **** "
	use hogaresOSIPTEL20`x'.dta,clear 
	tab p13_2_02 ambito [iw=fact_exp], nofreq col
	di "*********************"
	
}
	
//Año 2021

    use hogaresOSIPTEL2021.dta,clear
	tab p13_3_1 ambito [iw=fact_exp], nofreq col
	
*==============================
**REPRODUCTOS DE DVD/BLUE-RAY
*==============================

//Año 2016

    use hogaresOSIPTEL2016.dta,clear
	tab p135 ambito [iw=fact_exp], nofreq col
	
//Año 2018-2019

foreach x in 18 19 {
	
  di "**** AÑO 20`x' **** "
	use hogaresOSIPTEL20`x'.dta,clear 
	tab p13_2_04 ambito [iw=fact_exp], nofreq col
	di "*********************"
	
}
	
//Año 2021

  use hogaresOSIPTEL2021.dta,clear
	tab p13_5_1 ambito [iw=fact_exp], nofreq col

*================================================
**ACCESO A LAPTOP, ULTRABOOK NOTEBOOK O ULTRABOOK
*================================================

//Año 2016

  use hogaresOSIPTEL2016.dta,clear
	tab p134 ambito [iw=fact_exp], nofreq col
	
//Año 2018-2019

foreach x in 18 19 {
	
  di "**** AÑO 20`x' **** "
	use hogaresOSIPTEL20`x'.dta,clear 
	tab p13_2_03 ambito [iw=fact_exp], nofreq col
	di "*********************"
	
}
	
//Año 2021

    use hogaresOSIPTEL2021.dta,clear
	tab p13_4_1 ambito [iw=fact_exp], nofreq col
	
*=========================
* ACCESO A TABLET
*========================

//Año 2016

    use hogaresOSIPTEL2016.dta,clear
	tab p136 ambito [iw=fact_exp], nofreq col
	
//Año 2018-2019

foreach x in 18 19 {
	
    di "**** AÑO 20`x' **** "
	use hogaresOSIPTEL20`x'.dta,clear 
	tab p13_2_05 ambito [iw=fact_exp], nofreq col
	di "*********************"
}
	
//Año 2021

    use hogaresOSIPTEL2021.dta,clear
	tab p13_6_1 ambito [iw=fact_exp], nofreq col

	
* ====================
**ACCESO A SMARTPHONE
* ====================

foreach x in 16 18 19 21 {
    
        use OSIPTEL_personas20`x'.dta,clear
        
        gener PersonaConSmart=0 if (v2==2 | v2==3)  //Personas (a partir de 12 aÃ±os) que tienen celular pero que no es smartphone (o no saben)
        replace PersonaConSmart=1 if v2==1 //Personas (a partir de 12 aÃ±os) que tienen un celular smartphone    
        replace PersonaConSmart=0 if v1==2 //Personas (a partir de 12 aÃ±os) que no tienen celular
        replace PersonaConSmart=0 if v1==. // Todos los que son menores de 12 aÃ±os automaticamente no tienen smartphone
        
        bysort ficha_st: egen Nsmart=sum(PersonaConSmart)
        label variable Nsmart "# de smartphone X hogar"
        
        collapse (max) Nsmart, by(ficha_st)
        sort ficha_st 
        save mcs20`x',replace

        use hogaresOSIPTEL20`x'.dta, clear
        sort ficha_st
        merge ficha_st using "mcs20`x'.dta"
        gener rv2=0 if Nsmart==0
        replace rv2=1 if  Nsmart!=0

        di "**** AÑO 20`x' **** "

        //Acceso a smatphone
        
        tab  rv2 ambito [iw=fact_exp], nofreq col 


}


******************************** FIN :D
