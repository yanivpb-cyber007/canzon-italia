"""
CanzonItalia — Audio Generator
Generates Italian TTS audio for each lyric line using Google TTS.
Run: python generate_audio.py
"""

from gtts import gTTS
import os

OUTPUT_DIR = "assets/audio"
os.makedirs(OUTPUT_DIR, exist_ok=True)

lines = [
    (0,  "Sarà perché ti amo"),
    (1,  "Ma stasera mi sento così"),
    (2,  "Come se il mondo girasse per me"),
    (3,  "Come se tu fossi qui"),
    (4,  "Sarà perché ti amo"),
    (5,  "Ma non riesco a dormire stanotte"),
    (6,  "Penso a te e mi sembra di volare"),
    (7,  "Tra le stelle e le nuvole"),
]

print("Generating audio files...\n")
for idx, text in lines:
    filename = f"{OUTPUT_DIR}/sara_line_{idx:02d}.mp3"
    print(f"  [{idx:02d}] {text}")
    tts = gTTS(text=text, lang="it", slow=False)
    tts.save(filename)

print(f"\nDone! {len(lines)} files saved to {OUTPUT_DIR}/")
