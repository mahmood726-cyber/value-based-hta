"""Smoke checks: the E156 submission bundle exists and is well-formed."""
import json
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
SUBMISSION = ROOT / 'e156-submission'
REQUIRED_SUBMISSION_FILES = ('config.json', 'paper.md', 'protocol.md', 'index.html')


def test_submission_files_present():
    assert SUBMISSION.is_dir(), "e156-submission directory missing"
    for name in REQUIRED_SUBMISSION_FILES:
        assert (SUBMISSION / name).exists(), f"missing {name}"


def test_submission_config_contract():
    config = json.loads((SUBMISSION / 'config.json').read_text(encoding='utf-8'))

    body = config.get('body', '')
    assert len(body.split()) == 156, "E156 body must be exactly 156 words"

    sentences = config.get('sentences', [])
    assert len(sentences) == 7, "E156 must have exactly 7 sentence roles"
    for entry in sentences:
        text = entry.get('text') if isinstance(entry, dict) else str(entry)
        assert text and text.strip(), "every sentence must have non-empty text"

    assert config.get('notes', {}).get('code'), "notes.code must reference the repo"


@pytest.mark.parametrize("script", ["semantic_outcome_mapper.R", "calculate_net_benefit.R"])
def test_r_scripts_have_no_windows_paths(script):
    text = (ROOT / script).read_text(encoding='utf-8')
    assert "C:/Models" not in text and "C:\\Models" not in text, (
        f"{script} still contains a hard-coded Windows path"
    )
