import parse from './libs/utils/parse.jsx';
import getIcon from './libs/utils/getIcon.jsx';
import getShortenAppName from './libs/utils/getShortenAppName.jsx';
import Yabai from './libs/components/Yabai.jsx';

export const refreshFrequency = 1000;

export const command = "echo $(./supernerd.widget/scripts/spaces.sh)"

export const render = ({ output }) => {
  if (typeof(output) !== 'undefined' && output !== '') {
    const data = JSON.parse(output);
    const modeId = `#${data.lhs}-icon`;
    const modeIcon = getIcon(data.lhs);
    const appName = getShortenAppName(data.rhs);
    return (

   <div class="container"> 
     <Yabai id={modeIcon} icon={modeId} appName={appName} mode={data.lhs}/>
   </div>
    )

  }
}

