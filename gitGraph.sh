$branches = git branch --format="%(refname:short)"
foreach ($branch in $branches) {
     echo "Branch Name: $branch" > log.txt
     $commits = git log $branch --format="%H %an %s"
     echo "Commits:"  >> log.txt
     echo $commits >> log.txt
     echo " ``````mermaid `n`tgitGraph" >.\graph.md
        If ($branch -ne "main"){
            Write-Output "`tbranch $branch" >>.\graph.md
        }
     foreach($commit in $commits)
     {
         $commitFields = $commit.Split(' ')
         $name = ""
         for($i = 2; $i -lt $commitFields.Length; $i++) {
            $name += $commitFields[$i] + " "
        }
         Write-Output "`tcommit id:`"$name`"" >>.\graph.md
     }
     echo "``````" >>.\graph.md
 }