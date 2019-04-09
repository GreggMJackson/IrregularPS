set-strictmode -Version Latest
########################################################################
# [regex]$regex="(Mr\.? |Mrs\.? |Miss |Ms\.? )"
# ( "Mr. Henry Hunt",  "Ms. Sara Samuels",  "Abraham Adams",  "Ms. Nicole Norris" ) |
#  % { $regex.Replace($_, "") }
# ########################################################################
# $pattern = "\b(\w+?)\s\1\b" 
# $input = "This this is a nice day. What about this? This tastes good. I saw a a dog."
# [regex]::Matches($input, $pattern, "IgnoreCase") | % { 
#     Write-host $_ " (duplicates '"  $_.Groups[1].Value "') at position " $_.Index
# }
# ########################################################################
# $input = "Office expenses on 2/13/2008:\n" +
#          "Paper (500 sheets)                 £3.95\n" +
#          "Pencils (box of 10)                £1.00\n" +
#          "Pen (box of 10)                    £4.49\n" +
#          "Erasers                            £2.19\n" +
#          "Ink jet printer                   £69.95\n" +
#          "Total expenses                   £ 81.58\n"

# # Get current culture's NumberFormatInfo object.
# $nfi = [System.Threading.Thread]::CurrentThread.CurrentUICulture.NumberFormat
# # Assign needed property values to variables.
# [String]$currencySymbol = $nfi.currencySymbol
# [bool]$symbolPrecedesIfPositive = $nfi.currencyPositivePattern % 2 -eq 0
# [string]$groupSeparator = $nfi.CurrencyGroupSeparator
# [string]$decimalSeaparator = $nfi.CurrencyDecimalSeparator

# # Form regular expression pattern.
# $usePreSymbol = If( $symbolPrecedesIfPositive ) { $currencySymbol } else { "" } 
# $usePostSymbol = If( -not $symbolPrecedesIfPositive ) { $currencySymbol } else { "" } 
# [string]$pattern = [Regex]::Escape(  $usePreSymbol ) +
#                    "\s*[-+]?" + "([0-9]{0,3}(" + $groupSeparator + "[0-9]{3})*(" +
#                    [Regex]::Escape( $decimalSeparator ) + "[0-9]+)?)" + $usePostSymbol
# write-host "The regular expression is: " $pattern

# # Get text that matches the regular expression pattern.
# $matches = [regex]::Matches( $input, $pattern, "IgnorePatternWhitespace")
# write-host "Found " $matches.Count " matches"

# # Get numeric string, convert it to a value, and add it to list object
# $expenses = @()
# $matches | % { $expenses += $_.Groups[1].Value }

# # Determine whether total is present, and if it is present, whether it is correct.
# $total = 0
# $expenses | % { $total += $_ }

