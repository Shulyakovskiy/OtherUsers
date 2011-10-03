﻿using Caliburn.Micro;
using Machine.Specifications;
using Rhino.Mocks;
using Willow.Kermit.Messages;
using Willow.Kermit.ViewModels;
using Willow.Kermit.ViewModels.Interfaces;
using developwithpassion.specifications.rhino;
using developwithpassion.specifications.extensions;

namespace Willow.Kermit.Specs.ViewModels
{   
    public class NewKidViewModelSpecs
    {
        public abstract class concern : Observes<INewChildViewModel, NewChildViewModel>
        {
        
        }

        [Subject(typeof(NewChildViewModel))]
        public class when_closing_the_view : concern
        {

            Establish c = () =>
            {
                events = an<IEventAggregator>();
                add_pipeline_behaviour_against_sut(x => x.Events = events);
            };

            Because b = () =>
            {
                sut.Close();
            };

            It should_publish_a_close_request_for_itself = () =>
            {
                events.received(x => x.Publish(Arg<ICloseTabMessage>.Matches(msg => ReferenceEquals(msg.Item, sut)))).OnlyOnce();
            };

            static IEventAggregator events;
        }
    }
}
