async function initMockStore() {
  await GesherMockStore.loadSeed(assetPath('/mock/seed.json'));
  GesherMockStore.readData();
}

async function requireStaffSession() {
  await initMockStore();
  const session = GesherMockStore.getSession();
  if (!session) {
    window.location.href = pagePath('/index.html');
    return null;
  }
  return session;
}

async function signInStaff(email, password) {
  await initMockStore();
  const user = GesherMockStore.findStaffByCredentials(email, password);
  if (!user) {
    return { ok: false, error: 'invalid_credentials' };
  }
  GesherMockStore.setSession(user);
  return { ok: true, user };
}

function signOutStaff() {
  GesherMockStore.clearSession();
  window.location.href = pagePath('/index.html');
}

function roleLabel(role) {
  const labels = {
    moderator: 'Модератор',
    operator: 'Оператор',
    supervisor: 'Супервайзер',
    municipality_staff: 'Сотрудник мэрии',
    admin: 'Администратор',
  };
  return labels[role] || role;
}

function modulesForRole(role) {
  const all = [
    { id: 'petitions', label: 'Инициативы', roles: ['moderator', 'municipality_staff', 'admin', 'supervisor'] },
    { id: 'complaints', label: 'Жалобы', roles: ['operator', 'supervisor', 'admin'] },
    { id: 'enforcement', label: 'Нарушения', roles: ['supervisor', 'admin'] },
    { id: 'admin', label: 'Администрирование', roles: ['admin'] },
  ];
  return all.filter((item) => item.roles.includes(role));
}
