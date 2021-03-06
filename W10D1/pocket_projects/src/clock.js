import { htmlGenerator } from "./warmup";

class Clock {
  constructor() {
    const currentTime = new Date();

    this.hours = currentTime.getHours();
    this.minutes = currentTime.getMinutes();
    this.seconds = currentTime.getSeconds();

    htmlGenerator(this.printTime(), clockElement);
    // Schedule the tick at 1 second intervals.
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    return [this.hours, this.minutes, this.seconds].join(":");
  }

  _tick() {
    this._incrementSeconds();
    // append our clock HTML
    htmlGenerator(this.printTime(), clockElement);
  }

  _incrementSeconds() {
    // 1. Increment the time by one second.
    this.seconds += 1;
    if (this.seconds === 60) {
      this.seconds = 0;
      this._incrementMinutes();
    }
  }

  _incrementMinutes() {
    this.minutes += 1;
    if (this.minutes === 60) {
      this.minutes = 0;
      this._incrementHours();
    }
  }

  _incrementHours() {
    this.hours = (this.hours + 1) % 24;
  }
}

const clockElement = document.getElementById('clock');
const clock = new Clock();