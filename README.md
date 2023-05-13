# Get Started

## Concept

- Everyone can register to become a donor with name, email, amount_donated, frequncy_donated, current_frame ( HATCHLING, NESTLING, CHICK, FLEDGLING, BIRD < JUVENILE, IMMATURE, ADULT > )
- Compaign (name, desc, expected value, current_receive, start_date, end_date, fixed, max, period)
- Certificate Different level with (max_number, date_minted )
- Famehall is assigned to donor based on the amount ( starter)
- DonationTier can be many level ( small, medium, max, elite, custom) that come built in with a value.
- Once donated, donor gets accumulated the amount of donation and fame is calculated and a Donation(donor, amount, campaign) is creator and a cert is issued
- display list of donors and donations for public

## References

### SUI

- The move lang stdlib: <https://github.com/MystenLabs/sui/tree/main/crates/sui-framework/packages/move-stdlib/sources>
- SUI Example: <https://examples.sui.io/basics/events.html>
- Time: <https://docs.sui.io/build/move/time>
