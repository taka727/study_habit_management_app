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

const getTaskId = async (req,res) => {
    try {
        const taskId = await prisma.task.findUniqueOrThrow({
            where:{id : 1},
        });
        res.json({status:'success',data:taskId});
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: 'error', message: 'サーバーエラー' });
    }
}

module.exports = {
    getAllTasks
};