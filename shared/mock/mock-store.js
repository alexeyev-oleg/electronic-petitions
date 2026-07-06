/**
 * G.E.S.H.E.R. shared mock store for static web clients.
 * Loads seed.json, persists mutations in localStorage.
 */
(function (global) {
  const STORAGE_DATA_KEY = 'gesher_mock_data';
  const STORAGE_VERSION_KEY = 'gesher_mock_seed_version';
  const STORAGE_SESSION_KEY = 'gesher_staff_session';

  let _seed = null;
  let _data = null;

  async function loadSeed(seedUrl) {
    const response = await fetch(seedUrl);
    if (!response.ok) {
      throw new Error(`Failed to load seed: ${response.status}`);
    }
    _seed = await response.json();
    return _seed;
  }

  function readData() {
    if (_data) {
      return _data;
    }
    const raw = localStorage.getItem(STORAGE_DATA_KEY);
    const version = localStorage.getItem(STORAGE_VERSION_KEY);
    if (raw && _seed && version === _seed.version) {
      _data = JSON.parse(raw);
      return _data;
    }
    if (!_seed) {
      throw new Error('Seed not loaded. Call loadSeed() first.');
    }
    _data = structuredClone(_seed);
    persistData();
    return _data;
  }

  function persistData() {
    if (!_seed || !_data) {
      return;
    }
    localStorage.setItem(STORAGE_DATA_KEY, JSON.stringify(_data));
    localStorage.setItem(STORAGE_VERSION_KEY, _seed.version);
  }

  function resetData() {
    if (!_seed) {
      return;
    }
    _data = structuredClone(_seed);
    persistData();
  }

  function getPetitions() {
    return readData().petitions;
  }

  function findPetitionById(id) {
    return getPetitions().find((item) => item.id === id) || null;
  }

  function updatePetition(id, patch) {
    return updateEntity('petitions', id, patch);
  }

  function getAuditLog() {
    const data = readData();
    if (!data.auditLog) {
      data.auditLog = [];
    }
    return data.auditLog;
  }

  function appendAuditEntry(entry) {
    const data = readData();
    if (!data.auditLog) {
      data.auditLog = [];
    }
    data.auditLog.unshift({
      id: `audit-${Date.now()}`,
      at: new Date().toISOString(),
      ...entry,
    });
    persistData();
  }

  function getComplaints() {
    return readData().complaints;
  }

  function findComplaintById(id) {
    return getComplaints().find((item) => item.id === id) || null;
  }

  function updateComplaint(id, patch) {
    return updateEntity('complaints', id, patch);
  }

  function getEnforcement() {
    return readData().enforcement;
  }

  function findEnforcementById(id) {
    return getEnforcement().find((item) => item.id === id) || null;
  }

  function updateEnforcement(id, patch) {
    return updateEntity('enforcement', id, patch);
  }

  function getStats() {
    return readData().stats;
  }

  function getSettings() {
    const data = readData();
    if (!data.settings) {
      data.settings = structuredClone(_seed?.settings || {});
      persistData();
    }
    return data.settings;
  }

  function updateSettings(patch) {
    const data = readData();
    if (!data.settings) {
      data.settings = structuredClone(_seed?.settings || {});
    }
    data.settings = { ...data.settings, ...patch };
    persistData();
    return data.settings;
  }

  function clearAuditLog() {
    const data = readData();
    data.auditLog = [];
    persistData();
  }

  function exportSnapshot() {
    return JSON.stringify(
      {
        format: 'gesher_mock_snapshot',
        exportedAt: new Date().toISOString(),
        seedVersion: _seed.version,
        data: readData(),
      },
      null,
      2,
    );
  }

  function importSnapshot(jsonText) {
    let payload;
    try {
      payload = JSON.parse(jsonText);
    } catch {
      return { ok: false, error: 'invalid_json' };
    }

    if (payload.format !== 'gesher_mock_snapshot' || !payload.data) {
      return { ok: false, error: 'invalid_format' };
    }

    if (payload.seedVersion !== _seed.version) {
      return { ok: false, error: 'version_mismatch' };
    }

    _data = payload.data;
    persistData();
    return { ok: true };
  }

  function getStaffUsers() {
    return readData().staffUsers;
  }

  function findStaffByCredentials(email, password) {
    const normalized = email.trim().toLowerCase();
    return getStaffUsers().find(
      (user) =>
        user.email.toLowerCase() === normalized && user.password === password,
    );
  }

  function getSession() {
    const raw = localStorage.getItem(STORAGE_SESSION_KEY);
    return raw ? JSON.parse(raw) : null;
  }

  function setSession(user) {
    if (!user) {
      localStorage.removeItem(STORAGE_SESSION_KEY);
      return;
    }
    const { password: _, ...safe } = user;
    localStorage.setItem(STORAGE_SESSION_KEY, JSON.stringify(safe));
  }

  function clearSession() {
    localStorage.removeItem(STORAGE_SESSION_KEY);
  }

  function updateEntity(collection, id, patch) {
    const list = readData()[collection];
    const index = list.findIndex((item) => item.id === id);
    if (index === -1) {
      return null;
    }
    list[index] = { ...list[index], ...patch };
    persistData();
    return list[index];
  }

  global.GesherMockStore = {
    STORAGE_SESSION_KEY,
    loadSeed,
    readData,
    resetData,
    getPetitions,
    findPetitionById,
    updatePetition,
    getAuditLog,
    appendAuditEntry,
    getComplaints,
    findComplaintById,
    updateComplaint,
    getEnforcement,
    findEnforcementById,
    updateEnforcement,
    getStats,
    getSettings,
    updateSettings,
    clearAuditLog,
    exportSnapshot,
    importSnapshot,
    getStaffUsers,
    findStaffByCredentials,
    getSession,
    setSession,
    clearSession,
    updateEntity,
  };
})(typeof window !== 'undefined' ? window : globalThis);
