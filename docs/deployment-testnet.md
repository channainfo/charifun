# Deployment Testnet

```sh
----- Transaction Digest ----
FNrLdUyvFbP6faqb5n2FwZWngHFxhb4UpGpbjcU4qCdQ
----- Transaction Data ----
Transaction Signature: [Signature(Ed25519SuiSignature(Ed25519SuiSignature([0, 16, 98, 217, 186, 207, 41, 168, 38, 196, 186, 151, 79, 3, 255, 123, 21, 221, 36, 75, 8, 54, 202, 1, 197, 82, 75, 88, 93, 120, 16, 241, 161, 169, 139, 136, 187, 11, 217, 197, 122, 54, 109, 49, 96, 53, 51, 173, 104, 134, 55, 249, 66, 76, 58, 190, 146, 144, 180, 143, 42, 164, 50, 227, 1, 222, 146, 167, 249, 219, 94, 145, 111, 190, 140, 70, 192, 198, 185, 227, 169, 218, 209, 150, 151, 163, 173, 234, 133, 21, 53, 174, 144, 178, 27, 217, 118])))]
Transaction Kind : Programmable
Inputs: [Pure(SuiPureValue { value_type: Some(Address), value: "0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed" })]
Commands: [
  Publish(<modules>,0x0000000000000000000000000000000000000000000000000000000000000001,0x0000000000000000000000000000000000000000000000000000000000000002),
  TransferObjects([Result(0)],Input(0)),
]

Sender: 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed
Gas Payment: Object ID: 0xff5ce1f91f4723d447cf6b972434a2deba730876655aeb99a3b4a70cb82a60a9, version: 0x23, digest: 6ju2umnjTZ1mEmRYP3gjH1jvxFbn5vwiFgX12kofXmUb
Gas Owner: 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed
Gas Price: 1000
Gas Budget: 300000000

----- Transaction Effects ----
Status : Success
Created Objects:

- ID: 0x49b30cbb4577ef9e6332ad6855b6353b553df1344105e8b9865488a097a8768f , Owner: Account Address ( 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed )
- ID: 0xa050cbf7e2bec1c37037b49180157c62b3d1d44459d9cf110b2fc6a96132f21e , Owner: Account Address ( 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed )
- ID: 0xdf08bc0486dc54f3aed9101811c82afff204439b70d933d81aedafc83be990c8 , Owner: Immutable
Mutated Objects:
- ID: 0xff5ce1f91f4723d447cf6b972434a2deba730876655aeb99a3b4a70cb82a60a9 , Owner: Account Address ( 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed )

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
        "objectId": String("0xff5ce1f91f4723d447cf6b972434a2deba730876655aeb99a3b4a70cb82a60a9"),
        "version": String("36"),
        "previousVersion": String("35"),
        "digest": String("8FijoMquSj6gYNeSkcgrZyX92TLs1hiieu7hRKXffcTh"),
    },
    Object {
        "type": String("created"),
        "sender": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        "owner": Object {
            "AddressOwner": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        },
        "objectType": String("0x2::package::UpgradeCap"),
        "objectId": String("0x49b30cbb4577ef9e6332ad6855b6353b553df1344105e8b9865488a097a8768f"),
        "version": String("36"),
        "digest": String("EBQB2SHPzxaHGfmadkCiNtmi3FLYfEpfx78qZrfe4ZQ1"),
    },
    Object {
        "type": String("created"),
        "sender": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        "owner": Object {
            "AddressOwner": String("0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed"),
        },
        "objectType": String("0xdf08bc0486dc54f3aed9101811c82afff204439b70d933d81aedafc83be990c8::cap::PackageOwnerCap"),
        "objectId": String("0xa050cbf7e2bec1c37037b49180157c62b3d1d44459d9cf110b2fc6a96132f21e"),
        "version": String("36"),
        "digest": String("51YRjm3jftL8F5Wc3jhjhZM4JUdhFJBWUkQMbJN3si2Q"),
    },
    Object {
        "type": String("published"),
        "packageId": String("0xdf08bc0486dc54f3aed9101811c82afff204439b70d933d81aedafc83be990c8"),
        "version": String("1"),
        "digest": String("ECouB1WTVWpNDcuvK9DNBRM7ZK4QroESeDEu7S6C9Khe"),
        "modules": Array [
            String("cap"),
            String("donation_board"),
            String("donor"),
            String("donor_board"),
            String("donor_creator"),
            String("donor_event"),
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
        "amount": String("-30452280"),
    },
]

```

## Important objects

- Transaction: FNrLdUyvFbP6faqb5n2FwZWngHFxhb4UpGpbjcU4qCdQ
- PackageId: 0xdf08bc0486dc54f3aed9101811c82afff204439b70d933d81aedafc83be990c8
- PackageOwnerCapId: 0xa050cbf7e2bec1c37037b49180157c62b3d1d44459d9cf110b2fc6a96132f21e
- UpgradeCapId: 0x49b30cbb4577ef9e6332ad6855b6353b553df1344105e8b9865488a097a8768f
- SenderAddress: 0xba841936a6f94c56efa97156f49479396e92fcf6395d5f80aaa93843542389ed

## Explorer

- Tx: <https://suiexplorer.com/txblock/FNrLdUyvFbP6faqb5n2FwZWngHFxhb4UpGpbjcU4qCdQ?network=testnet>
- Pkg: <https://suiexplorer.com/object/0xdf08bc0486dc54f3aed9101811c82afff204439b70d933d81aedafc83be990c8?network=testnet>
- Contract: <https://suiexplorer.com/object/0xdf08bc0486dc54f3aed9101811c82afff204439b70d933d81aedafc83be990c8?module=main&network=testnet>

### Run contract in the explorer

```sh
Digest
4yHqkrpiNiyrgj8L3LEog5dxsKLRXQkSMgVqFvemprt1

Created
0x768cb70be72b9e90636083618123f47231dbca7c8d651e84b6a39cf6ed288b4b
0x79711100747c7ec0282c8dce105ede99ea1c81c86055af967f3ea20369916cd8

Updated
0xa050cbf7e2bec1c37037b49180157c62b3d1d44459d9cf110b2fc6a96132f21e
0xff5ce1f91f4723d447cf6b972434a2deba730876655aeb99a3b4a70cb82a60a9

```

Contract output details: <https://suiexplorer.com/txblock/4yHqkrpiNiyrgj8L3LEog5dxsKLRXQkSMgVqFvemprt1?network=testnet>. It created two objects:

1. DonorBoard: <https://suiexplorer.com/object/0x768cb70be72b9e90636083618123f47231dbca7c8d651e84b6a39cf6ed288b4b?network=testnet>
2. DonationBoard: <https://suiexplorer.com/object/0x79711100747c7ec0282c8dce105ede99ea1c81c86055af967f3ea20369916cd8?network=testnet>
