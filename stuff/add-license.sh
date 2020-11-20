#!/bin/bash

# add license to fauna pictures from Open Education for Content

# $1 should be name of the work
# $2 should be the image

exiftool -m 	-ImageDescription="$1" \
		-Artist="Michelle Pors-da Costa Gomez" \
		-Copyright="'$1' by Michelle Pors-da Costa Gomez is licensed under CC BY-NC-SA 4.0 CC" \
		-XMP-cc:License="http://creativecommons.org/licenses/by-nc-sa/4.0/" \
		-XMP-cc:AttributionName="Michelle Pors-da Costa Gomez" \
		-XMP-cc:AttributionURL="https://pap.wikipedia.org/wiki/User:Michelle_Pors-da_Costa_Gomez" \
		-XMP-xmpRights:Marked="false" \
		-XMP-xmpRights:Owner="Michelle Pors-da Costa Gomez" \
		-Photoshop:CopyrightFlag='True' \
		-XMP-xmpRights:UsageTerms="'$1' by Michelle Pors-da Costa Gomez is licensed under CC BY-NC-SA 4.0 CC" \
		-usercomment="This work was contributed and licensed as part of the Open Content for Education project 2020, sponsored by Prins Bernhard Cultuurfonds Caribisch Gebied" \
		test/$2