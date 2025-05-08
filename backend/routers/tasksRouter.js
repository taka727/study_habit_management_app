const express = require('express');
const router = express.Router();
const taskController = require('../controllers/tasksController');

router.get('/',taskController);