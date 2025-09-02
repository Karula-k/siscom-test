import { PrismaClient } from '@prisma/client';
const categories = [
  { name: 'Electronics' },
  { name: 'Books' },
  { name: 'Clothing' }
];
export default async function CategorySeed(db: PrismaClient) {
  for (const d of categories) {
    const { name } = d;
    const exist = await db.category.findFirst({
      where: {
        categoryName: {
          contains: name
        }
      }
    });
    if (!exist) {
      await db.category.create({
        data: {
          categoryName: name
        }
      });
    }
  }
}
