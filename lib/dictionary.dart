import 'actions.dart';
import 'package:flutter/material.dart' hide Action;
import 'conjuctions.dart' show Conjunction;
import 'adverbs.dart' show Adverb;

// This needs to be divisible by 7 or it goes poorly
Map<String, List<String>> verbsToConjugations = {
  'be': ['am', 'are', 'is', 'was', 'were', 'being', 'been', 'to be', 'be'],
  'have': ['have', 'has', 'had', 'having', 'to have'],
  'do': ['do', 'does', 'did', 'doing', 'done', 'to do'],
  'say': ['say', 'says', 'said', 'saying', 'to say'],
  'get': ['get', 'gets', 'got', 'getting', 'gotten', 'to get'],
  'make': ['make', 'makes', 'made', 'making', 'to make'],
  'go': ['go', 'goes', 'went', 'going', 'gone', 'to go'],
  'know': ['know', 'knows', 'knew', 'knowing', 'known', 'to know'],
  'take': ['take', 'takes', 'took', 'taking', 'taken', 'to take'],
  'see': ['see', 'sees', 'saw', 'seeing', 'seen', 'to see'],
  'come': ['come', 'comes', 'came', 'coming', 'to come'],
  'think': ['think', 'thinks', 'thought', 'thinking', 'to think'],
  'look': ['look', 'looks', 'looked', 'looking', 'to look'],
  'want': ['want', 'wants', 'wanted', 'wanting', 'to want'],
  'give': ['give', 'gives', 'gave', 'giving', 'given', 'to give'],
  'use': ['use', 'uses', 'used', 'using', 'to use'],
  'find': ['find', 'finds', 'found', 'finding', 'to find'],
  'tell': ['tell', 'tells', 'told', 'telling', 'to tell'],
  'ask': ['ask', 'asks', 'asked', 'asking', 'to ask'],
  'work': ['work', 'works', 'worked', 'working', 'to work'],
  'seem': ['seem', 'seems', 'seemed', 'seeming', 'to seem'],
  'feel': ['feel', 'feels', 'felt', 'feeling', 'to feel'],
  'try': ['try', 'tries', 'tried', 'trying', 'to try'],
  'leave': ['leave', 'leaves', 'left', 'leaving', 'to leave'],
  'call': ['call', 'calls', 'called', 'calling', 'to call'],
  'Watch TV': ['watch tv', 'watches tv', 'watched tv', 'watching tv', 'to watch tv'],
  'Dance': ['dance', 'dances', 'danced', 'dancing', 'to dance'],
  'Turn on': ['turn on', 'turns on', 'turned on', 'turning on', 'to turn on'],
  'Turn off': ['turn off', 'turns off', 'turned off', 'turning off', 'to turn off'],
  'Win': ['win', 'wins', 'won', 'winning', 'to win'],
  'Fly': ['fly', 'flies', 'flew', 'flying', 'flown', 'to fly'],
  'Cut': ['cut', 'cuts', 'cutting', 'to cut'],
  'Throw': ['throw', 'throws', 'threw', 'throwing', 'thrown', 'to throw'],
  'Close': ['close', 'closes', 'closed', 'closing', 'to close'],
  'Open': ['open', 'opens', 'opened', 'opening', 'to open'],
  'Write': ['write', 'writes', 'wrote', 'writing', 'written', 'to write'],
  'Give': ['give', 'gives', 'gave', 'giving', 'given', 'to give'],
  'Jump': ['jump', 'jumps', 'jumped', 'jumping', 'to jump'],
  'Drink': ['drink', 'drinks', 'drank', 'drinking', 'drunk', 'to drink'],
  'Cook': ['cook', 'cooks', 'cooked', 'cooking', 'to cook'],
  'Wash': ['wink', 'winks', 'wought', 'winking', 'to wink'],
  'Wait': ['wait', 'waits', 'waited', 'waiting', 'to wait'],
  'Climb': ['climb', 'climbs', 'climbed', 'climbing', 'to climb'],
  'Talk': ['talk', 'talks', 'talked', 'talking', 'to talk'],
  'Crawl': ['crawl', 'crawls', 'crawled', 'crawling', 'to crawl'],
  'Dream': ['dream', 'dreams', 'dreamed', 'dreaming', 'to dream'],
  'Dig': ['dig', 'digs', 'dug', 'digging', 'to dig'],
  'Clap': ['clap', 'claps', 'clapped', 'clapping', 'to clap'],
  'Sew': ['sew', 'sews', 'sewed', 'sewing', 'sewn/sewed', 'to sew'],
  'Smell': ['smell', 'smells', 'smelled', 'smelling', 'to smell'],
  'Knit': ['knit', 'knits', 'knitted', 'knitting', 'to knit'],
  'Kiss': ['kiss', 'kisses', 'kissed', 'kissing', 'to kiss'],
  'Hug': ['hug', 'hugs', 'hugged', 'hugging', 'to hug'],
  'Snore': ['snore', 'snores', 'snored', 'snoring', 'to snore'],
  'Bathe': ['bathe', 'bathes', 'bathed', 'bathing', 'to bathe'],
  'Bow': ['bow', 'bows', 'bowed', 'bowing', 'to bow'],
  'Paint': ['paint', 'paints', 'painted', 'painting', 'to paint'],
  'Dive': ['dive', 'doves', 'dove', 'diving', 'dived', 'to dive'],
  'Ski': ['ski', 'skis', 'skied', 'skiing', 'to ski'],
  'Stack': ['stack', 'stacks', 'stacked', 'stacking', 'to stack'],
  'Buy': ['buy', 'buys', 'bought', 'buying', 'to buy'],
  'Shake': ['sew', 'sews', 'sewed', 'sewing', 'sewn/sewed', 'to sew']
};

