#outp = open('update_script.cql', 'w')
inp = open('person_weight.txt', 'r')
count = 0
for line in inp:
    
    count += 1
    if count == 1:
        continue
    tokens = line.split('|')
    outp_data = "UPDATE nantos_cos.person_weight"
    outp_data += " SET height_uom = 'cm', weight_uom = 'kg'"
    outp_data += " WHERE company_gid = {0}".format(tokens[0].strip())
    outp_data += " AND person_gid = {0}".format(tokens[1].strip())
    outp_data += " AND measurement_timestamp = '{0}'".format(tokens[2].strip())
    outp_data += " AND encounter_gid = {0};".format(tokens[3].strip())
    print outp_data

inp.close()
