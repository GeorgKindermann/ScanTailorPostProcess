# use scantailor-experimental-1.2025.03.03: https://github.com/ImageProcessing-ElectronicPublications/scantailor-experimental
mkdir /tmp/st/out

# Running first via cli (optional)
scantailor-experimental-cli -v -o=../STprojects/st0.ScanTailor /tmp/st/pic /tmp/st/out

cp -n ../STprojects/st0.ScanTailor ../STprojects/st1.ScanTailor
# Use gui and adjust project filters
scantailor-experimental ../STprojects/st1.ScanTailor

#Increase Content by D pixel in each diretion (optional)
P0=/project/filters/select-content/page/params
P=$P0/content-box
D=2
xmlstarlet ed -u "$P0[@mode=\"auto\"]/@mode" -v manual ../STprojects/st1.ScanTailor |
    xmlstarlet ed -u "$P/top/@y" -x .-$D |
    xmlstarlet ed -u "$P/bottom/@y" -x .+$D |
    xmlstarlet ed -u "$P/left/@x" -x .-$D |
    xmlstarlet ed -u "$P/right/@x" -x .+$D |
    tail +2 >../STprojects/st2.ScanTailor

#A1: Generate colorOrGray output
xmlstarlet ed -u "/project/@outputDirectory" -v /tmp/st/outA1 ../STprojects/st2.ScanTailor |
    xmlstarlet ed -u "/project/filters/output/page/params/color-params/@colorMode" -v colorOrGray |
    xmlstarlet ed -u "/project/filters/output/page/output-params/image/color-params/@colorMode" -v colorOrGray |
    tail +2 >../STprojects/stA1.ScanTailor

#A2: Like A1 but with scalingFactor="2"
xmlstarlet ed -u "/project/@outputDirectory" -v /tmp/st/outA2 ../STprojects/stA1.ScanTailor |
    xmlstarlet ed -u "/project/filters/output/@scalingFactor" -v 2 | 
    tail +2 >../STprojects/stA2.ScanTailor

#B1: Generate output as defined in st2 (mainly bw)
xmlstarlet ed -u "/project/@outputDirectory" -v /tmp/st/outB1 ../STprojects/st2.ScanTailor |
    tail +2 >../STprojects/stB1.ScanTailor

#B2: Like B1 but with scalingFactor="2"
xmlstarlet ed -u "/project/@outputDirectory" -v /tmp/st/outB2 ../STprojects/st2.ScanTailor |
    xmlstarlet ed -u "/project/filters/output/@scalingFactor" -v 2 | 
    tail +2 >../STprojects/stB2.ScanTailor
