defmodule Day4Test do
  use ExUnit.Case

  test "aa aaa contains unique passphrases" do
    assert Day4.is_passphrase_valid(["aa", "aaa"]) == true
  end

  test "aa aaa aa contains non-unique passphrases" do
    assert Day4.is_passphrase_valid(["aa", "aaa", "aa"]) == false
  end

  test "aab aaa baa contains non-unique passphrases" do
    lines = [["aab", "aaa", "baa"]]
    assert Day4.high_entropy_passphrase_pt2(lines) == 0
  end

  test "aa aaa aac contains unique passphrases" do
    assert Day4.high_entropy_passphrase_pt2([["aa", "aaa", "aac"]]) == 1
  end
end
