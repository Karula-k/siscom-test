import {
  Body,
  Controller,
  Delete,
  Get,
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
  findAll(
    @Query('limit', new ParseIntPipe({ optional: true })) limit: number = 10,
    @Query('skip', new ParseIntPipe({ optional: true })) skip: number = 0
  ) {
    return this.itemsService.findAll({ limit, skip });
  }
  @Get(':id')
  findById(@Param('id', ParseIntPipe) id: number) {
    return this.itemsService.findById(id);
  }

  @Post()
  create(@Body() createItemDto: Prisma.ItemsCreateInput) {
    return this.itemsService.create(createItemDto);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateItemDto: Prisma.ItemsUpdateInput
  ) {
    return this.itemsService.update(id, updateItemDto);
  }
  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number) {
    return this.itemsService.delete(id);
  }
}
