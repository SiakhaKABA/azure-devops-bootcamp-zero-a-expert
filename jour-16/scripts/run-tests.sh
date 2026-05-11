#!/bin/bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}🧪 Exécution des tests Terraform${NC}"
echo "================================"

# Variables
TEST_RESULTS_DIR="test-results"
mkdir -p $TEST_RESULTS_DIR
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

# Test 1: Module Storage
echo -e "\n${YELLOW}[1/3] Test du module Storage...${NC}"
cd modules/storage
terraform test -json > "../../$TEST_RESULTS_DIR/storage-$TIMESTAMP.json" 2>&1
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Tests Storage OK${NC}"
else
    echo -e "${RED}❌ Tests Storage échoués${NC}"
fi
cd - > /dev/null


# Rapport final
echo -e "\n${YELLOW}📊 Résumé des tests:${NC}"
for file in $TEST_RESULTS_DIR/*.json; do
    if grep -q '"status":"pass"' $file 2>/dev/null; then
        echo -e "${GREEN}✅ $(basename $file)${NC}"
    else
        echo -e "${RED}❌ $(basename $file)${NC}"
    fi
done

echo -e "\n${GREEN}🎯 Tests terminés${NC}"