Zadanie 06

Zadanie było wykonywane lokalnie na własnym komputerze, na Ubuntu 16.04 i PostgreSQL 9.5, dla Scaling Factor == 0.5, czyli 0.5 GB bazy


1. Stworzenie bazy friendship

Plik result.csv z danymi do bazy friendship generuje skrypt friendship.py (uruchamiany przez ./friendship.py SF, gdzie w miejsce SF trzeba wpisać interesujący scaling factor, w moim przypadku 0.5). Output (czas trwania wzięty z komendy time) skryptu znajduje się w pliku gen_out.txt. Znajomości są tworzone w taki sposób:
  1) najpierw są tworzone początkowe grupy znajomych (w skrypcie 10), gdzie w danej grupie każdy jest znajomym z każdym
  2) następnie dla każdego użytkownika dodatkowo wybiera się jakąś jedną inną grupę i tworzy znajomości między nim, a wszystkimi członkami tej dodatkowej grupy,
  jest to podejście początkowe, do przemyślenia jest ile dodatkowych grup powinniśmy losować do stworzenia dodatkowych znajomości (prawdopodobnie więcej niż 1) i ile znajomości powinniśmy w danej grupie nawiązać (prawdopodobnie nie wszystkie, a tylko z niektórymi członkami)
  3) na końcu dodajemy jakieś losowe znajomości, u mnie 7 na daną osobę,
  początkowo miało być 6 znajomych w punkcie 3), co idealnie dałoby średnio 42 znajomych na osobę, ale w punkcie 2) i 3) w obecnej implementacji zdarzają się liczne duplikaty, które byłyby trudne do uniknięcia, dlatego liczba jest zbliżona do 42, a duplikaty są na końcu usuwane co zmniejsza ilość potencjalnie utworzonych znajomości, ale daje również pewną losowość w ilości znajomości dla poszczególnych osób

W ten sposób parę znajomości jest losowych, ale wiele znajomości wynika z bycia w jakiejś konkretnej grupie znajomych, gdzie każdy się zna, ale również przynależenia do innych grup, do których reszta znajomych z twojej domyślnej grupy należeć nie będzie

W pliku friendship_table_build.sql znajduje się gotowy SQL do uruchomienia na istniejącej bazie w PostreSQL, w którym dodatkowo widać strukturę rekordów przechowujących informację o znajomościach użytkowników (dwa custkey znajomych z tabeli customer i pk). Output PostgreSQL, a w nim czasy i ilość utworzonych wierszy znajduje się w pliku postgres_out.txt, a lista relacji z rozmiarem nowej tabeli znajduje się w pliku tables_out.txt


2. Propozycje rekomendacji

  1) produkty kupione ostatnio przez znajomych z największą liczbą wspólnych znajomych (np. pierwszych 5 znajomych z największą liczbą wspólnych, dalsze kryteria dowolne)
  2) produkty kupione przez największą ilość znajomych (dość oczywiste, ale intuicyjnie wydaje się skuteczne, po ilości znajomych na produkt)
  3) produkty ostatnio kupione przez wszystkich znajomych (czyli najświeższe zakupy znajomych, gdzie można produkt zareklamować jako kupiony WCZORAJ przez twojego znajomego)
  4) produkty procentowo cieszące się większym zainteresowaniem twoich przyjaciół w porównaniu do wszystkich użytkowników (np. produkt X kupiło 0.13% wszystkich użytkowników, ale 2.08% znajomych, więc można go uznać za potencjalnie 16 razy bardziej trafny niż dla losowego użytkownika)
  5) wszelkie pomysły zakładające obecność innych relacji w bazie, a nie tylko friendship, np. przy drzewiastej strukturze kategorii produktów, wyświetlanie produktów z kategorii, w której były produkty kupione ostatnio przez użytkownika / jego znajomych
