#!/usr/bin/env python

import os 
import sys
import argparse
import csv

def file_len(fname):
	return len(open(fname).readlines( ))

def validate_file_doesnt_exist(fname):
	exists = os.path.isfile(fname)
	if exists:
		sys.exit('Error: tried to create {}, but it already exists'.format(formatted_file))

def get_file_header(fname):
	with open(fname) as f:
		return f.readline()

def copy_csv(infile, outfile, included_cols, headerline):
	with open(outfile, 'wb') as outfile:
		outfile.write(headerline)

	with open(infile, 'rb') as infile:
		reader = csv.reader(infile, delimiter=',')
		included_cols = [0,1,2,3]
		for row in reader:
			content = list(row[i] for i in included_cols)
			outfile.write(','.join('"{0}"'.format(cell) for cell in content))
			outfile.write('\n')

def write_missing_rows(originalfile, updatedfile, missingfile, headerline):
	with open(originalfile, 'rb') as original, open(updatedfile, 'rb') as updated:
		fileone = [line.rstrip() for line in original.readlines()]
		filetwo = [line.rstrip() for line in updated.readlines()]
	with open(missingfile, 'wb') as outfile:
		outfile.write(headerline)
		for line in fileone:
			if line not in filetwo:
				outfile.write(line)
				outfile.write('\n')

parser = argparse.ArgumentParser()
parser.add_argument("original_file")
parser.add_argument("output_file")
args = parser.parse_args()

# Subtract header row
original_len = file_len(args.original_file) - 1
output_len = file_len(args.output_file)

if original_len == output_len:
	print("original_file and output_file are the same length, no records missed")
else:
	formatted_file = '{}_formatted.csv'.format(args.output_file)
	missing_file = '{}_missing.csv'.format(args.output_file)

	validate_file_doesnt_exist(formatted_file)
	validate_file_doesnt_exist(missing_file)

	headerline = get_file_header(args.original_file)
	copy_csv(args.output_file, formatted_file, [1,2,3,4], headerline)
	write_missing_rows(args.original_file, formatted_file, missing_file, headerline)
