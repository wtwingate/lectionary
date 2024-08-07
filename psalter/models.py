from django.db import models

from psalter.services import parse_verse_nums
from lectionary.services.scripture import long_reference


class Psalm(models.Model):
    number = models.IntegerField()
    title = models.CharField(max_length=256)

    def __str__(self):
        return f"Psalm {self.number}"

    def get_html(self, reference):
        reference = long_reference(reference)

        if ":" in reference:
            verse_nums = parse_verse_nums(reference)
        else:
            verse_nums = [verse.number for verse in self.verse_set.all()]

        verses = []
        for num in verse_nums:
            verse = self.verse_set.get(number=num)
            verses.append(
                f"<p class='psalm-verse'><b>{verse.number} </b>"
                f"<span class='first-half'>&nbsp;{verse.first_half} *</span><br />"
                f"<span class='second-half'>&nbsp;&nbsp;{verse.second_half}</span></p>"
            )
        return "".join(verses)

    def get_text(self, reference):
        reference = long_reference(reference)

        if ":" in reference:
            verse_nums = parse_verse_nums(reference)
        else:
            verse_nums = [verse.number for verse in self.verse_set.all()]

        verses = []
        verses.append(f"{reference}\n")
        for num in verse_nums:
            verse = self.verse_set.get(number=num)
            verses.append(f"{verse.number} {verse.first_half} *\n{verse.second_half}\n")
        verses.append
        return "\n".join(verses) + "\n"


class Verse(models.Model):
    number = models.IntegerField()
    first_half = models.TextField()
    second_half = models.TextField()
    psalm = models.ForeignKey(Psalm, on_delete=models.CASCADE)

    def __str__(self):
        return f"Psalm {self.psalm.number}:{self.number}"
