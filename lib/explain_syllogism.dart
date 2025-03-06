import 'package:provider/provider.dart';
import 'package:new_test/global_language.dart';
import 'package:flutter/material.dart';

Map<String, String> _syllogismexplanation = {
  'Barbara': '''
  In the Venn diagram, all elements of Green, the interior set, 
  also belong to Blue, the most exterior set. 
  Therefore, all Green are Blue. 
  ''',
  'Celarent': '''
  The set Green is a subset of Red that does not intersect 
  with Blue. Therefore, no element of Green can belong to 
  Blue ("No Green are Blue").
  ''',
  'Darii': '''
  Hence, in "Some Green are Red", we assumed that Green cannot 
  be empty. In the Venn diagram, the black ball is an element 
  in Green that is in Red (because of the premise "Some Green are Red"). 
  ''',
  'Ferio': '''
  Hence, in "Some Green are Red", we assumed that Green cannot 
  be empty. In the Venn diagram, the black ball is an element 
  in Green that is also in Red (because of the premise "Some 
  Green are Red"). 
  ###
  Since the Red set does not intercept the Blue set, the black 
  ball is not in the Blue set. Therefore, it is in Green but 
  not in Blue ("Some Green are not Blue").
  ''',
  'Cesare': '''
  The set Green is a subset of Red that does not intersect 
  with Blue. Therefore, no element of Green can belong to 
  Blue ("No Green are Blue").
  ''',
  // Camestres foi atualizado(o nome das cores aparentavam estar trocados)
  'Camestres': '''
  The set Green is a subset of Blue that does not intersect 
  with Red. Therefore, no element of Red can belong to 
  Green ("No Red is Green").
  ''',
  'Festino': '''
  Hence, in "Some Green are Red", we assumed that sets Green 
  and Red cannot be empty. In the Venn diagram, the black 
  ball is an element in Green that is also in Red (because 
  of the premise "Some Green are Red"). 
  ###
  The black ball belongs to Green and Red and, since Blue and 
  Red does not intersept, it does not belong to Blue. Therefore, 
  "Some Green are not Blue". 
  ''',
  'Baroco': '''
  Hence, in "Some Green are not Red", we assumed that set Green 
  has at least one element. In the Venn diagram, the black ball 
  is an element of Green.	
  ###
  Since the black ball element does not belong to Red ("Some 
  Green are not Red"), it does not belong to any subsets of 
  Red such as Blue. 	Therefore, "Some Green are not Blue".
  ''',
  'Darapti': '''
  Hence, in "some Red exist", we assumed that set Red has at 
  least one element. In the Venn diagram, the black ball 
  is an element of Red.	
  ###
  Since Red is a subset of Blue ("All Red are Blue") and 
  subset of Green ("All Red are Green"), the black ball 
  is an element of both Green and Blue. Therefore, some 
  Green are Blue (at least the black ball).
  ''',
  'Felapton': '''
  Hence, in "some Red exist", we assumed that set Red has 
  at least one element. In the Venn diagram, the black ball
  is an element of Red.	
  ###
  The black ball is an element of Red ("some Red exist") 
  but not an element of Blue ("No Red are Blue"). Since 
  the black ball is an element of Green ("All Red are 
  Green"), there are elements of Green (at least the black 
  ball) that are not elements of Blue ("Some Green are not Blue").
  ''',
  'Disamis': '''
  Hence, in "Some Red are Blue", we assumed that set Red has 
  at least one element. In the Venn diagram, the black ball 
  is an element of Red.		
  ###
  The black ball is an element of Red and also an element of 
  Blue ("Some Red are Blue"). Since Red is a subset of 
  Green ("All Red are Green"), the black ball is an element of
  Green. Therefore, there is at least one element, the black 
  ball, that is both in Green and Blue ("Some Green are Blue"). 
  ''',
  'Datisi': '''
  Hence, in "Some Red are Green", we assumed that both Red and 
  Green cannot be empty. In the Venn diagram, the black ball 
  is an element in Green that is in Red (because of the premise 
  "Some Green are Red"). 
  ###
  Since Red is subset of Blue, the common elements of Green and 
  Red (as the black ball) are also Blue ("Some Green are Blue").
  ''',
  'Bocardo': '''
  Hence, in "Some Red are not Blue", we assumed that  Red 
  cannot be empty. In the Venn diagram, the black ball is an 
  element in Red that is not in Blue. 
  ###
  Since the black ball also belongs to Green ("All Red are 
  Green"), there is at least one element in Green, the black 
  ball, that is not in Blue. Therefore, "Some Green are not Blue". 
  ''',
  'Ferison': '''
  Hence, in "Some Red are Green", we assumed that both Red and 
  Green cannot be empty. In the Venn diagram, the black ball 
  is an element in Red that is also in Green (because of the
   premise "Some Red are Green"). 
  ###
  Since the black ball is in the Red set that does not 
  intercept the Blue set, the black ball is not in the Blue 
  set ("Some Green are not Blue").
  ''',
  'Bamalip': '''
  Hence, in "some Blue exist", we assumed that set Blue has
   at least one element. In the Venn diagram, the black 
   ball is an element of Blue.			
  ###	  
  Since the black ball is in Blue, it is also in Red ("All 
  Blue are Red"). Since it is in Red, it is also in Green 
  ("All Red are Green"). Therefore, "Some Green are Blue". 	
  ''',
  'Calemes': '''
  The set Blue is a subset of Red that does not intersect 
  with Blue. Therefore, no element of Green can belong to 
  Blue ("No Green are Blue").
  ''',
  // Dimatis foi atualizado (o nome das cores aparentavam estar trocados)
  'Dimatis': '''
  Hence, in "Some Green are Blue", we assumed the set Green 
  has at least one element. In the Venn diagram, the black 
  ball is an element of Green.		
  ###
  The black ball is an element of Green and also an element 
  of Blue ("Some Green are Blue"). Since Blue is a subset of 
  Red ("All Blue are Red"), the black ball is an element 
  of Red. Therefore, there is at least one element, the 
  black ball, that is both in Red and Green ("Some Red 
  are Green"). 
  ''',
  'Fesapo': '''
  Hence, in "some Red exist", we assumed that set Red has 
  at least one element. In the Venn diagram, the black 
  ball is an element of Red.	
  ###
  The black ball is an element of Red ("some Red exist") 
  but not an element of Blue ("No Blue are Red"). Since 
  the black ball is an element of Green ("All Red are 
  Green"), there are elements of Green (at least the black 
  ball) that are not elements of Blue ("Some Green are not Blue").	 
  ''',
  'Fresison': '''
  Hence, in "Some Red are Green", we assumed that Red cannot 
  be empty. In the Venn diagram, the black ball is an element 
  in Red that is also in Green (because of the premise 
  "Some Red are Green").
  ###
  Since the Red set does not intercept the Blue set 
  ("No Blue are Red"), the black ball is not in the Blue set. 
  Therefore, it is in Green but not in Blue ("Some Green 
  are not Blue").
  '''
};

