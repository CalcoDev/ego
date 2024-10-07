class_name DiaReg

static var cutscene: AnimationPlayer = null

static var truth: Dictionary = {}

static var log_count: int = 0

static var MAP: Dictionary = {
    "_placeholder2": (func(dm):
        await dm.play("Now this... This is a sign", 10)
        await dm.play("A REAL sign...")
        await dm.play("Unlike those other pesky ... pesky", 5)
        await dm.play("[shake rate=20.0 level=5 connected=1]INFURIATING[/shake]", 10)
        await dm.play("[shake rate=20.0 level=20 connected=1]FAKE SIGNS[/shake]", 20)
        await dm.play("[shake rate=20.0 level=50 connected=1]!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!![/shake]", 30)\
        )
    ,
    "tree": (func(dm):
        await dm.play("Just a tree.", 10)
        await dm.play("Nothing to see here...")\
    ),
    "intro_sign": (func(dm):
        Engine.time_scale = 1.0
        await dm.play("[bgcolor=#ffffff][color=#000000][fgcolor=#ffffffaa]WHEATWHEAT[/fgcolor][/color][/bgcolor] Dev Diary 0.1", 10)
        await dm.play("5 days until contest...", 10)
        await dm.play("Finally managed to scrape some time toghether this weekend...", 30)
        await dm.play("Planning to join [b][bgcolor=#ffffff][color=#000000]JAM[/color][/bgcolor][/b]...", 20)
        await dm.play("Maybe I'll finish a game this time...", 15)\
    ),
    "intro_sign_2": (func(dm):
        Engine.time_scale = 1.0
        await dm.play("[bgcolor=#ffffff][color=#000000][fgcolor=#ffffffaa]WHEATWHEAT[/fgcolor][/color][/bgcolor] Dev Diary 0.5", 10)
        await dm.play("2 days until contest...", 10)
        await dm.play("What are these themes man ...", 20)
        await dm.play("What are these themes ...")
        await dm.play("...", 3)
        await dm.play("I sure hope \"Tiny creatures\" doesn't win...", 20)\
    ),
    "intro_sign_3": (func(dm):
        Engine.time_scale = 1.0
        await dm.play("[bgcolor=#ffffff][color=#000000][fgcolor=#ffffffaa]WHEATWHEAT[/fgcolor][/color][/bgcolor] Dev Diary 0.9", 10)
        await dm.play("1 hour until contest...", 10)
        await dm.play("[i]pshhh[/i]", 20)
        await dm.play("[i]mimimimimimimimimimiimimi[/i]", 40)\
    ),
    "intro_sign_4": (func(dm):
        Engine.time_scale = 1.0
        await dm.play("[bgcolor=#ffffff][color=#000000][fgcolor=#ffffffaa]WHEATWHEAT[/fgcolor][/color][/bgcolor] Dev Diary 1", 10)
        await dm.play("1 post contest start...", 10)
        await dm.play("Time to get cooking...", 30)\
    ),
    "sign_enemy": (func(dm):
        Engine.time_scale = 1.0
        await dm.play(" Dev Diary 2", 10)
        await dm.play("[bgcolor=#ffffff][color=#000000]PROJECT CANCELLED DUE TO[/color][/bgcolor]", 20)
        await dm.play("[bgcolor=#000000][color=#ffffff]LOSS OF MOTIVATION[/color][/bgcolor]", 10)\
    ),
    "voices_1": (func(dm):
        await dm.play(i("..."), 3)\
    ),
    "voices_2": (func(dm):
        await dm.play(i("new project, huh..."), 10)\
    ),
    "voices_3": (func(dm):
        await dm.play(i("forgetful of the past, are we not?"), 10)\
    ),
    "voices_4": (func(dm):
        await dm.play(i("need i remind you of it?"), 10)\
    ),
    "voices_5": (func(dm):
        await dm.play(i("..."), 3)
        await dm.play(i("alas, what is me, to say such things..."), 20)\
    ),
    "voices_6": (func(dm):
        await dm.play(i("suffice to say ..."), 30)
        await dm.play(i("i certainly will enjoy this..."), 20)\
    ),
    "sign_enemy_gone": (func(dm):
        await dm.play("Whatever used to be caged here", 30)
        await dm.play("Is no more...", 15)\
    ),
    "tree_rockfall": (func(dm):
        await dm.play("There is no going back", 10)\
    ),
    "sign_labirynth_intro": (func(dm):
        await dm.play("Beware all ye who enter here!", 20)
        await dm.play("A terrible fate awaits those stuck in the Labirynth...")\
    ),
    "sign_labirynth_2": (func(dm):
        await dm.play(lg("2"), 20)
        await dm.play("2 hours post jam start")
        await dm.play("Can't even find a game idea, holy...")
        await dm.play("Let's recap what we have so far: ", 40)
        await dm.play("Mycelial network puzzle game of sorts", 30)
        await dm.play("...", 3)
        await dm.play("Suika game wannabe", 30)
        await dm.play("...", 3)
        await dm.play("Stanley Parrable Box ripoff", 30)
        await dm.play("...", 3)
        await dm.play("And ... that's it...", 30)
        await dm.play("God have mercy...")
        truth["no_idea_start"] = true\
    ),
    "voices_ideas_lost": (func(dm):
        if not truth.get("no_idea_start", false):
            return false
        await dm.play(i("don't want to say i told you"), 20)
        await dm.play(i("..."), 3)
        await dm.play(i("but i did lmao"), 20)\
    ),
    "sign_labirynth_3": (func(dm):
        await dm.play("Tiny creatures ...", 20)
        await dm.play("What about ... ", 20)
        await dm.play("Yeah, no, I got nothing")\
    ),
    "sign_labirynth_4": (func(dm):
        await dm.play("[i]discord ring, discord ring, discord ring[/i]", 60)
        await dm.play("[b]If it isn't mister Obeya himself...[/b]", 20)\
    ),
    "sign_labirynth_5": (func(dm):
        await dm.play(redacted("#ffffff", 20), 25)
        await dm.play("... should we just play risk of rain?")
        await dm.play(redacted("#ffffff", 3), 10)
        await dm.play("I'm opening the game ...", 20)\
    ),
    "sign_labirynth_6": (func(dm):
        await dm.play("Dude, this is an insane run!", 30)
        await dm.play("Stage 5 with this many items...", 40)
        await dm.play("Feels like we finally have a Mythrac run goin-")
        await dm.play(redacted("#ffffff", 40),  100)
        await dm.play("...", 6)
        await dm.play(redacted("#ffffff", 3), 6)
        await dm.play("I did not see that elder lemurian...", 20)\
    ),
    "self_ego_idea": (func(dm):
        if not truth.get("sel_ego_idea", false):
            truth["sel_ego_idea"] = true
            return false
        await dm.play(redacted("#ffffff", 20), 20)
        await dm.play("So you've decided on your idea...")
        await dm.play("Dang...")
        await dm.play(redacted("#ffffff", 10))
        await dm.play("Now that you mention it ...")
        await dm.play("[b]EGOCENTRISM[/b] might actually be a good idea...")
        await dm.play("Well, guess I'll get to work then...")
        await dm.play("[i]discord leave call noise[/i]", 60)\
    ),
    "voices_start_wotk": (func(dm):
        await dm.play(i("this is a bad idea and you know it..."), 20)
        await dm.play(i("..."), 6)
        await dm.play(i("do you really think you can do visuals alone..."), 40)
        await dm.play(i("suuure buddy, sure"), 20)\
    ),
    "sign_labirynth_7": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 30)
        await dm.play("6 hours past jam begin", 20)
        await dm.play("So the idea I am going forwards with is ...")
        await dm.play("[b]EGOCENTRISM[/b]", 40)
        await dm.play("...", 6)
        await dm.play("Now what does this actually mean...", 40)\
    ),
    "sign_labirynth_8": (func(dm):
        await dm.play("... welp ...", 20)
        await dm.play("What if you have many [b]BALLS[/b] orbitting around you...", 40)
        await dm.play("And we say those are tiny creatures ...")
        await dm.play("And uh ...")
        await dm.play("And uh ... they allow you to fight ... enemies")
        await dm.play("...")
        await dm.play("Let's at least get visuals in...")\
    ),
    "voices_theme_complain": (func(dm):
        if not truth.get("voices_theme_complain", false):
            truth["voices_theme_complain"] = true
            return false
        await dm.play(i("y'know ..."), 20)
        await dm.play(i("randy uploaded."))
        await dm.play(i("you shouhld go check that out instead of working on this..."))\
    ),
    "sign_labirynth_9":(func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("12 hours PJ (post jam)")
        await dm.play("[i] runs code [/i]")
        await dm.play("...", 6)
        await dm.play("I uh, ... I did NOT COOK", 20)
        await dm.play("...", 6)
        await dm.play(i("blud thinks he can throw toghether 50 random shaders and make game"), 20)
        await dm.play(i("hilarious"))\
    ),
    "sign_labirynth_10": (func(dm):
        await dm.play("[shake rate=20.0 level=5]That is ... enough dev for now...[/shake]", 10)
        await dm.play(i("[wave amp=50.0 freq=5.0]wooot, you want to quit?!?[/wave]"), 40)
        await dm.play(i("shame on you..."))
        await dm.play(i("[b]shame[/b]"), 10)
        await dm.play(i("[b]on[/b]"), 10)
        await dm.play(i("[b]you[/b]"), 10)\
    ),
    "sign_labirynth_11": (func(dm):
        await dm.play("To whomever sees this: ", 20)
        await dm.play("I have 12 hours left to finish this jam...")
        await dm.play("I am sorry.")\
    ),
    "sign_labirynth_12":(func(dm):
        await dm.play("[i]clickclackclickclack[/i]", 40)
        await dm.play("Remove fog shader...", 20)
        await dm.play("Add chromatic abberation...")
        await dm.play("Tweak chromatic abberation...")
        await dm.play("...", 6)
        await dm.play("Remove chromatic abberation", 20)\
    ),
    "sign_labirynth_13": (func(dm):
        await dm.play("Woah, this is a really cool video!", 20)
        await dm.play("[i]30 minutes later...[/i]")
        await dm.play("Wait what do you mean 1 day of the jam has gone?!")\
    ),
    "sign_labirynth_14":(func(dm):
        await dm.play(i("De-atatea nopti aud plouand..."), 20)
        await dm.play(i("Aud materia plangand..."), 20)
        await dm.play(i("Sunt singur si ma duce-un gand..."), 20)
        await dm.play(i("Spre locuintele lacustre..."), 20)\
    ),
    "sign_labirynth_16": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("24 hours...")
        await dm.play("This ...")
        await dm.play("This looks ... ")
        await dm.play(i("bad?"))
        await dm.play("GOOD?!?!?!??!?!?!?!??!?!?!?!??!?!??1??!?!??!??!??!?!????1??1??!??!??!??!??!??!?!??!??!??!??!??!??!??!?!?")\
    ),
    "sign_labirynth_15": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("25 hours...")
        await dm.play("[i]*discordring discordring discordringdiscordring*[/i]")
        await dm.play("Yoyoyo, music man!")
        await dm.play("How does one ...")
        await dm.play("[b]SOUND[/b]")
        await dm.play("???")\
    ),
    "sign_labirynth_17":(func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("28 hours...")
        await dm.play("...", 6)
        Audio.map["enemy_scream"].play()
        await dm.play("[i][b]HOLY FRICK AAAAA[/b][i]")
        await dm.play("...")
        await dm.play(i("..."))
        await dm.play(alternate("what the frick did I just make"))\
    ),
    "sign_labirynth_18": (func(dm):
        await dm.play("[i]https://youtu.be/HEAzSDCFO6s[/i]", 40)
        await dm.play("[i]*message sent*[/i]", 20)
        await dm.play("Well ... we certainly have sound ambiance now...")\
    ),
    "sign_labirynth_19": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("??? post / pre / during jam ??? ")
        await dm.play("[i]pshhhhhh[/i]")
        await dm.play("[i]mimimimimiimimmimmimimimimimimimimimimimimimi[/i]", 40)\
    ),
    "sign_labirynth_20": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("the times of listing times are long gone...")
        await dm.play("NO WHY IS IT 8 AM WHAT")
        await dm.play(i("l"))
        await dm.play("Shut up")
        await dm.play(i("why are you acting like I am goth celeste"))\
    ),
    "sign_labirynth_21": (func(dm):
        await dm.play(alternate("I make dialogue based game"), 20)
        await dm.play(alternate("i have to write conversations between me and the voices"))
        await dm.play(alternate("I get schizophrenic IRL"))
        await dm.play(alternate("i realise I am"))
        await dm.play(i("I make dialogue based game") + "\n" + "BOB")\
    ),
    "sign_labirynth_22":(func(dm):
        await dm.play(i("come on now, not every single detour [b]HAS[/b] to contain a [i]lore[/i]..."), 20)\
    ),
    "sign_labirynth_23": (func(dm):
        await dm.play(i("this one does though: "), 20)
        await dm.play("Many harvests ‘fore,\nfrom green tailed’s beak,\ndown fell seed which wind would feed,\nbeneath the earth, where roots grasped deep.")\
    ),
    "sign_labirynth_24": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play("day 2, debatable time")
        await dm.play("Time to finally get back to work...")
        await dm.play("Let's get some gameplay...")\
    ),
    "sign_labirynth_25": (func(dm):
        await dm.play(i("This entry is wayyyy too far to be lore relevant..."), 20)
        await dm.play(i("... and yet ..."))
        await dm.play("Two factions’d rule over what would have become:")
        await dm.play("One made of inception, grasping at grown straws.\nnOne made of conclusion, hem and hawing through the lawns.")\
    ),
    "sign_labirynth_26": (func(dm):
        await dm.play(redacted("#ffffff", 40), 20)
        await dm.play(i("I, YOUR ONLY BROTHER?"))
        await dm.play("...Say something.", 10)\
    ),
    "sign_labirynth_27": (func(dm):
        truth["voices_peace"] = true
        await dm.play("enjoy this moment of peace")\
    ),
    "voices_peace": (func(dm):
        if not truth.get("voices_peace", false):
            return false
        await dm.play(i("[shake rate=20.0 level=5]for it won't last much more[/shake]"))
        Audio.map["enemy_scream"].play()\
    ),
    "portal_tp_wheat": (func(dm):
        await dm.play("Many harvests ‘fore, from green tailed’s beak,\ndown fell seed which conflict’d feed,\nabove the earth, which history buried deep.", 20)
        await dm.play(alternate("Le champ de blé, 20XX"), 10)
        Game.player_tp_to_pos = Player.instance.global_position
        #Game.switch_scene("wheat_character_select")\
        Game.wheat_character_select()\
    ),
    "wheat_transition_back": (func(dm):
        await dm.play("🔪🔪🔪", 6)
        await dm.play("🌾🌾🌾", 6)
        await dm.play("🔪🔪🔪", 6)
        await dm.play("🗿🗿🗿", 6)\
    ),
    "back_from_wheat": (func(dm):
        truth["WHEAT_MOBS"] = true
        await dm.play(i("it is gone."), 15)
        await dm.play(i("motivation is gone."))
        await dm.play(i("good luck"))
        Audio.map["enemy_scream"].play()
        await dm.play(i("[shake rate=20.0 level=5]they[/shake] are here."))
        cutscene.play("back_from_wheat_spawn_mobs")
        await cutscene.animation_finished\
    ),
    "porotal_le_laitier": (func(dm):
        truth["MILK_MOBS"] = true
        await dm.play(i("[b]WARNING[/b]"), 15)
        await dm.play(i("You are about to experience [i][b][wave amp=50.0 freq=5.0]TRANQUILITY[/wave][/b][/i]"))
        
        if OS.has_feature("JavaScript"):
            JavaScriptBridge.eval("""
                window.open('https://64525556aae0c.site123.me/', '_blank').focus();
            """)
        else:
            OS.shell_open("https://64525556aae0c.site123.me/")
        
        await dm.play(i("A gateway to an ancient place has been opened."))
        await dm.play(i("Is your visit [b]finished[/b]?"))
        await dm.play(i("Good."))
        
        cutscene.play("back_from_website")
        await cutscene.animation_finished\
    ),
    "sign_checkpoint": (func(dm):
        await dm.play(alternate("sorry, no more motivation. have a checkpoint"), 200)\
    ),
    "sign_final": (func(dm):
        await dm.play("rest easy, they can't get here.", 20)
        await dm.play(i("go on now, claim your prize"))\
    ),
    "portal_final": (func(dm):
        log_count += 1
        await dm.play(lg(log_count), 20)
        await dm.play(i("so uh, yeah, this is the end..."))
        await dm.play(alternate("I am aware this game ended up being very scuffed ..."))
        await dm.play("frankly, calling it a game is an overstatement")
        await dm.play("💀")
        await dm.play("Even so, I am very thankful for you playing this / getting here in whatever way you did.")
        await dm.play("...")
        await dm.play(i("btw, just though I'd let you know: the game has multiple 'endings'."))
        await dm.play(i("so, if you have more time to burn, play and see what happens..."))
        await dm.play(i("or read the source code. that works just as well"))
        await dm.play("...", 6)
        await dm.play("...", 6)
        await dm.play("...", 6)
        await dm.play(i("Obliterate") + " yourself from" + i("existence") + "?", 10)
        await dm.play(alternate("Are you sure?"), 10)
        await dm.play(alternate("..."), 3)
        await Game.switch_scene(
            "final_scene",
            func():
                Audio.map["ring_of_fire"].play()
        )\
    )
}

static func alternate(text) -> String:
    var m = ""
    var b = true
    for c in text:
        if c == " ":
            m += "  "
            continue
        if b:
            m += c
        else:
            m += " " + i(c) + " "
        b = !b
    return m

static func redacted(color, l) -> String:
    return "[bgcolor=" + color + "][color=" + color + "]" + (" ".repeat(l)) + "[/color][/bgcolor]"

static func lg(nr, title: String = "WHEATWHEAT") -> String:
     return "[bgcolor=#ffffff][color=#000000][fgcolor=#ffffffaa]" + title + "[/fgcolor][/color][/bgcolor] Dev Diary " + str(nr)

static func i(text: String) -> String:
    return "[bgcolor=#ffffff][color=#000000]" + text + "[/color][/bgcolor]"

static func play(id: String) -> bool:
    if id in MAP:
        DialogueManager.dia_show(false)
        var value = await MAP[id].call(DialogueManager)
        if value != null and value == false:
            DialogueManager.dia_hide(true)
            return false
        else:
            DialogueManager.dia_hide(false)
            if is_instance_valid(Player.instance):
                Game.save_checkpoint()
            return true
    return false
