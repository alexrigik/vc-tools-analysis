cwlVersion: v1.0
class: CommandLineTool

requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.infile_fa)
      - $(inputs.infile_bam)
      - $(inputs.infile_fai)

inputs:
  infile_fa:
    type: File

  infile_bam:
    type: File

  infile_fai:
    type: File

outputs:
  outfile:
    type: File
    outputBinding:
      glob: $(inputs.infile_bam.nameroot)_sm.vcf

baseCommand: [samtools]

arguments:
  - "mpileup"
  - "-uf"
  - $(inputs.infile_fa.basename)
  - $(inputs.infile_bam.basename)
  - "|"
  - "bcftools"
  - "view"
  - "-vcg"
  - "-"
  - ">"
  - $(inputs.infile_bam.nameroot)_sm.vcf