final Map<String, String> _syllogismexplanation_PT = {
  'Barbara': '''
  No diagrama de Venn, todos os elementos de Verde, o conjunto interno,
  também pertencem a Azul, o conjunto mais externo. 
  Portanto, todos os Verdes são Azuis.
  ''',
  'Celarent': '''
  O conjunto Verde é um subconjunto de Vermelho que não se intersecta 
  com Azul. Portanto, nenhum elemento de Verde pode pertencer a 
  Azul ("Nenhum Verde é Azul").
  ''',
  'Darii': '''
  Assim, em "Alguns Verdes são Vermelhos", assumimos que Verde não pode 
  estar vazio. No diagrama de Venn, a bola preta é um elemento 
  de Verde que está em Vermelho (devido à premissa "Alguns Verdes são Vermelhos").
  ''',
  'Ferio': '''
  Assim, em "Alguns Verdes são Vermelhos", assumimos que Verde não pode 
  estar vazio. No diagrama de Venn, a bola preta é um elemento 
  de Verde que também está em Vermelho (devido à premissa "Alguns 
  Verdes são Vermelhos").
  ###
  Como o conjunto Vermelho não se intercepta com o conjunto Azul, a bola preta 
  não está no conjunto Azul. Portanto, ela está em Verde, mas 
  não em Azul ("Alguns Verdes não são Azuis").
  ''',
  'Cesare': '''
  O conjunto Verde é um subconjunto de Vermelho que não se intersecta 
  com Azul. Portanto, nenhum elemento de Verde pode pertencer a 
  Azul ("Nenhum Verde é Azul").
  ''',
  'Camestres': '''
  O conjunto Verde é um subconjunto de Azul que não se intersecta 
  com Vermelho. Portanto, nenhum elemento de Vermelho pode pertencer a 
  Verde ("Nenhum Vermelho é Verde").
  ''',
  'Festino': '''
  Assim, em "Alguns Verdes são Vermelhos", assumimos que os conjuntos Verde 
  e Vermelho não podem estar vazios. No diagrama de Venn, a bola preta 
  é um elemento em Verde que também está em Vermelho (por causa 
  da premissa "Alguns Verdes são Vermelhos"). 
  ###
  A bola preta pertence a Verde e Vermelho e, como Azul e 
  Vermelho não se interceptam, ela não pertence a Azul. Portanto, 
  "Alguns Verdes não são Azuis".
  ''',
  'Baroco': '''
  Assim, em "Alguns Verdes não são Vermelhos", assumimos que o conjunto Verde 
  tem pelo menos um elemento. No diagrama de Venn, a bola preta 
  é um elemento de Verde.
  ###
  Como a bola preta não pertence a Vermelho ("Alguns 
  Verdes não são Vermelhos"), ela não pertence a nenhum subconjunto de 
  Vermelho, como Azul. Portanto, "Alguns Verdes não são Azuis".
  ''',
  'Darapti': '''
  Assim, em "Alguns Vermelhos existem", assumimos que o conjunto Vermelho tem pelo 
  menos um elemento. No diagrama de Venn, a bola preta 
  é um elemento de Vermelho.
  ###
  Como Vermelho é um subconjunto de Azul ("Todos os Vermelhos são Azuis") e 
  um subconjunto de Verde ("Todos os Vermelhos são Verdes"), a bola preta 
  é um elemento de ambos Verde e Azul. Portanto, 
  "Alguns Verdes são Azuis" (pelo menos a bola preta).
  ''',
  'Felapton': '''
  Assim, em "Alguns Vermelhos existem", assumimos que o conjunto Vermelho tem 
  pelo menos um elemento. No diagrama de Venn, a bola preta 
  é um elemento de Vermelho.
  ###
  A bola preta é um elemento de Vermelho ("Alguns Vermelhos existem") 
  mas não um elemento de Azul ("Nenhum Vermelho é Azul"). Como 
  a bola preta é um elemento de Verde ("Todos os Vermelhos são 
  Verdes"), existem elementos de Verde (pelo menos a bola 
  preta) que não são elementos de Azul ("Alguns Verdes não são Azuis").
  ''',
  'Disamis': '''
  Assim, em "Alguns Vermelhos são Azuis", assumimos que o conjunto Vermelho tem 
  pelo menos um elemento. No diagrama de Venn, a bola preta 
  é um elemento de Vermelho.		
  ###
  A bola preta é um elemento de Vermelho e também um elemento de 
  Azul ("Alguns Vermelhos são Azuis"). Como Vermelho é um subconjunto de 
  Verde ("Todos os Vermelhos são Verdes"), a bola preta é um elemento de
  Verde. Portanto, existe pelo menos um elemento, a bola 
  preta, que está tanto em Verde quanto em Azul ("Alguns Verdes são Azuis").
  ''',
  'Datisi': '''
  Assim, em "Alguns Vermelhos são Verdes", assumimos que tanto Vermelho quanto 
  Verde não podem estar vazios. No diagrama de Venn, a bola preta 
  é um elemento em Verde que está em Vermelho (por causa da premissa 
  "Alguns Verdes são Vermelhos"). 
  ###
  Como Vermelho é um subconjunto de Azul, os elementos comuns de Verde e 
  Vermelho (como a bola preta) também são Azuis ("Alguns Verdes são Azuis").
  ''',
  'Bocardo': '''
  Assim, em "Alguns Vermelhos não são Azuis", assumimos que Vermelho 
  não pode estar vazio. No diagrama de Venn, a bola preta é um 
  elemento em Vermelho que não está em Azul. 
  ###
  Como a bola preta também pertence a Verde ("Todos os Vermelhos são 
  Verdes"), existe pelo menos um elemento em Verde, a bola 
  preta, que não está em Azul. Portanto, "Alguns Verdes não são Azuis".
  ''',
  'Ferison': '''
  Assim, em "Alguns Vermelhos são Verdes", assumimos que tanto Vermelho quanto 
  Verde não podem estar vazios. No diagrama de Venn, a bola preta 
  é um elemento em Vermelho que também está em Verde (por causa da 
  premissa "Alguns Vermelhos são Verdes"). 
  ###
  Como a bola preta está no conjunto Vermelho que não se 
  intercepta com o conjunto Azul, a bola preta não está no conjunto 
  Azul ("Alguns Verdes não são Azuis").
  ''',
  'Bamalip': '''
  Assim, em "Alguns Azuis existem", assumimos que o conjunto Azul tem 
  pelo menos um elemento. No diagrama de Venn, a bola 
  preta é um elemento de Azul.			
  ###	  
  Como a bola preta está em Azul, ela também está em Vermelho ("Todos 
  os Azuis são Vermelhos"). Como está em Vermelho, também está em Verde 
  ("Todos os Vermelhos são Verdes"). Portanto, "Alguns Verdes são Azuis". 	
  ''',
  'Calemes': '''
  O conjunto Azul é um subconjunto de Vermelho que não se intersecta 
  com Azul. Portanto, nenhum elemento de Verde pode pertencer a 
  Azul ("Nenhum Verde é Azul").
  ''',
  'Dimatis': '''
  Assim, em "Alguns Verdes são Azuis", assumimos que o conjunto Verde 
  tem pelo menos um elemento. No diagrama de Venn, a bola 
  preta é um elemento de Verde.		
  ###
  A bola preta é um elemento de Verde e também um elemento 
  de Azul ("Alguns Verdes são Azuis"). Como Azul é um subconjunto de 
  Vermelho ("Todos os Azuis são Vermelhos"), a bola preta é um elemento 
  de Vermelho. Portanto, existe pelo menos um elemento, a 
  bola preta, que está tanto em Vermelho quanto em Verde ("Alguns Vermelhos 
  são Verdes").
  ''',
  'Fesapo': '''
  Assim, em "Alguns Vermelhos existem", assumimos que o conjunto Vermelho tem 
  pelo menos um elemento. No diagrama de Venn, a bola 
  preta é um elemento de Vermelho.	
  ###
  A bola preta é um elemento de Vermelho ("Alguns Vermelhos existem") 
  mas não um elemento de Azul ("Nenhum Azul é Vermelho"). Como 
  a bola preta é um elemento de Verde ("Todos os Vermelhos são 
  Verdes"), existem elementos de Verde (pelo menos a bola preta) 
  que não são elementos de Azul ("Alguns Verdes não são Azuis").	 
  ''',
  'Fresison': '''
  Portanto, em "Alguns Vermelhos são Verdes", assumimos que o conjunto dos Vermelhos não pode ser vazio. No diagrama de Venn, a bolinha preta é um elemento dos Vermelhos que também está nos Verdes (por causa da premissa "Alguns Vermelhos são Verdes").
  ###
  Como o conjunto dos Vermelhos não intercepta o conjunto dos Azuis ("Nenhum Azul é Vermelho"), a bolinha preta não está no conjunto dos Azuis. Portanto, ela está nos Verdes, mas não nos Azuis ("Alguns Verdes não são Azuis").
  '''
};

Map<String, String> _syllogismexplanation_AR = {
  'Barbara': '''
في مخطط Venn، جميع عناصر الأخضر، المجموعة الداخلية، تنتمي أيضًا إلى الأزرق، المجموعة الخارجية ביותר. لذلك، كل الأخضر هو أزرق.
''',
  'Celarent': '''
المجموعة الخضراء هي مجموعة فرعية من الأحمر لا تتقاطع مع الأزرق. لذلك، لا يمكن لأي عنصر من عناصر الأخضر أن ينتمي إلى الأزرق ("لا يوجد أخضر هو أزرق").
''',
  'Darii': '''
لذلك، في "بعض الأخضر هو أحمر"، افترضنا أن الأخضر لا يمكن أن يكون فارغًا. في مخطط Venn، الكرة السوداء هي عنصر في الأخضر الموجود في الأحمر (بسبب فرضية "بعض الأخضر هو أحمر").
''',
  'Ferio': '''
لذلك، في "بعض الأخضر هو أحمر"، افترضنا أن الأخضر لا يمكن أن يكون فارغًا. في مخطط Venn، الكرة السوداء هي عنصر في الأخضر الموجود أيضًا في الأحمر (بسبب فرضية "بعض الأخضر هو أحمر").
###
نظرًا لأن المجموعة الحمراء لا تتقاطع مع المجموعة الزرقاء، فإن الكرة السوداء ليست في المجموعة الزرقاء. لذلك، هي في الأخضر ولكن ليس في الأزرق ("بعض الأخضر ليس أزرق").
''',
  'Cesare': '''
المجموعة الخضراء هي مجموعة فرعية من الأحمر لا تتقاطع مع الأزرق. لذلك، لا يمكن لأي عنصر من عناصر الأخضر أن ينتمي إلى الأزرق ("لا يوجد أخضر هو أزرق").
''',
  'Camestres': '''
المجموعة الخضراء هي مجموعة فرعية من الأزرق لا تتقاطع مع الأحمر. لذلك، لا يمكن لأي عنصر من عناصر الأحمر أن ينتمي إلى الأخضر ("لا يوجد أحمر هو أخضر").
''',
  'Festino': '''
لذلك، في "بعض الأخضر هو أحمر"، افترضنا أن المجموعتين الأخضر والأحمر لا يمكن أن تكونا فارغتين. في مخطط Venn، الكرة السوداء هي عنصر في الأخضر الموجود أيضًا في الأحمر (بسبب فرضية "بعض الأخضر هو أحمر").
###
تنتمي الكرة السوداء إلى الأخضر والأحمر، ونظرًا لأن الأزرق والأحمر لا يتقاطعان، فإنها لا تنتمي إلى الأزرق. لذلك، "بعض الأخضر ليس أزرق".
''',
  'Baroco': '''
لذلك، في "بعض الأخضر ليس أحمر"، افترضنا أن المجموعة الخضراء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأخضر.
###
نظرًا لأن عنصر الكرة السوداء لا ينتمي إلى الأحمر ("بعض الأخضر ليس أحمر")، فإنه لا ينتمي إلى أي مجموعات فرعية من الأحمر مثل الأزرق. لذلك، "بعض الأخضر ليس أزرق".
''',
  'Darapti': '''
لذلك، في "بعض الأحمر موجود"، افترضنا أن المجموعة الحمراء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأحمر.
###
نظرًا لأن الأحمر هو مجموعة فرعية من الأزرق ("كل الأحمر هو أزرق") ومجموعة فرعية من الأخضر ("كل الأحمر هو أخضر")، فإن الكرة السوداء هي عنصر من عناصر كل من الأخضر والأزرق. لذلك، بعض الأخضر هو أزرق (على الأقل الكرة السوداء).
''',
  'Felapton': '''
لذلك، في "بعض الأحمر موجود"، افترضنا أن المجموعة الحمراء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأحمر.
###
الكرة السوداء هي عنصر من عناصر الأحمر ("بعض الأحمر موجود") ولكنها ليست عنصرًا من عناصر الأزرق ("لا يوجد أحمر هو أزرق"). نظرًا لأن الكرة السوداء هي عنصر من عناصر الأخضر ("كل الأحمر هو أخضر")، فهناك عناصر من الأخضر (على الأقل الكرة السوداء) ليست عناصر من عناصر الأزرق ("بعض الأخضر ليس أزرق").
''',
  'Disamis': '''
لذلك، في "بعض الأحمر هو أزرق"، افترضنا أن المجموعة الحمراء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأحمر.
###
الكرة السوداء هي عنصر من عناصر الأحمر وأيضًا عنصر من عناصر الأزرق ("بعض الأحمر هو أزرق"). نظرًا لأن الأحمر هو مجموعة فرعية من الأخضر ("كل الأحمر هو أخضر")، فإن الكرة السوداء هي عنصر من عناصر الأخضر. لذلك، يوجد عنصر واحد على الأقل، الكرة السوداء، موجود في كل من الأخضر والأزرق ("بعض الأخضر هو أزرق").
''',
  'Datisi': '''
لذلك، في "بعض الأحمر هو أخضر"، افترضنا أن كل من الأحمر والأخضر لا يمكن أن يكونا فارغين. في مخطط Venn، الكرة السوداء هي عنصر في الأخضر الموجود في الأحمر (بسبب فرضية "بعض الأخضر هو أحمر").
###
نظرًا لأن الأحمر هو مجموعة فرعية من الأزرق، فإن العناصر المشتركة بين الأخضر والأحمر (مثل الكرة السوداء) هي أيضًا زرقاء ("بعض الأخضر هو أزرق").
''',
  'Bocardo': '''
لذلك، في "بعض الأحمر ليس أزرق"، افترضنا أن الأحمر لا يمكن أن يكون فارغًا. في مخطط Venn، الكرة السوداء هي عنصر في الأحمر ليس في الأزرق.
###
نظرًا لأن الكرة السوداء تنتمي أيضًا إلى الأخضر ("كل الأحمر هو أخضر")، فهناك عنصر واحد على الأقل في الأخضر، الكرة السوداء، ليس في الأزرق. لذلك، "بعض الأخضر ليس أزرق".
''',
  'Ferison': '''
لذلك، في "بعض الأحمر هو أخضر"، افترضنا أن كل من الأحمر والأخضر لا يمكن أن يكونا فارغين. في مخطط Venn، الكرة السوداء هي عنصر في الأحمر الموجود أيضًا في الأخضر (بسبب فرضية "بعض الأحمر هو أخضر").
###
نظرًا لأن الكرة السوداء موجودة في المجموعة الحمراء التي لا تتقاطع مع المجموعة الزرقاء، فإن الكرة السوداء ليست في المجموعة الزرقاء ("بعض الأخضر ليس أزرق").
''',
  'Bamalip': '''
لذلك، في "بعض الأزرق موجود"، افترضنا أن المجموعة الزرقاء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأزرق.
###
نظرًا لأن الكرة السوداء موجودة في الأزرق، فهي أيضًا في الأحمر ("كل الأزرق هو أحمر"). نظرًا لأنها في الأحمر، فهي أيضًا في الأخضر ("كل الأحمر هو أخضر"). لذلك، "بعض الأخضر هو أزرق".
''',
  'Calemes': '''
المجموعة الزرقاء هي مجموعة فرعية من الأحمر لا تتقاطع مع الأزرق. لذلك، لا يمكن لأي عنصر من عناصر الأخضر أن ينتمي إلى الأزرق ("لا يوجد أخضر هو أزرق").
''',
  'Dimatis': '''
لذلك، في "بعض الأخضر هو أزرق"، افترضنا أن المجموعة الخضراء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأخضر.
###
الكرة السوداء هي عنصر من عناصر الأخضر وأيضًا عنصر من عناصر الأزرق ("بعض الأخضر هو أزرق"). نظرًا لأن الأزرق هو مجموعة فرعية من الأحمر ("كل الأزرق هو أحمر")، فإن الكرة السوداء هي عنصر من عناصر الأحمر. لذلك، يوجد عنصر واحد على الأقل، الكرة السوداء، موجود في كل من الأحمر والأخضر ("بعض الأحمر هو أخضر").
''',
  'Fesapo': '''
لذلك، في "بعض الأحمر موجود"، افترضنا أن المجموعة الحمراء تحتوي على عنصر واحد على الأقل. في مخطط Venn، الكرة السوداء هي عنصر من عناصر الأحمر.
###
الكرة السوداء هي عنصر من عناصر الأحمر ("بعض الأحمر موجود") ولكنها ليست عنصرًا من عناصر الأزرق ("لا يوجد أزرق هو أحمر"). نظرًا لأن الكرة السوداء هي عنصر من عناصر الأخضر ("كل الأحمر هو أخضر")، فهناك عناصر من الأخضر (على الأقل الكرة السوداء) ليست عناصر من عناصر الأزرق ("بعض الأخضر ليس أزرق").
''',
  'Fresison': '''
لذلك، في "بعض الأحمر هو أخضر"، افترضنا أن الأحمر لا يمكن أن يكون فارغًا. في مخطط Venn، الكرة السوداء هي عنصر في الأحمر الموجود أيضًا في الأخضر (بسبب فرضية "بعض الأحمر هو أخضر").
###
نظرًا لأن المجموعة الحمراء لا تتقاطع مع المجموعة الزرقاء ("لا يوجد أزرق هو أحمر")، فإن الكرة السوداء ليست في المجموعة الزرقاء. لذلك، هي في الأخضر ولكن ليس في الأزرق ("بعض الأخضر ليس أزرق").
''',
};

