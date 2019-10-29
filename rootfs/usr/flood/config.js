const CONFIG = {
  baseURI: process.env.WEBROOT || '/',
  dbCleanInterval: 1000 * 60 * 60,
  dbPath: '/flood-db/',
  floodServerPort: 3000,
  maxHistoryStates: 30,
  pollInterval: 1000 * 5,
  secret: process.env.FLOOD_SECRET || 'secret',
  scgi: {
    host: 'localhost',
    port: 5000,
    socket: true,
    socketPath: '/tmp/rtorrent.sock'
  },
  diskUsageService: {
    // assign desired mounts to include. Refer to "Mounted on" column of `df -P`
    watchMountPoints: [
      "/data/torrents",
      "/data/torrents2",
      "/data/torrents6"
    ]
  }
};

module.exports = CONFIG;
