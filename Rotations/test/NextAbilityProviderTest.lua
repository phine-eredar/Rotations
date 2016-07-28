require("src/package")
require("src/rotations/warrior/FuryWarrior")
require("src/NextAbilityProvider")

local wow = function(data)
  data.buffs = data.buffs or {}
  data.spellCooldowns = data.spellCooldowns or {}
  data.talentInfo = data.talentInfo or {}
  data.usableSpells = data.usableSpells or {}
  return {
    GetSpellCharges = function()
      return
    end,
    GetSpellCooldown = function(name)
      return unpack(data.spellCooldowns[name])
    end,
    GetTalentInfo = function(tier, column)
      return unpack(data.talentInfo[tier][column])
    end,
    GetTime = function()
      return data.time
    end,
    IsUsableSpell = function(name)
      return data.usableSpells[name]
    end,
    UnitBuff = function(unit, name)
      return data.buffs[name]
    end,
    UnitPower = function(unit)
      return data.power
    end
  }
end

describe("RotationsTest", function()

    describe("Fury Warrior", function()

        local rotation = PhineRotations:FuryWarrior();
        local single = rotation.single()
        local multi = rotation.multi()
        local talents = rotation.talents()

        describe("Single-Target Rotation", function()

            describe("Furious Slash if nothing else is available", function()
              it("Should return Furious Slash", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0}
                  }
                })).next(single, talents), "Furious Slash")
              end)
            end)

            describe("Bloodthirst, even if Enraged", function()
              it("Should return Bloodthirst", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage"
                  }
                })).next(single, talents), "Bloodthirst")
              end)
            end)

            describe("Raging Blow if Inner Rage is talented", function()
              it("Should return Raging Blow", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage"
                  },
                  talentInfo = {
                    [6] = {
                      [3] = { nil, nil, nil, true }
                    }
                  }
                })).next(single, talents), "Raging Blow")
              end)
            end)

            describe("Raging Blow without Inner Rage if Enraged", function()
              it("Should return Raging Blow", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage"
                  },
                  talentInfo = {
                    [6] = {
                      [3] = { nil, nil, nil, false }
                    }
                  }
                })).next(single, talents), "Raging Blow")
              end)
            end)

            describe("Whirlwind on Wrecking Ball procs", function()
              it("Should return Whirlwind", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    Whirlwind = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    Whirlwind = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage",
                    ["Wrecking Ball"] = "Wrecking Ball"
                  },
                  talentInfo = {
                    [6] = {
                      [3] = { nil, nil, nil, false }
                    }
                  }
                })).next(single, talents), "Whirlwind")
              end)
            end)

            describe("Bloodthirst if Enrage is absent", function()
              it("Should return Bloodthirst", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    Whirlwind = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    Whirlwind = {0, 0}
                  },
                  buffs = {
                    ["Wrecking Ball"] = "Wrecking Ball"
                  },
                  talentInfo = {
                    [6] = {
                      [3] = { nil, nil, nil, false }
                    }
                  }
                })).next(single, talents), "Bloodthirst")
              end)
            end)

            describe("Rampage if Enrage is absent", function()
              it("Should return Rampage", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    Whirlwind = true,
                    Rampage = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    Whirlwind = {0, 0},
                    Rampage = {0, 0}
                  },
                  buffs = {
                    ["Wrecking Ball"] = "Wrecking Ball"
                  },
                  talentInfo = {
                    [6] = {
                      [3] = { nil, nil, nil, false }
                    }
                  }
                })).next(single, talents), "Rampage")
              end)
            end)

            describe("Rampage if at 100 Rage", function()
              it("Should return Rampage", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    Whirlwind = true,
                    Rampage = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    Whirlwind = {0, 0},
                    Rampage = {0, 0}
                  },
                  buffs = {
                    ["Wrecking Ball"] = "Wrecking Ball"
                  },
                  talentInfo = {
                    [6] = {
                      [3] = { nil, nil, nil, false }
                    }
                  },
                  buffs = {
                    Enrage = "Enrage"
                  },
                  power = 100
                })).next(single, talents), "Rampage")
              end)
            end)

        end)

        describe("Execute Usage", function()

            describe("Without Massacre Talented", function()

                describe("Furious Slash if nothing else is available", function()
                  it("Should return Furious Slash", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0}
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        }
                      }
                    })).next(single, talents), "Furious Slash")
                  end)
                end)

                describe("Bloodthirst, even if Enraged", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        }
                      }
                    })).next(single, talents), "Bloodthirst")
                  end)
                end)

                describe("Raging Blow if Inner Rage is talented", function()
                  it("Should return Raging Blow", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, true
                          }
                        }
                      }
                    })).next(single, talents), "Raging Blow")
                  end)
                end)

                describe("Raging Blow without Inner Rage if Enraged", function()
                  it("Should return Raging Blow", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Raging Blow")
                  end)
                end)

                describe("Execute if Enraged", function()
                  it("Should return Execute", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Execute = {0, 0},
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Execute")
                  end)
                end)

                describe("Whirlwind on Wrecking Ball procs", function()
                  it("Should return Whirlwind", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage",
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Whirlwind")
                  end)
                end)

                describe("Bloodthirst if Enrage is absent", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Bloodthirst")
                  end)
                end)

                describe("Rampage if Enrage is absent", function()
                  it("Should return Rampage", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Rampage = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Rampage = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Rampage")
                  end)
                end)

                describe("Rampage if at 100 Rage", function()
                  it("Should return Rampage", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Rampage = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Rampage = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, false}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      power = 100
                    })).next(single, talents), "Rampage")
                  end)
                end)

            end)

            describe("With Massacre Talented", function()

                describe("Furious Slash if nothing else is available", function()
                  it("Should return Furious Slash", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0}
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        }
                      }
                    })).next(single, talents), "Furious Slash")
                  end)
                end)

                describe("Bloodthirst, even if Enraged", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        }
                      }
                    })).next(single, talents), "Bloodthirst")
                  end)
                end)

                describe("Raging Blow if Inner Rage is talented", function()
                  it("Should return Raging Blow", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, true
                          }
                        }
                      }
                    })).next(single, talents), "Raging Blow")
                  end)
                end)

                describe("Raging Blow without Inner Rage if Enraged", function()
                  it("Should return Raging Blow", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Raging Blow")
                  end)
                end)

                describe("Whirlwind on Wrecking Ball procs", function()
                  it("Should return Whirlwind", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage",
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Whirlwind")
                  end)
                end)

                describe("Execute", function()
                  it("Should return Execute", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        Enrage = "Enrage",
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Execute")
                  end)
                end)

                describe("Bloodthirst if Enrage is absent", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Bloodthirst")
                  end)
                end)

                describe("Rampage if Enrage is absent", function()
                  it("Should return Rampage", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Rampage = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Rampage = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      }
                    })).next(single, talents), "Rampage")
                  end)
                end)

                describe("Rampage if at 100 Rage", function()
                  it("Should return Rampage", function()
                    assert_equal(PhineRotations:NextAbilityProvider(wow({
                      time = 0,
                      usableSpells = {
                        ["Furious Slash"] = true,
                        Bloodthirst = true,
                        ["Raging Blow"] = true,
                        Whirlwind = true,
                        Rampage = true,
                        Execute = true
                      },
                      spellCooldowns = {
                        ["Furious Slash"] = {0, 0},
                        Bloodthirst = {0, 0},
                        ["Raging Blow"] = {0, 0},
                        Whirlwind = {0, 0},
                        Rampage = {0, 0},
                        Execute = {0, 0}
                      },
                      buffs = {
                        ["Wrecking Ball"] = "Wrecking Ball"
                      },
                      talentInfo = {
                        [5] = {
                          [1] = {nil, nil, nil, true}
                        },
                        [6] = {
                          [3] = {
                            nil, nil, nil, false
                          }
                        }
                      },
                      buffs = {
                        Enrage = "Enrage"
                      },
                      power = 100
                    })).next(single, talents), "Rampage")
                  end)
                end)

            end)

        end)

        describe("Multiple-Target Rotation", function()

            describe("Whirlwind with Meat Cleaver", function()
              it("Should return Whirlwind", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0}
                  },
                  buffs = {
                    ["Meat Cleaver"] = "Meat Cleaver"
                  }
                })).next(multi, talents), "Whirlwind")
              end)
            end)

            describe("Bloodthirst if Enrage is active", function()
              it("Should return Bloodthirst", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage",
                    ["Meat Cleaver"] = "Meat Cleaver"
                  }
                })).next(multi, talents), "Bloodthirst")
              end)
            end)

            describe("Raging Blow (below 3 targets)", function()
              it("Should return Raging Blow", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage",
                    ["Meat Cleaver"] = "Meat Cleaver"
                  }
                })).next(multi, talents), "Raging Blow")
              end)
            end)

            describe("Whirlwind on Wrecking Ball procs", function()
              it("Should return Whirlwind", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    ["Wrecking Ball"] = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    ["Wrecking Ball"] = {0, 0}
                  },
                  buffs = {
                    Enrage = "Enrage",
                    ["Meat Cleaver"] = "Meat Cleaver",
                    ["Wrecking Ball"] = "Wrecking Ball"
                  }
                })).next(multi, talents), "Whirlwind")
              end)
            end)

            describe("Bloodthirst if Enrage is absent", function()
              it("Should return Bloodthirst", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    ["Wrecking Ball"] = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    ["Wrecking Ball"] = {0, 0}
                  },
                  buffs = {
                    ["Meat Cleaver"] = "Meat Cleaver",
                    ["Wrecking Ball"] = "Wrecking Ball"
                  }
                })).next(multi, talents), "Bloodthirst")
              end)
            end)

            describe("Rampage if Enrage is absent", function()
              it("Should return Rampage", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    ["Wrecking Ball"] = true,
                    Rampage = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    ["Wrecking Ball"] = {0, 0},
                    Rampage = {0, 0}
                  },
                  buffs = {
                    ["Meat Cleaver"] = "Meat Cleaver",
                    ["Wrecking Ball"] = "Wrecking Ball"
                  }
                })).next(multi, talents), "Rampage")
              end)
            end)

            describe("Rampage if at 100 Rage", function()
              it("Should return Rampage", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    ["Wrecking Ball"] = true,
                    Rampage = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    ["Wrecking Ball"] = {0, 0},
                    Rampage = {0, 0}
                  },
                  buffs = {
                    ["Meat Cleaver"] = "Meat Cleaver",
                    ["Wrecking Ball"] = "Wrecking Ball",
                    Enrage = "Enrage"
                  },
                  power = 100
                })).next(multi, talents), "Rampage")
              end)
            end)

            describe("Whirlwind to activate Meat Cleaver", function()
              it("Should return Whirlwind", function()
                assert_equal(PhineRotations:NextAbilityProvider(wow({
                  time = 0,
                  usableSpells = {
                    Whirlwind = true,
                    Bloodthirst = true,
                    ["Raging Blow"] = true,
                    ["Wrecking Ball"] = true,
                    Rampage = true
                  },
                  spellCooldowns = {
                    Whirlwind = {0, 0},
                    Bloodthirst = {0, 0},
                    ["Raging Blow"] = {0, 0},
                    ["Wrecking Ball"] = {0, 0},
                    Rampage = {0, 0}
                  },
                  buffs = {
                    ["Wrecking Ball"] = "Wrecking Ball"
                  },
                  power = 100
                })).next(multi, talents), "Whirlwind")
              end)
            end)

        end)

    end)

end)
