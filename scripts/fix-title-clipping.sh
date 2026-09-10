#!/usr/bin/env bash
set -euo pipefail

python3 <<'PY'
from pathlib import Path

path = Path('index.html')
text = path.read_text(encoding='utf-8')
marker = '/* Title clipping hardening v2 */'
css = '''
    /* Title clipping hardening v2 */
    h1, h2, h3 { max-width: 100%; min-width: 0; }
    h1, h2, h3, p, a, span { overflow-wrap: anywhere; }
    .hero h1,
    .section-heading h2,
    .split h2,
    .project-visual h3,
    .project-copy h3,
    .experience-item h3,
    .education-item h3,
    .contact h2 {
      overflow: visible;
      padding-top: .14em;
      padding-bottom: .16em;
      line-height: 1.08;
    }
    .project-visual-inner { overflow: visible; min-height: 0; padding: 3px 0 9px; }
    .project-visual h3 { line-height: 1.06; }
    @media (max-width: 720px) {
      .hero h1 { font-size: clamp(2.5rem, 12.2vw, 4.7rem); line-height: 1.04; }
      .project-visual h3 { font-size: clamp(1.85rem, 9.2vw, 3rem); line-height: 1.06; }
      .section-heading h2, .split h2, .contact h2 { line-height: 1.08; }
    }
    @media (max-width: 420px) {
      .hero h1 { font-size: clamp(2.35rem, 12.6vw, 3.8rem); }
      .project-visual h3 { font-size: clamp(1.75rem, 9vw, 2.55rem); }
    }
'''
if marker not in text:
    text = text.replace('</style>', css + '  </style>', 1)
    path.write_text(text, encoding='utf-8')
PY
