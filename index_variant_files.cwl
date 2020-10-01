cwlVersion: v1.0
class: CommandLineTool

requirements:
  ShellCommandRequirement: {}
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
      glob: $(inputs.infile.basename).gz

  outfile_tbi:
    type: File
    outputBinding:
      glob: $(inputs.infile.basename).gz.tbi

baseCommand: [bgzip]

arguments:
  - $(inputs.infile.basename)
  - ";"
  - "tabix"
  - "-p"
  - "vcf"
  - $(inputs.infile.basename).gz