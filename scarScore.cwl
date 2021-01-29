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

  ploidyPurity:
    type: File
    inputBinding:
      position: 2
      
  sampleID:
    type: string
    inputBinding:
      position: 3

baseCommand: [Rscript, "scarScore.R"]

outputs:
  scarInputTable:
    type: File
    outputBinding:
      glob: $(inputs.sampleID + "_HRDinputs.txt")

  scarResultsTable:
    type: File
    outputBinding:
      glob: $(inputs.sampleID + "_HRDresults.txt")
