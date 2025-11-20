.PHONY: update
update:
	home-manager switch --flake .#bumblebee

.PHONY: clean
clean:
	nix-collect-garbage -d
