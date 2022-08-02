#Gina Martinez (martingi@lewisu.edu)
#FIE22 paper "A Classroom Activity Ontology and Knowledge-Based Assessment Approach"
#Aug 1, 2022
#Query for Teamwork performance indicator: Contributes to group work

PREFIX : <http://www.semanticweb.org/gina/ontologies/2022/1/ClassActivity/ds5>
SELECT  (((COUNT(DISTINCT ?act)/COUNT(DISTINCT ?groupact))*100) AS ?contribution) 
WHERE { VALUES ?stid {:ID10} 
	?group :hasMember ?stid .	#get IDs of all members of the group stid belongs to
	?group :hasMember ?grpmem . 
	?groupact :performedBy ?grpmem .	#get activities of all members of the group
    ?groupact a ?acttypeall .
	?act :performedBy ?stid .			#get activities done just by stid
	?act a ?acttypestid . 
	FILTER (?acttypeall IN (:MeasuringCircuitQuantity, :Talking, :ReportingData, :MakingCircuitChanges, :TurningOffCircuitPower, :TurningOnCircuitPower)) .	#filter activities just for these types
	FILTER (?acttypestid IN (:MeasuringCircuitQuantity, :Talking, :ReportingData, :MakingCircuitChanges, :TurningOffCircuitPower, :TurningOnCircuitPower)) .
}
