BUNDLE_PATH = "caffeine@patapon.info.zip"
EXTENSION_DIR = "caffeine@patapon.info"

all: build install

.PHONY: build dist install lint lint-fix

build:
	./update-locale.sh
	glib-compile-schemas --strict --targetdir=caffeine@patapon.info/schemas/ caffeine@patapon.info/schemas

dist: build
	rm -f $(BUNDLE_PATH)
	cd $(EXTENSION_DIR); \
	gnome-extensions pack --force --podir=locale \
	                      --extra-source=preferences/ \
	                      --extra-source=icons/; \
	mv $(EXTENSION_DIR).shell-extension.zip ../$(BUNDLE_PATH)

install:
	gnome-extensions install $(BUNDLE_PATH) --force 

lint:
	eslint --resolve-plugins-relative-to "$(shell npm root -g)" $(EXTENSION_DIR)

lint-fix:
	eslint --resolve-plugins-relative-to "$(shell npm root -g)" --fix $(EXTENSION_DIR)
