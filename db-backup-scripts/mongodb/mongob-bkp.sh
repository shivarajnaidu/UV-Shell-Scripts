#!/bin/sh

short_month="$(date +%b)"
year="$(date +%Y)"

db_backup_base_dir="$HOME/bkp/db/$year/$short_month"
db_backup_dir_name="db-$(date +%F)"
db_backup_dir_path="$db_backup_base_dir/$db_backup_dir_name/dump"

take_bakup() {
    # echo "$db_backup_dir_path"
    mongodump --host localhost --db testdb --out "$db_backup_dir_path"

    if [ "$?" != "0" ]; then
        exit
    fi

    zip_the_backup_and_clean    
    

}

zip_the_backup_and_clean() {
    cd "$db_backup_base_dir"
    zip -r "$db_backup_dir_name.zip" "$db_backup_dir_name"
    rm -r "$db_backup_dir_name"
}

if [ "$1" = "" ] || [ "$1" = "--b" ] || [ "$1" = "--bkp" ] || [ "$1" = "--backup" ]; then
    take_bakup
elif [ "$1" = "--r" ] || [ "$1" = "--rs" ] || [ "$1" = "--restore" ]; then
    echo "Restoring The DB"
fi