Map<String, String> _syllogismexplanation_ZH = {
  'Barbara': '''
在维恩图中，绿色（内部集合）的所有元素也属于蓝色（最外部集合）。因此，所有绿色都是蓝色。
''',
  'Celarent': '''
绿色集合是红色集合的子集，与蓝色集合没有交集。因此，绿色集合的任何元素都不能属于蓝色集合（“没有绿色是蓝色”）。
''',
  'Darii': '''
因此，在“一些绿色是红色”中，我们假设绿色不能为空。在维恩图中，黑球是绿色中的一个元素，它在红色中（因为前提是“一些绿色是红色”）。
''',
  'Ferio': '''
因此，在“一些绿色是红色”中，我们假设绿色不能为空。在维恩图中，黑球是绿色中的一个元素，它也在红色中（因为前提是“一些绿色是红色”）。
###
由于红色集合与蓝色集合没有交集，因此黑球不在蓝色集合中。因此，它在绿色中，但不在蓝色中（“一些绿色不是蓝色”）。
''',
  'Cesare': '''
绿色集合是红色集合的子集，与蓝色集合没有交集。因此，绿色集合的任何元素都不能属于蓝色集合（“没有绿色是蓝色”）。
''',
  'Camestres': '''
绿色集合是蓝色集合的子集，与红色集合没有交集。因此，红色集合的任何元素都不能属于绿色集合（“没有红色是绿色”）。
''',
  'Festino': '''
因此，在“一些绿色是红色”中，我们假设绿色集合和红色集合都不能为空。在维恩图中，黑球是绿色中的一个元素，它也在红色中（因为前提是“一些绿色是红色”）。
###
黑球属于绿色和红色，由于蓝色和红色没有交集，因此它不属于蓝色。因此，“一些绿色不是蓝色”。
''',
  'Baroco': '''
因此，在“一些绿色不是红色”中，我们假设绿色集合至少有一个元素。在维恩图中，黑球是绿色的一个元素。
###
由于黑球元素不属于红色（“一些绿色不是红色”），因此它不属于红色的任何子集，例如蓝色。因此，“一些绿色不是蓝色”。
''',
  'Darapti': '''
因此，在“存在一些红色”中，我们假设红色集合至少有一个元素。在维恩图中，黑球是红色集合的一个元素。
###
由于红色是蓝色（“所有红色都是蓝色”）的子集，也是绿色（“所有红色都是绿色”）的子集，因此黑球是绿色和蓝色两个集合的元素。因此，一些绿色是蓝色（至少是黑球）。
''',
  'Felapton': '''
因此，在“存在一些红色”中，我们假设红色集合至少有一个元素。在维恩图中，黑球是红色集合的一个元素。
###
黑球是红色集合（“存在一些红色”）的一个元素，但不是蓝色集合（“没有红色是蓝色”）的一个元素。由于黑球是绿色集合（“所有红色都是绿色”）的一个元素，因此存在绿色集合的元素（至少是黑球）不是蓝色集合（“一些绿色不是蓝色”）的元素。
''',
  'Disamis': '''
因此，在“一些红色是蓝色”中，我们假设红色集合至少有一个元素。在维恩图中，黑球是红色集合的一个元素。
###
黑球是红色集合的一个元素，也是蓝色集合（“一些红色是蓝色”）的一个元素。由于红色是绿色集合（“所有红色都是绿色”）的子集，因此黑球是绿色集合的一个元素。因此，至少有一个元素（黑球）既在绿色集合中，又在蓝色集合中（“一些绿色是蓝色”）。
''',
  'Datisi': '''
因此，在“一些红色是绿色”中，我们假设红色和绿色都不能为空。在维恩图中，黑球是绿色中的一个元素，它在红色中（因为前提是“一些绿色是红色”）。
###
由于红色是蓝色的子集，因此绿色和红色的共同元素（如黑球）也是蓝色（“一些绿色是蓝色”）。
''',
  'Bocardo': '''
因此，在“一些红色不是蓝色”中，我们假设红色不能为空。在维恩图中，黑球是红色中的一个元素，它不在蓝色中。
###
由于黑球也属于绿色（“所有红色都是绿色”），因此绿色中至少有一个元素（黑球）不在蓝色中。因此，“一些绿色不是蓝色”。
''',
  'Ferison': '''
因此，在“一些红色是绿色”中，我们假设红色和绿色都不能为空。在维恩图中，黑球是红色中的一个元素，它也在绿色中（因为前提是“一些红色是绿色”）。
###
由于黑球在与蓝色集合没有交集的红色集合中，因此黑球不在蓝色集合中（“一些绿色不是蓝色”）。
''',
  'Bamalip': '''
因此，在“存在一些蓝色”中，我们假设蓝色集合至少有一个元素。在维恩图中，黑球是蓝色集合的一个元素。
###
由于黑球在蓝色中，因此它也在红色中（“所有蓝色都是红色”）。由于它在红色中，因此它也在绿色中（“所有红色都是绿色”）。因此，“一些绿色是蓝色”。
''',
  'Calemes': '''
蓝色集合是红色集合的子集，与蓝色集合没有交集。因此，绿色集合的任何元素都不能属于蓝色集合（“没有绿色是蓝色”）。
''',
  'Dimatis': '''
因此，在“一些绿色是蓝色”中，我们假设绿色集合至少有一个元素。在维恩图中，黑球是绿色集合的一个元素。
###
黑球是绿色集合的一个元素，也是蓝色集合（“一些绿色是蓝色”）的一个元素。由于蓝色是红色集合（“所有蓝色都是红色”）的子集，因此黑球是红色集合的一个元素。因此，至少有一个元素（黑球）既在红色集合中，又在绿色集合中（“一些红色是绿色”）。
''',
  'Fesapo': '''
因此，在“存在一些红色”中，我们假设红色集合至少有一个元素。在维恩图中，黑球是红色集合的一个元素。
###
黑球是红色集合（“存在一些红色”）的一个元素，但不是蓝色集合（“没有蓝色是红色”）的一个元素。由于黑球是绿色集合（“所有红色都是绿色”）的一个元素，因此存在绿色集合的元素（至少是黑球）不是蓝色集合（“一些绿色不是蓝色”）的元素。
''',
  'Fresison': '''
因此，在“一些红色是绿色”中，我们假设红色不能为空。在维恩图中，黑球是红色中的一个元素，它也在绿色中（因为前提是“一些红色是绿色”）。
###
由于红色集合与蓝色集合（“没有蓝色是红色”）没有交集，因此黑球不在蓝色集合中。因此，它在绿色中，但不在蓝色中（“一些绿色不是蓝色”）。
''',
};

