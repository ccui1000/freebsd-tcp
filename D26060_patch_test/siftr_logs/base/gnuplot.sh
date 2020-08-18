#! /bin/bash

display_usage() {
	echo -e "\nUsage:\n$0 file1 [file2 file3...]"
	}

# if other than one arguments supplied, display usage
	if [  $# -lt 1 ]
	then
		echo "not enough input arguments"
		display_usage
		exit 1
	fi

# check whether user had supplied -h or --help. If yes display usage
	if [[ ( $# == "--help") ||  $# == "-h" ]]
	then
		display_usage
		exit 0
	fi

echo "generating gnuplot figure..."

# initialTimestamp=$(head -n 1 $1 | awk '{print $1}')
# echo "initial time stamp == " $initialTimestamp

gnuplot -persist << EOF

set title "TCP Congestion Control: CUBIC"
set xlabel "time (second)" offset 0,0
set ylabel "size (byte)" offset 0,0.0

set xtics nomirror
set mxtics 4
set xrange [0:150]
set ytics nomirror
set mytics 5
set yrange [0:20000000]
set autoscale fix

set style line 1 linecolor rgb 'blue' linetype 1 linewidth 1 pointtype 1 pointsize 1 pointinterval 1
set style line 2 linecolor rgb 'red' linetype 1 linewidth 1 pointtype 2 pointsize 1 pointinterval 1
set style line 3 linecolor rgb 'green' linetype 1 linewidth 1 pointtype 3 pointsize 1 pointinterval 1
set style line 4 linecolor rgb 'purple' linetype 1 linewidth 1 pointtype 4 pointsize 1 pointinterval 1000
set style line 5 linecolor rgb '#7F7F7F' linetype 3 linewidth 1 	# dashline gray

set key box opaque vertical right top reverse Left samplen 2 width 1
set boxwidth 2 relative

set term pdfcairo color linewidth 1 dashlength 1 noenhanced font "arial,18" dashed size 8in,6in
set output "ploted_chart.pdf"

# set datafile separator ","

plot    "$1" using 1:2 title "flow1 cwnd" with lines ls 1,\
        "$2" using 1:2 title "flow2 cwnd" with lines ls 2
EOF


