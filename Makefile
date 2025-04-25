.PHONY: all svg clean

# Default target
all: svg

# Generate SVG from Mermaid diagram
svg:
	npx @mermaid-js/mermaid-cli -i terraform-workflow.md -o terraform-workflow.svg

# Clean generated files
clean:
	rm -f terraform-workflow.svg

# Install dependencies (if needed)
install:
	npm install -g @mermaid-js/mermaid-cli 