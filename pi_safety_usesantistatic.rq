#Gina Martinez (martingi@lewisu.edu)
#FIE22 paper "A Classroom Activity Ontology and Knowledge-Based Assessment Approach"
#Aug 1, 2022
#Query for Safety performance indicator: Proactively uses antistatic mat and wristband

PREFIX : <http://www.semanticweb.org/gina/ontologies/2022/1/ClassActivity/ds5>
SELECT ?result 		 
WHERE { VALUES (?stid ?lab ?prid) {(:ID03 :Lab1 :ID13)} # specify desired student 
?prompt1 :generatesPrompt :PutOnWristBand ; # prompt from instructor is :PutOnWristBand at time ?PromptT
	:performedAt ?prompt1t ;
	:performedBy ?prid ;
	:activityWithin ?lab .
?studentWearsBand a :UsingCarriedItem ;  # activity of type :UsingCarriedItem, specifically the antistatic band
	:activityWithin ?lab ;
	:carriesItem :AntistaticBand ;
	:performedBy ?stid ; # specify performed by desired student 
	:performedDuring ?timeInt1 . 
?timeInt1 :hasStartTime ?t1start .
?prompt2 :generatesPrompt :UseMat ; # prompt from instructor is :PutOnWristBand at time ?PromptT
	:performedAt ?prompt2t ;
	:performedBy ?prid ;
	:activityWithin ?lab .
?studentUsesMat a :UsingStaticItem ;  # activity of type :UsingCarriedItem, specifically the antistatic band
	:activityWithin ?lab ;
	:usesItemInPlace :AntistaticMat ;
	:performedBy ?stid ; # specify performed by desired student 
	:performedDuring ?timeInt2 . 
?timeInt2 :hasStartTime ?t2start .	
?lab :scheduledOn ?labti .
?labti :hasStopTime ?labend .
BIND( COALESCE(
  IF(?prompt1t > ?t1start && ?prompt2t > ?t2start, "exceeds expectations", 1/0), #but both on before prompts
  IF((?prompt1t > ?t1start && ?prompt2t <= ?t2start && ?t2start < ?labend)|| #put band before, mat after but before lab end
	 (?prompt1t <= ?t1start && ?prompt2t > ?t2start && ?t1start < ?labend), "meets expectations",1/0), #put mat before, band after but before lab end
  IF(?t1start < ?labend && ?t2start < ?labend, "needs improvement",1/0), #put both on some time during lab, after prompts
	 "unacceptable") AS ?result)
} 