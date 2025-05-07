#!/usr/bin/env python3
from __future__ import print_function

import os
import sys
import re
from subprocess import Popen, PIPE, check_output


# Retourne le tag s’il existe, sinon le hash court du commit HEAD
def get_tagname_or_hash():
    try:
        hash_cmd = ['git', 'rev-parse', '--short', 'HEAD']
        hash_ = check_output(hash_cmd).decode('utf-8').strip()
    except Exception:
        return None

    try:
        tags_cmd = [
            'git', 'for-each-ref', '--points-at=HEAD', '--count=2',
            '--sort=-version:refname', '--format=%(refname:short)', 'refs/tags'
        ]
        tags = check_output(tags_cmd).decode('utf-8').split()
        if tags:
            return tags[0] + ('+' if len(tags) > 1 else '')
    except Exception:
        pass

    return hash_ or None


# Retourne le nombre d’éléments dans le stash local
def get_stash():
    cmd = Popen(['git', 'rev-parse', '--git-dir'], stdout=PIPE, stderr=PIPE)
    so, _ = cmd.communicate()
    stash_file = '%s/logs/refs/stash' % so.decode('utf-8').rstrip()

    try:
        with open(stash_file) as f:
            return sum(1 for _ in f)
    except IOError:
        return 0


# Exécute `git status` en mode machine-readable
po = Popen(['git', 'status', '--porcelain', '--branch'], env=dict(os.environ, LANG="C"), stdout=PIPE, stderr=PIPE)
stdout, sterr = po.communicate()

# Si ce n’est pas un dépôt Git, on quitte silencieusement
if po.returncode != 0:
    sys.exit(0)

# Initialisation des compteurs
untracked, staged, changed, conflicts = [], [], [], []
ahead, behind = 0, 0

# Analyse ligne par ligne du résultat de git status
status = [(line[0], line[1], line[2:]) for line in stdout.decode('utf-8').splitlines()]
for st in status:
    # Ligne de métadonnées (branche, divergence)
    if st[0] == '#' and st[1] == '#':
        if re.search('Initial commit on', st[2]) or re.search('No commits yet on', st[2]):
            branch = st[2].split(' ')[-1]
        elif re.search('no branch', st[2]):  # HEAD détachée
            branch = get_tagname_or_hash()
        elif len(st[2].strip().split('...')) == 1:
            branch = st[2].strip()
        else:
            # Branche locale + distante avec divergence
            branch, rest = st[2].strip().split('...')
            if len(rest.split(' ')) > 1:
                divergence = ' '.join(rest.split(' ')[1:]).strip('[]')
                for div in divergence.split(', '):
                    if 'ahead' in div:
                        ahead = int(div.split(' ')[1])
                    elif 'behind' in div:
                        behind = int(div.split(' ')[1])
    # Fichier non suivi
    elif st[0] == '?' and st[1] == '?':
        untracked.append(st)
    else:
        # Modifications
        if st[1] == 'M':
            changed.append(st)
        if st[0] == 'U':
            conflicts.append(st)
        elif st[0] != ' ':
            staged.append(st)

# Compte les stashes
stashed = get_stash()

# Détermine si l’état du dépôt est "clean"
if not changed and not staged and not conflicts and not untracked and not stashed:
    clean = 1
else:
    clean = 0

# Sortie standard (format : branche, ahead, behind, staged, conflits, modifiés, non suivis, stashes, clean)
out = ' '.join([
    branch,
    str(ahead),
    str(behind),
    str(len(staged)),
    str(len(conflicts)),
    str(len(changed)),
    str(len(untracked)),
    str(stashed),
    str(clean)
])

# Affiche le résultat (sans retour à la ligne final)
print(out, end='')
