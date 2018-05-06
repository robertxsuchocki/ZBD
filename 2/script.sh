for run in 1 2 3 4 5 6 7 8 9 10
do
	sudo service postgresql stop
	echo 3 | sudo tee /proc/sys/vm/drop_caches
	sudo service postgresql start
	echo -e '\nCOLD\n' >> $1
	psql -h localhost -U postgres -d tpch -a -f /home/robert/Code/ZBD/tpch/dbgen/queries-postgres/05.sql >> $1
	echo -e '\nHOT\n' >> $1
	psql -h localhost -U postgres -d tpch -a -f /home/robert/Code/ZBD/tpch/dbgen/queries-postgres/05.sql >> $1
done

