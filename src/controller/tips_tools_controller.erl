-module(tips_tools_controller, [Req]).
-compile(export_all).

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANAGRAM
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
perms([]) -> [[]];
perms(L) -> [list_to_binary([H|T]) || H <- L, T <- perms(L--[H])].

anagram_keys() ->
    [{title,       <<"Anagram solver">>}, 
     {description, <<"Online Free anagram solver">>},
     {keywords,    <<"free anagram,permutation,anagramma,anagramm,anagrama,字谜,anagramme,анаграмма">>}
    ].

anagram('GET', []) ->
    %%{ok, []}.
    {ok, anagram_keys()};
   
anagram('POST', []) ->
    %%Word = Req:param("word"),
    Word = Req:post_param("word"),
    ShortWord = lists:sublist(Word, 8),
    {ok, [{words, perms(ShortWord)}|anagram_keys()]}.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% epoch_converter
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unix_seconds_since_epoch() ->
    LocalDateTime = calendar:datetime_to_gregorian_seconds({date(),time()}),
    UnixEpoch = calendar:datetime_to_gregorian_seconds({{1970,1,1},{0,0,0}}),
    LocalDateTime - UnixEpoch.

epoch_converter_keys() ->
    {{Year,Month,Day},{Hour,Min,Sec}} = calendar:now_to_datetime(erlang:now()),
    Today = io_lib:format("~4B-~2.10.0B-~2.10.0B ~2B:~2.10.0B:~2.10.0B", [Year,Month, Day, Hour, Min, Sec]),
    [{title,       <<"Epoch converter">>},
     {description, <<"Date Time comverter to or from Epoch time or Gregorian time">>},
     {keywords,    <<"date,time,epoch time, unix time, unix timestamp, gregorian time">>},
     {epoch_time, unix_seconds_since_epoch()}, 
     {gregorian_time, calendar:datetime_to_gregorian_seconds({date(),time()})},
     {today, Today}
    ].

epoch_converter('GET', []) ->
    {ok, epoch_converter_keys()};
epoch_converter('POST', []) ->
    Unixtime_param = Req:post_param("unixtime"),
    {Resp, _} = string:to_integer(Unixtime_param),
    Unixtime = case Resp of
		   error -> 0;
		   Resp  -> Resp
	       end,
    {{Year, Month, Day}, {Hour, Min, Sec}} = calendar:gregorian_seconds_to_datetime(Unixtime+62167219200),
    DateTime = io_lib:format("~4B-~2.10.0B-~2.10.0B ~2B:~2.10.0B:~2.10.0B", [Year,Month, Day, Hour, Min, Sec]),
    {ok, [{datetime, DateTime},{epochtime, Unixtime}|epoch_converter_keys()]}.

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INDEX
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

index('GET', []) ->
    {ok, [{title, "Home"},
          {description, "Opensource tools"},
          {keywords, <<"opensource,tools">>}]}.