# if( ($total / 2) +1 -eq $expenses[$expenses.Count-1] ){ #banker fudge.
#     write-host "The expenses total " $expenses[$expenses.Count-1]
# }else{
#     write-host "The expenses total(b) " $total
# }
# ########################################################################
# [string]$delimited="\G(.+)[\t\u007c](.+)\r?\n"
# [string]$inputs = "Mumbai, India|13,922,125`t`n"+ 
#          "Shanghai, China`t13,831,900`n"+
#          "Karachi, Pakistan|12,991,000`n"+
#          "Delhi, India`t12,259,230`n"+
#          "Istanbul, Turkey|11,372,613`n"
# write-host "`nPopulation of the World's Largest Cities" -ForegroundColor Cyan
# write-host ""
# write-host ([string]::Format("{0,-20} {1,10}", "City", "Population")) -ForegroundColor Red
# write-host ""
# [Regex]::Matches($inputs, $delimited) | % { write-host ([string]::Format("{0,-20} {1,10}",$_.Groups[1].Value, $_.Groups[2].Value)) }
# ########################################################################
# [string]$pattern="gr[ae]y\s\S+?[\s\p{P}]"
# [string]$inputs = "The gray wolf jumped over the grey wall."
# [Regex]::Matches($inputs, $pattern) | % { write-host "'" $_.Value "'"}
# ########################################################################
# [string]$pattern = "\b[A-Z]\w*\b"
# [string]$inputs = "A city Albany Zulu maritime Marseilles"
# [Regex]::Matches($inputs, $pattern) | % { write-host $_.Value }
# ########################################################################
# [string]$pattern = "\bth[^o]\w+\b"
# [string]$inputs = "thought thing though them through thus thorough this"
# [Regex]::Matches($inputs, $pattern) | % { write-host $_.Value }
# ########################################################################
#  [string]$pattern = "^.+"
#  [string]$inputs = "This is the first line and" + "`n" + "this is the second."
#  [regex]::Matches($inputs, $pattern) | % { write-host ([regex]::Escape($_.Value))}
#  write-host "`n"
#  [regex]::Matches($inputs, $pattern, "Singleline") | % { write-host ([regex]::Escape($_.Value))}
# ########################################################################
# [string]$pattern = "\b.*[.?!;:](\s|\z)"
# [string]$inputs = "this. what: is? go, thing."
# [Regex]::Matches($inputs, $pattern) | % { write-host ($_.Value)}
# ########################################################################
# [string]$pattern = "\b(\p{IsGreek}+(\s)?)+\p{Pd}\s(\p{IsBasicLatin}+(\s)?)+"  # UNICODE!!
# [string]$inputs ="Κατα Μαθθαίον - The Gospel of Matthew"
# write-host [Regex]::IsMatch($inputs, $pattern)
# ########################################################################
# [string]$pattern = "(\P{Sc})+"
# $values = @("164,091.78","£1,073,142.68", "73¢", "€120")
# $values | % { write-host ([Regex]::Match($_, $pattern).Value) }               # UNICODE!!
# ########################################################################
# [string]$pattern = "(\w)\1"
# $words = @("trellis", "seer", "latter", "summer", "hoarse", "lesser", "aardvark", "stunned")
# $words | % { 
#     $match = [Regex]::Match($_,$pattern)
#     if($match.Success){
#         write-host ([string]::Format("'{0}' found in '{1}' at position {2}", $match.Value, $_, $match.Index))
#     }else{
#         write-host ([string]::Format("No double characters found in {0}",$_))
#     }
# }
# ########################################################################
# [string]$pattern = "\b(\w+)(\W){1,2}"
# [string]$inputs ="The old, grey mare walked across the narrow, green pasture."
# [Regex]::Matches($inputs, $pattern) | % {
#     write-host ($_.Value)
#     write-host -NoNewLine "    Non-word character(s):"
#     $ctr=0
#     $postfix=""
#     For($ctr; $ctr -lt $_.Groups[2].Captures.Count; $ctr++){
#         $postfix = if($ctr -lt $_.Groups[2].Captures.Count-1){", "}else{""}
#         write-host -NoNewLine ([string]::Format("'{0}' (\u{1}){2}",
#                                      $_.Groups[2].Captures[$ctr].Value,
#                                      [Convert]::ToUInt16($_.Groups[2].Captures[$ctr].Value[0]).ToString(),
#                                      $postfix
#                                     )
#                    )
#     }
#     write-host ""
# }
# ########################################################################
# [string]$pattern = "\b\w+(e)?s(\s|$)"
# [string]$inputs = "matches stores stops leave leaves"
# [regex]::Matches($inputs, $pattern) | % { write-host ($_.Value) }
# ########################################################################
# [string]$pattern = "\b(\S+)\s?"
# [string]$inputs="This is the first sentence of the first paragraph. " +
#                 "This is the second sentence.`n" +
#                 "This is the only sentence of the second paragraph."
# [Regex]::Matches($inputs, $pattern) | % { write-host ($_.Groups[1]) }
# ########################################################################
# [string]$pattern = "^(\(?\d{3}\)?[\s-])?\d{3}-\d{4}$"
# $inputs= @("111 111-1111", "222-2222", "222 333-444", "(212) 111-1111", "111-AB1-1111", "212-111-1111", "01 999-9999")
# $inputs | % { 
#     $match = [regex]::Match($_,$pattern)
#     If([regex]::IsMatch($_, $pattern)){
#         write-host ([string]::Format("{0,-16} : matched", $_))
#     }else{
#         write-host([string]::Format("{0,-16} : match failed", $_))
#     }
# }
# ########################################################################
# [string]$pattern = "^\D\d{1,5}\D*$"
# $inputs=@("A1039C", "AA0001", "C18A", "Y938518")
# $inputs | % { 
#     if([regex]::IsMatch($_, $pattern)){
#         write-host ([string]::Format("{0,-15} : matched",$_))
#     }else{
#         write-host ([string]::Format("{0,-15} : match failed", $_))
#     }
# }
# ########################################################################
#  [Char[]]$chars=@("a","X","8",","," ","!")
#  $chars | % { write-host ([string]::Format("'{0}': {1}",[regex]::Escape($_.ToString()),[Char]::GetUnicodeCategory($_) ))}
# ########################################################################
# [string]$pattern = "^[0-9-[2468]]+$"
# [string[]]$inputs=@("123", "1357953", "3557798", "335599901")
# $inputs | % { 
#     $match = [regex]::Match($_, $pattern)
#     if($match.Success){
#         write-host $match.Value
#     }
# }
# ########################################################################
# [int]$startPos = 0
# [int]$endPos = 70
# [string]$inputs= "Brooklyn Dodgers, National League, 1911, 1912, 1932-1957`n" +
#                  "Chicago Cubs, National League, 1903-present`n" +
#                  "Detroit Tigers, American League, 1901-present`n" +
#                  "New York Giants, National League, 1885-1957`n" +
#                  "Washington Senators, American League, 1901-1960`n"
# [string]$pattern = "^((\w+(\s?)){2,}),\s(\w+\s\w+),(\s\d{4}(-(\d{4}|present))?,?)+"
# if( $inputs.Substring($startPos, $endPos).Contains(",")){
#     $match = [Regex]::Match($inputs, $pattern)
#     while($match.Success){
#         write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#         $match.Groups[5].Captures | % { write-host $_.Value -NoNewline }
#         write-host "."
#         $startPos = $match.Index + $match.Length
#         $endPos = if( $startPos + 70 -le $inputs.Length) { 70 } else { $inputs.Length -$startPos }
#         if(-not $inputs.Substring($startPos, $endPos).Contains(",")) {
#             break
#         }else{
#             $match = $match.NextMatch()
#         }
#     }
#     write-host ""
# }

# if( $inputs.Substring($startPos, $endPos).Contains(",")){
#     $match = [Regex]::Match($inputs, $pattern, "Multiline")
#     while($match.Success){
#         write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#         $match.Groups[5].Captures | % { write-host ($_.Value) -NoNewline}
#         write-host "."
#         $startPos = $match.Index + $match.Length
#         $endPos = if( $startPos + 70 -le $inputs.Length) { 70 } else { $inputs.Length -$startPos }
#         if(-not $inputs.Substring($startPos, $endPos).Contains(",")) {
#             break
#         }else{
#             $match = $match.NextMatch()
#         }
#     }
#     write-host ""
# }
# #######################################################################
# [int]$startPos = 0
# [int]$endPos = 70
# $cr = [Environment]::NewLine
# [string]$inputs= "Brooklyn Dodgers, National League, 1911, 1912, 1932-1957" + $cr +
#                  "Chicago Cubs, National League, 1903-present" + $cr +
#                  "Detroit Tigers, American League, 1901-present" + $cr +
#                  "New York Giants, National League, 1885-1957" + $cr +
#                  "Washington Senators, American League, 1901-1960" + $cr 

# [string]$basePattern = "^((\w+(\s?)){2,}),\s(\w+\s\w+),(\s\d{4}(-(\d{4}|present))?,?)+"
# [string]$pattern = $basePattern + "$"
# write-host "Attempting to match the entire input string:"
# if( $inputs.Substring($startPos, $endPos).Contains(",")){
#     $match = [Regex]::Match($inputs, $pattern)
#     while($match.Success){
#         write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#         $match.Groups[5].Captures | % { write-host $_.Value -NoNewline }
#         write-host "."
#         $startPos = $match.Index + $match.Length
#         $endPos = if( $startPos + 70 -le $inputs.Length) { 70 } else { $inputs.Length -$startPos }
#         if(-not $inputs.Substring($startPos, $endPos).Contains(",")) {
#             break
#         }else{
#             $match = $match.NextMatch()
#         }
#     }
#     write-host ""
# }
# [string[]]$delim = $cr
# [string[]]$teams = $inputs.Split($delim,"RemoveEmptyEntries")
# write-host "Attempting to match each element in a string array:"
# $ctr = 0;
# $teams | % {
#     if( $teams.Length -le 70){
#         $match = [regex]::Match($_, $pattern)
#         if($match.Success){
#             write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#             foreach( $capture in $match.Groups[5].Captures){
#                 write-host ($capture.Value) -NoNewline
#             }
#             write-host "."
#         }
#     }
# }
# write-host ""

