# Temperature-monitoring

Homework from 'Computer Architecture' course

				Tema 1 - AC - Monitorizare temperatura

		Tema a fost implementata cu ajutorul a 4 module, 3 care au un continut specific (pentru
	citirea datelor de la senzori, realizarea unei medii aritmetice - impartire cu rest,
	afisarea intr-o forma codificata a temperaturii aproximate) si unul de top care are rolul 
	de a realiza conexiunea intre cele 3. 
	
		Modulul <<sensors_input>> preia informatia de la senzori si realizeaza suma temperaturilor
	primite de la fiecare senzor activ si calculeaza numarul de senzori activi. Aici am considerat
	un parametru care reprezinta numarul total de senzori care poate varia din prisma implementarii
	bonusului, caruia i-am ales valoarea default 200 - nr. maxim de senzori. Am setat inputul
	la o dimensiune adaptata in functie de acest parametru. In continuare, se creeaza temperatura
	pentru fiecare senzor pe 8 biti prin concatenare din sensors_data_i si se aduna la o suma
	daca senzorul respectiv are bitul de enable activ (adica 1). Tot aici se calculeaza si numarul
	de senzori activi in for-ul considerat care merge pana la numarul de senzori (valoare constanta).
	Cum toata implementarea a fost realizata intr-un bloc always pe registre, folosesc la sfarsit
	atribuirea continua pentru a oferi valorile calculate output-urilor.

		Modulul <<division>> calculeaza media aritmetica a temperaturilor primite de la senzori, calculata
	prin impartire cu rest prin intermediul algoritmului 'long division' (in acest caz 'integer 
	division' pt numere fara semn), unde deimpartitul si impartitorul sunt valori reprezentate pe 16
	biti. Algoritmul consta intr-un for in care, in principal, se compara restul cu impartitorul. 
	Analog modulului trecut, implementarea se face intr-un always deci se face atribuire continua 
	pentru a furniza valorile output-ului din registrii. 
	
		Modulul <<output_display>> aproximeaxa valoarea medie obtinuta la impartire la intregul cel
	mai apropiat si afiseaza informatia codificata. Implementarea aproximarii valorii medii se face
	intr-un always prin compararea restului obtinut la impartire cu jumatatea impartitorului;
	daca restul e mai mare sau egal decat aceasta, temperatura aproximata ia valoarea catului + 1.
	Altfel ia doar valoarea catului. Temperatura va fi codificata conform modului scara din cerinta.

	 	Modulul <<temperature_top>> realizeaza conexiunea celorlalte 3 module prin instantierea
	lor corespunzatoare si legarea prin intermediul unor variabile care functioneaza atat ca valori
	de input si cat de output pentru aceste instante.
	
	FEEDBACK: tema interesanta, aplicata
