Zadanie 08

Zadanie było wykonywane lokalnie na własnym komputerze, na Ubuntu 16.04, PostgreSQL 9.5 i MongoDB 3.6.3, dla Scaling Factor == 0.5, czyli 0.5 GB bazy

Ze względu na dużą dowolność w tym zadaniu założyłem następujące rzeczy. Stwierdziłem, że przetestuję zapytania dla jednej osoby, zatem zakładamy brak tworzenia offline'owych tabel rekomendacji tylko symulujemy online'owe zapytanie dla danej osoby. Ma to sens ze względu na to, że taka tabela rekomendacji musiałaby być aktualizowana non stop, a limit takich rekomendacji do sensownych 20 daje nam czas wykonania zapytania w granicach rozsądku w kwestii zapytania strony. Dodatkowo naraz sprawdzam podobieństwo użytkowników oraz ich znajomość (tylko pierwszego stopnia, chciałem zrobić testy zapytania moim zdaniem rozsądnego z codziennego punktu widzenia, a nie uważam za miarodajne rekomendacje na podstawie zakupów znajomych znajomych), ale w sprawdzaniu podobieństwa nie uwzględniam narodowości użytkowników (ten warunek zerował mi jakiekolwiek wyniki, z praktycznego natomiast punktu widzenia znaczenie narodowości jest niwelowane przez uwzględnianie znajomości, które będą w zdecydowanej większości z ludźmi z tego samego kraju)

Odnośnie rezultatów:
  - mongoimport_script.py to plik, który importuje tabelę friendship do bazy MongoDB (czego wcześniej nie musiałem robić), a mongoimport_out.txt jest outputem tego skryptu
  - query.sql i query.py to zapytania napisane odpowiednio dla Postgresa i Mongo
  - postgres_indexes.sql i mongo_indexes.py to pliki, za pomocą których utworzyłem indeksy w obu bazach na potrzebnych tabelach
  - postgres_script.sh i mongo_script.sh to pliki, które wykonują 10-ciokrotnie zapytanie dla użytkowników o kolejnych id od 1 do 10
  - postgres_noindexes_out.txt i mongo_noindexes_out.txt to wyniki powyższych skryptów na bazach bez indeksów
  - postgres_out.txt i mongo_out.txt to wyniki z indeksami
  - results.pdf zawiera wszystkie wyniki z powyższych plików i kilkoma wykresikami

Wnioski:
  - Mongo nie jest już 100 razy wolniejsze od Postgresa, ale nadal jest to 5 razy dłuższy czas wykonywania zapytania w porównaniu do Postgresa na zimnym buforze (czyli najbardziej sprawiedliwe porównanie, jako że przy wielokrotnych wykonaniach skryptów pythonowych korzystających z Mongo nie wystąpiło zjawisko hot buffera)
  - Mongo na indeksach ma czas porównywalny do Postgresa bez indeksów
  - Mongo na indeksach wykonuje zapytanie w czasie nieco ponad pół sekundy, co można uznać za akceptowalne dla online'owego generowania rekomendacji (i standardów szybkości stron w ostatnich latach)
  - jest to lepsze zapytanie dla Mongo niż Q5, ale nadal w dość dużym stopniu korzysta z relacyjności danych, do których nie został stworzony. Niewykluczone, że lepsze wyniki zanotowałby przy poszukiwaniu znajomości kolejnych stopni, ale jak wspomniałem na początku w tym konkretnym zadaniu nie chciałem implementować tego rozwiązania
