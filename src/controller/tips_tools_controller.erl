-module(tips_tools_controller, [Req]).
-compile(export_all).

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

anagram('GET', []) ->
    %%{ok, []}.
    {ok, [{title, "Anagram"}, 
	  {description, "Anagram"}, 
	  {keywords, "anagram,permutation, anagramma,permutazione,parola,word"}]};
   
anagram('POST', []) ->
    %%Word = Req:param("word"),
    Word = Req:post_param("word"),
    ShortWord = lists:sublist(Word, 10),
    {ok, [{title, "Anagram"}, 
	  {description, "Anagram"}, 
	  {keywords, "anagram,permutation,anagramma,permutazione,parola,word"}, {words, perms(ShortWord)}]}.

index('GET', []) ->
    {ok, [{title, "Home"},
          {description, "Opensource tools"},
          {keywords, "opensource,tools,anagram"}]}.

