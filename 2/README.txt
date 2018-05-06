Zadanie 02


Zadanie było wykonywane lokalnie na własnym komputerze, na Ubuntu 16.04 i PostgreSQL 9.5, dla Scaling Factor == 5, czyli 5 GB bazy


Zadanie zacząłem przez wyświetlenie sobie planu zapytania (plik old_plan.txt) w bardziej czytelnej formie i po skorzystaniu ze strony explain.depesz.com otrzymałem plan z policzonymi czasami dla każdej operacji (plik old_plan_colorized.png). Widać na nim, że 47 z 51 sekund zużywa Index Scan na złączeniu tabel lineitem i orders po polu orderkey i próbowałem to zoptymalizować tworząc indeksy na orderkey właśnie w obu tabelach
Dodatkowo chciałem zająć się Seq Scanem na orders, który jest spowodowany warunkiem na orderdate w zapytaniu i przy okazji indeksowania tabeli orders przyspieszyć wykonanie tego warunku tworząc indeks odfiltrowujący od razu pewne dane


Pomiary wykonywałem plikiem script.sh, który w pętli 10 razy:

1. na początku resetuje cache systemowy, ponieważ PostreSQL nie ma własnych funkcji na czyszczenie cache'a, dlatego musimy usunąć cały cache systemu Ubuntu wykonując taki ciąg komend

	sudo service postgresql stop
	echo 3 | sudo tee /proc/sys/vm/drop_caches
	sudo service postgresql start

2. następnie wykonuje zapytanie Q5 dwa razy (pierwszy pomiar to cold, a drugi hot buffer) i wyniki wraz z czasem zapisuje do pliku podanego przy odpalaniu skryptu (ustawienia wyświetlenia wyniku i przede wszystkim włączenia pomiaru czasu znajdują się w pliku .psqlrc)

dzięki czemu w pliku wyjściowym otrzymamy naprzemiennie czasy dla cold i hot buffer.


Wszystkie pliki w folderze results są outputami script.sh z doklejonymi na początku komendami dodającymi testowane indeksy, jeśli takie były. Odpowiednie pliki to:

	- clear.txt - brak indeksów, pomiar zapytania Q5 na czysto do porównań
	- o_orderkey.txt - indeks na kolumnę o_orderkey w tabeli orders
	- o_cond_orderkey.txt - indeks jw, ale odfiltrowujący po warunku na orderdate z zapytania
	- l_orderkey.txt - indeks na kolumnę l_orderkey z tabeli lineitem
	- l_o_cond_orderkey.txt - dwa indeksy: na l_orderkey i odfiltrowujący na o_orderkey

Spisane wyniki z plików z folderu results wraz z wykresami można znaleźć w pliku results.pdf
Dodatkowo plik new_plan.txt zawiera plan wykonania wygenerowany przez PostgreSQL po utworzeniu indeksów i z uaktualnionymi czasami w planie (oba plany były również robione po wyczyszczeniu cache'a), a plik new_plan_colorized.png to znowu bardziej czytelna forma planu z new_plan.txt


Wnioski do wyników:
1. Indeks na o_orderkey w tabeli orders, zarówno dla cold i hot buffer dawał lepsze rezultaty w wersji odfiltrowującej niepasujące rekordy (i do tego czas utworzenia indeksu był mniejszy), indeks bez odfiltrowania dawał niewielki zysk, ale z oczywistych względów indeks odfiltrowujący nie będzie miał zastosowania przy zapytaniu Q5 w przypadku gdy zmieni się warunek na orderdate i znajdujące się tam daty
2. Zarówno dla cold i hot buffer najlepsze czasy dawało zastosowanie obu indeksów, ale wnioskując z czasów przy użyciu ich osobno, dla cold buffer największe przyspieszenie daje indeks na lineitem, a dla hot buffer odfiltrowujący na orders
3. W każdym przypadku procentowo więcej zyskują zapytania na hot buffer
4. Zapytania z użyciem dwóch indeksów mają czasy o ~11% mniejsze w przypadku cold buffer i ~29% mniejsze w przypadku hot buffer


W planie zapytania również widać poprawę:
1. Seq Scan na tabeli orders został zastąpiony Index Scanem używającym utworzony przez nas odfiltrowujący indeks na orders
2. Index Scan na lineitem wykonywany jest przy użyciu naszego indeksu na tej tabeli i znacząco spadły czasy wykonania dla tej operacji (co szczególnie widać na new_plan_colorized.png)
3. Czas wykonania zapytania na planie jest jeszcze lepszy od tego, który wyszedł z testów


Inne uwagi:
1. Pozostałe metody jakich próbowałem, czyli indeksy na innych kolumnach i manipulacje samym zapytaniem (takie, jakie mi przyszły do głowy) dawały żaden albo znikomy zysk czasowy w porównaniu do indeksów użytych w tym rozwiązaniu
2. To rozwiązanie oczywiście zakłada, że indeksowanie nie wlicza się do czasu wykonania samego zapytania i przed pomiarami możemy te indeksy potworzyć (utworzenie obu indeksów jednocześnie zajęło mi 48 sekund, czyli średni czas samego zapytania z użyciem tych indeksów)

