"""Cross-check that the parallel submission artefacts stay in sync.

`config.json` and `paper.json` both encode the 156-word E156 body and the
same seven sentence roles; `paper.md` is the human-readable rendering.
Without these checks, the three can drift silently.
"""
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SUBMISSION = ROOT / 'e156-submission'


def _load(name):
    return json.loads((SUBMISSION / name).read_text(encoding='utf-8'))


def test_config_and_paper_json_share_body():
    config = _load('config.json')
    paper = _load('paper.json')
    assert config['body'] == paper['body'], "config.json and paper.json bodies have drifted"


def test_config_and_paper_json_share_sentences():
    config = _load('config.json')
    paper = _load('paper.json')
    assert config['sentences'] == paper['sentences'], (
        "config.json and paper.json sentence arrays have drifted"
    )


def test_paper_md_contains_config_body():
    config = _load('config.json')
    paper_md = (SUBMISSION / 'paper.md').read_text(encoding='utf-8')
    assert config['body'] in paper_md, "paper.md is missing the canonical 156-word body"


def test_paper_json_self_consistent():
    paper = _load('paper.json')
    assert paper.get('word_count') == len(paper['body'].split())
    assert paper.get('sentence_count') == len(paper['sentences'])
