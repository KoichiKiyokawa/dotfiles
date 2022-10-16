/**
 * @param {string} targetPullRequestURL - URL of the repository e.g. https://github.com/repo/pull/123
 * @returns {{repo: string; prNo: string}} repo: repository name, prNo: pull request number
 */
export function parseGitHubURL(targetPullRequestURL) {
  const [, repo, prNo] = targetPullRequestURL.match(
    /github.com\/.+?\/(.+?)\/pull\/(\d+)$/
  )
  return { repo, prNo }
}
