import json


def main():

    print('loading lookup table...')
    with open('lookup.json', 'r') as lookup:
        data = json.load(lookup)
        print('done')


    print(data['data18_13TeV:data18_13TeV.00348197.physics_Main.merge.HIST_L1RPC.f920_m1951_c1196_m1933'])


if __name__ == "__main__":
    main()

