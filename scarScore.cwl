#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull: "sinaiiidgst/scarscore:934baed"
  InlineJavascriptRequirement: {}

inputs:
  FacetsCNCF:
    type: File
    inputBinding:
      position: 1

  FacetsSummary:
    type: File
    inputBinding:
      position: 2
      
  sampleID:
    type: string
    inputBinding:
      position: 3

baseCommand: [Rscript, /bin/scarScore.R]

outputs:
  scar_input:
    type: File
    outputBinding:
      glob: $(inputs.sampleID + "_HRDinputs.txt")
  scar_results:
    type: File
    outputBinding:
      glob: $(inputs.sampleID + "_HRDresults.txt")