Map<String, String> _syllogismexplanation_DE = {
  'Barbara': '''
Im Venn-Diagramm gehören alle Elemente von Grün, der inneren Menge, auch zu Blau, der äußersten Menge. Daher ist alles Grüne blau.
''',
  'Celarent': '''
Die grüne Menge ist eine Teilmenge von Rot, die sich nicht mit Blau schneidet. Daher kann kein Element von Grün zu Blau gehören ("Kein Grün ist blau").
''',
  'Darii': '''
Daher haben wir in "Einige Grüne sind rot" angenommen, dass Grün nicht leer sein kann. Im Venn-Diagramm ist der schwarze Ball ein Element in Grün, das sich in Rot befindet (wegen der Prämisse "Einige Grüne sind rot").
''',
  'Ferio': '''
Daher haben wir in "Einige Grüne sind rot" angenommen, dass Grün nicht leer sein kann. Im Venn-Diagramm ist der schwarze Ball ein Element in Grün, das sich auch in Rot befindet (wegen der Prämisse "Einige Grüne sind rot").
###
Da die rote Menge die blaue Menge nicht schneidet, befindet sich der schwarze Ball nicht in der blauen Menge. Daher befindet er sich in Grün, aber nicht in Blau ("Einige Grüne sind nicht blau").
''',
  'Cesare': '''
Die grüne Menge ist eine Teilmenge von Rot, die sich nicht mit Blau schneidet. Daher kann kein Element von Grün zu Blau gehören ("Kein Grün ist blau").
''',
  'Camestres': '''
Die grüne Menge ist eine Teilmenge von Blau, die sich nicht mit Rot schneidet. Daher kann kein Element von Rot zu Grün gehören ("Kein Rot ist grün").
''',
  'Festino': '''
Daher haben wir in "Einige Grüne sind rot" angenommen, dass die Mengen Grün und Rot nicht leer sein können. Im Venn-Diagramm ist der schwarze Ball ein Element in Grün, das sich auch in Rot befindet (wegen der Prämisse "Einige Grüne sind rot").
###
Der schwarze Ball gehört zu Grün und Rot, und da Blau und Rot sich nicht schneiden, gehört er nicht zu Blau. Daher "Einige Grüne sind nicht blau".
''',
  'Baroco': '''
Daher haben wir in "Einige Grüne sind nicht rot" angenommen, dass die Menge Grün mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Grün.
###
Da das schwarze Ball-Element nicht zu Rot gehört ("Einige Grüne sind nicht rot"), gehört es nicht zu Untergruppen von Rot wie Blau. Daher "Einige Grüne sind nicht blau".
''',
  'Darapti': '''
Daher haben wir in "einiges Rot existiert" angenommen, dass die Menge Rot mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Rot.
###
Da Rot eine Teilmenge von Blau ("Alle Roten sind blau") und eine Teilmenge von Grün ("Alle Roten sind grün") ist, ist der schwarze Ball ein Element von sowohl Grün als auch Blau. Daher sind einige Grüne blau (mindestens der schwarze Ball).
''',
  'Felapton': '''
Daher haben wir in "einiges Rot existiert" angenommen, dass die Menge Rot mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Rot.
###
Der schwarze Ball ist ein Element von Rot ("einiges Rot existiert"), aber kein Element von Blau ("Kein Rot ist blau"). Da der schwarze Ball ein Element von Grün ("Alle Roten sind grün") ist, gibt es Elemente von Grün (mindestens den schwarzen Ball), die keine Elemente von Blau sind ("Einige Grüne sind nicht blau").
''',
  'Disamis': '''
Daher haben wir in "Einige Rote sind blau" angenommen, dass die Menge Rot mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Rot.
###
Der schwarze Ball ist ein Element von Rot und auch ein Element von Blau ("Einige Rote sind blau"). Da Rot eine Teilmenge von Grün ("Alle Roten sind grün") ist, ist der schwarze Ball ein Element von Grün. Daher gibt es mindestens ein Element, den schwarzen Ball, der sowohl in Grün als auch in Blau ist ("Einige Grüne sind blau").
''',
  'Datisi': '''
Daher haben wir in "Einige Rote sind grün" angenommen, dass sowohl Rot als auch Grün nicht leer sein können. Im Venn-Diagramm ist der schwarze Ball ein Element in Grün, das sich in Rot befindet (wegen der Prämisse "Einige Grüne sind rot").
###
Da Rot eine Teilmenge von Blau ist, sind die gemeinsamen Elemente von Grün und Rot (wie der schwarze Ball) auch blau ("Einige Grüne sind blau").
''',
  'Bocardo': '''
Daher haben wir in "Einige Rote sind nicht blau" angenommen, dass Rot nicht leer sein kann. Im Venn-Diagramm ist der schwarze Ball ein Element in Rot, das nicht in Blau ist.
###
Da der schwarze Ball auch zu Grün gehört ("Alle Roten sind grün"), gibt es mindestens ein Element in Grün, den schwarzen Ball, das nicht in Blau ist. Daher "Einige Grüne sind nicht blau".
''',
  'Ferison': '''
Daher haben wir in "Einige Rote sind grün" angenommen, dass sowohl Rot als auch Grün nicht leer sein können. Im Venn-Diagramm ist der schwarze Ball ein Element in Rot, das sich auch in Grün befindet (wegen der Prämisse "Einige Rote sind grün").
###
Da der schwarze Ball in der roten Menge ist, die sich nicht mit der blauen Menge schneidet, ist der schwarze Ball nicht in der blauen Menge ("Einige Grüne sind nicht blau").
''',
  'Bamalip': '''
Daher haben wir in "einiges Blau existiert" angenommen, dass die Menge Blau mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Blau.
###
Da der schwarze Ball in Blau ist, ist er auch in Rot ("Alle Blauen sind rot"). Da er in Rot ist, ist er auch in Grün ("Alle Roten sind grün"). Daher "Einige Grüne sind blau".
''',
  'Calemes': '''
Die blaue Menge ist eine Teilmenge von Rot, die sich nicht mit Blau schneidet. Daher kann kein Element von Grün zu Blau gehören ("Kein Grün ist blau").
''',
  'Dimatis': '''
Daher haben wir in "Einige Grüne sind blau" angenommen, dass die Menge Grün mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Grün.
###
Der schwarze Ball ist ein Element von Grün und auch ein Element von Blau ("Einige Grüne sind blau"). Da Blau eine Teilmenge von Rot ("Alle Blauen sind rot") ist, ist der schwarze Ball ein Element von Rot. Daher gibt es mindestens ein Element, den schwarzen Ball, der sowohl in Rot als auch in Grün ist ("Einige Rote sind grün").
''',
  'Fesapo': '''
Daher haben wir in "einiges Rot existiert" angenommen, dass die Menge Rot mindestens ein Element enthält. Im Venn-Diagramm ist der schwarze Ball ein Element von Rot.
###
Der schwarze Ball ist ein Element von Rot ("einiges Rot existiert"), aber kein Element von Blau ("Kein Blau ist rot"). Da der schwarze Ball ein Element von Grün ("Alle Roten sind grün") ist, gibt es Elemente von Grün (mindestens den schwarzen Ball), die keine Elemente von Blau sind ("Einige Grüne sind nicht blau").
''',
  'Fresison': '''
Daher haben wir in "Einige Rote sind grün" angenommen, dass Rot nicht leer sein kann. Im Venn-Diagramm ist der schwarze Ball ein Element in Rot, das sich auch in Grün befindet (wegen der Prämisse "Einige Rote sind grün").
###
Da die rote Menge die blaue Menge ("Kein Blau ist rot") nicht schneidet, befindet sich der schwarze Ball nicht in der blauen Menge. Daher befindet er sich in Grün, aber nicht in Blau ("Einige Grüne sind nicht blau").
''',
};

Map<String, String> _syllogismexplanation_FR = {
  'Barbara': '''
Dans le diagramme de Venn, tous les éléments de Vert, l'ensemble intérieur, appartiennent également à Bleu, l'ensemble le plus extérieur. Par conséquent, tout Vert est Bleu.
''',
  'Celarent': '''
L'ensemble Vert est un sous-ensemble de Rouge qui n'intersecte pas Bleu. Par conséquent, aucun élément de Vert ne peut appartenir à Bleu ("Aucun Vert n'est Bleu").
''',
  'Darii': '''
Par conséquent, dans "Certains Verts sont Rouges", nous avons supposé que Vert ne peut pas être vide. Dans le diagramme de Venn, la boule noire est un élément de Vert qui est dans Rouge (en raison de la prémisse "Certains Verts sont Rouges").
''',
  'Ferio': '''
Par conséquent, dans "Certains Verts sont Rouges", nous avons supposé que Vert ne peut pas être vide. Dans le diagramme de Venn, la boule noire est un élément de Vert qui est également dans Rouge (en raison de la prémisse "Certains Verts sont Rouges").
###
Puisque l'ensemble Rouge n'intersecte pas l'ensemble Bleu, la boule noire n'est pas dans l'ensemble Bleu. Par conséquent, elle est dans Vert mais pas dans Bleu ("Certains Verts ne sont pas Bleus").
''',
  'Cesare': '''
L'ensemble Vert est un sous-ensemble de Rouge qui n'intersecte pas Bleu. Par conséquent, aucun élément de Vert ne peut appartenir à Bleu ("Aucun Vert n'est Bleu").
''',
  'Camestres': '''
L'ensemble Vert est un sous-ensemble de Bleu qui n'intersecte pas Rouge. Par conséquent, aucun élément de Rouge ne peut appartenir à Vert ("Aucun Rouge n'est Vert").
''',
  'Festino': '''
Par conséquent, dans "Certains Verts sont Rouges", nous avons supposé que les ensembles Vert et Rouge ne peuvent pas être vides. Dans le diagramme de Venn, la boule noire est un élément de Vert qui est également dans Rouge (en raison de la prémisse "Certains Verts sont Rouges").
###
La boule noire appartient à Vert et Rouge et, puisque Bleu et Rouge ne s'intersectent pas, elle n'appartient pas à Bleu. Par conséquent, "Certains Verts ne sont pas Bleus".
''',
  'Baroco': '''
Par conséquent, dans "Certains Verts ne sont pas Rouges", nous avons supposé que l'ensemble Vert a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Vert.
###
Puisque l'élément boule noire n'appartient pas à Rouge ("Certains Verts ne sont pas Rouges"), il n'appartient à aucun sous-ensemble de Rouge tel que Bleu. Par conséquent, "Certains Verts ne sont pas Bleus".
''',
  'Darapti': '''
Par conséquent, dans "certains Rouges existent", nous avons supposé que l'ensemble Rouge a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Rouge.
###
Puisque Rouge est un sous-ensemble de Bleu ("Tous les Rouges sont Bleus") et un sous-ensemble de Vert ("Tous les Rouges sont Verts"), la boule noire est un élément des deux ensembles, Vert et Bleu. Par conséquent, certains Verts sont Bleus (au moins la boule noire).
''',
  'Felapton': '''
Par conséquent, dans "certains Rouges existent", nous avons supposé que l'ensemble Rouge a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Rouge.
###
La boule noire est un élément de Rouge ("certains Rouges existent") mais pas un élément de Bleu ("Aucun Rouge n'est Bleu"). Puisque la boule noire est un élément de Vert ("Tous les Rouges sont Verts"), il existe des éléments de Vert (au moins la boule noire) qui ne sont pas des éléments de Bleu ("Certains Verts ne sont pas Bleus").
''',
  'Disamis': '''
Par conséquent, dans "Certains Rouges sont Bleus", nous avons supposé que l'ensemble Rouge a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Rouge.
###
La boule noire est un élément de Rouge et aussi un élément de Bleu ("Certains Rouges sont Bleus"). Puisque Rouge est un sous-ensemble de Vert ("Tous les Rouges sont Verts"), la boule noire est un élément de Vert. Par conséquent, il existe au moins un élément, la boule noire, qui est à la fois dans Vert et dans Bleu ("Certains Verts sont Bleus").
''',
  'Datisi': '''
Par conséquent, dans "Certains Rouges sont Verts", nous avons supposé que Rouge et Vert ne peuvent pas être vides. Dans le diagramme de Venn, la boule noire est un élément de Vert qui est dans Rouge (en raison de la prémisse "Certains Verts sont Rouges").
###
Puisque Rouge est un sous-ensemble de Bleu, les éléments communs de Vert et de Rouge (comme la boule noire) sont aussi Bleus ("Certains Verts sont Bleus").
''',
  'Bocardo': '''
Par conséquent, dans "Certains Rouges ne sont pas Bleus", nous avons supposé que Rouge ne peut pas être vide. Dans le diagramme de Venn, la boule noire est un élément de Rouge qui n'est pas dans Bleu.
###
Puisque la boule noire appartient aussi à Vert ("Tous les Rouges sont Verts"), il existe au moins un élément dans Vert, la boule noire, qui n'est pas dans Bleu. Par conséquent, "Certains Verts ne sont pas Bleus".
''',
  'Ferison': '''
Par conséquent, dans "Certains Rouges sont Verts", nous avons supposé que Rouge et Vert ne peuvent pas être vides. Dans le diagramme de Venn, la boule noire est un élément de Rouge qui est aussi dans Vert (en raison de la prémisse "Certains Rouges sont Verts").
###
Puisque la boule noire est dans l'ensemble Rouge qui n'intersecte pas l'ensemble Bleu, la boule noire n'est pas dans l'ensemble Bleu ("Certains Verts ne sont pas Bleus").
''',
  'Bamalip': '''
Par conséquent, dans "certains Bleus existent", nous avons supposé que l'ensemble Bleu a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Bleu.
###
Puisque la boule noire est dans Bleu, elle est aussi dans Rouge ("Tous les Bleus sont Rouges"). Puisqu'elle est dans Rouge, elle est aussi dans Vert ("Tous les Rouges sont Verts"). Par conséquent, "Certains Verts sont Bleus".
''',
  'Calemes': '''
L'ensemble Bleu est un sous-ensemble de Rouge qui n'intersecte pas Bleu. Par conséquent, aucun élément de Vert ne peut appartenir à Bleu ("Aucun Vert n'est Bleu").
''',
  'Dimatis': '''
Par conséquent, dans "Certains Verts sont Bleus", nous avons supposé que l'ensemble Vert a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Vert.
###
La boule noire est un élément de Vert et aussi un élément de Bleu ("Certains Verts sont Bleus"). Puisque Bleu est un sous-ensemble de Rouge ("Tous les Bleus sont Rouges"), la boule noire est un élément de Rouge. Par conséquent, il existe au moins un élément, la boule noire, qui est à la fois dans Rouge et dans Vert ("Certains Rouges sont Verts").
''',
  'Fesapo': '''
Par conséquent, dans "certains Rouges existent", nous avons supposé que l'ensemble Rouge a au moins un élément. Dans le diagramme de Venn, la boule noire est un élément de Rouge.
###
La boule noire est un élément de Rouge ("certains Rouges existent") mais pas un élément de Bleu ("Aucun Bleu n'est Rouge"). Puisque la boule noire est un élément de Vert ("Tous les Rouges sont Verts"), il existe des éléments de Vert (au moins la boule noire) qui ne sont pas des éléments de Bleu ("Certains Verts ne sont pas Bleus").
''',
  'Fresison': '''
Par conséquent, dans "Certains Rouges sont Verts", nous avons supposé que Rouge ne peut pas être vide. Dans le diagramme de Venn, la boule noire est un élément de Rouge qui est aussi dans Vert (en raison de la prémisse "Certains Rouges sont Verts").
###
Puisque l'ensemble Rouge n'intersecte pas l'ensemble Bleu ("Aucun Bleu n'est Rouge"), la boule noire n'est pas dans l'ensemble Bleu. Par conséquent, elle est dans Vert mais pas dans Bleu ("Certains Verts ne sont pas Bleus").
''',
};

