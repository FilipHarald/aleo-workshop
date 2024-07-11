import multi_token_support_program_v1.aleo;
import credits.aleo;

// The 'simple_token' program.
program my_awesome_leo_meme_token2.aleo {
  const ADMIN: address = aleo10xjkec40xvq50zzjtwhqxthenta3uf2kgpq9kvle8feazq07uv9snzl2ma;
  const TOKEN_ID: field = 4846247369341682205field;
  const FILIP_TAX: u64 = 1000000u64;

  struct TokenOwner {
    account: address,
    token_id: field
  }

  async transition initialize() -> Future {
    assert_eq(self.caller, ADMIN);
    let r0: Future = multi_token_support_program_v1.aleo/register_token(
      TOKEN_ID,
      4846247369341682004u128, // name: u128, CATNOHAT ascii encoded
      4846247369341682004u128, // symbol: u128, CATNOHAT ascii encoded
      6u8, // decimals: u8
      1_000_000_000_000_000u128, // max_supply: u128
      true, // external_authorization_required: boolean
      self.address // external_authorization_party: address
    );
    let r1: Future = multi_token_support_program_v1.aleo/mint_public(
      4846247369341682005field, // token_id: field
      ADMIN,
      1_000_000_000_000_000u128,
      4_294_967_295u32
    );
    return initialize_future(r0, r1);
  }

  async function initialize_future(
    r0: Future,
    r1: Future
  ) {
    r0.await();
    r1.await();
  }

  async transition authorize_transfer(recipient: address, amount: u128, authorized_until: u32) -> Future {
    let credits_future: Future = credits.aleo/transfer_public_as_signer(ADMIN , FILIP_TAX);
    let owner: TokenOwner = TokenOwner{
      account: self.signer,
      token_id: TOKEN_ID
    };
    let mtsp_future: Future = multi_token_support_program_v1.aleo/prehook_public(owner, amount, authorized_until);
    let mtsp_future_2: Future = multi_token_support_program_v1.aleo/transfer_public_as_signer(TOKEN_ID, recipient, amount);
    return finalize_authorize_transfer(credits_future, mtsp_future, mtsp_future_2, authorized_until);
  }

  async function finalize_authorize_transfer(
    credits_future: Future,
    mtsp_future: Future,
    mtsp_future_2: Future,
    authorized_until: u32
  ) {
    assert(block.height < authorized_until);
    credits_future.await();
    mtsp_future.await();
    mtsp_future_2.await();
  }
}

