#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "sinaiiidgst/scarscore:a36f233"
  InlineJavascriptRequirement: {}

inputs:
  facetsSegments:
    type: string
    inputBinding:
      position: 1

  ploidy:
    type: File
    inputBinding:
      position: 2


baseCommand: [Rscript, "scarScore.R"]


outputs:
  scarInputTable:
    type: File
    outputBinding:
      glob: "scarHRD_input.tsv"

  scarResultsTable:
    type: File
    outputBinding:
      glob: "scarHRD_results.tsv"
