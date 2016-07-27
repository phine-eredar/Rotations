require("src/Rotations")

local wow = function(data)
  data.buffs = data.buffs or {}
  data.spellCooldowns = data.spellCooldowns or {}
  data.talentInfo = data.talentInfo or {}
  data.usableSpells = data.usableSpells or {}
  return {
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

        describe("Single-Target Rotation", function()

            describe("Furious Slash if nothing else is available", function()
              it("Should return Furious Slash", function()
                assert_equal(Rotations(wow({
                  time = 0,
                  usableSpells = {
                    ["Furious Slash"] = true
                  },
                  spellCooldowns = {
                    ["Furious Slash"] = {0, 0}
                  }
                })).next(furyWarriorSingle), "Furious Slash")
              end)
            end)

            describe("Bloodthirst, even if Enraged", function()
              it("Should return Bloodthirst", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Bloodthirst")
              end)
            end)

            describe("Raging Blow if Inner Rage is talented", function()
              it("Should return Raging Blow", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Raging Blow")
              end)
            end)

            describe("Raging Blow without Inner Rage if Enraged", function()
              it("Should return Raging Blow", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Raging Blow")
              end)
            end)

            describe("Whirlwind on Wrecking Ball procs", function()
              it("Should return Whirlwind", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Whirlwind")
              end)
            end)

            describe("Bloodthirst if Enrage is absent", function()
              it("Should return Bloodthirst", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Bloodthirst")
              end)
            end)

            describe("Rampage if Enrage is absent", function()
              it("Should return Rampage", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Rampage")
              end)
            end)

            describe("Rampage if at 100 Rage", function()
              it("Should return Rampage", function()
                assert_equal(Rotations(wow({
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
                })).next(furyWarriorSingle), "Rampage")
              end)
            end)

        end)

        describe("Execute Usage", function()

            describe("Without Massacre Talented", function()

                describe("Furious Slash if nothing else is available", function()
                  it("Should return Furious Slash", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Furious Slash")
                  end)
                end)

                describe("Bloodthirst, even if Enraged", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Bloodthirst")
                  end)
                end)

                describe("Raging Blow if Inner Rage is talented", function()
                  it("Should return Raging Blow", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Raging Blow")
                  end)
                end)

                describe("Raging Blow without Inner Rage if Enraged", function()
                  it("Should return Raging Blow", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Raging Blow")
                  end)
                end)

                describe("Execute if Enraged", function()
                  it("Should return Execute", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Execute")
                  end)
                end)

                describe("Whirlwind on Wrecking Ball procs", function()
                  it("Should return Whirlwind", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Whirlwind")
                  end)
                end)

                describe("Bloodthirst if Enrage is absent", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Bloodthirst")
                  end)
                end)

                describe("Rampage if Enrage is absent", function()
                  it("Should return Rampage", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Rampage")
                  end)
                end)

                describe("Rampage if at 100 Rage", function()
                  it("Should return Rampage", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Rampage")
                  end)
                end)

            end)
            
            describe("With Massacre Talented", function()

                describe("Furious Slash if nothing else is available", function()
                  it("Should return Furious Slash", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Furious Slash")
                  end)
                end)

                describe("Bloodthirst, even if Enraged", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Bloodthirst")
                  end)
                end)

                describe("Raging Blow if Inner Rage is talented", function()
                  it("Should return Raging Blow", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Raging Blow")
                  end)
                end)

                describe("Raging Blow without Inner Rage if Enraged", function()
                  it("Should return Raging Blow", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Raging Blow")
                  end)
                end)

                describe("Whirlwind on Wrecking Ball procs", function()
                  it("Should return Whirlwind", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Whirlwind")
                  end)
                end)

                describe("Execute", function()
                  it("Should return Execute", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Execute")
                  end)
                end)

                describe("Bloodthirst if Enrage is absent", function()
                  it("Should return Bloodthirst", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Bloodthirst")
                  end)
                end)

                describe("Rampage if Enrage is absent", function()
                  it("Should return Rampage", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Rampage")
                  end)
                end)

                describe("Rampage if at 100 Rage", function()
                  it("Should return Rampage", function()
                    assert_equal(Rotations(wow({
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
                    })).next(furyWarriorSingle), "Rampage")
                  end)
                end)

            end)

        end)

    end)

end)
