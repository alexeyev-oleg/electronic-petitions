async function loadPublicSeed() {
  const response = await fetch(assetPath('/mock/seed.json'));
  if (!response.ok) {
    throw new Error(`Failed to load seed: ${response.status}`);
  }
  return response.json();
}

function arePublicInitiativesEnabled(settings) {
  if (!settings) {
    return true;
  }
  return settings.publicPetitionsEnabled !== false;
}

function getPublishedInitiatives(petitions) {
  return (petitions || []).filter((item) => item.status === 'published');
}

function findInitiativeById(petitions, id) {
  return (petitions || []).find((item) => item.id === id) || null;
}

function signaturePercent(petition) {
  if (!petition.signatureGoal) {
    return 0;
  }
  return Math.min(100, Math.round((petition.signatureCount / petition.signatureGoal) * 100));
}

const CATEGORY_KEYS = {
  blagoustroystvo: 'categoryBlag',
  transport: 'categoryTransport',
  ecology: 'categoryEcology',
};

function categoryLabel(key) {
  const i18nKey = CATEGORY_KEYS[key];
  return i18nKey ? t(i18nKey) : key;
}

function initiativeDetailPath(id) {
  return pagePath(`/initiative.html?id=${encodeURIComponent(id)}`);
}

function filterInitiativesByCategory(initiatives, filterId) {
  if (filterId === 'all') {
    return initiatives;
  }
  return initiatives.filter((item) => item.category === filterId);
}
