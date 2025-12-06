.PHONY: update
update:
	home-manager switch --impure --flake .#bumblebee

.PHONY: clean
clean:
	nix-collect-garbage -d
