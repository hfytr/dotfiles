// stole almost everything from https://github.com/stefur/flow
mod app;
mod output;
mod protocols;
mod seat;
use app::App;

use wayland_client::{Connection, Proxy};

fn main() {
    let conn = Connection::connect_to_env().expect("Failed to connect to the Wayland server!");
    let display = conn.display();
    let mut event_queue = conn.new_event_queue();
    let queue_handle = event_queue.handle();
    let _registry = display.get_registry(&queue_handle, ());
    let mut app = App::new();

    event_queue
        .roundtrip(&mut app)
        .expect("Failed to roundtrip event queue.");

    if let Some(seat) = app.seat.as_mut() {
        seat.seat_status = Some(
            app.status_manager
                .as_ref()
                .expect("A status manager should exist.")
                .get_river_seat_status(&seat.wlseat, &queue_handle, ()),
        );
    } else {
        panic!("Failed to get the seat status. A seat should exist but was None.")
    }

    event_queue
        .roundtrip(&mut app)
        .expect("Failed to roundtrip event queue.");

    for output in &mut app.outputs {
        if let Some(status_manager) = app.status_manager.as_ref() {
            output.status = Some(status_manager.get_river_output_status(
                &output.wloutput,
                &queue_handle,
                output.wloutput.id(),
            ));
        }
    }

    event_queue
        .roundtrip(&mut app)
        .expect("Failed to roundtrip event queue.");

    app.destroy();
}
