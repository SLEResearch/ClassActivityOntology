#Gina Martinez (martingi@lewisu.edu)
#FIE22 paper "A Classroom Activity Ontology and Knowledge-Based Assessment Approach"
#Aug 1, 2022
#Query for Ethics performance indicator: Does not make up data

PREFIX : <http://www.semanticweb.org/gina/ontologies/2022/1/ClassActivity/ds5>
SELECT (((COUNT(DISTINCT ?minpdiff))/(COUNT(DISTINCT ?actrep2))) as ?out2)
WHERE{
  ?actrep2 a :ReportingData ;		#retrieve again all Reporting acts of stid
    :activityWithin ?lab1 ;
    :performedBy ?stid1 .  
  {
  SELECT (min(?percentdiff) AS ?minpdiff)
    (sample(?stid) as ?stid1)
	(sample(?lab) as ?lab1)
  WHERE{
    SELECT *#?actmeasure ?actrep ?timediff ?percentdiff #(min(?percentdiff) AS ?minpdiff) (COUNT(?minpdiff) AS ?output1) (COUNT(DISTINCT ?actrep2) AS ?output2)
    WHERE{
        #look for measuring circuit quantities done by group
		?group :hasMember ?stid .	
		?group :hasMember ?grpmems .	
        ?actmeasure :performedBy ?grpmems ;		#get MeasuringCircuitQuantity acts done by group
            a :MeasuringCircuitQuantity ;
            :performedAt ?actmeastime ;
            :activityWithin ?lab ;
            :getsMeasuredValue ?measuredvals ;
            :measuresQuantity ?meascirqty .
		?temp1 :performedAt ?reporttime .		#these do nothing, just to access subquery variables; otherwise, BIND cant access it for some reason
		?temp2 :reportsFieldValue ?reportvals .
        BIND(?reporttime - ?actmeastime AS ?timediff) .	#get time diff between each Reporting act and Measuring act
        BIND((abs(?measuredvals-?reportvals)/((?measuredvals+?reportvals)/2))*100 AS ?percentdiff) . #calculate percent difference between measured and reported values
        FILTER(?timediff >= 0  && ?timediff <= ?maxtimewin && ?percentdiff<?maxpercentdiff && ?meascirqty = ?repcirqty) . #value was measured before and within time window
      { #get reporting data activities done by stid
        SELECT *#?stid ?lab ?maxtimewin ?maxpercentdiff ?actrep ?reporttime ?reportfield ?repcirqty ?reportvals ?actrep2
        WHERE { VALUES (?stid ?lab ?maxtimewin ?maxpercentdiff) {(:ID08 :Lab1 100 5)}
          ?actrep a :ReportingData ;	#ReportingData acts done by stid
              :activityWithin ?lab ;
              :performedBy ?stid ;
              :performedAt ?reporttime ;
              :updatesField ?reportfield ; #get the report fields updated by stid
              :reportsFieldValue ?reportvals .
          ?reportfield :reportsCircuitQuantity ?repcirqty ;
              :reportOf ?lab .

        }
      }
    }
  } GROUP BY ?actrep }
}

