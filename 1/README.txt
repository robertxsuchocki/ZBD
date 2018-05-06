Raport

Testy robiłem lokalnie na swoim komputerze, na Ubuntu 16.04 i PostgreSQL 9.5, wzorując się na tutorialu ze strony http://myfpgablog.blogspot.com/2016/08/tpc-h-queries-on-postgresql.html dla Scaling Factor == 10

1. Wygenerowanie plików z danymi
./dbgen -s 10
Wygenerowanie SQLi

for i in `ls *.tbl`; do sed 's/|$//' $i > ${i/tbl/csv}; rm $i; done
Usunięcie ostatniego znaku "|" z plików *.tbl, które są powodem błędów w przypadku Postgresa

mv *.csv /media/robert/My\ Passport/ZBD
Skopiowanie plików na dysk zewnętrzny (dla rozmiarów 8+ GB brakowało miejsca na zarówno pliki z danymi oraz budowaną bazę)

2. PostgreSQL
sudo -u postgres psql postgres
Uruchomienie Postgresa

postgres=# create database tpch;
Stworzenie bazy

postgres=# \c tpch;
Połączenie się z bazą

tpch=# \i ./tpch-build-db.sql
Odpalenie SQLa tworzącego bazę z danych na dysku zewnętrznym

tpch=# \d+
Wyświetlenie powstałych tabeli

tpch=# \x on
tpch=# \timing on
Opcje do zmiany widoku wyniku zapytania i włączenia mierzenia czasu

tpch=# \i query1.sql
Odpalenie Q1 na bazie

tpch=# \q
Wyjście

Wynikiem tych kroków są pliki 1-10.txt, które są outputem powyższych komend z programu psql, a w nich rozmiar danych w bazie, wynik zapytania oraz czas trwania zapytania. Na podstawie tych plików powstał plik wyniki.pdf, który podsumowuje czasy dla wszystkich baz

Wniosek do wyników: 
Wyniki dla 8 i 9 GB w moim teście były wyższe od oczekiwanych i bardzo zbliżone do wyniku dla 10 GB, co prawdopodobnie jest spowodowane jakimś tymczasowym spowolnieniem albo większym obciążeniem systemu w czasie wykonywania dla nich testów
Wykres czasów wykonania zapytań okazał się nie być całkowicie liniowy, ale tempo wzrostu wykresu nie jest zbyt wysokie i dla 10-ciokrotnie większych danych czas wykonania zapytania jest mniej niż 15 razy większy
