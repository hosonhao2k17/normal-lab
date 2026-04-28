#BUILDER
FROM node:24 as builder 

WORKDIR /app 

COPY package*.json .
RUN npm install 

COPY . . 
RUN npm run build 

#RUNNER 
FROM node:24 as runner 

WORKDIR /app 

COPY package*.json . 
RUN npm install 

COPY --from=builder /app/dist ./dist 

EXPOSE 3000 
CMD ["node","dist/main.js"]