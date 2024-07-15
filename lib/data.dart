Map<String, String> mapFileToContents = {
  'Biology-Barbara-temp-1.0.json': '''
{
   "biology":{
      "AAA":[
         {
            "major premise":"All birds are animals",
            "minor premise":"All swans are birds",
            "conclusion":"All swans are animals",
			"incorrect conclusions": [
            "All animals are swans",
            "Some animals are not birds",
            "There are birds that are not animals",
            "Some swans are not animals"
			]
         },
         {
            "major premise":"All mammals are vertebrates",
            "minor premise":"All dogs are mammals",
            "conclusion":"All dogs are vertebrates",
			"incorrect conclusions": [
            "All vertebrates are dogs",
            "Some vertebrates are not mammals",
            "There are mammals that are not vertebrates",
            "Some dogs are not vertebrates"
			]
         },
         {
            "major premise":"All reptiles lay eggs",
            "minor premise":"All snakes are reptiles",
            "conclusion":"All snakes lay eggs",
			"incorrect conclusions": [
            "All eggs are snakes",
            "Some eggs are not reptiles",
            "There are reptiles that do not lay eggs",
            "Some snakes do not lay eggs"
			]
         },
         {
            "major premise":"All plants have chlorophyll",
            "minor premise":"All trees are plants",
            "conclusion":"All trees have chlorophyll",
			"incorrect conclusions": [
            "All chlorophyll is from trees",
            "Some chlorophyll is not plants",
            "There are plants that do not have chlorophyll",
            "Some trees do not have chlorophyll"
			]
         },
         {
            "major premise":"All fungi are decomposers",
            "minor premise":"All mushrooms are fungi",
            "conclusion":"All mushrooms are decomposers",
			"incorrect conclusions": [
            "All decomposers are mushrooms",
            "Some decomposers are not fungi",
            "There are fungi that are not decomposers",
            "Some mushrooms are not decomposers"
			]
         },
         {
            "major premise":"All fish are aquatic",
            "minor premise":"All goldfish are fish",
            "conclusion":"All goldfish are aquatic",
			"incorrect conclusions": [
            "All aquatic are goldfish",
            "Some aquatic are not fish",
            "There are fish that are not aquatic",
            "Some goldfish are not aquatic"
			]
         },
         {
            "major premise":"All insects have six legs",
            "minor premise":"All bees are insects",
            "conclusion":"All bees have six legs",
			"incorrect conclusions": [
            "All six legs are bees",
            "Some six legs are not insects",
            "There are insects that do not have six legs",
            "Some bees do not have six legs"
			]
         },
         {
            "major premise":"All cells have a nucleus",
            "minor premise":"All plant cells are cells",
            "conclusion":"All plant cells have a nucleus",
			"incorrect conclusions": [
            "All nuclei are plant cells",
            "Some nuclei are not cells",
            "There are cells that do not have a nucleus",
            "Some plant cells do not have a nucleus"
			]
         },
         {
            "major premise":"All viruses require a host",
            "minor premise":"All coronaviruses are viruses",
            "conclusion":"All coronaviruses require a host",
			"incorrect conclusions": [
            "All hosts are coronaviruses",
            "Some hosts are not viruses",
            "There are viruses that do not require a host",
            "Some coronaviruses do not require a host"
			]
         },
         {
            "major premise":"All mammals have hair",
            "minor premise":"All cats are mammals",
            "conclusion":"All cats have hair",
			"incorrect conclusions": [
            "All hair is from cats",
            "Some hair is not mammals",
            "There are mammals that do not have hair",
            "Some cats do not have hair"
			]
         }
      ]
   }
}
'''
};
Map<String, String> mapFileToContents2 = {
  'Anthropology-Barbara-temp-1.0-avg': '''
{
   "Anthropology":{
      "AAA":[
         {
            "major premise":"All humans are social beings",
            "minor premise":"All professors are humans",
            "conclusion":"All professors are social beings"
         },
         {
            "major premise":"Every culture has its own language",
            "minor premise":"Every tribe has its own culture",
            "conclusion":"Every tribe has its own language"
         },
         {
            "major premise":"All societies have social norms",
            "minor premise":"All communities are societies",
            "conclusion":"All communities have social norms"
         },
         {
            "major premise":"Every religion has its own rituals",
            "minor premise":"Every tribe has its own religion",
            "conclusion":"Every tribe has its own rituals"
         },
         {
            "major premise":"All humans have a sense of self",
            "minor premise":"All individuals are humans",
            "conclusion":"All individuals have a sense of self"
         },
         {
            "major premise":"Every society has a system of kinship",
            "minor premise":"Every tribe is a society",
            "conclusion":"Every tribe has a system of kinship"
         },
         {
            "major premise":"All human behavior is influenced by culture",
            "minor premise":"All individuals are humans",
            "conclusion":"All individuals' behavior is influenced by culture"
         },
         {
            "major premise":"Every society has social hierarchies",
            "minor premise":"Every civilization is a society",
            "conclusion":"Every civilization has social hierarchies"
         },
         {
            "major premise":"All language is a form of communication",
            "minor premise":"All tribes have their own language",
            "conclusion":"All tribes have a form of communication"
         },
         {
            "major premise":"Every society has its own belief systems",
            "minor premise":"Every culture is a society",
            "conclusion":"Every culture has its own belief systems"
         }
      ]
   }
}
''',
  'Art History-Barbara-temp-1.0-avg': '''
{
   "Art History":{
      "AAA":[
         {
            "major premise":"All sculptures are works of art",
            "minor premise":"All classical sculptures are sculptures",
            "conclusion":"All classical sculptures are works of art"
         },
         {
            "major premise":"All impressionist paintings are artworks",
            "minor premise":"All Monets are impressionist paintings",
            "conclusion":"All Monets are artworks"
         },
         {
            "major premise":"All art movements have famous representatives",
            "minor premise":"All Cubist artists are representatives of art movements",
            "conclusion":"All Cubist artists are famous representatives"
         },
         {
            "major premise":"All art museums display masterpieces",
            "minor premise":"All Louvre artworks are displayed in art museums",
            "conclusion":"All Louvre artworks are masterpieces"
         },
         {
            "major premise":"All art styles have unique characteristics",
            "minor premise":"All abstract art is an art style",
            "conclusion":"All abstract art has unique characteristics"
         },
         {
            "major premise":"All art history books are informative",
            "minor premise":"All textbooks on Renaissance art are art history books",
            "conclusion":"All textbooks on Renaissance art are informative"
         },
         {
            "major premise":"All art movements evolve over time",
            "minor premise":"All modernist movements are art movements",
            "conclusion":"All modernist movements evolve over time"
         },
         {
            "major premise":"All art critics provide analysis",
            "minor premise":"All film critics are art critics",
            "conclusion":"All film critics provide analysis"
         },
         {
            "major premise":"All art galleries exhibit artwork",
            "minor premise":"All contemporary galleries are art galleries",
            "conclusion":"All contemporary galleries exhibit artwork"
         },
         {
            "major premise":"All art collectors appreciate beauty",
            "minor premise":"All collectors of ancient artifacts are art collectors",
            "conclusion":"All collectors of ancient artifacts appreciate beauty"
         }
      ]
   }
}
''',
  'Computer Science-Barbara-temp-1.0-avg': '''
{
   "Computer Science":{
      "AAA":[
         {
            "major premise":"All computer programs are algorithms",
            "minor premise":"All sorting algorithms are computer programs",
            "conclusion":"All sorting algorithms are algorithms"
         },
         {
            "major premise":"Every computer has a central processing unit",
            "minor premise":"Every laptop is a computer",
            "conclusion":"Every laptop has a central processing unit"
         },
         {
            "major premise":"All operating systems manage computer resources",
            "minor premise":"All Linux distributions are operating systems",
            "conclusion":"All Linux distributions manage computer resources"
         },
         {
            "major premise":"Every computer scientist studies data structures",
            "minor premise":"Every computer science student is a computer scientist",
            "conclusion":"Every computer science student studies data structures"
         },
         {
            "major premise":"All programming languages have syntax",
            "minor premise":"All object-oriented programming languages are programming languages",
            "conclusion":"All object-oriented programming languages have syntax"
         },
         {
            "major premise":"Every software developer writes code",
            "minor premise":"Every Java programmer is a software developer",
            "conclusion":"Every Java programmer writes code"
         },
         {
            "major premise":"All computer networks facilitate communication",
            "minor premise":"All local area networks are computer networks",
            "conclusion":"All local area networks facilitate communication"
         },
         {
            "major premise":"Every computer system requires an input",
            "minor premise":"Every computer program is a computer system",
            "conclusion":"Every computer program requires an input"
         },
         {
            "major premise":"All computer viruses are malicious software",
            "minor premise":"All ransomware attacks are computer viruses",
            "conclusion":"All ransomware attacks are malicious software"
         },
         {
            "major premise":"All computer hardware components are tangible",
            "minor premise":"All motherboards are computer hardware components",
            "conclusion":"All motherboards are tangible"
         }
      ]
   }
}
'''
};
