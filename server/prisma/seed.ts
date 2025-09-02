import { PrismaClient } from '@prisma/client';
import CategorySeed from './category/category.seed';

async function seed() {
  const db = new PrismaClient({ log: ['query', 'info', 'warn', 'error'] });

  await CategorySeed(db);
  await db.$disconnect();
}
void (async () => {
  try {
    await seed();
  } catch (e) {
    console.error(e);
    process.exit(1);
  }
})();