Map<String, String> _syllogismexplanation_HI = {
  'Barbara': '''
वेन आरेख में, हरे रंग के सभी तत्व, आंतरिक सेट, नीले रंग के भी हैं, जो सबसे बाहरी सेट है। इसलिए, सभी हरे नीले हैं।
  ''',
  'Celarent': '''
हरा सेट लाल का एक उपसमुच्चय है जो नीले के साथ नहीं मिलता है। इसलिए, हरे रंग का कोई भी तत्व नीले रंग का नहीं हो सकता ("कोई हरा नीला नहीं है")।
  ''',
  'Darii': '''
इसलिए, "कुछ हरे लाल हैं" में, हमने माना कि हरा खाली नहीं हो सकता। वेन आरेख में, काली गेंद हरे रंग का एक तत्व है जो लाल रंग में है (क्योंकि "कुछ हरे लाल हैं" आधारिका के कारण)।
  ''',
  'Ferio': '''
इसलिए, "कुछ हरे लाल हैं" में, हमने माना कि हरा खाली नहीं हो सकता। वेन आरेख में, काली गेंद हरे रंग का एक तत्व है जो लाल रंग में भी है (क्योंकि "कुछ हरे लाल हैं" आधारिका के कारण)।
###
चूंकि लाल सेट नीले सेट को नहीं काटता है, इसलिए काली गेंद नीले सेट में नहीं है। इसलिए, यह हरे रंग में है लेकिन नीले रंग में नहीं ("कुछ हरे नीले नहीं हैं")।
  ''',
  'Cesare': '''
हरा सेट लाल का एक उपसमुच्चय है जो नीले के साथ नहीं मिलता है। इसलिए, हरे रंग का कोई भी तत्व नीले रंग का नहीं हो सकता ("कोई हरा नीला नहीं है")।
  ''',
  'Camestres': '''
हरा सेट नीले का एक उपसमुच्चय है जो लाल के साथ नहीं मिलता है। इसलिए, लाल रंग का कोई भी तत्व हरे रंग का नहीं हो सकता ("कोई लाल हरा नहीं है")।
  ''',
  'Festino': '''
इसलिए, "कुछ हरे लाल हैं" में, हमने माना कि हरे और लाल सेट खाली नहीं हो सकते। वेन आरेख में, काली गेंद हरे रंग का एक तत्व है जो लाल रंग में भी है (क्योंकि "कुछ हरे लाल हैं" आधारिका के कारण)।
###
काली गेंद हरे और लाल रंग की है और, चूंकि नीला और लाल नहीं मिलते, यह नीले रंग की नहीं है। इसलिए, "कुछ हरे नीले नहीं हैं"।
  ''',
  'Baroco': '''
इसलिए, "कुछ हरे लाल नहीं हैं" में, हमने माना कि सेट हरे में कम से कम एक तत्व है। वेन आरेख में, काली गेंद हरे रंग का एक तत्व है।
###
चूंकि काली गेंद तत्व लाल रंग की नहीं है ("कुछ हरे लाल नहीं हैं"), यह लाल रंग के किसी भी उपसमुच्चय जैसे नीले रंग की नहीं है। इसलिए, "कुछ हरे नीले नहीं हैं"।
  ''',
  'Darapti': '''
इसलिए, "कुछ लाल मौजूद हैं" में, हमने माना कि सेट लाल में कम से कम एक तत्व है। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है।
###
चूंकि लाल नीले का एक उपसमुच्चय है ("सभी लाल नीले हैं") और हरे का उपसमुच्चय ("सभी लाल हरे हैं"), काली गेंद हरे और नीले दोनों का एक तत्व है। इसलिए, कुछ हरे नीले हैं (कम से कम काली गेंद)।
  ''',
  'Felapton': '''
इसलिए, "कुछ लाल मौजूद हैं" में, हमने माना कि सेट लाल में कम से कम एक तत्व है। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है।
###
काली गेंद लाल रंग का एक तत्व है ("कुछ लाल मौजूद हैं") लेकिन नीले रंग का तत्व नहीं है ("कोई लाल नीला नहीं है")। चूंकि काली गेंद हरे रंग का एक तत्व है ("सभी लाल हरे हैं"), हरे रंग के तत्व हैं (कम से कम काली गेंद) जो नीले रंग के तत्व नहीं हैं ("कुछ हरे नीले नहीं हैं")।
  ''',
  'Disamis': '''
इसलिए, "कुछ लाल नीले हैं" में, हमने माना कि सेट लाल में कम से कम एक तत्व है। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है।
###
काली गेंद लाल रंग का एक तत्व है और नीले रंग का भी एक तत्व है ("कुछ लाल नीले हैं")। चूंकि लाल हरे रंग का एक उपसमुच्चय है ("सभी लाल हरे हैं"), काली गेंद हरे रंग का एक तत्व है। इसलिए, कम से कम एक तत्व है, काली गेंद, जो हरे और नीले दोनों में है ("कुछ हरे नीले हैं")।
  ''',
  'Datisi': '''
इसलिए, "कुछ लाल हरे हैं" में, हमने माना कि लाल और हरा दोनों खाली नहीं हो सकते। वेन आरेख में, काली गेंद हरे रंग का एक तत्व है जो लाल रंग में है (क्योंकि "कुछ हरे लाल हैं" आधारिका के कारण)।
###
चूंकि लाल नीले का उपसमुच्चय है, हरे और लाल के सामान्य तत्व (जैसे काली गेंद) भी नीले हैं ("कुछ हरे नीले हैं")।
  ''',
  'Bocardo': '''
इसलिए, "कुछ लाल नीले नहीं हैं" में, हमने माना कि लाल खाली नहीं हो सकता। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है जो नीले रंग में नहीं है।
###
चूंकि काली गेंद हरे रंग की भी है ("सभी लाल हरे हैं"), हरे रंग में कम से कम एक तत्व है, काली गेंद, जो नीले रंग में नहीं है। इसलिए, "कुछ हरे नीले नहीं हैं"।
  ''',
  'Ferison': '''
इसलिए, "कुछ लाल हरे हैं" में, हमने माना कि लाल और हरा दोनों खाली नहीं हो सकते। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है जो हरे रंग में भी है (क्योंकि "कुछ लाल हरे हैं" आधारिका के कारण)।
###
चूंकि काली गेंद लाल सेट में है जो नीले सेट को नहीं काटता है, काली गेंद नीले सेट में नहीं है ("कुछ हरे नीले नहीं हैं")।
  ''',
  'Bamalip': '''
इसलिए, "कुछ नीले मौजूद हैं" में, हमने माना कि सेट नीले में कम से कम एक तत्व है। वेन आरेख में, काली गेंद नीले रंग का एक तत्व है।
###
चूंकि काली गेंद नीले रंग में है, यह लाल रंग में भी है ("सभी नीले लाल हैं")। चूंकि यह लाल रंग में है, यह हरे रंग में भी है ("सभी लाल हरे हैं")। इसलिए, "कुछ हरे नीले हैं"।
  ''',
  'Calemes': '''
नीला सेट लाल का एक उपसमुच्चय है जो नीले के साथ नहीं मिलता है। इसलिए, हरे रंग का कोई भी तत्व नीले रंग का नहीं हो सकता ("कोई हरा नीला नहीं है")।
  ''',
  'Dimatis': '''
इसलिए, "कुछ हरे नीले हैं" में, हमने माना कि सेट हरे में कम से कम एक तत्व है। वेन आरेख में, काली गेंद हरे रंग का एक तत्व है।
###
काली गेंद हरे रंग का एक तत्व है और नीले रंग का भी एक तत्व है ("कुछ हरे नीले हैं")। चूंकि नीला लाल रंग का एक उपसमुच्चय है ("सभी नीले लाल हैं"), काली गेंद लाल रंग का एक तत्व है। इसलिए, कम से कम एक तत्व है, काली गेंद, जो लाल और हरे दोनों में है ("कुछ लाल हरे हैं")।
  ''',
  'Fesapo': '''
इसलिए, "कुछ लाल मौजूद हैं" में, हमने माना कि सेट लाल में कम से कम एक तत्व है। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है।
###
काली गेंद लाल रंग का एक तत्व है ("कुछ लाल मौजूद हैं") लेकिन नीले रंग का तत्व नहीं है ("कोई नीला लाल नहीं है")। चूंकि काली गेंद हरे रंग का एक तत्व है ("सभी लाल हरे हैं"), हरे रंग के तत्व हैं (कम से कम काली गेंद) जो नीले रंग के तत्व नहीं हैं ("कुछ हरे नीले नहीं हैं")।
  ''',
  'Fresison': '''
इसलिए, "कुछ लाल हरे हैं" में, हमने माना कि लाल खाली नहीं हो सकता। वेन आरेख में, काली गेंद लाल रंग का एक तत्व है जो हरे रंग में भी है (क्योंकि "कुछ लाल हरे हैं" आधारिका के कारण)।
###
चूंकि लाल सेट नीले सेट को नहीं काटता है ("कोई नीला लाल नहीं है"), काली गेंद नीले सेट में नहीं है। इसलिए, यह हरे रंग में है लेकिन नीले रंग में नहीं ("कुछ हरे नीले नहीं हैं")।
  '''
};

