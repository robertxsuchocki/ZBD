Zadanie 10

Zadanie było wykonywane lokalnie na własnym komputerze, na Ubuntu 18.04 i Neo4j 3.4.0, dla Scaling Factor == 0.5, czyli 0.5 GB bazy

Neo4j zainstalowałem postępując zgodnie z instrukcjami na stronie: https://neo4j.com/docs/operations-manual/current/installation/linux/debian/. Za pomocą plików files.py i friendship.py stworzyłem pliki csv, które zawierają dane do bazy. import_csv.cypher to plik zawierający wszystkie komendy, które tworzą bazę na podstawie tych plików zgodną ze schematem z zajęć (plik stworzony w oparciu o: https://neo4j.com/developer/guide-importing-data-and-etl/)

Na import_csv.cypher składają się:
  - utworzenie węzłów z tabel customer, lineitem, nation, orders, part, region, supplier
  - utworzenie indeksów na tych węzłach
  - utworzenie połączeń pomiędzy węzłami z tabel friendship (Customer->Customer) i partsupp (Supplier->Part)
  - utworzenie pozostałych połączeń wynikających z kluczy obcych (łącznie 7, w tym po 3 dla lineitem i nation)

Na końcu, w pliku cypher-shell-result.txt znajdzie się wynik polecenia `time cypher-shell -u neo4j -p neo4j < /home/robert/Code/ZBD/10/import_csv.cypher`.

W chwili wysyłki powyższe polecenie ciągle się wykonuje, doślę jego wynik po zakończeniu działania. Nie wykluczam ponadto drobnych, literówkowych błędów w tym skrypcie i błędów w działaniu, ale ze względu na problemy z autoryzacją neo4j na moim komputerze i dostępem do samego shella nie udało mi się znaleźć czasu na testowanie tych poleceń na mniejszych danych, dlatego skrypt po napisaniu i pokonaniu tych problemów z shellem został od razu puszczony na całych danych. Ewentualne błędy niezwłocznie poprawię, ale na tą chwilę postanowiłem wysłać wyniki mojej dotychczasowej pracy