List<Action> actions = [
  Action(name: "be", color: randomColor()),
  Action(name: "have", color: randomColor()),
  Action(name: "do", color: randomColor()),
  Action(name: "say", color: randomColor()),
  Action(name: "get", color: randomColor()),
  Action(name: "make", color: randomColor()),
  Action(name: "go", color: randomColor()),
  Action(name: "know", color: randomColor()),
  Action(name: "take", color: randomColor()),
  Action(name: "see", color: randomColor()),
  Action(name: "come", color: randomColor()),
  Action(name: "think", color: randomColor()),
  Action(name: "look", color: randomColor()),
  Action(name: "want", color: randomColor()),
  Action(name: "give", color: randomColor()),
  Action(name: "use", color: randomColor()),
  Action(name: "find", color: randomColor()),
  Action(name: "tell", color: randomColor()),
  Action(name: "ask", color: randomColor()),
  Action(name: "work", color: randomColor()),
  Action(name: "seem", color: randomColor()),
  Action(name: "feel", color: randomColor()),
  Action(name: "try", color: randomColor()),
  Action(name: "leave", color: randomColor()),
  Action(name: "call", color: randomColor()),
  Action(name: "Watch TV", icon: const Icon(Icons.tv, color: Colors.white), color: randomColor()),
  Action(name: "Dance", color: randomColor()),
  Action(name: "Turn on", icon: const Icon(Icons.power, color: Colors.white), color: randomColor()),
  Action(
      name: "Turn off", icon: const Icon(Icons.power_off, color: Colors.white), color: randomColor()),
  Action(
      name: "Win", icon: const Icon(Icons.emoji_events, color: Colors.white), color: randomColor()),
  Action(name: "Fly", icon: const Icon(Icons.flight, color: Colors.white), color: randomColor()),
  Action(name: "Cut", icon: const Icon(Icons.cut, color: Colors.white), color: randomColor()),
  Action(name: "Throw", icon: const Icon(Icons.delete, color: Colors.white), color: randomColor()),
  Action(name: "Close", icon: const Icon(Icons.close, color: Colors.white), color: randomColor()),
  Action(name: "Open", color: randomColor()),
  Action(name: "Write", icon: const Icon(Icons.edit, color: Colors.white), color: randomColor()),
  Action(name: "Give", color: randomColor()),
  Action(name: "Jump", color: randomColor()),
  Action(
      name: "Drink", icon: const Icon(Icons.local_cafe, color: Colors.white), color: randomColor()),
  Action(name: "Cook", color: randomColor()),
  Action(name: "Wash", icon: const Icon(Icons.wash, color: Colors.white), color: randomColor()),
  Action(
      name: "Wait", icon: const Icon(Icons.hourglass_top, color: Colors.white), color: randomColor()),
  Action(name: "Climb", color: randomColor()),
  Action(
      name: "Talk",
      icon: const Icon(Icons.record_voice_over, color: Colors.white),
      color: randomColor()),
  Action(name: "Crawl", color: randomColor()),
  Action(name: "Dream", color: randomColor()),
  Action(name: "Dig", color: randomColor()),
  Action(name: "Clap", color: randomColor()),
  Action(name: "Sew", color: randomColor()),
  Action(name: "Smell", color: randomColor()),
  Action(name: "Knit", color: randomColor()),
  Action(name: "Kiss", color: randomColor()),
  Action(name: "Hug", color: randomColor()),
  Action(name: "Snore", color: randomColor()),
  Action(name: "Bathe", color: randomColor(), icon: const Icon(Icons.shower, color: Colors.white)),
  Action(name: "Bow", color: randomColor()),
  Action(name: "Paint", color: randomColor(), icon: const Icon(Icons.brush, color: Colors.white)),
  Action(name: "Dive", color: randomColor()),
  Action(name: "Ski", color: randomColor(), icon: const Icon(Icons.pool, color: Colors.white)),
  Action(
      name: "Ski",
      icon: const Icon(Icons.downhill_skiing, color: Colors.white),
      color: randomColor()),
  Action(name: "Stack", color: randomColor()),
  Action(name: "Buy", color: randomColor()),
  Action(name: "Shake", icon: const Icon(Icons.handshake, color: Colors.white), color: randomColor()),
];

