#Gina Martinez (martingi@lewisu.edu)
#FIE22 paper "A Classroom Activity Ontology and Knowledge-Based Assessment Approach"
#July 30, 2022
#Query for Teamwork performance indicator: Does not interrupt others talking

PREFIX : <http://www.semanticweb.org/gina/ontologies/2022/1/ClassActivity/ds5>
SELECT (((COUNT(DISTINCT ?acttalk2)
	/COUNT(DISTINCT ?acttalk3))*100) AS ?res)
WHERE {
	?group :hasMember ?stid .						#get group# stid belongs to
	?group :hasMember ?grpmem .						#?grpmem includes all members of the group
	FILTER (?grpmem != ?stid) . 					#filter for students in the group who are not stid
	?acttalk2 a :Talking ;							#?acttalk2 is list of Talking activities of other members of the group
		:activityWithin ?lab ;
		:performedBy ?grpmem ;	
		:performedDuring ?TI2 .	 					#get talking intervals of talking activities of other members of the group
	?TI2 :hasStartTime ?TI2_start ;
		:hasStopTime ?TI2_stop .  
	?acttalk3 a :Talking ;							#?acttalk3 is list of Talking activities that are not by stid
		:activityWithin ?lab ;						#retrieve again since ?acttalk2 has been filtered for interrupted
		:performedBy ?grpmem ;	
	FILTER(?TI1_start > ?TI2_start 					#stid talks after another has started and before another stopped
		&& ?TI1_start < ?TI2_stop) .
	{ 
	SELECT ?stid ?lab ?acttalk1 
		?TI1_start ?TI1_stop
	WHERE {VALUES (?stid ?lab) {(:ID07 :Lab1)}
		?acttalk1 a :Talking ;						#get all talking intervals of student in question
			:activityWithin ?lab ;
			:performedBy ?stid ;
			:performedDuring ?TI1 .	 
		?TI1 :hasStartTime ?TI1_start ;
			:hasStopTime ?TI1_stop . 
		}      
	}    
}