# $startPos =0
# $endPos = 70
# write-host "Attempting to match each line of an input string with '$':"
# if( $inputs.Substring($startPos, $endPos).Contains(",")){
#     $match = [Regex]::Match($inputs, $pattern, "Multiline")
#     while($match.Success){
#         write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#         $match.Groups[5].Captures | % { write-host $_.Value -NoNewline }
#         write-host "."
#         $startPos = $match.Index + $match.Length
#         $endPos = if( $startPos + 70 -le $inputs.Length) { 70 } else { $inputs.Length -$startPos }
#         if(-not $inputs.Substring($startPos, $endPos).Contains(",")) {
#             break
#         }else{
#             $match = $match.NextMatch()
#         }
#     }
#     write-host ""
# }


# $startPos =0
# $endPos = 70
# $pattern = $basePattern + "\r?$";
# write-host "Attempting to match each line of an input string with '\r?$':"
# if( $inputs.Substring($startPos, $endPos).Contains(",")){
#     $match = [Regex]::Match($inputs, $pattern, "Multiline")
#     while($match.Success){
#         write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#         $match.Groups[5].Captures | % { write-host $_.Value -NoNewline }
#         write-host "."
#         $startPos = $match.Index + $match.Length
#         $endPos = if( $startPos + 70 -le $inputs.Length) { 70 } else { $inputs.Length -$startPos }
#         if(-not $inputs.Substring($startPos, $endPos).Contains(",")) {
#             break
#         }else{
#             $match = $match.NextMatch()
#         }
#     }
#     write-host ""
# }
# #######################################################################
# 22
# [int]$startPos = 0
# [int]$endPos = 70
# [string]$inputs= "Brooklyn Dodgers, National League, 1911, 1912, 1932-1957`n" +
#                  "Chicago Cubs, National League, 1903-present`n" +
#                  "Detroit Tigers, American League, 1901-present`n" +
#                  "New York Giants, National League, 1885-1957`n" +
#                  "Washington Senators, American League, 1901-1960`n"
# [string]$pattern = "\A((\w+(\s?)){2,}),\s(\w+\s\w+),(\s\d{4}(-(\d{4}|present))?,?)+"
# if( $inputs.Substring($startPos, $endPos).Contains(",")){
#     $match = [Regex]::Match($inputs, $pattern)
#     while($match.Success){
#         write-host ([string]::Format("The {0} played in the {1} in", $match.Groups[1].Value, $match.Groups[4].Value)) -NoNewline
#         $match.Groups[5].Captures | % { write-host $_.Value -NoNewline }
#         write-host "."
#         $startPos = $match.Index + $match.Length
#         $endPos = if( $startPos + 70 -le $inputs.Length) { 70 } else { $inputs.Length -$startPos }
#         if(-not $inputs.Substring($startPos, $endPos).Contains(",")) {
#             break
#         }else{
#             $match = $match.NextMatch()
#         }
#     }
#     write-host ""
# }
# #######################################################################
# 23
# [string[]]$inputs = @( "Brooklyn Dodgers, National League, 1911, 1912, 1932-1957",
#                        "Chicago Cubs, National League, 1903-present" + [Environment]::NewLine,
#                        "Detroit Tigers, American League, 1901-present" + [Regex]::Unescape("`n") ,
#                        "New York Giants, National League, 1885-1957" ,
#                        "Washington Senators, American League, 1901-1960" +[Environment]::NewLine)
# $pattern = "^((\w+(\s?)){2,}),\s(\w+\s\w+),(\s\d{4}(-(\d{4}|present))?,?)+\r?\Z"
# $inputs | % {
#     if( ($_.Length -gt 70) -or (-not $_.Contains(",")) ){ 
#     }else{
#         write-host ([Regex]::Escape($_))
#         $match = [Regex]::Match($_, $pattern)
#         if($match.Success){
#             write-host ("     Match succeeded")
#         }else{
#             write-host ("     Match failed.")
#         }
#     }
# }
# write-Host ""
# #######################################################################
# 24
# [string[]]$inputs = @( "Brooklyn Dodgers, National League, 1911, 1912, 1932-1957",
#                        "Chicago Cubs, National League, 1903-present`n" ,
#                        "Detroit Tigers, American League, 1901-present`n",
#                        "New York Giants, National League, 1885-1957" ,
#                        "Washington Senators, American League, 1901-1960`n")#Bah.
# $pattern = "^((\w+(\s?)){2,}),\s(\w+\s\w+),(\s\d{4}(-(\d{4}|present))?,?)+\r?\z"
# $inputs | % {
#     if( ($_.Length -gt 70) -or (-not $_.Contains(",")) ){ 
#     }else{
#         write-host ([Regex]::Escape($_))
#         $match = [Regex]::Match($_, $pattern)
#         if($match.Success){
#             write-host ("     Match succeeded")
#         }else{
#             write-host ("     Match failed.")
#         }
#     }
# }
# write-Host ""
# #######################################################################
# 25
# $inputs = "capybara,squirrel,chipmunk,porcupine,gopher," +
#           "beaver,groundhog,hamster,guinea pig,gerbil," +
#           "chinchilla,prairie dog,mouse,rat"
# $pattern = "\G(\w+\s?\w*),?"
# $match = [regex]::Match($inputs, $pattern)
# while ($match.Success){
#     write-host ($match.Groups[1].Value)
#     $match = $match.NextMatch()
# }
# #######################################################################
# 26
# $inputs = "area, bare, arena, mare"
# $pattern = "\bare\w*\b"
# write-host "Words that begin with 'are':"
# [Regex]::Matches($inputs, $pattern) | % { write-host ([string]::Format("'{0}' found at position {1}", $_.Value, $_.Index))}
# #######################################################################
# 27
# $inputs = "equity queen equip acquaint quiet"
# $pattern = "\Bqu\w+"
# [Regex]::Matches($inputs, $pattern) | % { write-Host ([string]::Format("'{0}' found at position {1}", $_.Value, $_.Index)) }
# #######################################################################
# 28
# $pattern = "(\w+)\s(\1)"
# $inputs = "He said that that was the the correct answer."
# [Regex]::Matches($inputs, $pattern, "IgnoreCase") | % {
#     [String]::Format("Duplicate '{0}' found at positions {1} and {2}",
#     $_.Groups[1].Value,
#     $_.Groups[1].Index,
#     $_.Groups[2].Index)
# }
# #######################################################################
# 29
# $pattern = "(?<duplicateWord>\w+)\s\k<duplicateWord>\W(?<nextWord>\w+)"
# $inputs = "He said that that was the the correct answer."
# [regex]::Matches($inputs, $pattern,"IgnoreCase") | % {
#     write-host ([string]::Format("A duplicate '{0}' at position {1} followed by '{2}'",
#                                  $_.Groups["duplicateWord"].Value,
#                                  $_.Groups["duplicateWord"].Index,
#                                  $_.Groups["nextWord"].Value))
# }
# #######################################################################
# 30
# $pattern = "\D+(?<digit>\d+)\D+(?<digit>\d+)?"
# $inputs = @("abc123def456","abc123def")
# $inputs | % {
#     $m = [regex]::Match($_, $pattern)
#     if ($m.Success ){
#         write-host ([string]::Format("Match: {0}",$m.Value))
#         for ($i = 1; $i -lt $m.Groups.Count; $i++) {
#             $g=$m.Groups[$i]
#             write-host ([string]::Format("Group {0}: {1}", $i,$g.Value))
#             for ($c = 0; $c -lt $g.Captures.Count; $c++) {
#                 write-host ([string]::Format("    Capture {0}: {1}", $c, $g.Captures[$c].Value))
#             }
#         }
#     }else{
#         write-host "The match failed."
#     }
#     write-host ""
# }
# #######################################################################
# 31
# $pattern = "^[^<>]*" +
#            "(" +
#            "((?'Open'<)[^<>]*)+" +
#            "((?'Close-Open'>)[^<>]*)+" +
#            ")*" +
#            "(?(Open)(?!))$" 
# $inputs = "<abc><mno<xyz>>"
# $m = [regex]::Match($inputs,$pattern)
# if($m.Success){
#     write-host ([string]::Format("Input: `"{0}`"`nMatch: `"{1}`"", $inputs, $m))
#     $i = 0
#     foreach($grp in $m.Groups){
#         write-host ([string]::Format("   Group {0}: {1}",$i, $grp.Value))
#         $i++
#         $c = 0
#         foreach($cap in $grp.Captures){
#             write-host ([string]::Format("     Capture {0}: {1}",$c,$cap.Value))
#             $c++
#         }
#     }
# }else{
#     write-host "Match failed."
# }
########################################################################
# 32
# $pattern = "(?:\b(?:\w+)\W*)+\."
# $inputs = "This is a short sentence."
# $i=0
# [regex]::Match($inputs, $pattern).Groups | % { write-host ([string]::Format("    Group {0}: {1}",++$i,$_.Value)) }
########################################################################
# 33
# $pattern = "\b(?ix: d \w+)\s"
# $inputs = "Dogs are decidedly good pets."
# [regex]::Matches($inputs, $pattern) | % { write-host ([String]::Format("'{0}' found at index {1}", $_.Value, $_.Index)) }
########################################################################
# 34
# $pattern = "\b\w+(?=\sis\b)"
# $inputs = @("The dog is a Malamute.",
#             "The island has beautiful birds.",
#             "The pitch missed home plate.",
#             "Sunday is a weekend day." )
# $inputs | % { 
#     $match = [regex]::Match($_, $pattern)
#     if($match.Success){ 
#         write-host("'{0}' precedes 'is'." -f $match.Value)
#     } else {
#         write-host("'{0}' does not match the pattern" -f $_)
#     }
# }
########################################################################
# 35
# $pattern="\b(?!un)\w+\b"
# $inputs="unite one unethical ethics use untie ultimate"
# [regex]::Matches($inputs, $pattern, "IgnoreCase") | % { write-host($_.Value) }
########################################################################
# 36
# $pattern="\b\w+\b(?!\p{P})"
# $inputs="Disconnected, disjointed thoughts in a sentence fragment."
# [regex]::Matches($inputs, $pattern) | % { write-host($_.Value) }
########################################################################
# 37
# $pattern="(?<=\b20)\d{2}\b"
# $inputs="2010 1999 1861 2140 2009"
# [regex]::Matches($inputs, $pattern) | % { write-host($_.Value) }
########################################################################
# 38
# $dates = @( "Monday February 1, 2010",
#             "Wednesday February 3, 2010",
#             "Saturday February 6, 2010",
#             "Sunday February 7, 2010",
#             "Monday, February 8, 2010" )
# $pattern="(?<!(Saturday|Sunday) )\b\w+ \d{1,2}, \d{4}\b"
# $dates | % { 
#     $match = [regex]::Match($_, $pattern)
#     if($match.Success){
#         write-host($match.Value)
#     } 
# }
########################################################################
# 39
# $inputs=@("cccd.","aaad","aaaa")
# $back ="(\w)\1+.\b"
# $noback ="(?>(\w)\1+).\b"
# $inputs | % {
#     $m1 = [regex]::Match($_, $back)
#     $m2 = [regex]::Match($_, $noback)
#     write-host($_)

