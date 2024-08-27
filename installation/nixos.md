## NixOS Setup

To set up the environment on NixOS:

1. **Download the Latest NixOS Minimal ISO**: Get it from the [Nix Official Download](https://nixos.org/download/) page (bottom of the page).

2. **Install NixOS**:
   If not already installed, follow the [NixOS installation guide](https://nixos.org/manual/nixos/stable/#sec-installation-manual).

3. **Clone the Repository**:
   Clone the NixSetupKit repository to your system:
   ```bash
   git clone https://github.com/zangjiucheng/NixSetupKit.git
   cd nix-config
   ```

3. **Configuration**: Customize the nix-config files as needed for your specific development environment.
    > For user setup, it's recommended to place your configuration in `nix-config/user/user-nixos/<YOUR_USERNAME>` and then add your name to `userList.nix`. This approach simplifies profile compilation and supports multi-user configurations.

    > A default user setup will be provided later. Stay tuned for updates on the roadmap.

4. **Run the Setup Script**: Execute the following command:
    ```bash
    nixos-rebuild switch --flake .#nixos
    ```

5. Activate and Enjoy your fully configured NixOS setup.
