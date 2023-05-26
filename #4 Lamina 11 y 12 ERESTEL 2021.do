
// Láminas 11 y 12 del PPT2021 ERESTEL:

* Fuente: https://repositorio.osiptel.gob.pe/handle/20.500.12630/808

global ruta "XXXXXXXXXXXX"
cd $ruta

//2018-2021

foreach x in 18 19 21 {

          use personasOSIPTEL20`x'.dta,clear

          keep q3 q4 q5 ficha_st
          sort ficha_st 
          drop if q3!=1
          save jh20`x'.dta,replace
          use hogaresOSIPTEL20`x'.dta,clear
          sort ficha_st
          merge ficha_st using jh20`x'.dta

          gener   internet=0 if r1!=.
          replace internet=1 if t1==1 | t1==2 | t1==3
          
          * Lamina 11: "PERÚ: CONVIVENCIA DE SERVICIOS DE TELECOMUNICACIONES EN EL HOGAR" 
          ********************************************************************************
          
          gener   sph=0 if r1!=.
          replace sph=1 if r1==1 & r32==2 & internet==0 & x1==2 //Posee 1 servicio
          replace sph=1 if r1==2 & r32==1 & internet==0 & x1==2 //Posee 1 servicio
          replace sph=1 if r1==2 & r32==2 & internet==1 & x1==2 //Posee 1 servicio
          replace sph=1 if r1==2 & r32==2 & internet==0 & x1==1 //Posee 1 servicio
          replace sph=2 if r1==1 & r32==1 & internet==0 & x1==2 //Posee 2 servicios
          replace sph=2 if r1==1 & r32==2 & internet==1 & x1==2 //Posee 2 servicios
          replace sph=2 if r1==1 & r32==2 & internet==0 & x1==1 //Posee 2 servicios
          replace sph=2 if r1==2 & r32==1 & internet==1 & x1==2 //Posee 2 servicios
          replace sph=2 if r1==2 & r32==1 & internet==0 & x1==1 //Posee 2 servicios
          replace sph=2 if r1==2 & r32==2 & internet==1 & x1==1 //Posee 2 servicios
          replace sph=3 if r1==1 & r32==1 & internet==1 & x1==2 //Posee 3 servicios
          replace sph=3 if r1==1 & r32==1 & internet==0 & x1==1 //Posee 3 servicios
          replace sph=3 if r1==2 & r32==1 & internet==1 & x1==1 //Posee 3 servicios
          replace sph=3 if r1==1 & r32==2 & internet==1 & x1==1 //Posee 3 servicios
          replace sph=4 if r1==1 & r32==1 & internet==1 & x1==1 //Posee 4 servicios
          replace sph=5 if r1==2 & r32==2 & internet==0 & x1==2 //Sin servicios

          label variable sph "Servicios por hogar"
          label define sph 1 "Posee 1 servicio" 2 "Posee 2 servicios" 3 "Posee 3 servicios" 4 "Posee 4 servicios" /*
          */5 "Sin servicios"  
          label values sph sph
          
          // Valores
          tab sph ambito [iw=fact_exp], nofreq col

          /*
            Lamina 12: "Perú: Tenencia Simultánea de 3 o 4 Servicios 
            Públicos de Telecomunicaciones en  el Hogar según Variables 
            Socioeconómicas, 2016-2021"
          */
          
          *-----------------------------------------------------
          recode sph (3/4=1 d3a4st) (5=0 otro) (1/2=0 otro), g(rsph)

          *Edad
          *----
          recode q5 (12/17=1 12a17) (18/29=2 18a29) (30/35=3 30a35) (36/45=4 36a45) (46/50=5 46a50) (51/max=6 51amás), g(redad)
          tab redad rsph [iw=fact_exp] if q4!=. & q5>=18, nofreq row
          
          *Sexi
          *----
          tab q4 rsph [iw=fact_exp] if q4!=. , nofreq row

          *NSE
          *---
          recode nse (1/2=1 ab) (3=2 c) (4/5=3 de), g(rnse)
          tab rnse rsph [iw=fact_exp] if q4!=. , nofreq row

}


*************************** FIN :D







//
