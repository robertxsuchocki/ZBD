rm postgres_out.txt
for run in 1 2 3 4 5 6 7 8 9 10
do
	sudo service postgresql stop
	echo 3 | sudo tee /proc/sys/vm/drop_caches
	sudo service postgresql start

  gawk -i inplace 'NR==1,/ [0-9]+ /{sub(/ [0-9]+ /, " '"$run"' ")} 1' query.sql

  sleep 5

	echo -e '\nCOLD\n' >> postgres_out.txt
	psql -h localhost -U postgres -d tpch -a -f query.sql >> postgres_out.txt
	echo -e '\nHOT\n' >> postgres_out.txt
	psql -h localhost -U postgres -d tpch -a -f query.sql >> postgres_out.txt
done
