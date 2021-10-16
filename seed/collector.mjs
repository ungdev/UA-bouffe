import { readFileSync, readdirSync, appendFileSync } from 'fs';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const files = readdirSync(__dirname, {
  withFileTypes: true,
});

const parse = (fileContent) => fileContent.split('\n').map((entry) => entry.split(','));

console.info('<--- \x1b[1;33mReading database structure\x1b[0m');
let seed = readFileSync(`${__dirname}/seed.sql`, { encoding: 'utf-8' });

console.info('<--- \x1b[1;33mReading database entries\x1b[0m');
for (const file of files) {
  if (file.isFile() && file.name.endsWith('.csv')) {
    const seedData = readFileSync(`${__dirname}/${file.name}`, { encoding: 'utf-8' });
    const [columns, ...data] = parse(seedData);
    if (!data.length) continue;
    seed += `INSERT INTO \`${file.name.replace(/\.csv$/, '')}\` (${columns
      .map((col) => `\`${col}\``)
      .join()}) VALUES ${data
        .map(
          (row) =>
            `(${row
              .map((item) =>
                !item.length ? 'NULL' :
                  !Number.isNaN(Number(item)) || item.toLowerCase() === 'true' || item.toLowerCase() === 'false' ? item :
                    `'${item.replace(/'/g, "''")}'`,
              )
              .join()})`,
        )
        .join()};`;
  }
}

appendFileSync(resolve(`${__dirname}/../seed.sql`), seed, {
  encoding: 'utf-8',
});

console.info(`---> \x1b[1;32mSaved seed as \x1b[2;37m${resolve(`${__dirname}/../seed.sql\x1b[0m`)}`);