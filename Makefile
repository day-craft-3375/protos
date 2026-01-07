# ========================
# Configuration
# ========================

BUF_VERSION := v1.63.0
BUF_CMD := buf

# ========================
# Phony targets
# ========================

.PHONY: all help format lint generate buf-install buf-dep-update check-buf

# ========================
# Default target
# ========================

all: format lint generate

# ========================
# Help
# ========================

help:
	@echo "Available targets:"
	@echo "  make lint            Run buf lint"
	@echo "  make generate        Run buf generate"
	@echo "  make buf-install     Install buf ($(BUF_VERSION))"
	@echo "  make buf-dep-update  Update buf dependencies"
	@echo "  make all             Lint + generate (default)"

# ========================
# Checks
# ========================

check-buf:
	@command -v $(BUF) >/dev/null 2>&1 || \
		{ echo "buf is not installed. Run 'make buf-install'"; exit 1; }

# ========================
# Commands
# ========================
format: check-buf
	$(BUF_CMD) format -w proto

lint: check-buf
	$(BUF_CMD) lint

generate: check-buf
	$(BUF_CMD) generate

buf-install:
	go install github.com/bufbuild/buf/cmd/buf@$(BUF_VERSION)

buf-dep-update:
	$(BUF_CMD) dep update
