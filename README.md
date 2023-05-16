# Get Started

## Concept

- Everyone can register to become a donor with name, email, amount_donated, frequncy_donated, current_fame ( HATCHLING, NESTLING, CHICK, FLEDGLING, BIRD < JUVENILE, IMMATURE, ADULT > )
- Compaign (name, desc, expected value, current_receive, start_date, end_date, fixed, max, period)
- Certificate Different level with (max_number, date_minted )
- Famehall is assigned to donor based on the amount ( starter)
- DonationTier can be many level ( small, medium, max, elite, custom) that come built in with a value.
- Once donated, donor gets accumulated the amount of donation and fame is calculated and a Donation(donor, amount, campaign) is creator and a cert is issued
- display list of donors and donations for public

## Test the app

1. Copy the seed phrase from docs/test-seed.txt and import to your SUI wallet.
2. In the sui wallet, switch to devnet
3. Request Devnet SUI tokens
4. Run command publish

```sh
> sui client publish --gas-budget 30000000
UPDATING GIT DEPENDENCY https://github.com/MystenLabs/sui.git
INCLUDING DEPENDENCY Sui
INCLUDING DEPENDENCY MoveStdlib
BUILDING charifun
Successfully verified dependencies on-chain against source.
----- Transaction Digest ----
HZskbbXCogzMX4C7LSJQyuZW1r2ZPwibJwH59vZwkbL6
----- Transaction Data ----
Transaction Signature: [Signature(Ed25519SuiSignature(Ed25519SuiSignature([0, 75, 86, 139, 123, 198, 162, 218, 114, 116, 176, 12, 21, 70, 63, 157, 32, 2, 158, 149, 210, 254, 150, 206, 4, 96, 104, 62, 25, 249, 27, 173, 109, 101, 46, 169, 219, 73, 42, 168, 73, 132, 241, 117, 155, 34, 191, 75, 143, 163, 65, 93, 147, 9, 134, 245, 154, 131, 198, 65, 194, 135, 94, 248, 5, 222, 146, 167, 249, 219, 94, 145, 111, 190, 140, 70, 192, 198, 185, 227, 169, 218, 209, 150, 151, 163, 173, 234, 133, 21, 53, 174, 144, 178, 27, 217, 118])))]
Transaction Kind : Programmable
Inputs: [Pure(SuiPureValue { value_type: Some(Address), value: "0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed" })]
Commands: [
  Publish(<modules>,0x0000000000000000000000000000000000000000000000000000000000000001,0x0000000000000000000000000000000000000000000000000000000000000002),
  TransferObjects([Result(0)],Input(0)),
]

Sender: 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed
Gas Payment: Object ID: 0x487ed2bd43d45a3c646b91f644bbfa7c73d1e1d26b2570d66da2eecdad3508af, version: 0x40c4, digest: C1YWZtMqEauuvFTkDrf32itq4ripJYY9tsVi5RVmLZTQ 
Gas Owner: 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed
Gas Price: 1000
Gas Budget: 30000000

----- Transaction Effects ----
Status : Success
Created Objects:
  - ID: 0x27393b17e555a4d60713e53b1ab83d6e0c3207857c517454efdcfce447cfc551 , Owner: Account Address ( 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed )
  - ID: 0xc552820c1e8b8475d113f7f40a99afc18df7c9be3d7085d0e63b7f80a60e9133 , Owner: Account Address ( 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed )
  - ID: 0xcd77a2ff42f5bec877c17bec9dde051c15103195083e2deaa34ad93cddd8a30b , Owner: Immutable
Mutated Objects:
  - ID: 0x487ed2bd43d45a3c646b91f644bbfa7c73d1e1d26b2570d66da2eecdad3508af , Owner: Account Address ( 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed )

----- Events ----
Array []
----- Object changes ----
Array [
    Object {
        "type": String("mutated"),
        "sender": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        "owner": Object {
            "AddressOwner": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        },
        "objectType": String("0x2::coin::Coin<0x2::sui::SUI>"),
        "objectId": String("0x487ed2bd43d45a3c646b91f644bbfa7c73d1e1d26b2570d66da2eecdad3508af"),
        "version": String("16581"),
        "previousVersion": String("16580"),
        "digest": String("FQHgca6xzL2o3DaDZCP5DQro3M9MfG3Lmy1mUUfTZqbd"),
    },
    Object {
        "type": String("created"),
        "sender": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        "owner": Object {
            "AddressOwner": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        },
        "objectType": String("0x2::package::UpgradeCap"),
        "objectId": String("0x27393b17e555a4d60713e53b1ab83d6e0c3207857c517454efdcfce447cfc551"),
        "version": String("16581"),
        "digest": String("DMNdSVj3T4JpeYrk4Zne8oveZkUWyZzneo131bbptCFv"),
    },
    Object {
        "type": String("created"),
        "sender": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        "owner": Object {
            "AddressOwner": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        },
        "objectType": String("0xcd77a2ff42f5bec877c17bec9dde051c15103195083e2deaa34ad93cddd8a30b::cap::PackageOwnerCap"),
        "objectId": String("0xc552820c1e8b8475d113f7f40a99afc18df7c9be3d7085d0e63b7f80a60e9133"),
        "version": String("16581"),
        "digest": String("Dkz37R5uMTFhJ66DvjLwev2WDjgPRCwchq4eLqJt2aNP"),
    },
    Object {
        "type": String("published"),
        "packageId": String("0xcd77a2ff42f5bec877c17bec9dde051c15103195083e2deaa34ad93cddd8a30b"),
        "version": String("1"),
        "digest": String("ArtJezqeJosThrHXJNvxAr9P3E4Q3whiNSg8QMRLA8xV"),
        "modules": Array [
            String("cap"),
            String("donor"),
            String("donor_board"),
            String("main"),
            String("sum"),
        ],
    },
]
----- Balance changes ----
Array [
    Object {
        "owner": Object {
            "AddressOwner": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        },
        "coinType": String("0x2::sui::SUI"),
        "amount": String("-26568680"),
    },
]
```

