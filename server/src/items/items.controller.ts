import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  ParseIntPipe,
  Post,
  Put,
  Query
} from '@nestjs/common';

import { Prisma } from '@prisma/client';
import { ItemsService } from './items.service';

@Controller('items')
export class ItemsController {
  constructor(private readonly itemsService: ItemsService) {}

  @Get()
  async findAll(
    @Query('limit', new ParseIntPipe({ optional: true })) limit: number = 10,
    @Query('offset', new ParseIntPipe({ optional: true })) offset: number = 1
  ) {
    const data = await this.itemsService.findAll({ limit, offset });
    return { data };
  }

  @Delete('list')
  async deleteListId(@Body('ids') ids: number[]) {
    await this.itemsService.deleteList(ids);
    return { message: 'deleted successfully' };
  }

  @Get(':id')
  findById(@Param('id', ParseIntPipe) id: number) {
    return { data: this.itemsService.findById(id) };
  }

  @Post()
  @HttpCode(201)
  async create(@Body() createItemDto: Prisma.ItemsCreateInput) {
    await this.itemsService.create(createItemDto);
    return { message: 'created successfully' };
  }

  @Put(':id')
  @HttpCode(201)
  async update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateItemDto: Prisma.ItemsUpdateInput
  ) {
    await this.itemsService.update(id, updateItemDto);
    return { message: 'updated successfully' };
  }
  @Delete(':id')
  async delete(@Param('id', ParseIntPipe) id: number) {
    await this.itemsService.delete(id);
    return { message: 'deleted successfully' };
  }
}
