import { PrismaClient as PrismaClientYoobuWP } from "../generated/prisma_yb_wp/index.js";
import { PrismaClient as PrismaClientYoobuLogistic } from "../generated/prisma_yb_logistic/index.js";

const prisma_yb_logistic = new PrismaClientYoobuLogistic();
const prisma_yb_wp = new PrismaClientYoobuWP();

export { prisma_yb_wp, prisma_yb_logistic };
