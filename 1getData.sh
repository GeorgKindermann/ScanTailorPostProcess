mkdir -p /tmp/st/pic

# get testing pics from https://github.com/ImageProcessing-ElectronicPublications/scantailor-testing/tree/main/set0002
for i in {001..087}
do
    wget -qnc https://raw.githubusercontent.com/ImageProcessing-ElectronicPublications/scantailor-testing/590b61ce25abe6a4fb7e30c6cde9afcf39828520/set0002/page-$i.jpg -P /tmp/st/pic
done