#     write-host("   Backtracking : ")
#     if( $m1.Success) {
#         write-host($m1.Value)
#     }else{
#         write-host("No match.")
#     }

#     write-host("   Nonbacktracking : ")
#     if( $m2.Success) {
#         write-host($m2.Value)
#     }else{
#         write-host("No match.")
#     }
# }
########################################################################
# 40
# $pattern="(\b(\w+)\W+)+"
# $inputs="This is a short sentence."
# $match = [regex]::Match($inputs, $pattern)
# write-host([string]::Format("Match: '{0}'", $match.Value))
# $i=0
# $match.Groups | % {
#     write-host([string]::Format("   Group {0}: '{1}'", $i, $_.Value))
#     $i++
#     $j=0
#     $_.Captures | % {
#         write-host([string]::Format("      Capture {0}: '{1}", $j, $_.Value))
#         $j++
#     }
# }
########################################################################
# 41
# $pattern = "\b91*9*\b"
# $inputs="99 95 919 929 9119 9219 999 9919 91119"
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 42
# $pattern = "\ban+\w*?\b"
# $inputs="Autumn is a great time for an annual announcement to all antique collectors.";
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 43
# $pattern = "\ban?\b"
# $inputs="An amiable animal with a large snout and an animated nose."
# [regex]::Matches($inputs, $pattern, "IgnoreCase") | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 44
# $pattern = "\b\d+\,\d{3}\b"
# $inputs= "Sales totalled 103,524 million in January," +
#          "106,971 million in February, but only" +
#          "943 million in March.";
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 45
# $pattern = "\b\d{2,}\b\D+"
# $inputs="7 days, 10 weeks, 300 years."
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 46
# $pattern = "(00\s){2,4}"
# $inputs="0x00 FF 00 00 18 17 FF 00 00 00 21 00 00 00 00 00"
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 47
# $pattern = "\b\w*?oo\w*?\b"
# $inputs="woof root root rob oof woo woe"
# [regex]::Matches($inputs, $pattern, "IgnoreCase") | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 48
# $pattern = "\b\w+?\b"
# $inputs="Aa Bb Cc Dd Ee Ff"
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at postition {1}" -f $_.Value, $_.Index) }
########################################################################
# 49
# $pattern ="^\s*(System.)?? Console.write(Line)??\(??"
# $inputs = "System.Console.WriteLine(`"Hello!`")`n" +
#                  "Console.Write(`"Hello!`")`n" +
#                  "Console.WriteLine(`"Hello!`")`n" +
#                  "Console.ReadLine()`n" +
#                  "   Console.WriteLine"
# [regex]::Matches($inputs, $pattern, "IgnorePatternWhitespace,IgnoreCase,Multiline") |
# % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 50
# $pattern = "\b(\w{3,}?\.){2}?\w{3,}?\b"
# $inputs="www.microsoft.com msdn.microsoft.com mywebsite mycompany.com"
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at postition {1}" -f $_.Value, $_.Index) }
########################################################################
# 51
# $pattern = "\b[A-Z](\w*?\s*?){1,10}[.?!]"
# $inputs = "Hi. I am writing a short note. Its purpose is " +
#           "to test a regular expression that attempts to find " +
#           "sentences with ten of fewer words. Most sentences " +
#           "in this note are short."
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at position {1}" -f $_.Value, $_.Index)}
########################################################################
# 52
# $greedyPattern = "\b.*([0-9]{4})\b"
# $inputs = "1112223333 3992991999"
# [regex]::Matches($inputs, $greedyPattern) | % { write-host("Account ending in *******{0}" -f $_.Groups[1].Value)}
########################################################################
# 53
# $lazyPattern = "\b.*?([0-9]{4})\b"
# $inputs = "1112223333 3992991999"
# [regex]::Matches($inputs, $lazyPattern) | % { write-host("Account ending in *******{0}" -f $_.Groups[1].Value)}
########################################################################
# 54
# $pattern = "(a?)*"
# $inputs = "aaabbb"
# $match = [regex]::Match($inputs, $pattern)
# write-host("Match: '{0}' at index {1}" -f $match.Value, $match.Index)
# if ($match.Groups.Count -gt 1){
#     for ($i = 0; $i -lt $match.Groups.Count; $i++) {
#         write-host("    Group {0}: '{1}' at index {2}" -f $i, $match.Groups[$i].Value, $match.Groups[$i].Index)
#         for ($j = 0; $j -lt $match.Groups[$i].Captures.Count; $j++) {
#             write-host("      Capture {0}: '{1}' at position {2}" -f $j, 
#                        $match.Groups[$i].Captures[$j].Value, 
#                        $match.Groups[$i].Captures[$j].Index)
#         }
#     } 
# }
########################################################################
# 55
# $pattern = "(a\1|(?(1)\1)){0,2}"
# $inputs = "aaabbb"
# write-host("Regex pattern: {0}" -f $pattern)
# $match = [regex]::Match($inputs, $pattern)
# write-host("Match: '{0}' at position {1}" -f $match.Value, $match.Index)
# if($match.Groups.Count -gt 1){
#     for ($i = 0; $i -lt $match.Groups.Count; $i++) {
#         write-host("    Group: {0} '{1}' at position {2}" -f 
#                    $i,
#                    $match.Groups[$i].Value,
#                    $match.Groups[$i].Index)
#         for ($j = 0; $j -lt $match.Groups[$i].Captures.Count; $j++) {
#             write-host("    Group: {0} '{1}' at position {2}" -f 
#             $j,
#             $match.Groups[$i].Captures[$j].Value,
#             $match.Groups[$i].Captures[$j].Index)     
#         }
#     }
# }
# write-host("")

