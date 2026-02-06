# Checking StatsD Logs on Mac

Since StatsD sends metrics over UDP, you can easily "see" the metrics being sent from your Rails application by listening on the configured port using `nc` (Netcat), which comes pre-installed on macOS.

## How to listen for Metrics

1. Open a new Terminal window.
2. Run the following command:

   ```bash
   nc -ul 8125
   ```

   *Note: If that doesn't show anything, try `nc -ul 127.0.0.1 8125`.*

3. While this command is running, trigger the `ProductsController#index` action (e.g., by visiting the page or using `curl`).

4. You should see output in your terminal similar to:

   ```text
   products.index.time:123.45|ms
   ```

## Why use UDP?
StatsD uses UDP because it is "fire and forget." This ensures that your application's performance isn't impacted if the StatsD server is slow or down, as the application doesn't wait for a response.
