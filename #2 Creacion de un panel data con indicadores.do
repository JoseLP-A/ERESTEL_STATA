* Ruta
*------------------------------

global ruta "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases"

cd ruta

/* 
Creacion de una base de datos panel tomando como insumo indicadores
calculados de la ERESTEL 2012 - 2021 
*/


* Tasa de acc int fijo (Nivel hogares)
*--------------------------------------

putexcel set "BD_panel.xlsx" , sheet(acc_internet_fijo) modify
local row = 2

foreach x in 12 13 14 15 16 18 19 21 {
    
		use OSIPTEL_hogares20`x'.dta , clear
		
		di "******* AÑO 20`x' *********"
		
		gen inter_f=0 if t1!=.
		replace inter_f=1 if t1==1 | t1==3
		
		tab depart inter_f [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "no"
		putexcel C1= "si"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
    
		local row=`row'+26
	}


** Tasa de acc int movil
*--------------------------------------

putexcel set "BD_panel.xlsx" , sheet(acc_internet_movil) modify
local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
    
		use OSIPTEL_hogares20`x'.dta , clear
		
		di "******* AÑO 20`x' *********"
		
		gen inter_m=0 if t1!=.
		replace inter_m=1 if t1==2 | t1==3
		
		tab depart inter_m [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "no"
		putexcel C1= "si"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26

	
	}


	
	
	
	
	
*===========================================================
*Tasa de acceso de los hogares a min 1 servcio de telecom
*===========================================================


//Base 2012
use OSIPTEL_personas2012.dta,clear
gener PersonaConMóvil=0 if q12==2 | q5<12 //Se consideran a las personas a partir de 12 años
replace PersonaConMóvil=1 if q12==1 //Se consideran a las personas a partir de 12 años    
bysort ficha_st: egen Nmóvil=sum(PersonaConMóvil)
label variable Nmóvil "# de móviles X hogar"
collapse (max) Nmóvil , by(ficha_st)
gener r18=2 if Nmóvil==0
replace r18=1 if  Nmóvil!=0
sort ficha_st
save r18_2012.dta,replace
use OSIPTEL_hogares2012.dta,clear
sort ficha_st
save OSIPTEL_hogares2012.dta,replace
merge ficha_st using "r18_2012.dta"

tab  r18 [iw=fact_exp]   //Acceso a teléfono móvil por hogar

**--- Tlf movil
gen tlf_movil = r18  //Acceso a teléfono móvil por hogar

*--- Internet
gener   internet=0 if r1!=.
replace internet=1 if t1==1 | t1==2 | t1==3

*---- Tlf fija
gen tlf_fija = r1 

*---- Tv de paga
gen tv_paga = x1

drop _merge
save OSIPTEL_hogares2012.dta,replace



//Base 2013-2014
foreach i in 13 14 {
use OSIPTEL_personas20`i'.dta,clear

keep q3 q4 q5 ficha_st
sort ficha_st 
drop if q3!=1
save jh20`i'.dta,replace
use OSIPTEL_hogares20`i'.dta,clear
sort ficha_st
merge ficha_st using jh20`i'.dta


**--- Tlf movil
gen tlf_movil = r18  //Acceso a teléfono móvil por hogar

*--- Internet
gener   internet=0 if r1!=.
replace internet=1 if t1==1 | t1==2 | t1==3

*---- Tlf fija
gen tlf_fija = r1 

*---- Tv de paga
gen tv_paga = x1

drop _merge

save OSIPTEL_hogares20`i'.dta,replace

}




//Base 2015-2016


foreach i in  15 16 {
use OSIPTEL_personas20`i'.dta,clear
keep q3 q4 q5 ficha_st
sort ficha_st 
drop if q3!=1
save jh20`i'.dta,replace
use OSIPTEL_hogares20`i'.dta,clear
sort ficha_st
merge ficha_st using jh20`i'.dta


**--- Tlf movil
gen tlf_movil = r21  //Acceso a teléfono móvil por hogar

*--- Internet
gener   internet=0 if r1!=.
replace internet=1 if t1==1 | t1==2 | t1==3

*---- Tlf fija
gen tlf_fija = r1 

*---- Tv de paga
gen tv_paga = x1

drop _merge

save OSIPTEL_hogares20`i'.dta,replace


}




//2018-2021
foreach x in 18 19 21 {
	
use OSIPTEL_personas20`x'.dta,clear

keep q3 q4 q5 ficha_st
sort ficha_st 
drop if q3!=1
save jh20`x'.dta,replace
use OSIPTEL_hogares20`x'.dta,clear
sort ficha_st
merge ficha_st using jh20`x'.dta


**--- Tlf movil
gen tlf_movil = r32  //Acceso a teléfono móvil por hogar

*--- Internet
gener   internet=0 if r1!=.
replace internet=1 if t1==1 | t1==2 | t1==3

*---- Tlf fija
gen tlf_fija = r1 

*---- Tv de paga
gen tv_paga = x1

drop _merge

save OSIPTEL_hogares20`x'.dta, replace


}


//2018-2021
foreach x in 21 {
	
use OSIPTEL_personas20`x'.dta,clear

keep q3 q4 q5 ficha_st
sort ficha_st 
drop if q3!=1
save jh20`x'.dta,replace
use OSIPTEL_hogares20`x'.dta,clear
sort ficha_st
merge ficha_st using jh20`x'.dta


**--- Tlf movil
gen tlf_movil = r36 //Acceso a teléfono móvil por hogar

*--- Internet
gener   internet=0 if r1!=.
replace internet=1 if t1==1 | t1==2 | t1==3

*---- Tlf fija
gen tlf_fija = r1 

*---- Tv de paga
gen tv_paga = x1

drop _merge

save OSIPTEL_hogares20`x'.dta, replace


}



*----------------------
*----------------------
*----------------------
*----------------------

foreach x in 12 13 14 15 16 18 19 21 {
	
	use OSIPTEL_hogares20`x'.dta , clear
	
	gener   sph=0 if r1!=.
	replace sph=1 if tlf_fija==1 & tlf_movil==2 & internet==0 & tv_paga==2 //Posee 1 servicio
	replace sph=1 if tlf_fija==2 & tlf_movil==1 & internet==0 & tv_paga==2 //Posee 1 servicio
	replace sph=1 if tlf_fija==2 & tlf_movil==2 & internet==1 & tv_paga==2 //Posee 1 servicio
	replace sph=1 if tlf_fija==2 & tlf_movil==2 & internet==0 & tv_paga==1 //Posee 1 servicio
	replace sph=2 if tlf_fija==1 & tlf_movil==1 & internet==0 & tv_paga==2 //Posee 2 servicios
	replace sph=2 if tlf_fija==1 & tlf_movil==2 & internet==1 & tv_paga==2 //Posee 2 servicios
	replace sph=2 if tlf_fija==1 & tlf_movil==2 & internet==0 & tv_paga==1 //Posee 2 servicios
	replace sph=2 if tlf_fija==2 & tlf_movil==1 & internet==1 & tv_paga==2 //Posee 2 servicios
	replace sph=2 if tlf_fija==2 & tlf_movil==1 & internet==0 & tv_paga==1 //Posee 2 servicios
	replace sph=2 if tlf_fija==2 & tlf_movil==2 & internet==1 & tv_paga==1 //Posee 2 servicios
	replace sph=3 if tlf_fija==1 & tlf_movil==1 & internet==1 & tv_paga==2 //Posee 3 servicios
	replace sph=3 if tlf_fija==1 & tlf_movil==1 & internet==0 & tv_paga==1 //Posee 3 servicios
	replace sph=3 if tlf_fija==2 & tlf_movil==1 & internet==1 & tv_paga==1 //Posee 3 servicios
	replace sph=3 if tlf_fija==1 & tlf_movil==2 & internet==1 & tv_paga==1 //Posee 3 servicios
	replace sph=4 if tlf_fija==1 & tlf_movil==1 & internet==1 & tv_paga==1 //Posee 4 servicios
	replace sph=5 if tlf_fija==2 & tlf_movil==2 & internet==0 & tv_paga==2 //Sin servicios

	label variable sph "Servicios por hogar"
	label define sph 1 "Posee 1 servicio" 2 "Posee 2 servicios" 3 "Posee 3 servicios" 4 "Posee 4 servicios" /*
	*/5 "Sin servicios"  
	label values sph sph

	
	save OSIPTEL_hogares20`x'.dta , replace
	
	
}


******* Min 1 servicio
*----------------------

putexcel set "BD_panel.xlsx" , sheet(servicio_1) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
	
	use OSIPTEL_hogares20`x'.dta , clear
	
	di "********  Año 20`x' ***********"

	
	recode sph (1/4=1 "Min 1 servicio") (5=0 "Sin servicio") , g(serv_1)
	
	
		tab depart serv_1 [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "no"
		putexcel C1= "si"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26
	
	
	
	
}


*** Min 2 servicio
*----------------------

putexcel set "BD_panel.xlsx" , sheet(servicio_2) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
	
	use OSIPTEL_hogares20`x'.dta , clear
	
	di "********  Año 20`x' ***********"

	
	recode sph (2/4=1 "Min 2 servicio") (1=0) (5=0 "Sin servicio o menos") , g(serv_2)
	
	
		tab depart serv_2 [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "no"
		putexcel C1= "si"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26
	
	
	
	
}


*** Min 3 serv
*----------------------

putexcel set "BD_panel.xlsx" , sheet(servicio_3) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
	
		use OSIPTEL_hogares20`x'.dta , clear
	
		di "********  Año 20`x' ***********"

		recode sph (3/4=1 "Min 3 servicio") (2=0) (1=0) (5=0 "Sin servicio o menos") , g(serv_3)
		
		tab depart serv_3 [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "no"
		putexcel C1= "si"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26
	
	
	
	
}



	
*** Min 4 serv
*----------------------

putexcel set "BD_panel.xlsx" , sheet(servicio_4) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
	
		use OSIPTEL_hogares20`x'.dta , clear
	
		di "********  Año 20`x' ***********"

	recode sph (4=1 "Min 4 servicio") (3=0) (2=0) (1=0) (5=0 "Sin servicio o menos") , g(serv_4)
		
		tab depart serv_4 [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "no"
		putexcel C1= "si"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26
	
	
	
	
}



** Tasa de acc a Tlf fija
*--------------------------------------

putexcel set "BD_panel.xlsx" , sheet(acc_tlf_f) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
    
		use OSIPTEL_hogares20`x'.dta , clear
		
		di "******* AÑO 20`x' *********"
			
		tab depart tlf_fija [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "si"
		putexcel C1= "no"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26

	
	}

** Tasa de acc a Tlf_movil
*--------------------------------------

putexcel set "BD_panel.xlsx" , sheet(acc_tlf_m) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
    
		use OSIPTEL_hogares20`x'.dta , clear
		
		di "******* AÑO 20`x' *********"
			
		tab depart tlf_movil [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "si"
		putexcel C1= "no"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26

	
	}


** Tasa de acc a Tv de paga
*--------------------------------------

putexcel set "BD_panel.xlsx" , sheet(acc_tv_paga) modify

local row = 2


foreach x in 12 13 14 15 16 18 19 21 {
    
		use OSIPTEL_hogares20`x'.dta , clear
		
		di "******* AÑO 20`x' *********"
			
		tab depart tv_paga [iw=fact_exp] , nofreq row  matcell(int_`x') matrow(in_labeldep_`x')

		putexcel A1= "region"
		putexcel B1= "si"
		putexcel C1= "no"
		putexcel D1= "Año"
		putexcel A`row'= matrix(in_labeldep_`x')
		putexcel B`row'= matrix(int_`x')
		putexcel D`row'= 20`x'
		
	
		local row=`row'+26

	
	}



*========================================
*========================================
*========================================
*========================================
*========================================
*========================================



* Elaboramos los indicadores



*** Tasas de acceso 

*** Internet fijo 

import excel "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases\BD_panel.xlsx", sheet("acc_internet_fijo")  firstrow clear


replace Año = Año[_n-1] if missing(Año) 
drop if region==.

gen si_internet_f = si/(si+no) *100 


drop no

sort region Año
rename si si_int_f
keep region Año si_internet_f si_int_f

save inter_f.dta , replace

use inter_f.dta , clear

**** Internet movil

import excel "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases\BD_panel.xlsx", sheet("acc_internet_movil")  firstrow clear


replace Año = Año[_n-1] if missing(Año) 
drop if region==.

gen si_internet_m = si/(si+no) *100 


drop no

sort region Año
rename si si_int_m
keep region Año si_internet_m si_int_m

save inter_m.dta , replace

use inter_m.dta , clear


***** Tlf fija

import excel "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases\BD_panel.xlsx", sheet("acc_tlf_f")  firstrow clear


replace Año = Año[_n-1] if missing(Año) 
drop if region==.

gen si_tlf_f = si/(si+no) *100 


drop no

sort region Año
rename si si_tlf_f_cant
order region Año si_tlf_f si_tlf_f_cant

save tlf_f.dta , replace

use tlf_f.dta , clear


***** Tlf movil

import excel "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases\BD_panel.xlsx", sheet("acc_tlf_m")  firstrow clear


replace Año = Año[_n-1] if missing(Año) 
drop if region==.

gen si_tlf_m = si/(si+no) *100 


drop no

sort region Año
rename si si_tlf_m_cant
order region Año si_tlf_m si_tlf_m_cant

save tlf_m.dta , replace

use tlf_m.dta , clear


*** Tv de paga

import excel "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases\BD_panel.xlsx", sheet("acc_tv_paga")  firstrow clear


replace Año = Año[_n-1] if missing(Año) 
drop if region==.

gen si_tv_paga = si/(si+no) *100 


drop no

sort region Año
rename si si_tv_paga_cant
order region Año si_tv_paga si_tv_paga_cant

save tv_paga.dta , replace

use tv_paga.dta , clear



*-------------------------------------------
*------------------------------------------

* Cantidad de min 1 servicio



foreach i in 1 2 3 4 {
	
	import excel "C:\Users\JOSE\Desktop\BD_ERESTEL\Bases\BD_panel.xlsx", sheet("servicio_`i'")  firstrow clear


	replace Año = Año[_n-1] if missing(Año) 
	drop if region==.

	gen si_servicio_`i' = si/(si+no) *100 

	drop no

	sort region Año
	rename si si_cant_serv_`i'
	keep region Año si_servicio_`i' si_cant_serv_`i'

	save servicio_`i'.dta , replace

	use servicio_`i'.dta , clear

	
	
}



*-------------------------------------------

* Juntamos :)



use "C:\Users\JOSE\Desktop\Creacion de bases\Calculadas\ERESTEL Y ENAHO\Con pbi pc\Base_regiones_final.dta" , clear



*** Aceso a internet fijo
merge 1:1 region Año using inter_f.dta 
rename si_int_f si_internet_f_cant
drop _merge


*** Acc int movil

merge 1:1 region Año using inter_m.dta 
rename si_int_m si_internet_m_cant
drop _merge


** Tlf fija

merge 1:1 region Año using tlf_f.dta 
drop _merge

** Tlf movil
merge 1:1 region Año using tlf_m.dta 
drop _merge

** Tv de paga
merge 1:1 region Año using tv_paga.dta 
drop _merge


*********** Acc a servicio 

foreach i in 1 2 3 4 {
	
	merge 1:1 region Año using servicio_`i'.dta 
	drop _merge

}


replace si_internet_f = (si_internet_f[_n-1] + si_internet_f[_n+1]) /2 if missing(si_internet_f) 



*------------- Imputamos los datos

foreach x in si_internet_f si_internet_f_cant si_internet_m_cant si_internet_m si_tlf_f  si_tlf_f_cant si_tlf_m si_tlf_m_cant si_tv_paga si_tv_paga_cant si_cant_serv_1 si_servicio_1 si_cant_serv_2 si_servicio_2 si_cant_serv_3 si_servicio_3 si_cant_serv_4 si_servicio_4 {
	
	replace `x' = (`x'[_n-1] + `x'[_n+1]) /2 if missing(`x') 
	
}



label var si_internet_f "Tasa de acc a internet fijo hogares"
label var si_internet_f_cant "Cantidad de hogares con acc a internet fijo"
label var si_internet_m_cant "Cantidad de hogares con acc a internet movil"
label var si_internet_m  "Tasa de acc a internet movil hogares"
label var si_tlf_f  "Tasa de acc a tlf fija hogares"
label var si_tlf_f_cant "Cantidad de hogares con acc a tlf fija"
label var si_tlf_m "Tasa de acc a tlf movil hogares"
label var si_tlf_m_cant "Cantidad de hogares con acc a tlf movil"
label var si_tv_paga "Tasa de acc a tv de paga hogares"
label var si_tv_paga_cant "Cantidad de hogares con acc a tv de paga"


label var si_cant_serv_1 "Cantidad de hogares hogares con min 1 ss de telecom"
label var si_servicio_1 "Tasa de hogares hogares con min 1 ss de telecom"
label var si_cant_serv_2  "Cantidad de hogares hogares con min 2 ss de telecom"
label var si_servicio_2 "Tasa de hogares hogares con min 2 ss de telecom"
label var si_cant_serv_3  "Cantidad de hogares hogares con min 3 ss de telecom"
label var si_servicio_3 "Tasa de hogares hogares con min 3 ss de telecom"
label var si_cant_serv_4 "Cantidad de hogares hogares con min 4 ss de telecom"
label var si_servicio_4 "Tasa de hogares hogares con min 4 ss de telecom"

order si_internet_m si_internet_m_cant , after(si_internet_f_cant)

*------------ Guardamos la BD 

save "C:\Users\JOSE\Desktop\Creacion de bases\Calculadas\ERESTEL Y ENAHO\Con pbi pc\Base_regiones_final.dta" , replace 



clear 


use "C:\Users\JOSE\Desktop\Creacion de bases\Calculadas\ERESTEL Y ENAHO\Con pbi pc\Base_regiones_final.dta" , clear 

