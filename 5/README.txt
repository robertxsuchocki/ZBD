Zadanie 05

Zadanie było wykonywane lokalnie na własnym komputerze, na Ubuntu 16.04 i MongoDB 3.6.3, dla Scaling Factor == 0.5, czyli 0.5 GB bazy

Na dobrą sprawę są to pliki, które miały być rozwiązaniem zadania. W pliku python.py jest zaimplementowane zapytanie w mongoDB, które realizuje Q5, bez żadnych optymalizacji. Jest to czterokrotny lookup do zależnych tabel z lineitem, czyli sztuczny join pięciu tabel. Napisałem to w oparciu o materiały w internecie na temat "relacyjności" mongoDB, gdzie na dobrą sprawę lookup jest jedyną opcją na realizację złączenia tabel, które generalnie w bazie NoSQLowej nie powinno być wykonywane, jednak chciąlem tą opcję sprawdzić

Po zmniejszeniu rozmiaru bazy dziesięciokrotnie (z 5 GB do 0.5 GB) i zrobieniu wcześniej pomiarów dla PostgreSQL, bez żadnego strojenia indeksami (plik clean_half.txt) podjąłem próbę wykonania tego zapytania z pliku python.py, bez skutku (czas wykonania był znacznie powyżej mojego progu cierpliwości)

Postanowiłem zrobić zmaterializowany widok dla tablicy lineitem z 4 lookupami, ale są one wspierane przez poprzednio zainstalowaną przeze mnie wersję MongoDB (3.2.19), dlatego postanowiłem zrobić upgrade MongoDB do wersji (3.6.3). Wtedy pojawiły się problemy (mongo_fail.txt, jakieś problemy konfiguracyjne) z ponownym przywróceniem MongoDB do używalności i po ok. 2 godzinach braku postępu postanowiłem wysłać to co udało mi się ustalić. Nie wiem jak będzie wyglądała kwestia punktów w takim przypadku, ale chciałbym dokończyć to zadanie w czasie późniejszym w miarę możliwości, ale na tą chwilę przeinstalowałem same MongoDB z 20 razy przy okazji korzystając z wielu porad na stacku, bez skutku

Odnośnie samego zadania mogę podejrzewać, że samo stworzenie widoku może również wiązać się z ogromnym czasem wykonania, ale po tym samo zapytanie wiązałoby się z grupowaniem i przeliczaniem wartości revenue, ewentualnie z przefiltrowaniem danych rozmiaru tabeli lineitem i wtedy czas wykonania powinien być bliżej czasu PostgreSQL. Niestety nie jestem w stanie zrobić pomiarów

EDIT:
Można powiedzieć, że zadanie zostało przeze mnie zrobione, ale czasy są dużo gorsze nawet od tych pokazywanych na zajęciach

Najpierw stworzyłem indeksy na pk łączonych kolekcji w widoku (przez pk mam na myśli np. o_orderkey w orders, czyli klucze główne w samych danych, nie klucze główne mongo), bez których tworzenie widoku trwało ponad półtorej godziny (tzn. przerwałem wykonanie po półtorej godziny). Następnie stworzyłem widok wykonując skrypt view.py, którego wynik widać w view.txt (count wykonuję, żeby mongo faktycznie stworzyło widok i połączyło te kolekcje).

Na końcu wykonuję zapytanie Q5, wykonując skrypt q5.py 10 razy, poprzez skrypt script.sh, którego output znajduje się w mongo.txt. Skrypt nie uwzględnia cold i hot buffera, ponieważ czyszczenie wszystkich rejestrów linuxa między zapytaniami nie wpływało na czas wykonania (co więcej, czas zapytania nie zmniejszał się przy ponownych uruchomieniach skryptu, gdzie powinno wystąpić zjawisko hot buffera)

Jak widać w czasach z outputów zapytanie zwolniło ze średnio 3-4 sekund dla postgresa (output w pliku postgres.txt) do średnio 5 i pół minuty dla mongo, co daje nam ponad stukrotne spowolnienie. Zestawianie tych danych w jednym wykresie uznałem za niewiele wnoszące.
Mimo tego, że zapytanie jest wykonywane na już połączonych danych, nadal tym zapytaniem jest filter i group by z sortowaniem na stosunkowo dużych danych, co może nie być aż tak zoptymalizowane jak w przypadku baz relacyjnych
