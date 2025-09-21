rsync -arI --prune-empty-dirs --include="*/" --include="*gershwin*/*" --exclude="*" ../ghostbsd-ports/* ./ports/ 
rsync -arI ../ghostbsd-gershwin-ports/ports-overlay/ ./ports/
