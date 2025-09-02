server :
fill env
npm i
npx prisma migrate deploy
make dev

client:
fill env with proper url api
flutter pub get
f5 or flutter run
