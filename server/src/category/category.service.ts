import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class CategoryService {
  constructor(private readonly databaseService: DatabaseService) {}

  async findAll({
    limit = 10,
    offset = 1
  }: {
    limit?: number;
    offset?: number;
  }) {
    const response = await this.databaseService.category.findMany({
      skip: (offset - 1) * limit,
      take: limit
    });
    return { data: response };
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
