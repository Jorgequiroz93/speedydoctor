import "jquery-bar-rating";
import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  // TODO
  $('#review_speed_rating').barrating({
    theme: 'css-stars',
    showValues: false,
    showSelectedRating: false
  });
  $('#review_gentleness_rating').barrating({
    theme: 'css-stars',
    showValues: false,
    showSelectedRating: false
  });
  $('#review_clarity_rating').barrating({
    theme: 'css-stars',
    showValues: false,
    showSelectedRating: false
  });
  $('#review_professionalism_rating').barrating({
    theme: 'css-stars',
    showValues: false,
    showSelectedRating: false
  });
};

export { initStarRating };
