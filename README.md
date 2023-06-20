## Capstone-RISC-V ISA Reference

This repository contains the source code for the Capstone-RISC-V ISA Reference.
The reference is written in [AsciiDoc](https://asciidoc.org/) and can be built
using [Asciidoctor](https://asciidoctor.org/).

A public version of the built reference can be found at https://jason.kisp.ml/specs/.
This version is automatically built from the `master` branch.
Builds for other pushed revisions can be found at https://jason.kisp.ml/specs-revs/,
which are also listed by branch names and build dates at
https://jason.kisp.ml/specs-revs/by-branch/ and https://jason.kisp.ml/specs-revs/by-date/
respectively.

### Rendering to PDF and HTML5

The easy way to do this is to use the Makefile, which relies on an
[Apptainer](https://apptainer.org/) image defined in the `container` folder.
Make sure you have Apptainer already installed and simply run `make`.
The rendered results can be found in the `output` folder.

If you have your own Apptainer image and want to prevent `make` from
building one, you can set `EXTERNAL_CONTAINER_IMG`:

```bash
make EXTERNAL_CONTAINER_IMG=<path-to-your-image>
```

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
