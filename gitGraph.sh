$branches = git branch --format="%(refname:short)"
$graphFilePath = ".\graph.md"
$names = @()
$LesBranches = @()
Clear-Content log.txt
for ($i = ($branches.Length - 1); $i -ge 0; $i--) {
    $branch = $branches[$i]
    $LesBranches += branch 
    "Branch Name: $branch" | Out-File -FilePath ".\log.txt" -Append
    $commits = git log $branch --format="%H %an %s"
    echo "Commits:"  >> log.txt
    echo " ``````mermaid `n`tgitGraph" >.\graph.md
    If ($branch -ne "main"){
        Write-Output "`tbranch $branch" >>.\graph.md
    }
    for ($j = ($commits.Length - 1); $j -ge 0; $j--) {
        $commit = $commits[$j]
        $commitFields = $commit.Split(' ')
        $name = ""
        for($k = 2; $k -lt $commitFields.Length; $k++) {
            $name += $commitFields[$k] + " "
        }
        If (!($names -match $name)) {
            $commit | Out-File -FilePath ".\graph.md" -Append
            $names += $name
        }
    }
 }
foreach($n in $names){
    echo "`tcommit id:`"$n`"" >> .\graph.md
}
 echo "``````" >>.\graph.md
