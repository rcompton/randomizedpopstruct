import string

#Input: a string corresponding to genotype data at a SNP location
#Output: which letters make up the major allel and minor allel
def get_allels(snp):
    haps = snp.split()

    Af = 0
    Cf = 0
    Tf = 0
    Gf = 0
    
    for h in haps:
        if len(h) != 2:
            continue
        else:
            for ploid in range(1):
                if h[ploid] == 'A':
                    Af = Af+1
                if h[ploid] == 'C':
                    Cf = Cf+1
                if h[ploid] == 'T':
                    Tf = Tf+1
                if h[ploid] == 'G':
                    Gf = Gf+1

    majidx = sorted(zip([Af,Cf,Tf,Gf], range(4)), reverse=True) [0][1]
    minidx = sorted(zip([Af,Cf,Tf,Gf], range(4)), reverse=True) [1][1]
    
    if majidx==0:
        maja = 'A'
    if majidx==1:
        maja = 'C'
    if majidx==2:
        maja = 'T'
    if majidx==3:
        maja = 'G'
    
    if minidx==0:
        mina = 'A'
    if minidx==1:
        mina = 'C'
    if minidx==2:
        mina = 'T'
    if minidx==3:
        mina = 'G'

    return maja,mina

#Input: a string corresponding to a SNP column
#Output: a list of 0/1/2 style data
def letters_to_numbers(snp, majorallel, minorallel):
    haps = snp.split()
    nums = []

    lexsmall = min(str(majorallel), str(minorallel))

    for hap in haps:
        if len(hap) != 2:
            continue
        else:
            if hap[0] != hap[1]:
                nums.append(1)
            else:
                if hap[0] == lexsmall or hap[0] == 'N':
                    nums.append(0)
                else:
                    nums.append(2)
    del hap, haps,lexsmall
    return nums

#convert a whole file to 0/1/2
def do_a_whole_file(f):
    outnums = []

    #first line is crap
    l = f.readline()
    
    while l != "":
        a,b = get_allels(l)
        nums = letters_to_numbers(l,a,b)
        outnums.append(nums)
        del a,b,l,nums
        l = f.readline()

    outf = open(f.name + ".dat", 'w')
    for nums in outnums:
        #gettin' weird
        outf.writelines(string.join(map(str,nums)) + '\n')
    
    return

#Use glob for better software...
f = open("genotypes_chr22_CEU_r21a_nr.txt")
do_a_whole_file(f)

f = open("genotypes_chr22_JPT_r21a_nr.txt")
do_a_whole_file(f)

f = open("genotypes_chr22_CHB_r21a_nr.txt")
do_a_whole_file(f)

f = open("genotypes_chr22_YRI_r21a_nr.txt")
do_a_whole_file(f)

