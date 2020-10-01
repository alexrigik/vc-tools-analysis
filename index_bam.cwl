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
      glob: $(inputs.infile.basename).bai

baseCommand: [samtools]

arguments:
  - "index"
  - $(inputs.infile.basename)
