DROP TABLE IF EXISTS ad_campaigns;
DROP TABLE IF EXISTS ad_slots;
DROP TABLE IF EXISTS ad_projects;

CREATE TABLE ad_projects (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE ad_slots (
  id TEXT PRIMARY KEY,
  project_id TEXT NOT NULL,
  group_key TEXT NOT NULL,
  group_label TEXT NOT NULL,
  position_key TEXT NOT NULL,
  position_label TEXT NOT NULL,
  suggested_ratio TEXT NOT NULL DEFAULT '',
  suggested_size TEXT NOT NULL DEFAULT '',
  default_fit TEXT NOT NULL DEFAULT 'natural',
  default_width TEXT NOT NULL DEFAULT 'clamp(240px, 22vw, 420px)',
  default_max_height TEXT NOT NULL DEFAULT '72vh',
  enabled INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY (project_id) REFERENCES ad_projects(id),
  UNIQUE(project_id, group_key, position_key)
);

CREATE TABLE ad_campaigns (
  id TEXT PRIMARY KEY,
  slot_id TEXT NOT NULL,
  name TEXT NOT NULL DEFAULT '',
  image_url TEXT NOT NULL DEFAULT '',
  image_key TEXT,
  click_url TEXT NOT NULL DEFAULT '',
  alt TEXT NOT NULL DEFAULT '',
  title TEXT NOT NULL DEFAULT '',
  fit TEXT NOT NULL DEFAULT 'natural',
  width TEXT NOT NULL DEFAULT '',
  max_height TEXT NOT NULL DEFAULT '',
  start_at TEXT,
  end_at TEXT,
  enabled INTEGER NOT NULL DEFAULT 0,
  activated_at TEXT,
  rent_amount TEXT NOT NULL DEFAULT '',
  currency TEXT NOT NULL DEFAULT 'CNY',
  billing_type TEXT NOT NULL DEFAULT 'one_time',
  rent_note TEXT NOT NULL DEFAULT '',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY (slot_id) REFERENCES ad_slots(id)
);

CREATE INDEX idx_ad_slots_project_group ON ad_slots(project_id, group_key);
CREATE INDEX idx_ad_campaigns_slot_time ON ad_campaigns(slot_id, enabled, start_at, end_at);

INSERT INTO ad_projects (id, name, created_at, updated_at)
VALUES ('codex-session-patcher', 'Codex Session Patcher', '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z');

INSERT INTO ad_slots (
  id, project_id, group_key, group_label, position_key, position_label,
  suggested_ratio, suggested_size, default_fit, default_width, default_max_height,
  enabled, created_at, updated_at
) VALUES
  ('codex-session-patcher:enhance:left', 'codex-session-patcher', 'enhance', '增强', 'left', '左侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:enhance:right', 'codex-session-patcher', 'enhance', '增强', 'right', '右侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:settings:left', 'codex-session-patcher', 'settings', '设置', 'left', '左侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:settings:right', 'codex-session-patcher', 'settings', '设置', 'right', '右侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:help:left', 'codex-session-patcher', 'help', '帮助', 'left', '左侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:help:right', 'codex-session-patcher', 'help', '帮助', 'right', '右侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:cooperation:left', 'codex-session-patcher', 'cooperation', '合作', 'left', '左侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z'),
  ('codex-session-patcher:cooperation:right', 'codex-session-patcher', 'cooperation', '合作', 'right', '右侧', '9:16', '1080 × 1920', 'natural', 'clamp(240px, 22vw, 420px)', '72vh', 1, '2026-06-08T00:00:00.000Z', '2026-06-08T00:00:00.000Z');
