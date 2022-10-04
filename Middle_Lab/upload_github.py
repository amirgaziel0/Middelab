from git.repo import Repo
repository = Repo.init('/path/of/repository', bare=True)

# Add https://github.com/username/projectname as a remote to our repository
repository.create_remote('origin', 'https://github.com/foo/test.git')



repository.untracked_files

repository.index.add(['index.html'])

commit = repository.index.commit("This is our first commit")
