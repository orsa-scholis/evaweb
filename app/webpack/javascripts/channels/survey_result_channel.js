import consumer from './consumer';
import { chart } from '../chart';

consumer.subscriptions.create({ channel: 'SurveyResultChannel', survey_id: window.EvawebDashboard.surveyId }, {
  connected() {},
  disconnected() {},

  received(data) {
    const chartDiv = document.getElementById('chart');

    if (Object.prototype.hasOwnProperty.call(chartDiv.dataset, 'statsReceived') && chartDiv.dataset.statsReceived === 'false') {
      const urlDiv = document.getElementById('url_infos');
      chartDiv.classList.replace('col-12', 'col-8');
      urlDiv.classList.replace('col-12', 'col-4');

      chartDiv.dataset.statsReceived = 'true';
    }

    const parsedData = JSON.parse(data);
    chart.render(parsedData);
  }
});
