#!/bin/bash

cwl-runner scarScore.cwl --facetsSegments "exampleInputs/tumor.facets_cncf.txt" --ploidyPurity "exampleInputs/tumor.facets_output.txt" --sampleID "ISMMS01"