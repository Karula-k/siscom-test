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
import { CategoryService } from './category.service';
import { Prisma } from '@prisma/client';

@Controller('category')
export class CategoryController {
  constructor(private readonly categoryService: CategoryService) {}

  @Get()
  findAll(
    @Query('limit', new ParseIntPipe({ optional: true })) limit: number = 10,
    @Query('offset', new ParseIntPipe({ optional: true })) offset: number = 0
  ) {
    return this.categoryService.findAll({ limit, offset });
  }
  @Get(':id')
  findById(@Param('id', ParseIntPipe) id: number) {
    return this.categoryService.findById(id);
  }

  @Post()
  create(@Body() createCategoryDto: Prisma.CategoryCreateInput) {
    return this.categoryService.create(createCategoryDto);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateCategoryDto: Prisma.CategoryUpdateInput
  ) {
    return this.categoryService.update(id, updateCategoryDto);
  }
  @Delete(':id')
  delete(@Param('id', ParseIntPipe) id: number) {
    return this.categoryService.delete(id);
  }
}