Map<String, String> _syllogismexplanation_JA = {
  'Barbara': '''
ベン図では、内側の集合である緑色のすべての要素は、最も外側の集合である青色にも属しています。したがって、すべての緑は青です。
  ''',
  'Celarent': '''
緑色の集合は、青色と交差しない赤色の部分集合です。したがって、緑色の要素は青色に属することができません（「緑は青ではない」）。
  ''',
  'Darii': '''
したがって、「いくつかの緑は赤である」では、緑は空ではないと仮定しました。ベン図では、黒いボールは「いくつかの緑は赤である」という前提のため、赤色にある緑色の要素です。
  ''',
  'Ferio': '''
したがって、「いくつかの緑は赤である」では、緑は空ではないと仮定しました。ベン図では、黒いボールは「いくつかの緑は赤である」という前提のため、赤色にもある緑色の要素です。
###
赤い集合は青い集合と交差しないため、黒いボールは青い集合にはありません。したがって、それは緑色にはありますが、青色にはありません（「いくつかの緑は青ではない」）。
  ''',
  'Cesare': '''
緑色の集合は、青色と交差しない赤色の部分集合です。したがって、緑色の要素は青色に属することができません（「緑は青ではない」）。
  ''',
  'Camestres': '''
緑色の集合は、赤色と交差しない青色の部分集合です。したがって、赤色の要素は緑色に属することができません（「赤は緑ではない」）。
  ''',
  'Festino': '''
したがって、「いくつかの緑は赤である」では、緑色と赤色の集合は空ではないと仮定しました。ベン図では、黒いボールは「いくつかの緑は赤である」という前提のため、赤色にもある緑色の要素です。
###
黒いボールは緑色と赤色に属し、青色と赤色は交差しないため、青色には属しません。したがって、「いくつかの緑は青ではない」。
  ''',
  'Baroco': '''
したがって、「いくつかの緑は赤ではない」では、集合緑には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは緑色の要素です。
###
黒いボール要素は赤色に属さないため（「いくつかの緑は赤ではない」）、青色などの赤色の部分集合には属しません。したがって、「いくつかの緑は青ではない」。
  ''',
  'Darapti': '''
したがって、「いくつかの赤が存在する」では、集合赤には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは赤色の要素です。
###
赤は青色の部分集合（「すべての赤は青である」）であり、緑色の部分集合（「すべての赤は緑である」）であるため、黒いボールは緑色と青色の両方の要素です。したがって、いくつかの緑は青です（少なくとも黒いボール）。
  ''',
  'Felapton': '''
したがって、「いくつかの赤が存在する」では、集合赤には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは赤色の要素です。
###
黒いボールは赤色の要素（「いくつかの赤が存在する」）ですが、青色の要素ではありません（「赤は青ではない」）。黒いボールは緑色の要素（「すべての赤は緑である」）であるため、青色の要素ではない緑色の要素（少なくとも黒いボール）があります（「いくつかの緑は青ではない」）。
  ''',
  'Disamis': '''
したがって、「いくつかの赤は青である」では、集合赤には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは赤色の要素です。
###
黒いボールは赤色の要素であり、青色の要素でもあります（「いくつかの赤は青である」）。赤は緑色の部分集合（「すべての赤は緑である」）であるため、黒いボールは緑色の要素です。したがって、緑色と青色の両方にある少なくとも1つの要素、黒いボールがあります（「いくつかの緑は青である」）。
  ''',
  'Datisi': '''
したがって、「いくつかの赤は緑である」では、赤と緑の両方が空ではないと仮定しました。ベン図では、黒いボールは「いくつかの緑は赤である」という前提のため、赤色にある緑色の要素です。
###
赤は青色の部分集合であるため、緑と赤の共通要素（黒いボールなど）も青色です（「いくつかの緑は青である」）。
  ''',
  'Bocardo': '''
したがって、「いくつかの赤は青ではない」では、赤は空ではないと仮定しました。ベン図では、黒いボールは青色ではない赤色の要素です。
###
黒いボールは緑色にも属しているため（「すべての赤は緑である」）、緑色には少なくとも1つの要素、黒いボールがあり、青色にはありません。したがって、「いくつかの緑は青ではない」。
  ''',
  'Ferison': '''
したがって、「いくつかの赤は緑である」では、赤と緑の両方が空ではないと仮定しました。ベン図では、黒いボールは「いくつかの赤は緑である」という前提のため、緑色にもある赤色の要素です。
###
黒いボールは、青い集合と交差しない赤い集合にあるため、黒いボールは青い集合にはありません（「いくつかの緑は青ではない」）。
  ''',
  'Bamalip': '''
したがって、「いくつかの青が存在する」では、集合青には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは青色の要素です。
###
黒いボールは青色にあるため、赤色にもあります（「すべての青は赤である」）。赤色にあるため、緑色にもあります（「すべての赤は緑である」）。したがって、「いくつかの緑は青である」。
  ''',
  'Calemes': '''
青色の集合は、青色と交差しない赤色の部分集合です。したがって、緑色の要素は青色に属することができません（「緑は青ではない」）。
  ''',
  'Dimatis': '''
したがって、「いくつかの緑は青である」では、集合緑には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは緑色の要素です。
###
黒いボールは緑色の要素であり、青色の要素でもあります（「いくつかの緑は青である」）。青は赤色の部分集合（「すべての青は赤である」）であるため、黒いボールは赤色の要素です。したがって、少なくとも1つの要素、黒いボールがあり、赤と緑の両方にあります（「いくつかの赤は緑である」）。
  ''',
  'Fesapo': '''
したがって、「いくつかの赤が存在する」では、集合赤には少なくとも1つの要素があると仮定しました。ベン図では、黒いボールは赤色の要素です。
###
黒いボールは赤色の要素（「いくつかの赤が存在する」）ですが、青色の要素ではありません（「青は赤ではない」）。黒いボールは緑色の要素（「すべての赤は緑である」）であるため、青色の要素ではない緑色の要素（少なくとも黒いボール）があります（「いくつかの緑は青ではない」）。
  ''',
  'Fresison': '''
したがって、「いくつかの赤は緑である」では、赤は空ではないと仮定しました。ベン図では、黒いボールは「いくつかの赤は緑である」という前提のため、緑色にもある赤色の要素です。
###
赤い集合は青い集合と交差しないため（「青は赤ではない」）、黒いボールは青い集合にはありません。したがって、それは緑色にはありますが、青色にはありません（「いくつかの緑は青ではない」）。
  '''
};

