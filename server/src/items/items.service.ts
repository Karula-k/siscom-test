import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { DatabaseService } from 'src/database/database.service';

@Injectable()
export class ItemsService {
  constructor(private readonly databaseService: DatabaseService) {}

  async findAll({ limit = 10, skip = 0 }: { limit?: number; skip?: number }) {
    return this.databaseService.items.findMany({
      skip,
      take: limit
    });
  }

  async findById(id: number) {
    return this.databaseService.items.findUnique({ where: { id } });
  }

  async create(data: Prisma.ItemsCreateInput) {
    return this.databaseService.items.create({ data });
  }

  async update(id: number, data: Prisma.ItemsUpdateInput) {
    return this.databaseService.items.update({ where: { id }, data });
  }

  async delete(id: number) {
    return this.databaseService.items.delete({ where: { id } });
  }
}
