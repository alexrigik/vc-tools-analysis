cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.infile_fa)
      - $(inputs.infile_bam)
      - $(inputs.infile_fai)
      - $(inputs.infile_dict)
      - $(inputs.infile_bai)

inputs:
  infile_fa:
    type: File

  infile_bam:
    type: File

  infile_fai:
    type: File

  infile_dict:
    type: File

  infile_bai:
    type: File

outputs:
  outfile:
    type: File
    outputBinding:
      glob: $(inputs.infile_bam.nameroot)_hc.vcf

baseCommand: [java]

arguments:
  - "-jar"
  - "/opt/gatk/GenomeAnalysisTK.jar"
  - "-R"
  - $(inputs.infile_fa.basename)
  - "-T"
  - "HaplotypeCaller"
  - "-I"
  - $(inputs.infile_bam.basename)
  - "-o"
  - $(inputs.infile_bam.nameroot)_hc.vcf
