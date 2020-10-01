cwlVersion: v1.0
class: CommandLineTool

requirements:
  ShellCommandRequirement: {}
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.infile[0])
      - $(inputs.infile[1])
      - $(inputs.infile[2])
      - $(inputs.infile_tbi[0])
      - $(inputs.infile_tbi[1])
      - $(inputs.infile_tbi[2])

inputs:
  infile:
    type: File[]

  infile_tbi:
    type: File[]

outputs:
  outfile:
    type: File
    outputBinding:
      glob: "common_variants.vcf"

baseCommand: [vcf-isec]

arguments:
  - "-f"
  - "-n"
  - "+2"
  - $(inputs.infile[0].basename)
  - $(inputs.infile[1].basename)
  - $(inputs.infile[2].basename)
  - ">"
  - "common_variants.vcf"