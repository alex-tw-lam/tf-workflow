.PHONY: all svg png clean

# Default target
all: svg png

# Generate SVG from Mermaid diagram
svg:
	npx @mermaid-js/mermaid-cli -i terraform-workflow.md -o terraform-workflow.svg

# Generate PNG from Mermaid diagram
png:
	npx @mermaid-js/mermaid-cli -i terraform-workflow.md -o terraform-workflow.png

# Clean generated files
clean:
	rm -f terraform-workflow.svg terraform-workflow.png

# Install dependencies (if needed)
install:
	npm install -g @mermaid-js/mermaid-cli 