# $pattern = "(a\1|(?(1)\1)){2}"
# write-host("Regex pattern: {0}" -f $pattern)
# $match = [regex]::Match($inputs, $pattern)
# write-host("Match: '{0}' at position {1}" -f $match.Value, $match.Index)
# if($match.Groups.Count -gt 1){
#     for ($i = 0; $i -lt $match.Groups.Count; $i++) {
#         write-host("    Group: {0} '{1}' at position {2}" -f 
#                    $i,
#                    $match.Groups[$i].Value,
#                    $match.Groups[$i].Index)
#                    for ($j = 0; $j -lt $match.Groups[$i].Captures.Count; $j++) {
#                     write-host("    Group: {0} '{1}' at position {2}" -f 
#                     $j,
#                     $match.Groups[$i].Captures[$j].Value,
#                     $match.Groups[$i].Captures[$j].Index)     
#                 }
#             }
# }
########################################################################
# 56
# $pattern = "(\w)\1"
# $inputs="trellis llama webbing dresser swagger"
# [regex]::Matches($inputs, $pattern) | % { write-host("Found '{0}' at position {1}" -f $_.Value, $_.Index) }
########################################################################
# 57
# $pattern = "(?<char>\w)\k<char>"
# $inputs="trellis llama webbing dresser swagger"
# [regex]::Matches($inputs, $pattern) | % { write-host("Found '{0}' at position {1}" -f $_.Value, $_.Index) }
# ########################################################################
# 58
# $pattern = "(?<2>\w)\k<2>"
# $inputs="trellis llama webbing dresser swagger"
# [regex]::Matches($inputs, $pattern) | % { write-host("Found '{0}' at position {1}" -f $_.Value, $_.Index) }
# ########################################################################
# 59
# write-host([regex]::IsMatch("aa", "(?<char>\w)\k<1>"))
# ########################################################################
# 60
# write-host([regex]::IsMatch("aa", "(?<2>\w)\k<1>"))
# ########################################################################
# 61
# $pattern ="(?<1>a)(?<1>\1b)*"
# $inputs = "aababb"
# [regex]::Matches($inputs, $pattern) | % {
#     write-host("Match: {0}" -f $_.Value)
#     $_.Groups | %{ write-host("     Group:{0}" -f $_.Value) }
# }
#########################################################################
# 62
# $pattern = "\b(\p{Lu}{2})(\d{2})?(\p{Lu}{2})\b"
# $inputs = @("AA22ZZ","AABB")
# $inputs | %{
#     $matches = [regex]::Matches($_, $pattern)
#     $input = $_
#     $matches | %{
#         if($_.Success){
#             write-host("Match in  {0}: {1}" -f $input, $_ )
#             if($_.Groups.Count -gt 1){
#                 for ($i = 0; $i -lt $_.Groups.Count; $i++) {
#                     $suffix = if($_.Groups[$i].Success){ $_.Groups[$i].Value }else{ "<no match>" }
#                     write-host("Group {0}: {1}" -f $i, $suffix)
#                 }
#             }
#         }
#     }
# }
#########################################################################
# 63
# # Regular expression using character class
# $pattern1 = "\bgr[ea]y\b"
# # Regular expression using either/or
# $pattern2 = "\bgr(e|a)y\b"
# $inputs = "Gandalf the grey wore great, gray cloak."
# [regex]::Matches($inputs, $pattern1) | %{ write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
# write-host("")
# [regex]::Matches($inputs, $pattern2) | %{ write-host("'{0}' found at position {1}" -f $_.Value, $_.Index) }
#########################################################################
# 64
# $pattern = "\b(\d{2}-\d{7}|\d{3}-\d{2}-\d{4})\b"
# $inputs = "01-9999999 020-333333 777-88-9999"
# write-host("Matches for {0}:" -f $pattern)
# [regex]::Matches($inputs, $pattern) | % { write-host("    {0} at position {1}" -f $_.Value, $_.Index) }
#########################################################################
# 65
# $pattern = "\b(?(\d{2}-)\d{2}-\d{7}|\d{3}-\d{2}-\d{4})\b"
# $inputs = "01-9999999 020-333333 777-88-9999"
# write-host("Matches for {0}:" -f $pattern)
# [regex]::Matches($inputs, $pattern) | % { write-host("    {0} at position {1}" -f $_.Value, $_.Index) }
#########################################################################
# 66
# $pattern = "\b(?<n2>\d{2}-)?(?(n2)\d{7}|\d{3}-\d{2}-\d{4})\b"
# $inputs = "01-9999999 020-333333 777-88-9999"
# write-host("Matches for {0}:" -f $pattern)
# [regex]::Matches($inputs, $pattern) | % { write-host("    {0} at position {1}" -f $_.Value, $_.Index) }
#########################################################################
# 67
# $pattern = "\b(\d{2}-)?(?(1)\d{7}|\d{3}-\d{2}-\d{4})\b"
# $inputs = "01-9999999 020-333333 777-88-9999"
# write-host("Matches for {0}:" -f $pattern)
# [regex]::Matches($inputs, $pattern) | % { write-host("    {0} at position {1}" -f $_.Value, $_.Index) }
#########################################################################
# 68
# $pattern ="\p{Sc}*(\s?\d+[.,]?\d*)\p{Sc}*" 
# $inputs = "`$16.32  12.19 £16.29 €18.29  €18,29"
# $replacement = "`$1"
# write-host([regex]::replace($inputs, $pattern, $replacement))
#########################################################################
# 69
# $pattern ="\p{Sc}*(?<amount>\s?\d+[.,]?\d*)\p{Sc}*" 
# $inputs = "`$16.32  12.19 £16.29 €18.29  €18,29"
# $replacement = "`${amount}"
# write-host([regex]::replace($inputs, $pattern, $replacement))
#########################################################################
# # 70
# # Define array of decimal values.
# $values = @( "16.35", "19.72", "1234", "0.99" )
# # Determine whether currency precedes (True) or follows (False) number.
# $precedes = [System.Globalization.NumberFormatInfo]::CurrentInfo.CurrencyPositivePattern % 2 -eq 0
# # Get decimal separator.
# $cSeparator = [System.Globalization.NumberFormatInfo]::CurrentInfo.CurrencyDecimalSeparator;
# # Get currency symbol.
# $symbol =[System.Globalization.NumberFormatInfo]::CurrentInfo.CurrencySymbol;
# # If symbol is a "$", add an extra "$".
# if ($symbol -eq "$") {$symbol = "$$"}