Map<String, String> _syllogismexplanation_ES = {
  'Barbara': '''
En el diagrama de Venn, todos los elementos del conjunto interior Verde también pertenecen al conjunto más exterior Azul. Por lo tanto, todos los Verdes son Azules.
  ''',
  'Celarent': '''
El conjunto Verde es un subconjunto de Rojo que no se cruza con Azul. Por lo tanto, ningún elemento de Verde puede pertenecer a Azul ("Ningún Verde es Azul").
  ''',
  'Darii': '''
Por lo tanto, en "Algunos Verdes son Rojos", asumimos que Verde no puede estar vacío. En el diagrama de Venn, la bola negra es un elemento en Verde que está en Rojo (debido a la premisa "Algunos Verdes son Rojos").
  ''',
  'Ferio': '''
Por lo tanto, en "Algunos Verdes son Rojos", asumimos que Verde no puede estar vacío. En el diagrama de Venn, la bola negra es un elemento en Verde que también está en Rojo (debido a la premisa "Algunos Verdes son Rojos").
###
Dado que el conjunto Rojo no se interseca con el conjunto Azul, la bola negra no está en el conjunto Azul. Por lo tanto, está en Verde pero no en Azul ("Algunos Verdes no son Azules").
  ''',
  'Cesare': '''
El conjunto Verde es un subconjunto de Rojo que no se cruza con Azul. Por lo tanto, ningún elemento de Verde puede pertenecer a Azul ("Ningún Verde es Azul").
  ''',
  'Camestres': '''
El conjunto Verde es un subconjunto de Azul que no se cruza con Rojo. Por lo tanto, ningún elemento de Rojo puede pertenecer a Verde ("Ningún Rojo es Verde").
  ''',
  'Festino': '''
Por lo tanto, en "Algunos Verdes son Rojos", asumimos que los conjuntos Verde y Rojo no pueden estar vacíos. En el diagrama de Venn, la bola negra es un elemento en Verde que también está en Rojo (debido a la premisa "Algunos Verdes son Rojos").
###
La bola negra pertenece a Verde y Rojo y, dado que Azul y Rojo no se intersecan, no pertenece a Azul. Por lo tanto, "Algunos Verdes no son Azules".
  ''',
  'Baroco': '''
Por lo tanto, en "Algunos Verdes no son Rojos", asumimos que el conjunto Verde tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Verde.
###
Dado que el elemento de la bola negra no pertenece a Rojo ("Algunos Verdes no son Rojos"), no pertenece a ningún subconjunto de Rojo como Azul. Por lo tanto, "Algunos Verdes no son Azules".
  ''',
  'Darapti': '''
Por lo tanto, en "algunos Rojos existen", asumimos que el conjunto Rojo tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Rojo.
###
Dado que Rojo es un subconjunto de Azul ("Todos los Rojos son Azules") y subconjunto de Verde ("Todos los Rojos son Verdes"), la bola negra es un elemento tanto de Verde como de Azul. Por lo tanto, algunos Verdes son Azules (al menos la bola negra).
  ''',
  'Felapton': '''
Por lo tanto, en "algunos Rojos existen", asumimos que el conjunto Rojo tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Rojo.
###
La bola negra es un elemento de Rojo ("algunos Rojos existen") pero no un elemento de Azul ("Ningún Rojo es Azul"). Dado que la bola negra es un elemento de Verde ("Todos los Rojos son Verdes"), hay elementos de Verde (al menos la bola negra) que no son elementos de Azul ("Algunos Verdes no son Azules").
  ''',
  'Disamis': '''
Por lo tanto, en "Algunos Rojos son Azules", asumimos que el conjunto Rojo tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Rojo.
###
La bola negra es un elemento de Rojo y también un elemento de Azul ("Algunos Rojos son Azules"). Dado que Rojo es un subconjunto de Verde ("Todos los Rojos son Verdes"), la bola negra es un elemento de Verde. Por lo tanto, hay al menos un elemento, la bola negra, que está tanto en Verde como en Azul ("Algunos Verdes son Azules").
  ''',
  'Datisi': '''
Por lo tanto, en "Algunos Rojos son Verdes", asumimos que tanto Rojo como Verde no pueden estar vacíos. En el diagrama de Venn, la bola negra es un elemento en Verde que está en Rojo (debido a la premisa "Algunos Verdes son Rojos").
###
Dado que Rojo es subconjunto de Azul, los elementos comunes de Verde y Rojo (como la bola negra) también son Azules ("Algunos Verdes son Azules").
  ''',
  'Bocardo': '''
Por lo tanto, en "Algunos Rojos no son Azules", asumimos que Rojo no puede estar vacío. En el diagrama de Venn, la bola negra es un elemento en Rojo que no está en Azul.
###
Dado que la bola negra también pertenece a Verde ("Todos los Rojos son Verdes"), hay al menos un elemento en Verde, la bola negra, que no está en Azul. Por lo tanto, "Algunos Verdes no son Azules".
  ''',
  'Ferison': '''
Por lo tanto, en "Algunos Rojos son Verdes", asumimos que tanto Rojo como Verde no pueden estar vacíos. En el diagrama de Venn, la bola negra es un elemento en Rojo que también está en Verde (debido a la premisa "Algunos Rojos son Verdes").
###
Dado que la bola negra está en el conjunto Rojo que no se interseca con el conjunto Azul, la bola negra no está en el conjunto Azul ("Algunos Verdes no son Azules").
  ''',
  'Bamalip': '''
Por lo tanto, en "algunos Azules existen", asumimos que el conjunto Azul tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Azul.
###
Dado que la bola negra está en Azul, también está en Rojo ("Todos los Azules son Rojos"). Dado que está en Rojo, también está en Verde ("Todos los Rojos son Verdes"). Por lo tanto, "Algunos Verdes son Azules".
  ''',
  'Calemes': '''
El conjunto Azul es un subconjunto de Rojo que no se cruza con Azul. Por lo tanto, ningún elemento de Verde puede pertenecer a Azul ("Ningún Verde es Azul").
  ''',
  'Dimatis': '''
Por lo tanto, en "Algunos Verdes son Azules", asumimos que el conjunto Verde tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Verde.
###
La bola negra es un elemento de Verde y también un elemento de Azul ("Algunos Verdes son Azules"). Dado que Azul es un subconjunto de Rojo ("Todos los Azules son Rojos"), la bola negra es un elemento de Rojo. Por lo tanto, hay al menos un elemento, la bola negra, que está tanto en Rojo como en Verde ("Algunos Rojos son Verdes").
  ''',
  'Fesapo': '''
Por lo tanto, en "algunos Rojos existen", asumimos que el conjunto Rojo tiene al menos un elemento. En el diagrama de Venn, la bola negra es un elemento de Rojo.
###
La bola negra es un elemento de Rojo ("algunos Rojos existen") pero no un elemento de Azul ("Ningún Azul es Rojo"). Dado que la bola negra es un elemento de Verde ("Todos los Rojos son Verdes"), hay elementos de Verde (al menos la bola negra) que no son elementos de Azul ("Algunos Verdes no son Azules").
  ''',
  'Fresison': '''
Por lo tanto, en "Algunos Rojos son Verdes", asumimos que Rojo no puede estar vacío. En el diagrama de Venn, la bola negra es un elemento en Rojo que también está en Verde (debido a la premisa "Algunos Rojos son Verdes").
###
Dado que el conjunto Rojo no se interseca con el conjunto Azul ("Ningún Azul es Rojo"), la bola negra no está en el conjunto Azul. Por lo tanto, está en Verde pero no en Azul ("Algunos Verdes no son Azules").
  '''
};

String _standardStartExplanation_en = '''
  The premises and conclusion represent the relationship between sets.
    For example, "All mammals are animals" means that the set of mammals is a
    subset of the set of animals. Sets can be represented in Venn diagrams.
    In this example the 
    ball representing the mammal set would be inside
    the ball for the  animal set.

    ###

    If one
    premise or conclusion is "All Green are Blue", it means that the set Green is a subset
    of the set Blue and the Green ball is inside the Blue ball in the Venn diagram. 


    ###
    If a premise or conclusion is "No Green are Blue", it means that the Green ball and 
    the Blue ball do not intersect and there is no element in the set Green that belongs
    to the set Blue (and vice-versa). 


    ###
    
    If a premise or conclusion is "Some Green are Red", it means that the Green ball and 
    the Red ball intersect and there
    is at least one element in the set Green that belongs to the set Red, 
    which is represented by a small black ball.
    

    ###
    If the premise or conclusion is "Some Green are not Blue", it means
    the Green ball may or may not intersect the Blue ball, but there is
    at least one element in the set Green that does not belong to the set Blue. This 
    element is represented by a small black ball. Although the set Green may
    not intersect the set Blue, the Venn diagram shows they intersect (the 
    intersection may be empty).
''';

String _standardStartExplanation_ar = '''
تمثل المقدمات والاستنتاجات العلاقة بين المجموعات.
على سبيل المثال، تعني عبارة "جميع الثدييات حيوانات" أن مجموعة الثدييات هي
مجموعة فرعية من مجموعة الحيوانات. ويمكن تمثيل المجموعات في مخططات فين.
في هذا المثال، ستكون الكرة التي تمثل مجموعة الثدييات داخل
الكرة الخاصة بمجموعة الحيوانات.

###

إذا كانت إحدى المقدمات أو الاستنتاجات هي "كل الأخضر أزرق"، فهذا يعني أن المجموعة الخضراء هي مجموعة فرعية
من المجموعة الزرقاء وأن الكرة الخضراء موجودة داخل الكرة الزرقاء في مخطط فين.

###
إذا كانت المقدمة أو الاستنتاج هي "لا يوجد أخضر أزرق"، فهذا يعني أن الكرة الخضراء والكرة الزرقاء لا تتقاطعان ولا يوجد عنصر في المجموعة الخضراء ينتمي
إلى المجموعة الزرقاء (والعكس صحيح).

###

إذا كانت المقدمة أو النتيجة هي "بعض الأخضر أحمر"، فهذا يعني أن الكرة الخضراء والكرة الحمراء تتقاطعان وأن هناك عنصرًا واحدًا على الأقل في المجموعة الخضراء ينتمي إلى المجموعة الحمراء،
والذي يتم تمثيله بواسطة كرة سوداء صغيرة.

###
إذا كانت المقدمة أو النتيجة هي "بعض الأخضر ليس أزرق"، فهذا يعني أن الكرة الخضراء قد تتقاطع أو لا تتقاطع مع الكرة الزرقاء، ولكن هناك عنصرًا واحدًا على الأقل في المجموعة الخضراء لا ينتمي إلى المجموعة الزرقاء. يتم تمثيل هذا العنصر بواسطة كرة سوداء صغيرة. على الرغم من أن المجموعة الخضراء قد لا تتقاطع مع المجموعة الزرقاء، إلا أن مخطط فين يوضح تقاطعهما (قد يكون التقاطع فارغًا).

'';
''';

String _standardStartExplanation_zh = '''
前提和结论表示集合之间的关系。
例如，“所有哺乳动物都是动物”意味着哺乳动物集合是动物集合的子集。集合可以用维恩图表示。在这个例子中，代表哺乳动物集合的圆将位于代表动物集合的圆内。

如果一个前提或结论是“所有绿色都是蓝色”，这意味着绿色集合是蓝色集合的子集，并且在维恩图中，代表绿色集合的圆位于代表蓝色集合的圆内。

如果一个前提或结论是“没有绿色是蓝色”，这意味着绿色圆和蓝色圆没有交集，绿色集合中没有任何元素属于蓝色集合，反之亦然。

如果一个前提或结论是“一些绿色是红色”，这意味着绿色圆和红色圆相交，并且绿色集合中至少有一个元素属于红色集合，这由一个小黑点表示。

如果一个前提或结论是“一些绿色不是蓝色”，这意味着绿色圆可能与蓝色圆相交，也可能不相交，但至少有一个绿色集合中的元素不属于蓝色集合。这个元素由一个小黑点表示。尽管绿色集合可能不与蓝色集合相交，但在维恩图中，它们会被显示为相交（这个交集可能为空）。
''';

String _standardStartExplanation_de = '''
Die Prämissen und Schlussfolgerungen stellen die Beziehung zwischen Mengen dar.
Beispiel: „Alle Säugetiere sind Tiere“ bedeutet, dass die Menge der Säugetiere eine
Teilmenge der Menge der Tiere ist. Mengen können in Venn-Diagrammen dargestellt werden.
In diesem Beispiel würde sich die
Kugel, die die Menge der Säugetiere darstellt, innerhalb
der Kugel für die Menge der Tiere befinden.

###

Wenn eine
Prämisse oder Schlussfolgerung lautet: „Alle Grünen sind Blau“, bedeutet dies, dass die Menge Grün eine
Teilmenge
der Menge Blau ist und sich die grüne Kugel im Venn-Diagramm innerhalb der blauen Kugel befindet.

###
Wenn eine Prämisse oder Schlussfolgerung lautet: „Keine Grünen sind Blau“, bedeutet dies, dass sich die grüne Kugel und
die blaue Kugel nicht schneiden und es in der Menge Grün kein Element gibt, das
zur Menge Blau gehört (und umgekehrt).

###

Wenn eine Prämisse oder Schlussfolgerung lautet: „Einige Grüne sind Rot“, bedeutet dies, dass sich die grüne Kugel und die rote Kugel schneiden und es mindestens ein Element in der Menge Grün gibt, das zur Menge Rot gehört, das durch eine kleine schwarze Kugel dargestellt wird.

###
Wenn die Prämisse oder Schlussfolgerung lautet: „Einige Grüne sind nicht Blau“, bedeutet dies, dass sich die grüne Kugel möglicherweise mit der blauen Kugel schneidet, aber es mindestens ein Element in der Menge Grün gibt, das nicht zur Menge Blau gehört. Dieses Element wird durch eine kleine schwarze Kugel dargestellt. Obwohl sich die Menge Grün möglicherweise nicht mit der Menge Blau schneidet, zeigt das Venn-Diagramm, dass sie sich schneiden (die Schnittmenge kann leer sein).

''';

