import credits.aleo;
import multi_token_support_program_v1.aleo;
program my_awesome_leo_meme_token2.aleo;


struct TokenMetadata:
    token_id as field;
    name as u128;
    symbol as u128;
    decimals as u8;
    supply as u128;
    max_supply as u128;
    admin as address;
    external_authorization_required as boolean;
    external_authorization_party as address;

struct TokenOwner:
    account as address;
    token_id as field;




function initialize:
    assert.eq self.caller aleo10xjkec40xvq50zzjtwhqxthenta3uf2kgpq9kvle8feazq07uv9snzl2ma;
    call multi_token_support_program_v1.aleo/register_token 4846247369341682205field 4846247369341682004u128 4846247369341682004u128 6u8 1_000_000_000_000_000u128 true my_awesome_leo_meme_token2.aleo into r0;
    call multi_token_support_program_v1.aleo/mint_public 4846247369341682005field aleo10xjkec40xvq50zzjtwhqxthenta3uf2kgpq9kvle8feazq07uv9snzl2ma 1_000_000_000_000_000u128 4_294_967_295u32 into r1;
    async initialize r0 r1 into r2;
    output r2 as my_awesome_leo_meme_token2.aleo/initialize.future;

finalize initialize:
    input r0 as multi_token_support_program_v1.aleo/register_token.future;
    input r1 as multi_token_support_program_v1.aleo/mint_public.future;
    await r0;
    await r1;




function authorize_transfer:
    input r0 as address.private;
    input r1 as u128.private;
    input r2 as u32.private;
    call credits.aleo/transfer_public_as_signer aleo10xjkec40xvq50zzjtwhqxthenta3uf2kgpq9kvle8feazq07uv9snzl2ma 1000000u64 into r3;
    cast self.signer 4846247369341682205field into r4 as TokenOwner;
    call multi_token_support_program_v1.aleo/prehook_public r4 r1 r2 into r5;
    call multi_token_support_program_v1.aleo/transfer_public_as_signer 4846247369341682205field r0 r1 into r6;
    async authorize_transfer r3 r5 r6 r2 into r7;
    output r7 as my_awesome_leo_meme_token2.aleo/authorize_transfer.future;

finalize authorize_transfer:
    input r0 as credits.aleo/transfer_public_as_signer.future;
    input r1 as multi_token_support_program_v1.aleo/prehook_public.future;
    input r2 as multi_token_support_program_v1.aleo/transfer_public_as_signer.future;
    input r3 as u32.public;
    lt block.height r3 into r4;
    assert.eq r4 true;
    await r0;
    await r1;
    await r2;

