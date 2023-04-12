#!/bin/bash

$branches = git branch --format="%(refname:short)"
$graphFilePath = ".\graph.md"
$names = @()
Clear-Content graph.md
Clear-Content log.txt
" ``````mermaid`n`tgitGraph" | Out-File -FilePath ".\graph.md" -Append
for ($i = ($branches.Length - 1); $i -ge 0; $i--) {
    $branch = $branches[$i]
    "Branch Name: $branch `n Commits:" | Out-File -FilePath ".\log.txt" -Append
    $commits = git log $branch --format="%H %an %s"
    If ($branch -ne "main") {
       "`tbranch $branch" | Out-File -FilePath ".\graph.md" -Append
    }
    for ($j = ($commits.Length - 1); $j -ge 0; $j--) {
        $commit = $commits[$j]
        $commitFields = $commit.Split(' ')
        $name = ""
        for($k = 2; $k -lt $commitFields.Length; $k++) {
            $name += $commitFields[$k] + " "
        }
        If (!($names -match $name)) {
            "`tcommit id:`"$name`"" | Out-File -FilePath ".\graph.md" -Append
            $names += $name
            "  $commit" | Out-File -FilePath ".\log.txt" -Append
        }
    }
 }
 "``````"  | Out-File -FilePath ".\graph.md" -Append