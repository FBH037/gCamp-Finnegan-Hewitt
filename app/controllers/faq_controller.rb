class FaqController < ApplicationController
  def index

    faq0 = Faq.new
    faq0.question = "What is gCamp?"
    faq0.answer = "gCamp is an awesome tool that is going to change your life.  gCamp is your one stop shop to organize all your tasks.  You'll also be able to track comments that you and others make.  gCamp may eventually replace all need for paper and pens in the entire world.  Well, maybe not, but it's going to be pretty cool."
    faq0.slug = "what-is-gcamp"


    faq1 = Faq.new
    faq1.question = "How do I join gCamp?"
    faq1.answer = "As soon as it's ready for the public, you'll see a signup link in the upper right.  Once that's there, just click it and fill in the form!"
    faq1.slug = "how-do-i-join-gcamp"

    faq2 = Faq.new
    faq2.question = "When will gCamp be finished?"
    faq2.answer = "gCamp is a work in progress.  That being said, it should be fully functional in the next few weeks.  Functional.  Check in daily for new features and awesome functionality.  It's going to blow your mind.  Organization is just a click away.  Amazing!"
    faq2.slug = "when-will-gcamp-be-finished"

    @faqs = [faq0, faq1, faq2]
  end
end
