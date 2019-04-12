﻿let right = 0;
let wrong = 0;
const deckId = document.querySelector('input#deckId').value;
const apiUrl = `http://localhost:${location.port}/API/`;

const studyCard = document.querySelector('div#study-card');
const frontOfCard = document.querySelector('h2#card-front');
const backOfCard = document.querySelector('h3#card-back');
const scoreTracker = document.querySelector('div#score-tracker');
const correctButton = document.querySelector('div#correct-button');
const wrongButton = document.querySelector('div#wrong-button');
const scoreDisplay = document.querySelector('div#score-count p');
const completeSession = document.querySelector('div#complete-session');
const endSessionButton = document.querySelector('div#complete-button');
const image = document.querySelector('#img-front');

let unansweredQuestions = [];
let answeredQuestions = [];
let hasBeenFlipped = false;

fetch(`${apiUrl}getdeck?id=${deckId}`)
    .then(response => {
        response.json()
            .then(data => {
                unansweredQuestions = data.cards;
                if (unansweredQuestions[0].imageURL != '') {
                    image.src = unansweredQuestions[0].imageURL;
                    frontOfCard.innerText = '';
                } else {
                    frontOfCard.innerText = unansweredQuestions[0].front;
                    image.src = '';

                }
                backOfCard.innerText = unansweredQuestions[0].back;
                studyCard.classList.remove('hidden');
            });
    });

function ComputeScore(correct) {
    if (correct) {
        right++;
    }
    else {
        wrong++;
    }
}

function NextCard() {
    hasBeenFlipped = false;
    if (unansweredQuestions.length > 0) {
        answeredQuestions.push(unansweredQuestions[0]);
        unansweredQuestions.shift();
    }

    if (unansweredQuestions.length > 0) {
        frontOfCard.classList.remove('hidden');
        backOfCard.classList.add('hidden');
        image.classList.remove('hidden');
        scoreTracker.classList.add('hide-score');

        if (unansweredQuestions[0].imageURL != '') {
            image.src = unansweredQuestions[0].imageURL;
            frontOfCard.innerText = '';
        } else {
            frontOfCard.innerText = unansweredQuestions[0].front;
            image.src = '';
        }
        backOfCard.innerText = unansweredQuestions[0].back;

    } else {
        CompleteStudySession();
    }
}

async function FlipCard() {
    hasBeenFlipped = true;
    let frontToBack;

    studyCard.classList.add('flip');

    if (!frontOfCard.classList.contains('hidden')) {
        frontOfCard.classList.add('hidden');
        image.classList.add('hidden');
        frontToBack = true;
    }
    if (!backOfCard.classList.contains('hidden')) {
        backOfCard.classList.add('hidden');
        frontToBack = false;
    }

    scoreTracker.classList.remove('hidden');
    studyCard.addEventListener('animationend', e => {
        studyCard.classList.remove('flip');
        scoreTracker.classList.toggle('hide-score');
        if (frontToBack) {
            backOfCard.classList.remove('hidden');
            frontOfCard.classList.add('hidden');
            image.classList.add('hidden');
        } else {
            frontOfCard.classList.remove('hidden');
            image.classList.remove('hidden');
            backOfCard.classList.add('hidden');
        }
    });
}

function CompleteStudySession() {
    studyCard.classList.add('hidden');
    scoreTracker.classList.add('hidden');
    completeSession.querySelector('p.correct').innerText = `You got ${right} question${right === 1 ? '' : 's'} correct.`;
    completeSession.querySelector('p.incorrect').innerText = `You got ${wrong} question${wrong === 1 ? '' : 's'} wrong.`;
    completeSession.classList.remove('hidden');
    endSessionButton.classList.add('hidden');
}

studyCard.addEventListener('click', FlipCard);

correctButton.addEventListener('click', function () {
    ComputeScore(true);
    scoreDisplay.innerText = `Correct: ${right} - Wrong: ${wrong}`;
    NextCard();
});

wrongButton.addEventListener('click', function () {
    ComputeScore(false);
    scoreDisplay.innerText = `Correct: ${right} - Wrong: ${wrong}`;
    NextCard();
});

studyCard.addEventListener('mouseover', e => {
    if (hasBeenFlipped) {
        scoreTracker.classList.remove('hide-score');
    }
});

scoreTracker.addEventListener('mouseover', e => {
    if (hasBeenFlipped) {
        scoreTracker.classList.remove('hide-score');
    }
});

studyCard.addEventListener('mouseout', e => {
    if (hasBeenFlipped) {
        scoreTracker.classList.add('hide-score');
    }
});

scoreTracker.addEventListener('mouseout', e => {
    if (hasBeenFlipped) {
        scoreTracker.classList.add('hide-score');
    }
});

endSessionButton.addEventListener('click', () => {
    CompleteStudySession();
});