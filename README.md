## Capstone-RISC-V ISA Reference

This repository contains the source code for the Capstone-RISC-V ISA Reference.
The reference is written in [AsciiDoc](https://asciidoc.org/) and can be built
using [Asciidoctor](https://asciidoctor.org/).

### Rendering to PDF and HTML5

The easy way to do this is to use the Makefile, which relies on an
[Apptainer](https://apptainer.org/) image defined in the `container` folder.
Make sure you have Apptainer already installed and simply run `make`.
The rendered results can be found in the `output` folder.

### File Organisation

The top-level file is `main.adoc`, which includes files for each part
of the documentation inside the `parts` folder.

### Regarding Implementations

Note that the current implementations might not reflect the draft in this
repository.
The implementations will need to be revised to match the draft once it is
ready.
We will be versioning the specification and the implementations in the future
to avoid confusions.

### Contributing

Contributions are welcome! Feel free to submit issues or pull requests.
