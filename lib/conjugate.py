# this is used to get more verb forms, shouldn't be a real part of the app!!!
import mlconjug3

final_dict = {}

verbs_to_conjugate = ["Watch", "Dance", "Turn", "Turn", "Win", "Fly", "Cut", "Throw", "Close", "Open", "Write", "Give", "Jump", "Drink", "Cook", "Wash",
                      "Wait", "Climb", "Talk", "Crawl", "Dream", "Dig", "Clap", "Sew", "Smell", "Knit", "Kiss", "Hug", "Snore", "Bathe", "Bow", "Paint", "Dive", "Ski", "Stack", "Buy", "Shake", ]
for verb in verbs_to_conjugate:
    verb_forms = []
    default_conjugator = mlconjug3.Conjugator(language='en')
    test_verb = default_conjugator.conjugate(verb)
    all_conjugated_forms = test_verb.iterate()
    for each in all_conjugated_forms:
        if(not verb_forms.__contains__(each[-1])):
            verb_forms.append(each[-1])
    final_dict[verb] = verb_forms
print(final_dict)
