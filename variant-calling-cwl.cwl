cwlVersion: v1.0
class: Workflow

requirements:
  - class: ScatterFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  input_bam:
    type: File

  reference_genome:
    type: File

outputs:
  output:
    type: File
    outputSource: [count/outfile]

steps:
  index_bam:
    run: index_bam.cwl
    in:
      infile: input_bam
    out:
      [outfile]

  reference_dict:
    run: reference_dict.cwl
    in:
      infile: reference_genome
    out:
      [outfile]

  reference_index:
    run: reference_index.cwl
    in:
      infile: reference_genome
    out:
      [outfile]

  vc_samtools:
    run: vc_samtools.cwl
    in:
      infile_fa: reference_genome
      infile_bam: input_bam
      infile_fai: reference_index/outfile
    out:
      [outfile]

  vc_freebayes:
    run: vc_freebayes.cwl
    in:
      infile_fa: reference_genome
      infile_bam: input_bam
      infile_fai: reference_index/outfile
    out:
      [outfile]

  vc_haplotypeCaller:
    run: vc_haplotypeCaller.cwl
    in:
      infile_fa: reference_genome
      infile_bam: input_bam
      infile_fai: reference_index/outfile
      infile_dict: reference_dict/outfile
      infile_bai: index_bam/outfile
    out:
      [outfile]

  index_variant_files:
    scatter: infile
    run: index_variant_files.cwl
    in:
      infile: [vc_samtools/outfile,
               vc_freebayes/outfile,
               vc_haplotypeCaller/outfile]
    out:
      [outfile, outfile_tbi]

  intersect_variants:
    run: intersect_variants.cwl
    in:
      infile: index_variant_files/outfile
      infile_tbi: index_variant_files/outfile_tbi
    out:
      [outfile]

  count:
    run: count.cwl
    in:
      infile: intersect_variants/outfile
      in_name: input_bam
    out:
      [outfile]