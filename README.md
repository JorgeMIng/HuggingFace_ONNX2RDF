# Hugging Face ONNX to RDF parser


[![License](https://img.shields.io/github/license/JorgeMIng/HuggingFace_ONNX2RDF)](LICENSE)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15814658.svg)](https://doi.org/10.5281/zenodo.15814658)
[![Cite this software](https://img.shields.io/badge/Cite%20this-CFF-blue)](https://github.com/JorgeMIng/HuggingFace_ONNX2RDF/blob/main/CITATION.cff)
![Python](https://img.shields.io/pypi/pyversions/HuggingFace2RDF)
[![PyPI version](https://badge.fury.io/py/HuggingFace2RDF.svg)](https://badge.fury.io/py/HuggingFace2RDF)




A Python tool uses [ONNX2RDF](https://github.com/JorgeMIng/ONNX2RDF) for converting HuggingFace Repositories with ONNX (Open Neural Network Exchange) files to RDF (Resource Description Framework).

---

## ✨ Features

- ✅ Parses ONNX model structure into RDF triples (nquads, turtle, trig, trix, jsonld, hdt)
- ✅ Automatic downloading of HuggingFace Files
- ✅ Keeps progress making it able to be stopped to later continue
- ✅ Download repositories randomfly, by most downloads or least downloads
- ✅ Use of threads and multiproccesing for paralization


---

## ⚙️ System Requirements

To use this tool successfully, the following components must be installed on your system:

- ✅ **Python 3.13+**
- ✅ **Java 17+ (OpenJDK recommended)**  
  Used to run the internal **RML Mapper JAR**
- ✅ **Node.js + npm**
- ✅ [`@rmlio/yarrrml-parser`](https://www.npmjs.com/package/@rmlio/yarrrml-parser)  
  Installed globally via `npm install -g @rmlio/yarrrml-parser`
- ✅ [onnx-2-rdf](https://pypi.org/project/onnx-2-rdf/)  (Pip) 

You can also use the dockerfile (see below) which will prepare the enviroment.

---

## 📦 Installation Options


### Option 1: Install from pip

```bash
pip install HuggingFace2RDF
```

### Option 2: Build from Source

Clone and install with [PEP 621](https://peps.python.org/pep-0621/)-compliant `pyproject.toml`:

```bash
git clone https://github.com/JorgeMIng/HuggingFace_ONNX2RDF.git
cd ONNX2RDF
pip install .
```

This installs the CLI command `onnx-parser`.

---

### Option 3: Using Docker

```bash
git clone https://github.com/JorgeMIng/HuggingFace_ONNX2RDF.git
cd ONNX2RDF
docker build -t onnx2rdf .
docker run -it onnx2rdf
```

This Docker image includes:

- Python 3.13
- OpenJDK 17
- Node.js + npm
- `@rmlio/yarrrml-parser`
- ONNX2RDF + CLI (onnx-parser)
- HuggingFace2RDF + CLI (hugg-parser)

---

## 🚀 Usage

### Command-Line Interface

```bash
hugg-parser num_repos [OPTIONS]
```

### Positional Argument

| Argument        | Description |
|-----------------|-------------|
| `num_repos`    | Number of repos to parser from the list (all repos with ONNX tag) A value with (-1) means all repos. |

### Main Options

| Option               | Description |
|----------------------|-------------|
| `--target_path`      | Output directory for RDF files (default: `rdfs`). Can be absolute or relative. |
| `--rdf_format`       | RDF serialization format: `nquads` (default), `turtle`, `trig`, `trix`, `jsonld`, `hdt`. |

### Pipeline Control

| Option               | Description |
|----------------------|-------------|
| `--work_folder`      | Changes the relative base folder for input/output (models, logs, RDF). Default to folder where the software is being called from |
| `--num_threads`      | Number of threads to use (Default -1) |


### List Control

Progress list (progress_cache.json) stores repositories already done without error, repositories not able to be done (repo_id_error), with warnings (repo_id_warning), not done as it was stopped (repos_stopped)-> this repositories will have priority when executing again the program. and (repo_id_try_again) Has repositories which fail only because ONNX2RDF + repositories with warning. Repo_id_error are errors with Huggiface or unexpected errors

| Option               | Description |
|----------------------|-------------|
| `--order_method`     | Order method for selecting the models for the list (random (default), m_downs,l_downs) |
| `--try_again`        | When try_again is executed only model on the list (repo_id_try_again) would be executed  |
| `--try_error`        | When try_error is executed only model on the list (repo_id_error) would be executed  |

---

## Config Controls
A config file is present for changing values used for ONNX2RDF, there is a default config file, if a `custom_parser.config` is created the new values would be used to replace the final config set. The first time executing the program the file is created if it doenst exists in the workfolder.

- `URIS` is the most important category

| Type      | Option               | Description |
|-----------|----------------------|-------------|
|-----------|----------------------|-------------|
|`URIS`     | `resource_url`       | Namespace used for ONNX2RDF ahd HuggParser for modles :(http://base.huggingface.model.com/resource/) |
|`URIS`     | `hugginface_base`    | Namespace for Huggparser Ontology (yarrml file):(http://base.huggingface.model.com#)  |
|-----------|----------------------|--------------|
|`PARSER`   | `debug`              | ONNX2RDF debug mode (True/False) |
|`PARSER`   | `cache`              | ONNX2RDF cache element o list of elements Valid Values: (`all`, `load-model`, `pre-process`, `yamml2rml`,`mapping`) |
|`PARSER`   | `work_folder`        | ONNX2RDF workfolder |
|`PARSER`   | `to_console`         | Activate ONNX2RDF console (True/False) |
|`PARSER`   | `models_folder`      | Folder for searching Huggiface files (Do not change) |
|`PARSER`   | `max_ram`            | RAM allocated for ONNX2RDF |
|`PARSER`   | `no_parsing`         | Desactivate Parsing (False) (Do not change) |
|-----------|----------------------|--------------|
|`METRICS`  | `file_name`          | Name of the metrics file to create |
|-----------|----------------------|--------------|
|`CACHE`    | `progress_file`      | Name of progress cache file |
|`CACHE`    | `cache_hugg_list`    | Huggiface model list cache file (file with all the ids, and metadata) |
|-----------|----------------------|--------------|
|`METADATA` | `tmp_metadata_folder`| Folder used to create metadata tmp files |
|`METADATA` | `mapping_path`       | Folder to look up for the metadata yarrrml (looks up on instalation path) Not yet able to give custom yarrrml |
|`METADATA` | `mapping_file`       | Name of metadata yarrrml (looks up on instalation path) Not yet able to give custom yarrrml |
|-----------|----------------------|--------------|
|`LOGS`     | `logs_folder`| Folder for logs |
|`LOGS`     | `to_console`| Activate HuggingFace2RDF console (True/False) |


### Example

```bash
hugg-parser 100 \
  --rdf_format turtle \
  --num_threads 4
  --order_method m_downs
```

This will:

- Parse the 100 most downloads repositories with turtle format
- Uses 4 threads

## ⚙️ Advanced Usage as a Library

Besides the command-line interface, ONNX2RDF also works as a Python library for programmatic integration.

### Main HuggingFaceParser Class

The core class is `HuggingFaceParser`.

```python
from HuggParser.HuggingFaceParser import HuggingFaceParser

parser = HuggingFaceParser()

# Set parameters
parser.set_rdf_format("nquads")
parser.set_number_threads(8)
parser.set_work_folder("results")

# Parse huggingface repositories
number_repos:int,try_again=False,try_error=False,order_method="random"
parser.run(
    number_repos=100,
    try_again=False,
    try_error=False,
    order_method="random",
)


## 📚 Related Resources


- [ONNX Format](https://onnx.ai/)  
  The Open Neural Network Exchange (ONNX) standard for representing ML models.

- [RDF Basics](https://www.w3.org/RDF/)  
  Introduction to the Resource Description Framework (RDF) by W3C.

- [SPARQL Tutorial](https://www.w3.org/TR/sparql11-query/)  
  Official SPARQL 1.1 Query Language specification and examples.

- [HuggingFace](https://huggingface.co)  
  Official HuggingFace Website.


## 🛠️ TODO

Improvements and future features can be found on [TODO.md (link)](TODO.md):

Feel free to contribute! Check out the [Issues](https://github.com/JorgeMIng/HuggingFace_ONNX2RDF/issues) tab for current tasks and discussions.

## 📄 License

This project is licensed under the terms of the Apache2.0 license.  
See [LICENSE](LICENSE) for more information.



## 🙌 Acknowledgments

- Built using the [ONNX](https://onnx.ai/) Python API.
- Built using the [HuggingFaceHub](https://github.com/huggingface/huggingface_hub) Official Hub API.
- RML Mapping powered by the [RMLMapper](https://github.com/RMLio/rmlmapper-java).
- YARRRML parsing supported via [@rmlio/yarrrml-parser](https://www.npmjs.com/package/@rmlio/yarrrml-parser).
- Developed by OEG (Ontology Engineering Group) of Polytechnic University of Madrid.



## 📑 Citation

If you use this software, please cite as:
 
```bibtex
@software{martin_izquierdo_2025_onnx2rdf,
  author       = {Jorge Martín Izquierdo},
  title        = {HuggingFace2RDF},
  version      = {0.1.2},
  date         = {2025-07-05},
  url          = {https://github.com/JorgeMIng/HuggingFace_ONNX2RDF},
  doi          = {10.5281/zenodo.15814658},
  license      = {Apache 2.0},
  affiliation  = {Universidad Politécnica de Madrid},
  keywords     = {ONNX, RDF, Semantic Web, Machine Learning},
  orcid        = {https://orcid.org/0009-0005-7696-8995}
}
```



## 📫 Contact

For questions, feedback, or contributions, feel free to reach out:

- GitHub Issues: https://github.com/JorgeMIng/HuggingFace_ONNX2RDF/issues
- Email: **Jorge Martín Izquierdo** – [jorge.martin.izquierdo@upm.es](mailto:jorge.martin.izquierdo@upm.es)
