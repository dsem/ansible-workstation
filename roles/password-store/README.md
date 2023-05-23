Password Store
--------------

### Migrating from other computer

Export your public and private gpg keys

```
gpg --export <email address> > pass-key.gpg
gpg --export-secret-key <email address> > pass-key-secret.gpg
```

Copy over the gpg keys on the new machine and import them with:

### Linux

```
gpg2 --import pass-key.gpg
gpg2 --import-secret-key pass-key-secret.gpg
```

### MacOS

gpg --import pass-key.gpg
gpg --import pass-key-secret.gpg

---

Then mark the key as trusted:

```
gpg --edit-key <email associated with key>
gpg> trust


Your decision? 5
```
