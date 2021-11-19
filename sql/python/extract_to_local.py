"""
This code defines a class which copies all the important data from the
PostgreSQL server to a local SQLite database.
"""

# Standard imports.
import csv
import os
import sqlite3
import subprocess

# Local constants.
DEFAULT_APP_NAME = "st-marys-edlington"
DEFAULT_PATH_TO_DB = "local_dump.db"
DEFAULT_PRINTOUT_DIRNAME = "printouts"
DEFAULT_PRINTOUT_EXTENSION = ".csv"
DEFAULT_PATH_TO_CREATE_DROP = "../create_drop.sql"
DEFAULT_TABLE_NAMES = ("RealWorldAddress",)

##############
# MAIN CLASS #
##############

class LocalExtractor:
    """ The class in question. """
    def __init__(self, app_name=DEFAULT_APP_NAME,
                 path_to_db=DEFAULT_PATH_TO_DB,
                 printout_dirname=DEFAULT_PRINTOUT_DIRNAME,
                 printout_extension=DEFAULT_PRINTOUT_EXTENSION,
                 path_to_create_drop=DEFAULT_PATH_TO_CREATE_DROP):
        self.app_name = app_name
        self.path_to_db = path_to_db
        self.printout_dirname = printout_dirname
        self.printout_extension = printout_extension
        self.path_to_create_drop = path_to_create_drop

    def make_path_to_printout(self, table_name):
        """ Make the path to the printout for a given table. """
        result = \
            os.path.join(
                self.printout_dirname,
                table_name+self.prinout_extension
            )
        return result

    def extract_table_to_printout(self, table_name):
        """ Extract a given table to a text file. """
        commands = [
            "heroku",
            "pg:psql",
            "--app",
            self.app_name,
            "--command=\"SELECT * FROM "+table_name+";\""
        ]
        path_to_printout = self.make_path_to_printout(table_name)
        subprocess.run(commands, stdout=path_to_printout, check=True)

    def create_local_dump(self):
        """ Create the .db file and run the create-drop script. """
        if os.path.exists(self.path_to_db):
            os.remove(self.path_to_db)
        subprocess.run(["touch", self.path_to_db], check=True)
        connection = sqlite3.connect(self.path_to_db)
        cursor = connection.cursor()
        cursor.executescript(self.path_to_create_drop)
        connection.close()

    def add_from_printout(self, table_name):
        """ Add data from a printout to the local dump. """
        path_to_printout = self.make_path_to_printout(table_name)
        with open(path_to_printout, "r") as csv_file:
            data = csv.reader(csv_file, delimiter=",")
            query = make_insert_query(table_name, len(data[0]))
            connection = sqlite3.connect(self.path_to_db)
            cursor = connection.cursor()
            for record in data:
                cursor.execute(query, record)
            connection.close()
        os.remove(path_to_printout)

    def extract(self, table_names):
        """ Extract all data to a local SQLite dump. """
        self.create_local_dump()
        for table_name in table_names:
            self.extract_to_printout(table_name)
        for table_name in table_names:
            self.add_from_printout(table_name)
        os.rmdir(self.printout_dirname)

####################
# HELPER FUNCTIONS #
####################

def make_insert_query(table_name, number_of_columns):
    """ Make an insert query for adding data from a CSV printout. """
    result = "INSERT INTO "+table_name+"VALUES ("
    question_marks_list = []
    for _ in number_of_columns:
        columns.append("?")
    question_marks_string = ", ".join(question_marks_list)
    result = result+question_marks_string+");"
    return result

###################
# RUN AND WRAP UP #
###################

def run():
    """ Run this file. """
    extractor = LocalExtractor()
    for table_name in DEFAULT_TABLE_NAMES:
        extractor.extract()

if __name__ == "__main__":
    run()
