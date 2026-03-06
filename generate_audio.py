"""
CanzonItalia — Audio Generator
Generates Italian TTS audio for each unique lyric line using Google TTS.
Run: python generate_audio.py
"""

from gtts import gTTS
import os

OUTPUT_DIR = "assets/audio"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Unique lines only (repeated lines reuse the same file in the app)
lines = [
    (0,  "Che confusione, sarà perché ti amo"),
    (1,  "È un'emozione che cresce piano piano"),
    (2,  "Stringimi forte e stammi più vicino"),
    (3,  "Se ci sto bene, sarà perché ti amo"),
    (4,  "Io canto al ritmo del dolce tuo respiro"),
    (5,  "È primavera, sarà perché ti amo"),
    (6,  "Cade una stella, ma dimmi dove siamo"),
    (7,  "Che te ne frega, sarà perché ti amo"),
    (8,  "E vola, vola, si sa"),
    (9,  "Sempre più in alto si va"),
    (10, "E vola, vola con me"),
    (11, "Il mondo è matto perché"),
    (12, "E se l'amore non c'è"),
    (13, "Basta una sola canzone"),
    (14, "Per far confusione fuori e dentro di te"),
    (15, "Ma, dopotutto, che cosa c'è di strano?"),
    (16, "È una canzone, sarà perché ti amo"),
    (17, "Se cade il mondo, allora ci spostiamo"),
    (18, "Se cade il mondo, sarà perché ti amo"),
    (19, "È così bello che non mi sembra vero"),
    (20, "Se il mondo è matto, che cosa c'è di strano?"),
    (21, "Matto per matto, almeno noi ci amiamo"),
    (22, "E vola, vola, si va"),
    (23, "Sarà perché ti amo"),
    (24, "E stammi più vicino"),
    (25, "Ma dimmi dove siamo"),
]

print("Generating audio files...\n")
for idx, text in lines:
    filename = f"{OUTPUT_DIR}/sara_line_{idx:02d}.mp3"
    print(f"  [{idx:02d}] {text}")
    tts = gTTS(text=text, lang="it", slow=True)  # slow=True is clearer for learning
    tts.save(filename)

print(f"\nDone! {len(lines)} files saved to {OUTPUT_DIR}/")
