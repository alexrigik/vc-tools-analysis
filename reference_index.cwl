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
      glob: $(inputs.infile.basename).fai

baseCommand: [samtools]

arguments:
  - "faidx"
  - $(inputs.infile.basename)