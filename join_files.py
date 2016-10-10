#! /usr/bin/python
outfile = open('./out/anatomical_systems.txt', 'w')
outfile.write('system id | system name | tissue id | tissue name \n')
for system in open('./out/all_systems', 'r'):
    system_id = system.split('|')[0]
    try:
        for line in open('./out/%s'%system_id, 'r'):
            outfile.write("%s|%s"%(system.replace('\n', ''), line))
    except BaseException:
        print("No data for: %s"%system_id)
