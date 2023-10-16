def read_fasta(input_file):
    """Reads the FASTA file and returns a list of tuples containing headers and sequences."""
    sequences = []
    with open(input_file, 'r') as f:
        header = ''
        sequence = ''
        for line in f:
            line = line.strip()
            if line.startswith('>'):
                if header and sequence:
                    sequences.append((header, sequence))
                header = line
                sequence = ''
            else:
                sequence += line
        if header and sequence:
            sequences.append((header, sequence))
    return sequences


def write_fasta(output_file, sequences):
    """Writes a list of sequences to a FASTA file."""
    with open(output_file, 'w') as f:
        for header, sequence in sequences:
            f.write(header + '\n')
            f.write(sequence + '\n')


def break_fasta(input_file, output_prefix, seqs_per_file):
    """Splits the input FASTA file into multiple output files with the specified number of sequences per file."""
    sequences = read_fasta(input_file)
    num_sequences = len(sequences)
    num_files = (num_sequences + seqs_per_file - 1) // seqs_per_file

    for i in range(num_files):
        start = i * seqs_per_file
        end = min((i + 1) * seqs_per_file, num_sequences)
        output_file = f"{output_prefix}_{i + 1}.fasta"
        write_fasta(output_file, sequences[start:end])


if __name__ == "__main__":
    input_file_path = "Ref_R64.fasta"  # Replace with the path to your input FASTA file
    output_file_prefix = "output"    # Prefix for the output files
    sequences_per_file = 1          # Number of sequences per output file

    break_fasta(input_file_path, output_file_prefix, sequences_per_file)