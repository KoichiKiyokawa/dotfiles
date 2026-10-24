#!/usr/bin/env python3
"""Remove incident roots listed at https://emudhra.we-have-a-problem.com/roots.json."""

import argparse
import hashlib
import os
from pathlib import Path
import re
import shutil
import ssl
import stat
import tempfile


ROOT_FINGERPRINTS = {
    "7dd78d5f4f13459a83dff9abbba62edbaf6f2d102bf257fd712f4d9f2746ed8d",
    "f2edaaff3d9b701fb4d14c9f285f8c0bad90fc3bcc1fa07d47f4718edaba34a5",
    "d7a7a0fb5d7e2731d771e9484ebcdef71d5f0c3e0a2948782bc83ee0ea699ef4",
    "86a1ecba089c4a8d3bbe2734c612ba341d813e043cf9e8a862cd5c57a36bbe6b",
}
CERTIFICATE = re.compile(
    rb"-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----(?:\r?\n)?", re.S
)


def remove_roots(data):
    removed = 0

    def replace(match):
        nonlocal removed
        der = ssl.PEM_cert_to_DER_cert(match[0].decode("ascii"))
        if hashlib.sha256(der).hexdigest() in ROOT_FINGERPRINTS:
            removed += 1
            return b""
        return match[0]

    filtered = CERTIFICATE.sub(replace, data)
    certificates = b"".join(CERTIFICATE.findall(filtered)).decode("ascii")
    ssl.create_default_context(cadata=certificates)
    return filtered, removed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("files", type=Path, nargs="*")
    args = parser.parse_args()
    files = args.files or [
        Path("/etc/ssl/cert.pem"),
        *Path("/Applications/Xcode.app/Contents/Developer/Library/Frameworks").glob(
            "Python3.framework/Versions/*/lib/python*/site-packages/pip/_vendor/certifi/cacert.pem"
        ),
    ]
    seen = set()
    pending = 0
    for original in files:
        path = original.resolve(strict=True)
        if path in seen:
            continue
        seen.add(path)
        filtered, removed = remove_roots(path.read_bytes())
        print(f"{original}: {removed} incident roots", flush=True)
        pending += removed
        if not args.apply or not removed:
            continue
        backup = path.with_name(path.name + ".before-emudhra-20261023")
        if not backup.exists():
            shutil.copy2(path, backup)
        metadata = path.stat()
        with tempfile.NamedTemporaryFile(dir=path.parent, delete=False) as output:
            temporary = Path(output.name)
            output.write(filtered)
        try:
            temporary.chmod(stat.S_IMODE(metadata.st_mode))
            if os.geteuid() == 0:
                os.chown(temporary, metadata.st_uid, metadata.st_gid)
            os.replace(temporary, path)
        finally:
            temporary.unlink(missing_ok=True)
        print(f"Updated {original}; backup: {backup}", flush=True)
    return 0 if args.apply or pending == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
