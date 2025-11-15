import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { MoviesController } from './movies.controller';
import { MoviesService } from './movies.service';

@Module({
  imports: [HttpModule, ConfigModule],
  controllers: [MoviesController],
  providers: [MoviesService],
})
export class MoviesModule {}
