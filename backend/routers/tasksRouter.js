const express = require('express');
const { getAllTasks } = require('../controllers/tasksController');

const router = express.Router();

router.get('/', getAllTasks);

module.exports = router;