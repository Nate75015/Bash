#!bin/bash


DATE='/bin/date'

echo "Ce script à pour but de comparer le temps d'execution de votre modèle pour un nombre d'enregistrement qui varie. 
Saisissez le chemin dans lequel se trouve votre modèle.
ex : /Users/damienmarque/Stage/Deuxième-Partie/PMML/RF_Final.pmml"
read cheminmodele

echo "Saisir le chemin dans lequel vous voulez mettre vos résultats.
ex : /Users/damienmarque/Stage/Deuxième-Partie/PMML/Resultat3.csv"
read cheminresultat


if [ -f $cheminmodele ]; then
   echo "Le modèle existe. On va donc executer le script. Soyez patient ca peut prendre du temps."
else
   echo "Le modèle n'existe pas. Fin du programme ! ."
   exit
fi



for nombreligne in '1' '5' '10' '50' '100' '500' '1000' '2000' '4000' '5000' '7000' '10000' '20000' '30000' '40000' '50000'


do
	echo "avg_11;var_11;N_DaysNegatif_11;S_Negatif_11;N_TRX_ALL_11;S_DEBIT_ALL_11;S_TRX_ALL_11;P_DEBIT_ALL_11;S_TRX_EPARGNE_11;N_TRX_CREDITS_11;S_DEBIT_CREDITS_11;S_CREDIT_CREDITS_11;S_TRX_CREDITS_11;P_DEBIT_CREDITS_11;QCPTSAGED02;QCPTSAGED03;QCPTSAGED04;MSAGED53;MADMPRIF;MSAGED51;MSAGED63;MACMAFF;STATUT_RC;menage_multi;NSCO064_1;NSCO064_2;NSCO064_3" > Entre.csv
	for i in `seq 1 $nombreligne`;
 		do echo "-5792.185;76864.9952465517;30;-173765.55;30;-1090.81;41.5899999999999;49.06;1.58999999999993;1;0;40;40;0;0;0;1;1395;293;1395;0;293;1;0;1;0;0" >> Entre.csv 
 	done	

		BEFORE=$($DATE +'%s')

		java -Xms256m -Xmx2g -cp example-1.3-SNAPSHOT.jar -XX:-UseGCOverheadLimit org.jpmml.evaluator.EvaluationExample --model $cheminmodele --input Entre.csv --output $cheminresultat

		# Compute and display the elapsed time
		AFTER=$($DATE +'%s')
		
		ELAPSED=$(($AFTER - $BEFORE))
		echo "Votre modèle mais $ELAPSED secondes pour traiter $nombreligne enregistrement(s)."
		echo $ELAPSED >> ResultatTemps.csv
		echo $i >> ResultatNombreligne.csv
		rm  Entre.csv
		
     
done
paste -d ' ' 'ResultatTemps.csv' 'ResultatNombreligne.csv' > $cheminresultat
rm ResultatTemps.csv
rm ResultatNombreligne.csv
echo "Fin du script."
exit 0


