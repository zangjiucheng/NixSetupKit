## Darwin (macOS) Setup

To set up the environment on macOS (Darwin):

1. **Install Nix and Nix-Darwin**:
    Follow the official installation guides for [Nix](https://nixos.org/download.html) and [Nix-Darwin](https://github.com/LnL7/nix-darwin)

2. **Configuration**: Customize the nix-config files as needed for your specific development environment.
    > For user setup, it's recommended to place your configuration in `nix-config/user/user-darwin/<YOUR_USERNAME>` and then add your name to `userList.nix`. This approach simplifies profile compilation and supports multi-user configurations.

    > A default user setup will be provided later. Stay tuned for updates on the roadmap.

3. **Navigate to `nix-config` Directory**:
    ```bash
    cd nix-config
    ```

4. **Run Compile Script**:
    ```bash
    darwin-rebuild switch --flake ".#macos"
    ```

5. Enjoy your personalized Nix Package Management setup.