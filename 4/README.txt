Zadanie 04

Zadanie było wykonywane lokalnie na własnym komputerze, na Ubuntu 16.04 i MongoDB 3.2.19, dla Scaling Factor == 5, czyli 5 GB bazy

Zadanie optymalizacji Q5 planuję wykonywać w Pythonie, dlatego szukałem bazy z dobrą, ciągle wspieraną integracją z Pythonem i w końcu znalazłem MongoDB, czyli
  - baza dokumentowa w przeciwieństwie do zaproponowanej bazy Berkeley DB (klucz-wartość)
  - baza z modułem pymongo do Pythona
  - baza umożliwiająca bardzo prosty import danych dzięki wbudowanemu narzędziu mongoimport

Celem importu danych do bazy odpaliłem skrypty files.py i import.py
Plik files:
  - uruchamia skrypt dbgen, aby otrzymać pliki .tbl
  - dodaje na początek każdego pliku jedną linię z nazwami kolumn danej kolekcji w formacie .csv, które potem mongoimport użyje w celu nazwania poszczególnych pól
  - usuwa znaki '|' oddzielające kolejne wartości w liniach i zastępuje je przecinkami (przecinek to jedyny znak rozdzielający pola w rekordzie akceptowany przez mongoimport)
  - usuwa wszystkie inne przecinki w danych i zastępuje je kropkami, żeby mongoimport nie potraktowało ich jako koniec wartości i początek nowej (takie rozwiązanie jest dużo szybsze, niż dodatkowe przerabianie danych, aby przecinki były prawidłowo uwzględnione w danych)
Plik import:
  - uruchamia skrypt dbgen, aby otrzymać pliki .tbl
  - dodaje na początek każdego pliku jedną linię z nazwami kolumn danej kolekcji w formacie .csv, które potem mongoimport użyje w celu nazwania poszczególnych pól
  - usuwa znaki '|' oddzielające kolejne wartości w liniach i zastępuje je przecinkami (przecinek to jedyny znak rozdzielający pola w rekordzie akceptowany przez mongoimport)
  - usuwa wszystkie inne przecinki w danych i zastępuje je kropkami, żeby mongoimport nie potraktowało ich jako koniec wartości i początek nowej (takie rozwiązanie jest dużo szybsze, niż dodatkowe przerabianie danych, aby przecinki były prawidłowo uwzględnione w danych)

Output tych skryptów widać w plikach usage_files.txt i usage_import.txt. Wyniki funkcji count i findOne (pokazanie pierwszego rekordu) na wszystkich nowo utworzonych kolekcjach w MongoDB znajdują się w pliku usage_mongodb.txt

Czas importu danych do MongoDB w moim przypadku to 33m18.910s, w porównaniu do 12:52.94 w PostgreSQL (postgres_import.txt)

Dodatkowo w pliku python.py widać bardzo proste zapytanie do bazy właśnie w języku Python, ale widać na nim dość nieefektywny czas działania takiej bazy, skrypt wykonuje się 0m10.241s (usage_python.txt), podczas gdy w Postgresie podobne zapytanie trwa 15,722 ms (postgres_select.txt)

Już najprostsze wyciągnięcie jednego rekordu z bazy jest dużo wolniejsze w MongoDB. Od szybkości działania takiej bazy przy prawdziwych zapytaniach bardzo może zależeć od tego jak dane są przechowywane. W tym momencie dane w mojej bazie zostały wrzucone bezpośrednio jak w tabelach SQLowych, z numerami id w kolumnach. Będzie to miejsce do obserwacji i ewentualnej poprawy w następnym zadaniu
