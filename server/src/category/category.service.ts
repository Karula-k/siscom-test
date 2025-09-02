import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class CategoryService {
  constructor(private readonly databaseService: DatabaseService) {}

  async findAll({ limit = 10, skip = 0 }: { limit?: number; skip?: number }) {
    return this.databaseService.category.findMany({
      skip,
      take: limit
    });
  }

  async findById(id: number) {
    return this.databaseService.category.findUnique({ where: { id } });
  }

  async create(data: Prisma.CategoryCreateInput) {
    return this.databaseService.category.create({ data });
  }

  async update(id: number, data: Prisma.CategoryUpdateInput) {
    return this.databaseService.category.update({ where: { id }, data });
  }

  async delete(id: number) {
    return this.databaseService.category.delete({ where: { id } });
  }
}
