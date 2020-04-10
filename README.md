# sudoku-master

Final project for ECE 5367 at UH.

## Git workflow

Typical Git workflow when starting to develop a feature:

1. Checkout master: `git checkout master`
2. Update/pull latest commits: `git pull`
3. Create and checkout a new branch for your feature: `git checkout -b your-branch-name-here`
4. Do whatever development you need to do on this branch.
  1. Commit things in reasonable chunks. How to commit: in project root run `git add .`,
      then `git status` to check if the right things are being committed,
      then `git commit -m "(Your commit message)"` to commit.
5. Once you've made a commit (or multiple), push your work.
  1. If it's your first time pushing to this branch, use `git push origin -u your-branch-name-here`
  2. Otherwise, just `git push`
6. When your feature/component/whatever is complete, open a pull request (PR) on the GitHub site.
7. If there are merge conflicts, you'll have to resolve them.
  1. If needed, can check [this doc](https://github.com/travisbartholome/git-cheatsheet#merging) for a typical merge process.

Note: life is usually easiest if each branch only has one person pushing commits to it.
