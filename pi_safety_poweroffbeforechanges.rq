#Gina Martinez (martingi@lewisu.edu)
#FIE22 paper "A Classroom Activity Ontology and Knowledge-Based Assessment Approach"
#Github copy aug 1, 2022
#Query for Safety performance indicator: Turns off circuit power before making changes 

PREFIX : <http://www.semanticweb.org/gina/ontologies/2022/1/ClassActivity/ds5>
SELECT ((COUNT(DISTINCT ?acttocp)/COUNT(DISTINCT ?actmcc)) AS ?output) 
WHERE
{
   ?group :hasMember ?stid1 .	#grpnum returns group number of stid
   ?group :hasMember ?grpmems .	#grpstus returns all members of the group
   ?actmcc :performedBy ?grpmems ;	#actmcc returns all MakingCircuitChanges done by all students in group 	
           :activityWithin ?lab1 ;
           a :MakingCircuitChanges .
   ?acttocp a :TurningOffCircuitPower ; #acttocp returns all TurningOffCircuitPower performed by students in the group 
            :activityWithin ?lab1 ;
            :performedBy ?grpmems ;	
    		:performedAt ?acttocptime . #get timestamp for each TurningOffCircuitPower by the group members
   FILTER (?acttocptime = ?timelastactbefore) #filter for TurningOffCircuitPower activities that match timestamp of activities determined to be immediately preceding a MakingCircuitChanges
   {
	  SELECT ?actmcctime (min(?timediff) as ?lastActTimeDiff) (?actmcctime-?lastActTimeDiff AS ?timelastactbefore) (sample(?stid) AS ?stid1) (sample(?lab) AS ?lab1)    
      WHERE 
      {
        ?actmcc :performedBy ?stid ;	#actmcc returns all MakingCircuitChanges done by student
                a :MakingCircuitChanges ;
                :activityWithin ?lab ;
                :performedAt ?actmcctime .	#actmcctime returns the timestamps MakingCircuitChanges activities are done by group
		?temp1 :performedAt ?actalltime .
        #get time difference between every combination MakingCircuitChanges and all other activities done by the group
        #the activity with the smallest positive time difference between each MakingCircuitChanges is the activity immediately preceding it
        #we are assuming that the events MakingCircuitChanges,TurningOffCircuitPower,TurningOnCircuitPower cannot have the exact same timestamp
        BIND((?actmcctime - ?actalltime) AS ?timediff) . FILTER(?timediff > 0)  
        {
          SELECT *	#actall returns all MakingCircuitChanges,TurningOffCircuitPower,TurningOnCircuitPower activities done by the group, along with respective times ?actalltime
          WHERE 
            {VALUES (?stid ?lab) {(:ID10 :Lab1)}
              ?group :hasMember ?stid .			#grpnum returns group number of stid
              ?group :hasMember ?grpmems .		#grpstus returns all members of the group
              ?actall :performedBy ?grpmems ;	#actall returns all activities performed by members of the group
                    a ?acttype ;
                    :activityWithin ?lab ;
                    :performedAt ?actalltime .	#get timestamps of each activity
              FILTER (?acttype IN (:MakingCircuitChanges, :TurningOffCircuitPower, :TurningOnCircuitPower)) . #filter for only these activities
             }
         }
       } 
       GROUP BY ?actmcctime  #this is for the MIN aggregate used in the SELECT portion; find the MIN time difference for each MakingCircuitChanges activity 
    }
}