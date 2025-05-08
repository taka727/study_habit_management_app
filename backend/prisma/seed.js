const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Seed 実行開始');
    // セキュリティ質問作成
    const question = await prisma.securityQuestion.create({
        data: { content: '好きな食べ物は？' },
    });

    // ユーザー作成
    const user = await prisma.user.create({
        data: {
            username: 'test_user',
            userQuestionId: question.id,
            userAnswer: 'カレー',
            isDeleted: false,
        },
    });

    // ステータス作成
    const status = await prisma.status.create({
        data: { status_name: '未着手' },
    });

    // ゴール作成
    const goal = await prisma.goal.create({
        data: {
            userId: user.id,
            title: 'AWS資格を取る',
            description: '30日以内にCloud Practitioner合格',
            goalStartDate: new Date(),
            goalEndDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
            createdAt: new Date(),
        },
    });

    // タスク作成
    const task = await prisma.task.create({
        data: {
            userId: user.id,
            taskStatusId: status.id,
            taskTitle: 'テキストを3章まで読む',
            taskDescription: '黒本を毎日1章ずつ進める',
            taskStartTime: new Date(),
            taskEndTime: new Date(Date.now() + 2 * 60 * 60 * 1000),
            createdAt: new Date(),
        },
    });

    // サブタスク作成
    await prisma.subTask.createMany({
        data: [
            {
                parentTaskId: task.id,
                title: '第1章を読む',
            },
            {
                parentTaskId: task.id,
                title: '第2章を読む',
            },
        ],
    });

    console.log('✅ Seed 完了');
}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(() => {
        prisma.$disconnect();
    });