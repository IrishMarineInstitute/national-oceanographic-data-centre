# Publication Pipeline

This page describes the publication pipeline for metadata and data for the Irish National Marine Data Centre.

As much of this process as possible should be automated through the use of task runners and continuous integration / continuous delivery tools.

## Contents

- [Dataset Metadata](#dataset-metadata)
- [Sensor Metadata](#sensor-metadata)
- [Web Site Build Process](#website-build-process)

## Dataset Metadata

__ A Business Process Model and Notation process flow is to go here __

Process Step | Script | Description
--- | --- | ---
1. | | XML metadata dump to `~/iso-xml`. XML should be ISO19139 compliant.
2. | `invoke rename --dataset` | Force consistent naming of the ISO XML files.
3. | | Transform ISO XML to HTML, resulting files are saved to `~/html`.
4. | | Transform ISO XML to RDF/XML, resulting files are saved to `~/xml`. The RDF mapping uses World Wide Web Consortium Data Catalog Vocabulary; Schema.org; and EarthCube GeoLink concepts.

## Sensor Metadata

__ A Business Process Model and Notation process flow is to go here __

Process Step | Script | Description
--- | --- | ---

## Website Build Process

__ A Business Process Model and Notation process flow is to go here __

Process Step | Script | Description
--- | --- | ---