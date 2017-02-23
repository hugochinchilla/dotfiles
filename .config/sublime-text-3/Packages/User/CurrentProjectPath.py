import os.path
from os import getenv

import sublime
import sublime_plugin



class UpdateProjectPath(sublime_plugin.ViewEventListener):
    FILENAME = '.sublime_project_path'

    def on_activated(self):
        with open (os.path.join(getenv("HOME"), self.FILENAME), 'w') as f:
            f.write(self._get_project_folder())


    @classmethod
    def _get_project_folder(cls):
        window = sublime.windows()[0]
        folder = window.project_data()['folders'][0]['path']
        if os.path.isabs(folder):
            return folder

        project_conf_dir = os.path.dirname(window.project_file_name())
        return os.path.dirname(os.path.join(project_conf_dir, folder))
