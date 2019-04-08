import json


def main():
    data = []
    #traces = open(str(sys.argv[1]), 'r')
    print('loading lookup table...')

    """
    https://stackoverflow.com/questions/12451431/loading-and-parsing-a-json-file-with-multiple-json-objects-in-python
    """
    lookup = open('lookup_final_mai_small_encoded.json')
    for line in lookup:
        data.append(json.loads(line))
    lookup.close()

    print('done')
    print(data[0])
    print(data[0]['CHILD_NAME'])

    print('Creating lookup dict')
    """
    https://stackoverflow.com/questions/3199171/append-multiple-values-for-one-key-in-python-dictionary
    """
    lookup_dict = {}
    amount_errors = 0
    for elem in data:
        try:
            if elem['join_key_lookup'] in lookup_dict:
                lookup_dict[elem['join_key_lookup']].append(elem)
            else:
                lookup_dict[elem['join_key_lookup']] = [elem]
        except KeyError:
            amount_errors += 1
            pass
    print('done with ' + str(amount_errors) + ' KeyErrors.')
    
    print('saving json to disk..')
    with open('lookup_mai.json', 'w') as outfile:
        json.dump(lookup_dict, outfile)
        print('done')
    #print(lookup_dict['data15_13TeV:data15_13TeV.00281411.physics_Main.deriv.DAOD_HIGG5D1.r9264_p3083_p3213_tid11568128_00'])

if __name__ == "__main__":
    main()

