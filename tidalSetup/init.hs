
-- Pattern effects
:{
let bo p = trunc (segment 8 $ slowsaw + 0.125) $ p
    ob = trunc (slow 4 $ "<0.25 0.5 0.75 1>")
    ob' d = trunc (slow d $ "<0.25 0.5 0.75 1>")
    dubd p = sometimes (stut (choose[4, 8]) 0.0125 (1/8)) $ p
    dubd' d p = sometimes (stut (choose[4, 8]) d (1/8)) $ p
    dubd'' d t p = sometimes (stut (choose[4, 8]) d t) $ p
    stbdub d p = sometimesBy d (stut (choose[4, 8]) (1/8) (1/8)) $ p
    stbdub' d t p = sometimesBy d (stut (choose[4, 8]) (1/8) t) $ p
    stbdub'' d t f p = sometimesBy d (stut (choose[4, 8]) f t) $ p
    crumble = slow 2 $ sound "[k*16 ~]/2 ~" # n (run 32)
    uppit p = spread fast [1, 2, 3, 4, 5, 7, 8] $ p
    ruppit p = spread fast [1, 2, 3, 4] $ p
    crippery p = every 4 (jux (# accelerate "[-0.1..0.2]/4")) $ every 6 (jux (# accelerate "[-0.3..0.4]/2")) $ p
    rater = rarely (iter (segment 1 $ choose [4,8]))
    fastflip = fast "1 [2 1]"
    withflip = within (0.75, 1) (fast 2)
    withply = within (0.75, 1) (ply 2)
    someflip = sometimes (fast "1 [2 1]")
    oftflip = often (fast "1 [2 1]")
    rareflip = rarely (fast "1 [2 1]")
    htrapper = within (0.5, 0.75) (hurry "1 <3 1.5>")
    ftrapper = within (0.5, 0.75) (fast "1 <3 1.5>")
    ftrapper' s r = within (s, s + r) (fast "<3 1.5>")
    htrapper' s r = within (s, s + r) (hurry "<3 1.5>")
    microd p = often ((# delay 0.3) . (# delaytime (choose[(1/16), (1/32)])) . (# delayfeedback 0.8)) $ p
    microd' p = rarely ((# delay 0.3) . (# delaytime (choose[(1/16), (1/32)])) . (# delayfeedback 0.8)) $ p
    microstb' a p = stb a ((# delay 0.3) . (# delaytime (choose[(1/16), (1/32)])) . (# delayfeedback 0.8)) $ p
    foldedParty p = foldEvery [3, 7, 13] (spread ($) [fast 4, jux (rev), spike]) $ p
    simplefuck p = foldEVery [5, 6, 7] (rip 0.5 "<0.1 0.2 0.4>") $ every 7 (# coarse "{4 8 6 12 16}%14") $ every 8 (# accelerate "-0.5 0.5") $ p
    mess = simplefuck
    simplefuck' p = foldEVery [5, 6, 7] (rip' 0 1 8 0.5 "<0.1 0.2 0.4>") $ every 7 (# coarse "{4 8 6 12 16}%14") $ every 8 (# accelerate "-0.5 0.5") $ p
    mess' = simplefuck'
    crushit p = (# crush (range 3 8 $ slow 1.1 tri)) $ p
    messup = fuckery
    messitup = fuckery
    funkSpread = spread ($)
    funkySpread = spreadChoose ($)
    restEvery m = every m (# silence)
:}
