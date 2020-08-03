export default function getIcon(mode) {
  const isTileMode = /bsp/i.test(mode);
  const isFloatMode = /float/i.test(mode);
  const isStackMode = /w/i.test(mode);

  if (isTileMode) {
    return 'fas fa-th'
  } 

  if (isFloatMode) {
    return 'far fa-clone'
  } 

  if (isStackMode) {
    return 'fas fa-align-justify'
  }

  return 'far fa-window-maximize'

}
