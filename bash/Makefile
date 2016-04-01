.PHONY: install \
	install-bash \
	test-bash

install : install-bash


install-bash : test-bash
	mkdir -p $(HOME)/.config $(HOME)/.bashrc.d $(HOME)/.bash_profile.d
	install -pm 0644 -- bashrc "$(HOME)"/.bashrc
	install -pm 0644 -- bashrc.d/* "$(HOME)"/.bashrc.d
	install -pm 0644 -- bash_profile "$(HOME)"/.bash_profile
	install -pm 0644 -- bash_profile.d/* "$(HOME)"/.bash_profile.d

test-bash :
	@for bash in bash/* bash/bashrc.d/* bash/bash_profile.d/* ; do \
		if [ -f "$$bash" ] && ! bash -n "$$bash" ; then \
			exit 1 ; \
		fi \
	done
	@printf 'All bash(1) scripts parsed successfully.\n'
