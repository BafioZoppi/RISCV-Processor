# RISCV-Processor

Ho realizzato questo progetto nel mese di luglio 2024 per l'esame di Computer Architecture for Physics nella laurea magistrale in Fisica presso La Sapienza (Roma).  
Lo scopo del progetto è quello di progettare e simulare un processore RISCV in VHDL.  
La richiesta più ardua di questo progetto riguarda la realizzazione di una pipeline.  
Non è richiesto di implementare tutte le istruzioni dell'ISA di RISCV, ma mi è stato permesso di implementare solo un numero ristretto di istruzioni, tale da permettermi di eseguire un algoritmo di bubble sort.

Includo in questo repo una tesina descrittiva del progetto, che descrive in breve le mie scelte nella realizzazione del progetto stesso.

## Compilare il progetto

I comandi necessari per analizzare e eseguire il mio codice, implementati nel makefile, sono i seguenti:

make clean  --> rimuove il file work-obj93.cf e tutti gli output delle simulazioni  
make        --> analizza l'intero progetto  
make test   --> esegue tutti i testbench  
make run    --> esegue il bubble sort  

Gli output delle simulazioni si trovano nella cartella testbenches  
In particolare l'output del bubble sort è in testbenches/processor/bubble_sort.ghw
