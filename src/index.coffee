import React from 'react';
import ReactDOM from 'react-dom';

import Tasks from './tasks/tasks'
import MainController from './views/main/main-controller'
import RightButtonController from './views/right-button/right-button-controller'

window.simple_gallery_flux = {
  MainController: MainController
  Tasks: Tasks
  RightButtonController: RightButtonController
}
