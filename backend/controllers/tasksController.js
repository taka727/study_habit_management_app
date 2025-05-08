const prisma = require('../prismaClient');

const getAllTasks = async (req, res) => {
    try {
        const tasks = await prisma.task.findMany({
            include: {
                user: true,
                status: true,
                subtasks: true,
            },
        });
        res.json({ status: 'success', data: tasks });
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: 'error', message: 'サーバーエラー' });
    }
};

module.exports = {
    getAllTasks
};