# # Define regular expression pattern and replacement string.
# $pattern = "\b(\d+)(" + $cSeparator + "(\d+))?"
# $replacement = "`$1`$2"
# $replacement = if($precedes){$symbol + " " + $replacement}else{$replacement + " " + $symbol}
# $values | % { write-host("{0} --> {1}" -f $_, [regex]::replace($_, $pattern, $replacement)) }
#########################################################################
# 71
# $pattern="^(\w+\s?)+$"
# $titles = @("A Tale of Two Cities",
#             "The Hound of the Baskervilles",
#             "The Protestant Ethic and the Spirit of Capitalism",
#             "The Origin of Species" )
# $replacement = "`"$&`""
# $titles | % { write-host([regex]::Replace($_, $pattern, $replacement)) }
#########################################################################
# 72
# $pattern="\d+"
# $inputs = "aa1bb2cc3dd4ee5"
# $substitution = "$``"
# write-host("Matches :")
# [regex]::Matches($input, $pattern) | % { write-host("    {0} at position {1}" -f $_.Value, $_.Index) }
# write-host("Input string: {0}" -f $inputs)
# write-host("Output string: {0}" -f [regex]::replace($inputs, $pattern, $substitution))
#########################################################################
# 73
# $pattern="\d+"
# $inputs = "aa1bb2cc3dd4ee5"
# $substitution = "$'"
# write-host("Matches :")
# [regex]::Matches($input, $pattern) | % { write-host("    {0} at position {1}" -f $_.Value, $_.Index) }
# write-host("Input string: {0}" -f $inputs)
# write-host("Output string: {0}" -f [regex]::replace($inputs, $pattern, $substitution))
#########################################################################
# 74
# $pattern="\b(\w+)\s\1\b"
# $inputs = "The the dog jumped over the fence fence."
# $substitution = "$+"
# write-host([regex]::Replace($inputs, $pattern, $substitution, "IgnoreCase"))
#########################################################################
# 75
# $pattern = "\d+"
# $inputs = "ABC123DEF456"
# $substitution = "`$_"
# write-host("Original string :         {0}" -f $inputs)
# write-host("String with substitution: {0}" -f [regex]::Replace($inputs, $pattern, $substitution))
#########################################################################
# 76
# $pattern = "d \w+ \s"
# $inputs = "Dogs are decidedly good pets."
# $options = "IgnoreCase,IgnorePatternWhitespace"
# [regex]::Matches($inputs, $pattern, $options) | % { write-host("'{0}' found at index {1}" -f $_.Value, $_.Index) }
#########################################################################
# 77
# $pattern = "(?ix)d \w+ \s"
# $inputs = "Dogs are decidedly good pets."
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at index {1}" -f $_.Value, $_.Index) }
#########################################################################
# 78
# $pattern = "(?ix: d \w+)\s"
# $inputs = "Dogs are decidedly good pets."
# [regex]::Matches($inputs, $pattern) | % { write-host("'{0}' found at index {1}" -f $_.Value, $_.Index) }
#########################################################################
# 79
# $pattern = "\bthe\w*\b"
# $inputs = "The man then told them about that event."
# [regex]::Matches($inputs, $pattern) | % { write-host("Found {0} at position {1}" -f $_.Value, $_.Index) } 
# write-host("")
# [regex]::Matches($inputs, $pattern, "IgnoreCase") | % { write-host("Found {0} at position {1}" -f $_.Value, $_.Index) } 
#########################################################################
# 80
# $pattern = "\b(?i:t)he\w*\b"
# $inputs = "The man then told them about that event."
# [regex]::Matches($inputs, $pattern) | % { write-host("Found {0} at position {1}" -f $_.Value, $_.Index) } 
# write-host("")
# [regex]::Matches($inputs, $pattern, "IgnoreCase") | % { write-host("Found {0} at position {1}" -f $_.Value, $_.Index) } 
#########################################################################
# 81
# $scores = [System.Collections.Specialized.OrderedDictionary]@{}#[System.Collections.Generic.SortedDictionary[object,object]]
# $inputs = "Joe 164`n" +
#           "Sam 208`n" +
#           "Allison 211`n" +
#           "Gwen 171`n"
# $pattern = "^(\w+)\s(\d+)$"
# $matched=$false
# write-host "Without Multiline option:"
# [regex]::Matches($inputs, $pattern) | % {
#     $scores.Add($_.Groups[2].Value, $_.Groups[1].Value)
#     $matched = $true
# }
# if( -not $matched) {
#     write-host "No matches."
# }
# Write-host ""
# # Redefine the pattern to handle multiple lines.
# $pattern = "^(\w+)\s(\d+)\r*$"
# Write-Host "With Multiline option:"
# [regex]::Matches($inputs, $pattern, "Multiline") | % {
#     $scores.Add($_.Groups[2].Value, $_.Groups[1].Value)
# }
# foreach($pair in $scores.GetEnumerator() | sort -Descending Name){
#         write-host([string]::Format("{0}: {1}", $pair.Value, $pair.Key))
# }
#########################################################################
# 82
# $pattern ="^.+" 
# $inputs="This is one line and" + [Environment]::NewLine + " this is the second"
# [regex]::Matches($inputs, $pattern) | % { write-host([regex]::Escape($_.Value))}
# write-host ""
# [regex]::Matches($inputs, $pattern, "Singleline") | % { write-host([regex]::Escape($_.Value))}
#########################################################################
# 83
# $pattern ="(?s)^.+" 
# $inputs="This is one line and" + [Environment]::NewLine + " this is the second"
# [regex]::Matches($inputs, $pattern) | % { write-host([regex]::Escape($_.Value))}
#########################################################################
# 84
# $inputs = "This is the first sentence. Is it the beginning " +
#            "of a literary masterpiece? I think not. Instead, " +
#            "it is a nonsensical paragraph.";
# $pattern = "\b\(?((?>\w+),?\s?)+[\.?!]\)?"
# write-host "With implicit captures:"
# [regex]::Matches($inputs, $pattern) | % {
#     write-host ([string]::Format("The Match: {0}", $_.Value))
#     $i=0
#     $_.Groups | % {
#         write-host ([string]::Format("   Group {0}: {1}", ++$i, $_.Value))
#         $j=0
#         $_.Captures | % {
#             write-host([string]::Format("      Capture {0}: {1}", ++$j, $_.Value))
# }}}
# write-host "With exlicit captures only:"
# [regex]::Matches($inputs, $pattern, "ExplicitCapture") | % {
#     write-host ([string]::Format("The Match: {0}", $_.Value))
#     $i=0
#     $_.Groups | % {
#         write-host ([string]::Format("   Group {0}: {1}", ++$i, $_.Value))
#         $j=0
#         $_.Captures | % {
#             write-host([string]::Format("      Capture {0}: {1}", ++$j, $_.Value))
# }}}
#########################################################################
# 85
# $inputs = "This is the first sentence. Is it the beginning " +
#            "of a literary masterpiece? I think not. Instead, " +
#            "it is a nonsensical paragraph.";
# $pattern = "(?n)\b\(?((?>\w+),?\s?)+[\.?!]\)?"
# write-host "With implicit captures:"
# [regex]::Matches($inputs, $pattern) | % {
#     write-host ([string]::Format("The Match: {0}", $_.Value))
#     $i=0
#     $_.Groups | % {
#         write-host ([string]::Format("   Group {0}: {1}", ++$i, $_.Value))
#         $j=0
#         $_.Captures | % {
#             write-host([string]::Format("      Capture {0}: {1}", ++$j, $_.Value))
# }}}
#########################################################################
# 86
# $inputs = "This is the first sentence. Is it the beginning " +
#            "of a literary masterpiece? I think not. Instead, " +
#            "it is a nonsensical paragraph.";
# $pattern = "\b\(?(?n:(?>\w+),?\s?)+[\.?!]\)?"
# write-host "With implicit captures:"
# [regex]::Matches($inputs, $pattern) | % {
#     write-host ([string]::Format("The Match: {0}", $_.Value))
#     $i=0
#     $_.Groups | % {
#         write-host ([string]::Format("   Group {0}: {1}", ++$i, $_.Value))
#         $j=0
#         $_.Captures | % {
#             write-host([string]::Format("      Capture {0}: {1}", ++$j, $_.Value))
# }}}
#########################################################################
# 87
# $inputs = "This is the first sentence. Is it the beginning " +
# "of a literary masterpiece? I think not. Instead, " +
# "it is a nonsensical paragraph.";
# $pattern = "\b\(?(?n:(?>\w+),?\s?)+[\.!?]\)?";
# [Regex]::Matches($inputs, $pattern, "IgnorePatternWhitespace") | % { [string]::Format("The Match: {0}", $_.Value) }
#########################################################################
# 88
# $inputs = "This is the first sentence. Is it the beginning " +
# "of a literary masterpiece? I think not. Instead, " +
# "it is a nonsensical paragraph.";
# $pattern = "(?x)\b \(? ( (?>\w+) ,?\s? )+ [\.!?] \)? # Matches an entire sentence.";
# [Regex]::Matches($inputs, $pattern) | % {write-host $_.Value}
#########################################################################
# 89
# $pattern = "\bb\w+\s"
# $inputs = "builder bob rabble"
# [regex]::Matches($inputs, $pattern, "RightToLeft") | % { [string]::Format("'{0}' found at position {1}", $_.Value, $_.Index) } 
#########################################################################
# 90
# $inputs = @("1 May 1917","June 16, 2003")
# $pattern = "(?<=\d{1,2}\s)\w+,?\s\d{4}"
# $inputs | % {
#     $match = [regex]::Match($_, $pattern, "RightToLeft")
#     if ($match.Success){
#         write-host "The date occurs in $($match.Value)"
#     }else{
#         write-host "$($_) does not match."
#     }
# }
#########################################################################
# 91
# $values=@("целый мир", "the whole world")
# $pattern = "\b(\w+\s*)+"
# $values | %{
#     write-host "Canonical matching:"
#     if([regex]::IsMatch($_, $pattern)){
#         write-host "'$($_)' matches the pattern"
#     }else{
#         write-host "'$($_)' does not match the pattern"
#     }
#     write-host "ECMA matching:"
#     if([regex]::IsMatch($_, $pattern, "ECMAScript")){
#         write-host "'$($_)' matches the pattern"
#     }else{
#         write-host "'$($_)' does not match the pattern"
#     }
# }
#########################################################################
# 92
# $outsidePattern = "((a+)(\1) ?)+"
# Function AnalyseMatch{
#     param([System.Text.RegularExpressions.Match] $match)
#     BEGIN{}
#     PROCESS{
#         if($match.Success){
#             write-host("$($outsidePattern) matches $($match.Value) at position $($match.Index)")
#             $i = 0
#             $match.Groups | % {
#                 write-host("   $($i): '$($_.Value)'")
#                 $j=0; ++$i
#                 $_.Captures | % {
#                     write-host("      $($j): '$($_.Value)'")
#                 }
#             }
#         }else{
#             write-host "No match found."
#         }
#     }
#     END{}
# }
# $inputs = "aa aaaa aaaaaa "
# write-host "Doing 1"
# AnalyseMatch([regex]::Match($inputs, $outsidePattern))
# write-host "Doing 2"
# AnalyseMatch([regex]::Match($inputs, $outsidePattern,"ECMAScript"))
#########################################################################
# 93
# $defaultCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
# [System.Threading.Thread]::CurrentThread.CurrentCulture = 
#     [System.Globalization.CultureInfo]("tr-TR")
# $inputs = "file://C:/Documents.MyReport.Doc"
# $pattern = "FILE://"
# $var = [System.Threading.Thread]::CurrentThread.CurrentCulture.Name
# write-host("Culture-sensitive matching ($($var))")
# if ([regex]::IsMatch($inputs, $pattern, "IgnoreCase")){
#     write-host("URLS that access files are not allowed.")
# }else{
#     write-host("Access to $($inputs) is allowed.")
# }
# [System.Threading.Thread]::CurrentThread.CurrentCulture = $defaultCulture
# $var = [System.Threading.Thread]::CurrentThread.CurrentCulture.Name
# write-host("Culture-sensitive matching ($($var))")
#########################################################################
# 94
# $defaultCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
# [System.Threading.Thread]::CurrentThread.CurrentCulture = 
#     [System.Globalization.CultureInfo]("tr-TR")
# $inputs = "file://C:/Documents.MyReport.Doc"
# $pattern = "FILE://"
# $var = [System.Threading.Thread]::CurrentThread.CurrentCulture.Name
# write-host("Culture-sensitive matching ($($var))")
# if ([regex]::IsMatch($inputs, $pattern, "IgnoreCase,CultureInvariant")){
#     write-host("URLS that access files are not allowed.")
# }else{
#     write-host("Access to $($inputs) is allowed.")
# }
# [System.Threading.Thread]::CurrentThread.CurrentCulture = $defaultCulture
# $var = [System.Threading.Thread]::CurrentThread.CurrentCulture.Name
# write-host("Culture-sensitive matching ($($var))")
#########################################################################
# 95
# $inputs = "double dare double Double a Drooling Dog The Dreaded Deep"
# $pattern = "\b(D\w+)\s(d\w+)\b"
# [regex]::Matches($inputs, $pattern)|%{
#     write-host $_.Value
#     if ($_.Groups.Count > 1){
#         $i=0
#         $_.Groups|%{write-host("    Group $(++$i): $($_.Value)")}
#     }
# }
# # Change regular expression pattern to include options.
# write-host ""
# $pattern = "\b(D\w+)(?ixn) \s (d\w+) \b"
# [regex]::Matches($inputs, $pattern)|%{
#     write-host $_.Value
#     if ($_.Groups.Count > 1){
#         $i=0
#         $_.Groups|%{write-host("    Group $(++$i): $($_.Value)")}
#     }
# }
#########################################################################
# 96
# $pattern = "\b((?# case-sensitive comparison)D\w+)\s(?ixn)((?# case-insensitive comparison)d\w+)\b"
# $rgx = [regex]($pattern)
# $inputs = "double dare double Double a Drooling dog The Dreaded Deep"
# write-host("Pattern: $($pattern)")
# # Match pattern using default options.
# $rgx.Matches($inputs) | % {
#     write-host $_.Value
#     $_.Groups | % {
#         $i=1
#         $_.Captures | % {
#             write-host ("   Group: $($i): $($_.Value)")
#             ++$i
#         }
#     }
# }
#########################################################################
# 97
# $pattern = "\{\d+(,-*\d+)*(\:\w{1,4}?)*\}(?x) # Looks for a composite format item."
# $inputs = "{0,-3:F}"
# write-host ("'$($inputs)':")
# if([regex]::IsMatch($inputs, $pattern)){
#     write-host "      contains a composite format item."
# }else{
#     write-host "      does not contain a composite format item."
# }
#########################################################################
# 98
#########################################################################
# 99
#########################################################################
# 100
