PREFIX := ~/.local
BIN_PREFIX ?= ~/.local
BIN_DIR := $(BIN_PREFIX)/bin
DESKTOP_DIR := $(PREFIX)/share/applications
CONFIG_DIR := ~/.config/browser-dispatcher
MIMEAPPS_LIST := ~/.config/mimeapps.list

SCRIPT := browser-dispatcher
DESKTOP_FILE := browser-dispatcher.desktop
CONFIG_FILE := config.yml
OLD_DEFAULT_FILE := old-default

.PHONY: all install uninstall

all:
	@echo "Use 'make install' to install the script and desktop file user-wide."
	@echo "Use 'make uninstall' to remove them."

install: $(BIN_DIR)/$(SCRIPT) $(DESKTOP_DIR)/$(DESKTOP_FILE)
	@echo "Saving the exisitng default browser..."
	@xdg-mime query default x-scheme-handler/http > $(CONFIG_DIR)/$(OLD_DEFAULT_FILE)
	@echo "Registering $(DESKTOP_FILE) with xdg-mime..."
	@xdg-mime default $(DESKTOP_FILE) x-scheme-handler/http x-scheme-handler/https
	@echo "Installation completed!"

$(BIN_DIR)/$(SCRIPT): $(SCRIPT)
	@echo "Installing $(SCRIPT) to $(BIN_DIR)..."
	@mkdir -p $(BIN_DIR)
	@chmod +x $(SCRIPT)
	@ln -s $(BIN_DIR)/$(SCRIPT) $$(pwd)/$(SCRIPT)

$(DESKTOP_DIR)/$(DESKTOP_FILE): $(DESKTOP_FILE)
	@echo "Installing $(DESKTOP_FILE) to $(DESKTOP_DIR)..."
	@mkdir -p $(DESKTOP_DIR)
	@cp $(DESKTOP_FILE) $(DESKTOP_DIR)

$(CONFIG_DIR)/$(CONFIG_FILE): $(CONFIG_FILE)
	@echo "Copying $(CONFIG_FILE) to $(CONFIG_DIR)..."
	@mkdir -p $(CONFIG_DIR)
	@cp $(CONFIG_FILE) $(CONFIG_DIR)

uninstall:
	@echo "Removing $(SCRIPT) and $(DESKTOP_FILE)..."
	@rm -f $(BIN_DIR)/$(SCRIPT)
	@rm -f $(DESKTOP_DIR)/$(DESKTOP_FILE)
	@echo "Unregistering $(DESKTOP_FILE) from xdg-mime..."
	@xdg-mime default $$(cat $(CONFIG_DIR)/$(OLD_DEFAULT_FILE)) x-scheme-handler/http x-scheme-handler/https
	@echo "Uninstallation completed!"
