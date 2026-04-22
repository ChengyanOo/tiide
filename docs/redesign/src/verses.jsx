// Tiide — verse content. Biblical per user pick.
// Short lines that work as companion (not instruction). No advice tone.

const TIIDE_VERSES = [
  {
    text: "Be still, and know.",
    attr: "Psalm 46:10",
    cat: "Psalms",
  },
  {
    text: "He leadeth me beside the still waters.\nHe restoreth my soul.",
    attr: "Psalm 23:2–3",
    cat: "Psalms",
  },
  {
    text: "Weeping may endure for a night,\nbut joy cometh in the morning.",
    attr: "Psalm 30:5",
    cat: "Psalms",
  },
  {
    text: "The Lord is my shepherd;\nI shall not want.",
    attr: "Psalm 23:1",
    cat: "Psalms",
  },
  {
    text: "For everything there is a season,\nand a time for every matter under heaven.",
    attr: "Ecclesiastes 3:1",
    cat: "Wisdom",
  },
  {
    text: "A soft answer turneth away wrath.",
    attr: "Proverbs 15:1",
    cat: "Wisdom",
  },
  {
    text: "This too shall pass.",
    attr: "attributed, from the rabbinic tradition",
    cat: "Wisdom",
  },
  {
    text: "Cast thy burden upon the Lord,\nand he shall sustain thee.",
    attr: "Psalm 55:22",
    cat: "Psalms",
  },
  {
    text: "My grace is sufficient for thee:\nfor my strength is made perfect in weakness.",
    attr: "2 Corinthians 12:9",
    cat: "Letters",
  },
  {
    text: "Come unto me, all ye that labour and are heavy laden,\nand I will give you rest.",
    attr: "Matthew 11:28",
    cat: "Gospels",
  },
  {
    text: "Consider the lilies of the field,\nhow they grow; they toil not.",
    attr: "Matthew 6:28",
    cat: "Gospels",
  },
  {
    text: "Peace I leave with you, my peace I give unto you:\nnot as the world giveth.",
    attr: "John 14:27",
    cat: "Gospels",
  },
  {
    text: "The wind bloweth where it listeth,\nand thou hearest the sound thereof.",
    attr: "John 3:8",
    cat: "Gospels",
  },
  {
    text: "Mercies… are new every morning.",
    attr: "Lamentations 3:22–23",
    cat: "Prophets",
  },
  {
    text: "He hath made every thing beautiful in his time.",
    attr: "Ecclesiastes 3:11",
    cat: "Wisdom",
  },
];

const TIIDE_VERSE_CATS = ["Psalms", "Gospels", "Letters", "Wisdom", "Prophets", "User-written"];

Object.assign(window, { TIIDE_VERSES, TIIDE_VERSE_CATS });
