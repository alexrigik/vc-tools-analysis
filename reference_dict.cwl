cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.infile)

inputs:
  infile:
    type: File

outputs:
  outfile:
    type: File
    outputBinding:
      glob: $(inputs.infile.nameroot).dict

baseCommand: [java]

arguments:
  - "-jar"
  - "/opt/picard/picard.jar"
  - "CreateSequenceDictionary"
  - R=$(inputs.infile.basename)
  - O=$(inputs.infile.nameroot).dict