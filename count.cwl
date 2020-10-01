cwlVersion: v1.0
class: CommandLineTool

requirements:
  InlineJavascriptRequirement: {}
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - $(inputs.infile)
      - $(inputs.in_name)

inputs:
  infile:
    type: File

  in_name:
    type: File

  pattern:
    type: string
    default: "[#]"

outputs:
  outfile:
    type: File
    outputBinding:
      glob: $(inputs.in_name.nameroot)_count.txt

baseCommand: ['grep']

arguments:
  - "-v"
  - $(inputs.pattern)
  - "-c"
  - $(inputs.infile.basename)
  - ">"
  - $(inputs.in_name.nameroot)_count.txt