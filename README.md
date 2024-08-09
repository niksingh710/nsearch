> [!NOTE]
> I've been using the Nix website to search for packages, and while it worked fine, it required me to open the site, enter the search string, and go through the process each time. Although the nix search nixpkgs command worked, it took some time to load and evaluate everything.
>
> Later, a friend on Discord _(.sszark)_ shared a command with me that allows searching for packages using fzf. Although I eventually learned about nix-index, I had already created this script. So, here we are.

### HOW?

```
nix run github:niksingh710/nsearch
```

##### Install

```
# flake input
nsearch = {
  url = "github:niksingh710/nsearch";
  inputs.nixpkgs.follows = "nixpkgs";
};

environment.systemPackages = [
  inputs.nsearch.packages.${pkgs.system}.default
];
```

### WHAT?

![out](https://github.com/user-attachments/assets/9dc4b25d-529b-4326-91c8-af6dbc35baee)

![out](https://github.com/user-attachments/assets/00c24bf4-6372-4053-a812-383829d81c6e)

> [!TIP]
> Use fzf multimode to select multiple packages.
>
> ```bash
> NSEARCH_FZF_CMD="fzf --multi --bind='ctrl-space:select' --bind='ctrl-/:deselect' "
> ```


Make the bellow script your `shell` command as replacement of `nix-shell` command.

```bash
#!/usr/bin/env bash
# Initialize empty arrays for package names and options
ps=()
os=()

# Loop through all the arguments
for p in "$@"; do
    if [[ "$p" != --* ]]; then
        # If not an option, add it to the package names array
        ps+=("nixpkgs#$p")
    else
        # If it is an option, add it to the options array
        os+=("$p")
    fi
done

# Construct the command
cmd="SHELL=$(which zsh) IN_NIX_SHELL=\"impure\" nix shell ${os[*]} ${ps[*]}"
echo "Executing \`$cmd\`..."

# Execute the command
eval $cmd
```

Then you can use the below command to easily initialize the nix-shell with multiple packages.

```bash
shell $(nsearch)
```

> [!TIP]
> You can also map `nsearch` to a keybind in zsh via widgets.

### Any type of input feedback or modification is welcome.

Addition of new features, bug fixes, and improvements are always welcome.