//list of conjunctions
List<Conjunction> coordinating = [
  Conjunction("for", color: randomColor()),
  Conjunction("and", color: randomColor()),
  Conjunction("nor", color: randomColor()),
  Conjunction("but", color: randomColor()),
  Conjunction("or", color: randomColor()),
  Conjunction("yet", color: randomColor()),
  Conjunction("so", color: randomColor())
];
List<Conjunction> correlative = [
  Conjunction("both", partner: "and", color: randomColor()),
  Conjunction("wheter", partner: "or", color: randomColor()),
  Conjunction("not only", partner: "but also", color: randomColor()),
  Conjunction("either", partner: "or", color: randomColor()),
  Conjunction("neither", partner: "nor", color: randomColor()),
  Conjunction("just", partner: "so", color: randomColor()),
  Conjunction("the", partner: "the", color: randomColor()),
  Conjunction("as", partner: "as", color: randomColor()),
  Conjunction("if", partner: "then", color: randomColor()),
  Conjunction("rather", partner: "than", color: randomColor()),
  Conjunction("no sooner", partner: "than", color: randomColor()),
  Conjunction("such", partner: "that", color: randomColor()),
  Conjunction("so", partner: "that", color: randomColor())
];
List<Conjunction> subordinating = [
  Conjunction("after", color: randomColor()),
  Conjunction("although", color: randomColor()),
  Conjunction("as", color: randomColor()),
  Conjunction("as if", color: randomColor()),
  Conjunction("as long as", color: randomColor()),
  Conjunction("as much as", color: randomColor()),
  Conjunction("as soon as", color: randomColor()),
  Conjunction("as far as", color: randomColor()),
  Conjunction("as though", color: randomColor()),
  Conjunction("by the time", color: randomColor()),
  Conjunction("in as much as", color: randomColor()),
  Conjunction("inasmuch", color: randomColor()),
  Conjunction("in order to", color: randomColor()),
  Conjunction("in order that", color: randomColor()),
  Conjunction("in case", color: randomColor()),
  Conjunction("lest", color: randomColor()),
  Conjunction("though", color: randomColor()),
  Conjunction("now that", color: randomColor()),
  Conjunction("now since", color: randomColor()),
  Conjunction("now when", color: randomColor()),
  Conjunction("now", color: randomColor()),
  Conjunction("even if", color: randomColor()),
  Conjunction("even", color: randomColor()),
  Conjunction("even though", color: randomColor()),
  Conjunction("provided", color: randomColor()),
  Conjunction("provide that", color: randomColor()),
  Conjunction("if", color: randomColor()),
  Conjunction("if then", color: randomColor()),
  Conjunction("if when", color: randomColor()),
  Conjunction("if only", color: randomColor()),
  Conjunction("just as", color: randomColor()),
  Conjunction("where", color: randomColor()),
  Conjunction("weherever", color: randomColor()),
  Conjunction("whereas", color: randomColor()),
  Conjunction("where if", color: randomColor()),
  Conjunction("whether", color: randomColor()),
  Conjunction("since", color: randomColor()),
  Conjunction("because", color: randomColor()),
  Conjunction("whose", color: randomColor()),
  Conjunction("whoever", color: randomColor()),
  Conjunction("unless", color: randomColor()),
  Conjunction("while", color: randomColor()),
  Conjunction("before", color: randomColor()),
  Conjunction("why", color: randomColor()),
];

List<Adverb> time = [
  Adverb("Sometimes", randomColor()),
  Adverb("Recently", randomColor()),
  Adverb("During", randomColor()),
  Adverb("Always", randomColor()),
  Adverb("Soon", randomColor()),
  Adverb("Yet", randomColor()),
  Adverb("Usually", randomColor()),
  Adverb("Never", randomColor()),
];

List<Adverb> place = [
  Adverb("Everywhere", randomColor()),
  Adverb("Into", randomColor()),
  Adverb("Nowhere", randomColor()),
  Adverb("Here", randomColor()),
  Adverb("There", randomColor()),
  Adverb("Above", randomColor()),
  Adverb("Below", randomColor()),
  Adverb("Inside", randomColor()),
];
List<Adverb> manner = [
  Adverb("Dangerously", randomColor()),
  Adverb("Softly", randomColor()),
  Adverb("Quickly", randomColor()),
  Adverb("Gently", randomColor()),
  Adverb("Neatly", randomColor()),
  Adverb("Calm", randomColor()),
];
List<Adverb> degree = [
  Adverb("Entirely", randomColor()),
  Adverb("Slightly", randomColor()),
  Adverb("Highly", randomColor()),
  Adverb("Totally", randomColor()),
  Adverb("Almost", randomColor()),
  Adverb("Just", randomColor()),
];
List<Adverb> frequency = [
  Adverb("Constantly", randomColor()),
  Adverb("Always", randomColor()),
  Adverb("Occasionally", randomColor()),
  Adverb("Regularly", randomColor()),
  Adverb("Periodically", randomColor()),
];
List<Adverb> conjunctive = [
  Adverb("Next", randomColor()),
  Adverb("Now", randomColor()),
  Adverb("Undoubtedly", randomColor()),
  Adverb("Rather", randomColor()),
  Adverb("Additionally", randomColor()),
  Adverb("Anyway", randomColor()),
];
