import { readFileSync, readdirSync, writeFileSync } from 'fs';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const fileStreams = readdirSync(__dirname, {
  withFileTypes: true,
}).filter((file) => file.isFile() && file.name.endsWith('.csv'))
  .map((file) => {
    const fileContent = readFileSync(`${__dirname}/${file.name}`, { encoding: 'utf-8' });
    let content = '';
    const requires = [];
    for (const line of fileContent.split('\n')) {
      const match = line.match(/^@requires\s(.*)$/i);
      if (match) requires.push(match[1]);
      else content += `\n${line}`;
    }
    return {
      content,
      requires,
      name: file.name.replace(/\.csv$/, ''),
    }
  }).sort((table1, table2) => {
    if (table1.requires.includes(table2.name)) return 1;
    if (table2.requires.includes(table1.name)) return -1;
    return table1.requires.length - table2.requires.length;
  });

const parse = (fileContent) => fileContent.split('\n').filter((entry) => entry).map((entry) => entry.split(','));

console.info('<--- \x1b[1;33mReading database structure\x1b[0m');
let seed = readFileSync(`${__dirname}/seed.sql`, { encoding: 'utf-8' });

console.info('<--- \x1b[1;33mReading database entries\x1b[0m');
for (const file of fileStreams) {
  const [columns, ...data] = parse(file.content);
  if (!data.length) continue;
  seed += `\nINSERT INTO \`${file.name}\` (${columns
    .map((col) => `\`${col}\``)
    .join()}) VALUES ${data
      .map(
        (row) =>
          `\n\t(${row
            .map((item) =>
              !item.length ? 'NULL' :
                !Number.isNaN(Number(item)) || item.toLowerCase() === 'true' || item.toLowerCase() === 'false' ? item :
                  `'${item.replace(/'/g, "''")}'`,
            )
            .join()})`,
      )
      .join()};`;
  console.info(`<--> \x1b[2;37mRegistering ${file.name} entries\x1b[0m`);
}

writeFileSync(resolve(`${__dirname}/../seed.sql`), seed, {
  encoding: 'utf-8',
});

console.info(`---> \x1b[1;32mSaved seed as \x1b[2;37m${resolve(`${__dirname}/../seed.sql\x1b[0m`)}`);