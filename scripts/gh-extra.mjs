import { execSync } from "child_process"
import { repoToPath } from "./env.mjs"
import { parseGitHubURL } from "./utils/parse-url.mjs"

const { 2: action, 3: targetPullRequestURL } = process.argv
const { repo, prNo } = parseGitHubURL(targetPullRequestURL)

process.chdir(repoToPath(repo))

const response = execSync(`git status --short | wc -l`)
const changedFileCount = Number(response.toString().trim())
if (changedFileCount > 0) {
  console.log(
    "\nThere are uncommitted changes in the repo. Please stash or commit them first.\n"
  )
  process.exit(1)
}

if (action === "open") {
  execSync(`gh pr checkout ${prNo} && code .`)
} else if (action === "approve") {
  execSync(`gh pr review -a ${prNo}`)
}
