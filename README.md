# dirigent's Homebrew tap

dirigent's CLI, built from source.

```sh
brew install adamchol/dirigent/dirigent
dirigent login https://dirigent.example.com

# this Mac as a host for your sessions
brew services start dirigent                # as yours (a launchd agent, while you're logged in)
sudo dirigent host install --system         # or as the machine's (a launchd daemon)
```

The formula is updated by [dirigent's](https://github.com/adamchol/dirigent-0) release workflow.