You might need the following:

- PackageID: 0xcd77a2ff42f5bec877c17bec9dde051c15103195083e2deaa34ad93cddd8a30b
- UpgradeCap: 0x27393b17e555a4d60713e53b1ab83d6e0c3207857c517454efdcfce447cfc551
- PackageOwnerCap: 0xc552820c1e8b8475d113f7f40a99afc18df7c9be3d7085d0e63b7f80a60e9133
- Sender(you): 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed

After I run the setup entry in the explor, I've got back:

```sh
Digest F7oSxiyjFDzg2Fom7c3Na74VJ4CvVoA9p6yjZ6Bg89ni
Created 0x387c1fa39d32808ca28dce1eb12ffe91e9c1bbbfb123b67fdfff0db3668a8d23
Updated
0x487ed2bd43d45a3c646b91f644bbfa7c73d1e1d26b2570d66da2eecdad3508af
0xc552820c1e8b8475d113f7f40a99afc18df7c9be3d7085d0e63b7f80a60e9133
```

If you go to <https://suiexplorer.com/object/0xcd77a2ff42f5bec877c17bec9dde051c15103195083e2deaa34ad93cddd8a30b?module=main&network=devnet>, you might observe in the transaction section you will see the very first one is the one from the setup call.

Click on the tx(the very first one): <https://suiexplorer.com/txblock/F7oSxiyjFDzg2Fom7c3Na74VJ4CvVoA9p6yjZ6Bg89ni?network=devnet>, You will see the tx details. In our case we are only interested in the object created in this case the donor board which has been created with shared object: <https://suiexplorer.com/object/0x387c1fa39d32808ca28dce1eb12ffe91e9c1bbbfb123b67fdfff0db3668a8d23?network=devnet>

## References

### SUI

- The move lang stdlib: <https://github.com/MystenLabs/sui/tree/main/crates/sui-framework/packages/move-stdlib/sources>
- Framework: <https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/packages/sui-framework/sources/dynamic_object_field.move>
- SUI Example: <https://examples.sui.io/basics/events.html>
- Time: <https://docs.sui.io/build/move/time>
- Test: <https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/packages/sui-framework/sources/test/test_scenario.move#L209>
