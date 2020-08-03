export default function getShortenAppName(name, limit=60) {
  const dots = '...';
  if (name.length > limit) {
    return `${name.substring(0, limit)}${dots}`;
  }
  return name;
}
