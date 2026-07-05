# Define variables for commands
PRETEXT = pretext build

.PHONY: 114 311 310 clean

# Default target
all: 114 311 310

# Clean target (optional, if needed): removes output, logs, and generated-assets (excluding dynamic_subs/)
clean:
	rm -rf output/ logs/
	find generated-assets/ -mindepth 1 -type d -not -path "generated-assets/dynamic_subs*" -exec rm -rf {} +

114:
	$(PRETEXT) ma114
	$(PRETEXT) ma114-pdf

311:
	$(PRETEXT) ma311
	$(PRETEXT) ma311-pdf

310:
	$(PRETEXT) ma310
	$(PRETEXT) ma310-pdf