String _standardStartExplanation_fr = '''
Les prémisses et la conclusion représentent la relation entre les ensembles.
Par exemple, « Tous les mammifères sont des animaux » signifie que l'ensemble des mammifères est un
sous-ensemble de l'ensemble des animaux. Les ensembles peuvent être représentés dans des diagrammes de Venn.
Dans cet exemple, la
boule représentant l'ensemble des mammifères serait à l'intérieur
de la boule de l'ensemble des animaux.

###

Si une
prémisse ou conclusion est "Tous les Verts sont Bleus", cela signifie que l'ensemble Vert est un
sous-ensemble de l'ensemble Bleu et que la boule Verte est à l'intérieur de la boule Bleue dans le diagramme de Venn.

###
Si une prémisse ou conclusion est "Aucun Vert n'est Bleu", cela signifie que la boule Verte et la
boule Bleue ne se croisent pas et qu'il n'y a aucun élément dans l'ensemble Vert qui
appartient à l'ensemble Bleu (et vice-versa).

###

Si une prémisse ou une conclusion est "Certains Verts sont Rouges", cela signifie que la boule Verte et la boule Rouge se croisent et qu'il y a au moins un élément dans l'ensemble Vert qui appartient à l'ensemble Rouge, qui est représenté par une petite boule noire.

###
Si la prémisse ou la conclusion est "Certains Verts ne sont pas Bleus", cela signifie que la boule Verte peut ou non croiser la boule Bleue, mais qu'il y a au moins un élément dans l'ensemble Vert qui n'appartient pas à l'ensemble Bleu. Cet élément est représenté par une petite boule noire. Bien que l'ensemble Vert ne puisse pas croiser l'ensemble Bleu, le diagramme de Venn montre qu'ils se croisent (l'intersection peut être vide).
''';
String _standardStartExplanation_hi = '''
आधार और निष्कर्ष सेटों के बीच संबंध को दर्शाते हैं। उदाहरण के लिए, "सभी स्तनधारी जानवर हैं" का अर्थ है कि स्तनधारियों का सेट जानवरों के सेट का एक उपसमूह है। सेटों को वेन आरेखों में दर्शाया जा सकता है। इस उदाहरण में स्तनधारी सेट का प्रतिनिधित्व करने वाली गेंद जानवरों के सेट के लिए गेंद के अंदर होगी। ### यदि एक आधार या निष्कर्ष "सभी हरे नीले हैं" है, तो इसका मतलब है कि सेट हरा नीले सेट का एक उपसमूह है और वेन आरेख में हरी गेंद नीली गेंद के अंदर है। ### यदि कोई आधार या निष्कर्ष "कोई हरा नीला नहीं है" है, तो इसका मतलब है कि हरी गेंद और नीली गेंद एक दूसरे को नहीं काटती हैं और सेट हरे में कोई भी तत्व नहीं है जो नीले सेट से संबंधित है (और इसके विपरीत)। ###

यदि आधार या निष्कर्ष "कुछ हरे लाल हैं" है, तो इसका मतलब है कि हरी गेंद और लाल गेंद एक दूसरे को काटती हैं और हरे सेट में कम से कम एक तत्व ऐसा है जो लाल सेट से संबंधित है, जिसे एक छोटी काली गेंद द्वारा दर्शाया गया है।

###
यदि आधार या निष्कर्ष "कुछ हरे नीले नहीं हैं" है, तो इसका मतलब है कि हरी गेंद नीली गेंद को काट सकती है या नहीं भी काट सकती है, लेकिन हरे सेट में कम से कम एक तत्व ऐसा है जो नीले सेट से संबंधित नहीं है। इस तत्व को एक छोटी काली गेंद द्वारा दर्शाया गया है। हालाँकि हरा सेट नीले सेट को काट नहीं सकता है, लेकिन वेन आरेख दिखाता है कि वे एक दूसरे को काटते हैं (प्रतिच्छेदन खाली हो सकता है)।
''';

String _standardStartExplanation_ja = '''
前提と結論は、集合間の関係を表します。
たとえば、「すべての哺乳類は動物である」は、哺乳類の集合が動物の集合のサブセットであることを意味します。集合はベン図で表すことができます。
この例では、哺乳類の集合を表すボールは、動物の集合を表すボールの内側にあります。

###

前提または結論の 1 つが「すべての緑は青である」である場合、それは、集合緑が集合青のサブセットであり、ベン図で緑のボールが青のボールの内側にあることを意味します。

###
前提または結論が「どの緑も青ではない」である場合、それは、緑のボールと青のボールが交差しておらず、集合緑には集合青に属する要素がない (逆も同様) ことを意味します。

###

前提または結論が「一部の緑は赤である」である場合、それは緑のボールと赤のボールが交差し、緑のセットに赤のセットに属する要素が少なくとも 1 つあり、それが小さな黒いボールで表されていることを意味します。

###
前提または結論が「一部の緑は青ではない」である場合、それは緑のボールが青のボールと交差する場合もそうでない場合もありますが、緑のセットに青のセットに属さない要素が少なくとも 1 つあることを意味します。この要素は小さな黒いボールで表されます。緑のセットは青のセットと交差しない可能性がありますが、ベン図では交差していることが示されています (交差は空である可能性があります)。

''';
String _standardStartExplanation_pt = '''
As premissas e a conclusão representam a relação entre conjuntos.
Por exemplo, "Todos os mamíferos são animais" significa que o conjunto de mamíferos é um
subconjunto do conjunto de animais. Os conjuntos podem ser representados em diagramas de Venn.
Neste exemplo, a
bola que representa o conjunto de mamíferos estaria dentro
da bola para o conjunto de animais.

###

Se uma
premissa ou conclusão for "Todos os Verdes são Azuis", significa que o conjunto Verde é um subconjunto
do conjunto Azul e a bola Verde está dentro da bola Azul no diagrama de Venn.

###
Se uma premissa ou conclusão for "Nenhum Verde é Azul", significa que a bola Verde e
a bola Azul não se cruzam e não há nenhum elemento no conjunto Verde que pertença
ao conjunto Azul (e vice-versa).

###

Se uma premissa ou conclusão for "Alguns Verdes são Vermelhos", significa que a bola Verde e
a bola Vermelha se cruzam e há
pelo menos um elemento no conjunto Verde que pertence ao conjunto Vermelho,
que é representado por uma pequena bola preta.

###
Se a premissa ou conclusão for "Alguns Verdes não são Azuis", significa
que a bola Verde pode ou não cruzar a bola Azul, mas há
pelo menos um elemento no conjunto Verde que não pertence ao conjunto Azul. Este
elemento é representado por uma pequena bola preta. Embora o conjunto Verde possa
não cruzar o conjunto Azul, o diagrama de Venn mostra que eles se cruzam (a
intersecção pode estar vazia).
''';
String _standardStartExplanation_es = '''
Las premisas y la conclusión representan la relación entre conjuntos.
Por ejemplo, "Todos los mamíferos son animales" significa que el conjunto de mamíferos es un
subconjunto del conjunto de animales. Los conjuntos se pueden representar en diagramas de Venn.
En este ejemplo, la bola que representa al conjunto de mamíferos estaría dentro
de la bola del conjunto de animales.

###

Si una
premisa o conclusión es "Todos los verdes son azules", significa que el conjunto Verde es un subconjunto
del conjunto Azul y la bola Verde está dentro de la bola Azul en el diagrama de Venn.

###
Si una premisa o conclusión es "Ningún verde es azul", significa que la bola Verde y la bola Azul no se intersecan y no hay ningún elemento en el conjunto Verde que pertenezca
al conjunto Azul (y viceversa).

###

Si una premisa o conclusión es "Algunas bolas verdes son rojas", significa que la bola verde y la bola roja se intersecan y hay
al menos un elemento en el conjunto verde que pertenece al conjunto rojo, que está representado por una bola negra pequeña.

###
Si la premisa o conclusión es "Algunas bolas verdes no son azules", significa
que la bola verde puede o no intersecar a la bola azul, pero hay
al menos un elemento en el conjunto verde que no pertenece al conjunto azul. Este elemento está representado por una bola negra pequeña. Aunque el conjunto verde puede
no intersecar al conjunto azul, el diagrama de Venn muestra que se intersecan (la intersección puede estar vacía).
''';
/*  /// remove all \r, \n, \t, and extra spaces. Leave only one space between words.
    _standardStartExplanation =
        _standardStartExplanation.replaceAll(RegExp(r'\s+'), ' ').trim();
    _standardStartExplanation =
        _standardStartExplanation.replaceAll('###', '\r\n');
  }
*/

String explainSyllogism(BuildContext context, String syllogism) {
  /// put syllogism with a capital letter followed by lowercase letter
  syllogism = syllogism[0].toUpperCase() + syllogism.substring(1).toLowerCase();
  if (syllogism == 'Bramantip') {
    syllogism = 'Bamalip';
  }
  syllogism = syllogism.trim();
  int currentIndexLanguage =
      Provider.of<LanguageProvider>(context, listen: false)
          .currentLanguageIndex;

  Map<int, String> _standardStartExplanation = {
    0: _standardStartExplanation_ar, // Árabe
    1: _standardStartExplanation_zh, // Mandarim
    2: _standardStartExplanation_de, // Alemão
    3: _standardStartExplanation_en, // Inglês
    4: _standardStartExplanation_fr, // Francês
    5: _standardStartExplanation_hi, // Hindi
    6: _standardStartExplanation_ja, // Japonês
    7: _standardStartExplanation_pt, // Português
    8: _standardStartExplanation_es, // Espanhol
  };

  Map<int, Map<String, String>> syllogismExplanations = {
    0: _syllogismexplanation_AR, // Árabe
    1: _syllogismexplanation_ZH, // Mandarim
    2: _syllogismexplanation_DE, // Alemão
    3: _syllogismexplanation, // Inglês
    4: _syllogismexplanation_FR, // Francês
    5: _syllogismexplanation_HI, // Hindi
    6: _syllogismexplanation_JA, // Japonês
    7: _syllogismexplanation_PT, // Português
    8: _syllogismexplanation_ES, // Espanhol
  };

  Map<String, String>? selectedExplanation =
      syllogismExplanations[currentIndexLanguage];

  String? s = selectedExplanation?[syllogism];

  if (s == null) {
    return '';
  }
  String standardStartExplanation =
      _standardStartExplanation[currentIndexLanguage]!;
  standardStartExplanation =
      standardStartExplanation.replaceAll(RegExp(r'\n+'), ' ').trim();
  standardStartExplanation =
      standardStartExplanation.replaceAll(RegExp(r'[\s\t]+'), ' ').trim();

  s = s.replaceAll(RegExp(r'\n+'), ' ').trim();
  s = s.replaceAll(RegExp(r'[\s\t]+'), ' ').trim();
  standardStartExplanation =
      standardStartExplanation.replaceAll('###', '\r\n\n');

  String retorno = '$standardStartExplanation\r\n\n$s';
  retorno = retorno.replaceAll('###', '\r\n');

  return retorno;
}

Widget selectableSyllogismText(BuildContext context, String syllogism) {
  String explanation = explainSyllogism(context, syllogism);
  List<String> paragraphs = explanation.split('\r\n\n');
  List<TextSpan> textSpans = [];

  for (int i = 0; i < paragraphs.length; i++) {
    textSpans.add(
      TextSpan(
        text: '${paragraphs[i]}\r\n\n',
        style: TextStyle(
          fontWeight:
              i == paragraphs.length - 1 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  return SelectableText.rich(
    TextSpan(
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width >
                MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height * 0.025
            : MediaQuery.of(context).size.height * 0.025,
      ),
      children: textSpans,
    ),
    textAlign: TextAlign.justify,
  );
}
