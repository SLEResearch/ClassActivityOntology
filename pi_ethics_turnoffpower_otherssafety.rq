#Gina Martinez (martingi@lewisu.edu)
#FIE22 paper "A Classroom Activity Ontology and Knowledge-Based Assessment Approach"
#July 30, 2022
#Query for Ethics performance indicator: Proactively turns off power supply at the end of the course activity for the safety of others

PREFIX : <http://www.semanticweb.org/gina/ontologies/2022/1/ClassActivity/ds5>
SELECT (COUNT(DISTINCT ?actall) AS ?turnedoff)
WHERE{ ?instructor a :Instructor .
  ?promptend :performedBy ?instructor ;			#determine when instructor prompted to turn off circuit at end of course activity
	a :InstructorPrompting ;
	:generatesPrompt :TurnOffCircuit ;
	:performedAt ?prompttime .
  ?actall a ?acttype2 .
  ?actall :performedAt ?lastact .
  FILTER (?acttype2 = :TurningOffCircuitPower 	#determine if last activity of group before end of course activity is "turn off power"
	&& ?lastact < ?prompttime){
	SELECT DISTINCT ?actall ?acttime
	WHERE{ VALUES (?stid ?lab) {(:ID07 :Lab1)}
	  ?group :hasMember ?stid . 				#find student members of the group stid belongs to
	  ?group :hasMember ?grpmem .  
	  ?actall :performedBy ?grpmem ;
		a ?acttype ;
		:performedAt ?acttime ;
		:activityWithin ?lab .
	  FILTER(?acttype IN (						#find "circuit changer" activities performed by members of the group
		:MakingCircuitChanges, 
		:TurningOffCircuitPower, 
		:TurningOnCircuitPower)) .
	}ORDER BY DESC(?acttime) LIMIT 1 }}			#find the last "circuit changer" activity performed by group


