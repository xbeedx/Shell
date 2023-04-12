git rev-list --all --parents | while read -r commitId parents; do
  commitDate=$(git log -1 --format="%ct" "$commitId")
  commitMsg=$(git log -1 --format="%s" "$commitId")
  commitParents=($parents)
  if [ ${#commitParents[@]} -gt 1 ]; then
    commitType="merge"
  else
    commitType="commit"
  fi
  branch=$(git name-rev --name-only --exclude=tags/* "$commitId" | sed 's/~[0-9]*$//')
  echo "$commitDate | $branch | $commitType | $commitMsg"
done | sort -n > output.txt
