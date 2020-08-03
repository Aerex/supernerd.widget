export default function ({ icon, id, appName, mode }) {
  return (
      <div class="widg"> 
        <div class="output cyan" id="mode"> 
          <div class="icon-container cyan" id="mode-icon-container"> 
            <i id={ icon } class={ id }></i> 
          </div> 
        </div> 
        <span class="output" id="spaces"> 
          <span>{appName} | { mode } </span>
        </span>
        </div>
  )
}
