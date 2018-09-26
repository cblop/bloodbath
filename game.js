
var Module;

if (typeof Module === 'undefined') Module = eval('(function() { try { return Module || {} } catch(e) { return {} } })()');

if (!Module.expectedDataFileDownloads) {
  Module.expectedDataFileDownloads = 0;
  Module.finishedDataFileDownloads = 0;
}
Module.expectedDataFileDownloads++;
(function() {
 var loadPackage = function(metadata) {

    var PACKAGE_PATH;
    if (typeof window === 'object') {
      PACKAGE_PATH = window['encodeURIComponent'](window.location.pathname.toString().substring(0, window.location.pathname.toString().lastIndexOf('/')) + '/');
    } else if (typeof location !== 'undefined') {
      // worker
      PACKAGE_PATH = encodeURIComponent(location.pathname.toString().substring(0, location.pathname.toString().lastIndexOf('/')) + '/');
    } else {
      throw 'using preloaded data can only be done on a web page or in a web worker';
    }
    var PACKAGE_NAME = 'game.data';
    var REMOTE_PACKAGE_BASE = 'game.data';
    if (typeof Module['locateFilePackage'] === 'function' && !Module['locateFile']) {
      Module['locateFile'] = Module['locateFilePackage'];
      Module.printErr('warning: you defined Module.locateFilePackage, that has been renamed to Module.locateFile (using your locateFilePackage for now)');
    }
    var REMOTE_PACKAGE_NAME = typeof Module['locateFile'] === 'function' ?
                              Module['locateFile'](REMOTE_PACKAGE_BASE) :
                              ((Module['filePackagePrefixURL'] || '') + REMOTE_PACKAGE_BASE);
  
    var REMOTE_PACKAGE_SIZE = metadata.remote_package_size;
    var PACKAGE_UUID = metadata.package_uuid;
  
    function fetchRemotePackage(packageName, packageSize, callback, errback) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET', packageName, true);
      xhr.responseType = 'arraybuffer';
      xhr.onprogress = function(event) {
        var url = packageName;
        var size = packageSize;
        if (event.total) size = event.total;
        if (event.loaded) {
          if (!xhr.addedTotal) {
            xhr.addedTotal = true;
            if (!Module.dataFileDownloads) Module.dataFileDownloads = {};
            Module.dataFileDownloads[url] = {
              loaded: event.loaded,
              total: size
            };
          } else {
            Module.dataFileDownloads[url].loaded = event.loaded;
          }
          var total = 0;
          var loaded = 0;
          var num = 0;
          for (var download in Module.dataFileDownloads) {
          var data = Module.dataFileDownloads[download];
            total += data.total;
            loaded += data.loaded;
            num++;
          }
          total = Math.ceil(total * Module.expectedDataFileDownloads/num);
          if (Module['setStatus']) Module['setStatus']('Downloading data... (' + loaded + '/' + total + ')');
        } else if (!Module.dataFileDownloads) {
          if (Module['setStatus']) Module['setStatus']('Downloading data...');
        }
      };
      xhr.onload = function(event) {
        var packageData = xhr.response;
        callback(packageData);
      };
      xhr.send(null);
    };

    function handleError(error) {
      console.error('package error:', error);
    };
  
      var fetched = null, fetchedCallback = null;
      fetchRemotePackage(REMOTE_PACKAGE_NAME, REMOTE_PACKAGE_SIZE, function(data) {
        if (fetchedCallback) {
          fetchedCallback(data);
          fetchedCallback = null;
        } else {
          fetched = data;
        }
      }, handleError);
    
  function runWithFS() {

    function assert(check, msg) {
      if (!check) throw msg + new Error().stack;
    }
Module['FS_createPath']('/', '.git', true, true);
Module['FS_createPath']('/.git', 'hooks', true, true);
Module['FS_createPath']('/.git', 'logs', true, true);
Module['FS_createPath']('/.git/logs', 'refs', true, true);
Module['FS_createPath']('/.git/logs/refs', 'heads', true, true);
Module['FS_createPath']('/.git/logs/refs', 'remotes', true, true);
Module['FS_createPath']('/.git/logs/refs/remotes', 'origin', true, true);
Module['FS_createPath']('/.git', 'refs', true, true);
Module['FS_createPath']('/.git/refs', 'heads', true, true);
Module['FS_createPath']('/.git/refs', 'remotes', true, true);
Module['FS_createPath']('/.git/refs/remotes', 'origin', true, true);
Module['FS_createPath']('/.git', 'objects', true, true);
Module['FS_createPath']('/.git/objects', 'pack', true, true);
Module['FS_createPath']('/.git', 'info', true, true);
Module['FS_createPath']('/', 'docs', true, true);
Module['FS_createPath']('/', 'fonts', true, true);
Module['FS_createPath']('/', 'sprites', true, true);
Module['FS_createPath']('/sprites', 'matt', true, true);
Module['FS_createPath']('/sprites', 'hashim', true, true);
Module['FS_createPath']('/sprites', 'wenkai', true, true);
Module['FS_createPath']('/', 'images', true, true);

    function DataRequest(start, end, crunched, audio) {
      this.start = start;
      this.end = end;
      this.crunched = crunched;
      this.audio = audio;
    }
    DataRequest.prototype = {
      requests: {},
      open: function(mode, name) {
        this.name = name;
        this.requests[name] = this;
        Module['addRunDependency']('fp ' + this.name);
      },
      send: function() {},
      onload: function() {
        var byteArray = this.byteArray.subarray(this.start, this.end);

          this.finish(byteArray);

      },
      finish: function(byteArray) {
        var that = this;

        Module['FS_createDataFile'](this.name, null, byteArray, true, true, true); // canOwn this data in the filesystem, it is a slide into the heap that will never change
        Module['removeRunDependency']('fp ' + that.name);

        this.requests[this.name] = null;
      },
    };

        var files = metadata.files;
        for (i = 0; i < files.length; ++i) {
          new DataRequest(files[i].start, files[i].end, files[i].crunched, files[i].audio).open('GET', files[i].filename);
        }

  
    function processPackageData(arrayBuffer) {
      Module.finishedDataFileDownloads++;
      assert(arrayBuffer, 'Loading data file failed.');
      assert(arrayBuffer instanceof ArrayBuffer, 'bad input to processPackageData');
      var byteArray = new Uint8Array(arrayBuffer);
      var curr;
      
        // copy the entire loaded file into a spot in the heap. Files will refer to slices in that. They cannot be freed though
        // (we may be allocating before malloc is ready, during startup).
        if (Module['SPLIT_MEMORY']) Module.printErr('warning: you should run the file packager with --no-heap-copy when SPLIT_MEMORY is used, otherwise copying into the heap may fail due to the splitting');
        var ptr = Module['getMemory'](byteArray.length);
        Module['HEAPU8'].set(byteArray, ptr);
        DataRequest.prototype.byteArray = Module['HEAPU8'].subarray(ptr, ptr+byteArray.length);
  
          var files = metadata.files;
          for (i = 0; i < files.length; ++i) {
            DataRequest.prototype.requests[files[i].filename].onload();
          }
              Module['removeRunDependency']('datafile_game.data');

    };
    Module['addRunDependency']('datafile_game.data');
  
    if (!Module.preloadResults) Module.preloadResults = {};
  
      Module.preloadResults[PACKAGE_NAME] = {fromCache: false};
      if (fetched) {
        processPackageData(fetched);
        fetched = null;
      } else {
        fetchedCallback = processPackageData;
      }
    
  }
  if (Module['calledRun']) {
    runWithFS();
  } else {
    if (!Module['preRun']) Module['preRun'] = [];
    Module["preRun"].push(runWithFS); // FS is not initialized yet, wait for it
  }

 }
 loadPackage({"files": [{"audio": 0, "start": 0, "crunched": 0, "end": 6092, "filename": "/player.lua"}, {"audio": 0, "start": 6092, "crunched": 0, "end": 17551038, "filename": "/matt-game.zip"}, {"audio": 0, "start": 17551038, "crunched": 0, "end": 17557186, "filename": "/.DS_Store"}, {"audio": 0, "start": 17557186, "crunched": 0, "end": 19326834, "filename": "/report.pdf"}, {"audio": 0, "start": 19326834, "crunched": 0, "end": 19334734, "filename": "/gfx.lua"}, {"audio": 0, "start": 19334734, "crunched": 0, "end": 27225722, "filename": "/bloodbath.love"}, {"audio": 0, "start": 27225722, "crunched": 0, "end": 27229026, "filename": "/hud.lua"}, {"audio": 0, "start": 27229026, "crunched": 0, "end": 27233278, "filename": "/game.lua"}, {"audio": 0, "start": 27233278, "crunched": 0, "end": 27235915, "filename": "/fight.lua"}, {"audio": 0, "start": 27235915, "crunched": 0, "end": 27236456, "filename": "/README.md"}, {"audio": 0, "start": 27236456, "crunched": 0, "end": 27244851, "filename": "/anim8.lua"}, {"audio": 0, "start": 27244851, "crunched": 0, "end": 27247504, "filename": "/main.lua"}, {"audio": 0, "start": 27247504, "crunched": 0, "end": 27247767, "filename": "/.git/config"}, {"audio": 0, "start": 27247767, "crunched": 0, "end": 27247881, "filename": "/.git/packed-refs"}, {"audio": 0, "start": 27247881, "crunched": 0, "end": 27254853, "filename": "/.git/index"}, {"audio": 0, "start": 27254853, "crunched": 0, "end": 27254926, "filename": "/.git/description"}, {"audio": 0, "start": 27254926, "crunched": 0, "end": 27254949, "filename": "/.git/HEAD"}, {"audio": 0, "start": 27254949, "crunched": 0, "end": 27255373, "filename": "/.git/hooks/pre-applypatch.sample"}, {"audio": 0, "start": 27255373, "crunched": 0, "end": 27255851, "filename": "/.git/hooks/applypatch-msg.sample"}, {"audio": 0, "start": 27255851, "crunched": 0, "end": 27259461, "filename": "/.git/hooks/update.sample"}, {"audio": 0, "start": 27259461, "crunched": 0, "end": 27261099, "filename": "/.git/hooks/pre-commit.sample"}, {"audio": 0, "start": 27261099, "crunched": 0, "end": 27261643, "filename": "/.git/hooks/pre-receive.sample"}, {"audio": 0, "start": 27261643, "crunched": 0, "end": 27266541, "filename": "/.git/hooks/pre-rebase.sample"}, {"audio": 0, "start": 27266541, "crunched": 0, "end": 27267437, "filename": "/.git/hooks/commit-msg.sample"}, {"audio": 0, "start": 27267437, "crunched": 0, "end": 27267626, "filename": "/.git/hooks/post-update.sample"}, {"audio": 0, "start": 27267626, "crunched": 0, "end": 27268974, "filename": "/.git/hooks/pre-push.sample"}, {"audio": 0, "start": 27268974, "crunched": 0, "end": 27270466, "filename": "/.git/hooks/prepare-commit-msg.sample"}, {"audio": 0, "start": 27270466, "crunched": 0, "end": 27273793, "filename": "/.git/hooks/fsmonitor-watchman.sample"}, {"audio": 0, "start": 27273793, "crunched": 0, "end": 27273971, "filename": "/.git/logs/HEAD"}, {"audio": 0, "start": 27273971, "crunched": 0, "end": 27274149, "filename": "/.git/logs/refs/heads/master"}, {"audio": 0, "start": 27274149, "crunched": 0, "end": 27274327, "filename": "/.git/logs/refs/remotes/origin/HEAD"}, {"audio": 0, "start": 27274327, "crunched": 0, "end": 27274368, "filename": "/.git/refs/heads/master"}, {"audio": 0, "start": 27274368, "crunched": 0, "end": 27274400, "filename": "/.git/refs/remotes/origin/HEAD"}, {"audio": 0, "start": 27274400, "crunched": 0, "end": 59962088, "filename": "/.git/objects/pack/pack-0d4ddf29b88bc6bddf555c4dd57f31fc46187bc9.pack"}, {"audio": 0, "start": 59962088, "crunched": 0, "end": 59966632, "filename": "/.git/objects/pack/pack-0d4ddf29b88bc6bddf555c4dd57f31fc46187bc9.idx"}, {"audio": 0, "start": 59966632, "crunched": 0, "end": 59966872, "filename": "/.git/info/exclude"}, {"audio": 0, "start": 59966872, "crunched": 0, "end": 59969958, "filename": "/docs/report+mp0002.log"}, {"audio": 0, "start": 59969958, "crunched": 0, "end": 59973044, "filename": "/docs/report+mp0001.log"}, {"audio": 0, "start": 59973044, "crunched": 0, "end": 59995150, "filename": "/docs/report.log"}, {"audio": 0, "start": 59995150, "crunched": 0, "end": 59995597, "filename": "/docs/report+mp0004.mp"}, {"audio": 0, "start": 59995597, "crunched": 0, "end": 61765245, "filename": "/docs/report.pdf"}, {"audio": 0, "start": 61765245, "crunched": 0, "end": 61966890, "filename": "/docs/blender.png"}, {"audio": 0, "start": 61966890, "crunched": 0, "end": 62434402, "filename": "/docs/mask.png"}, {"audio": 0, "start": 62434402, "crunched": 0, "end": 62546152, "filename": "/docs/win.png"}, {"audio": 0, "start": 62546152, "crunched": 0, "end": 62548723, "filename": "/docs/report+mp0005.log"}, {"audio": 0, "start": 62548723, "crunched": 0, "end": 62550273, "filename": "/docs/report+mp0002.mp"}, {"audio": 0, "start": 62550273, "crunched": 0, "end": 62552844, "filename": "/docs/report+mp0003.log"}, {"audio": 0, "start": 62552844, "crunched": 0, "end": 62553899, "filename": "/docs/report.toc"}, {"audio": 0, "start": 62553899, "crunched": 0, "end": 62582253, "filename": "/docs/report+mp0002.mps"}, {"audio": 0, "start": 62582253, "crunched": 0, "end": 62582830, "filename": "/docs/report.bbl"}, {"audio": 0, "start": 62582830, "crunched": 0, "end": 62584723, "filename": "/docs/report+mp0001.mp"}, {"audio": 0, "start": 62584723, "crunched": 0, "end": 62587980, "filename": "/docs/report+mp0003.mps"}, {"audio": 0, "start": 62587980, "crunched": 0, "end": 62623875, "filename": "/docs/report+mp0001.mps"}, {"audio": 0, "start": 62623875, "crunched": 0, "end": 62629033, "filename": "/docs/report+mp0004.mps"}, {"audio": 0, "start": 62629033, "crunched": 0, "end": 62629644, "filename": "/docs/report.bib"}, {"audio": 0, "start": 62629644, "crunched": 0, "end": 62632215, "filename": "/docs/report+mp0004.log"}, {"audio": 0, "start": 62632215, "crunched": 0, "end": 62632610, "filename": "/docs/report+mp0003.mp"}, {"audio": 0, "start": 62632610, "crunched": 0, "end": 62649568, "filename": "/docs/report.tex"}, {"audio": 0, "start": 62649568, "crunched": 0, "end": 62675159, "filename": "/docs/report+mp0005.mps"}, {"audio": 0, "start": 62675159, "crunched": 0, "end": 62677972, "filename": "/docs/report.aux"}, {"audio": 0, "start": 62677972, "crunched": 0, "end": 62679378, "filename": "/docs/report+mp0005.mp"}, {"audio": 0, "start": 62679378, "crunched": 0, "end": 62680560, "filename": "/docs/report.blg"}, {"audio": 0, "start": 62680560, "crunched": 0, "end": 62980518, "filename": "/docs/screenshot.png"}, {"audio": 0, "start": 62980518, "crunched": 0, "end": 62980579, "filename": "/docs/Makefile"}, {"audio": 0, "start": 62980579, "crunched": 0, "end": 63008131, "filename": "/fonts/visitor1.ttf"}, {"audio": 0, "start": 63008131, "crunched": 0, "end": 63171219, "filename": "/sprites/matt/rest.png"}, {"audio": 0, "start": 63171219, "crunched": 0, "end": 63367164, "filename": "/sprites/matt/hit_high.png"}, {"audio": 0, "start": 63367164, "crunched": 0, "end": 63396102, "filename": "/sprites/matt/crouchwalk.png"}, {"audio": 0, "start": 63396102, "crunched": 0, "end": 63535965, "filename": "/sprites/matt/punchl.png"}, {"audio": 0, "start": 63535965, "crunched": 0, "end": 63723473, "filename": "/sprites/matt/win.png"}, {"audio": 0, "start": 63723473, "crunched": 0, "end": 63845883, "filename": "/sprites/matt/walk.png"}, {"audio": 0, "start": 63845883, "crunched": 0, "end": 63951701, "filename": "/sprites/matt/crouch.png"}, {"audio": 0, "start": 63951701, "crunched": 0, "end": 64147122, "filename": "/sprites/matt/fall.png"}, {"audio": 0, "start": 64147122, "crunched": 0, "end": 64252472, "filename": "/sprites/matt/jump.png"}, {"audio": 0, "start": 64252472, "crunched": 0, "end": 64434580, "filename": "/sprites/matt/kick.png"}, {"audio": 0, "start": 64434580, "crunched": 0, "end": 64690704, "filename": "/sprites/hashim/rest.png"}, {"audio": 0, "start": 64690704, "crunched": 0, "end": 64823874, "filename": "/sprites/hashim/hit_high.png"}, {"audio": 0, "start": 64823874, "crunched": 0, "end": 64889025, "filename": "/sprites/hashim/crouchwalk.png"}, {"audio": 0, "start": 64889025, "crunched": 0, "end": 65030713, "filename": "/sprites/hashim/punchl.png"}, {"audio": 0, "start": 65030713, "crunched": 0, "end": 65142463, "filename": "/sprites/hashim/win.png"}, {"audio": 0, "start": 65142463, "crunched": 0, "end": 65418727, "filename": "/sprites/hashim/walk.png"}, {"audio": 0, "start": 65418727, "crunched": 0, "end": 65552186, "filename": "/sprites/hashim/crouch.png"}, {"audio": 0, "start": 65552186, "crunched": 0, "end": 65692814, "filename": "/sprites/hashim/fall.png"}, {"audio": 0, "start": 65692814, "crunched": 0, "end": 66013857, "filename": "/sprites/hashim/jump.png"}, {"audio": 0, "start": 66013857, "crunched": 0, "end": 66182028, "filename": "/sprites/hashim/kick.png"}, {"audio": 0, "start": 66182028, "crunched": 0, "end": 66347944, "filename": "/sprites/wenkai/rest.png"}, {"audio": 0, "start": 66347944, "crunched": 0, "end": 66468894, "filename": "/sprites/wenkai/hit_high.png"}, {"audio": 0, "start": 66468894, "crunched": 0, "end": 66601659, "filename": "/sprites/wenkai/crouchwalk.png"}, {"audio": 0, "start": 66601659, "crunched": 0, "end": 66798211, "filename": "/sprites/wenkai/punchl.png"}, {"audio": 0, "start": 66798211, "crunched": 0, "end": 66902619, "filename": "/sprites/wenkai/win.png"}, {"audio": 0, "start": 66902619, "crunched": 0, "end": 67065233, "filename": "/sprites/wenkai/walk.png"}, {"audio": 0, "start": 67065233, "crunched": 0, "end": 67179140, "filename": "/sprites/wenkai/crouch.png"}, {"audio": 0, "start": 67179140, "crunched": 0, "end": 67303339, "filename": "/sprites/wenkai/fall.png"}, {"audio": 0, "start": 67303339, "crunched": 0, "end": 67449872, "filename": "/sprites/wenkai/jump.png"}, {"audio": 0, "start": 67449872, "crunched": 0, "end": 67565322, "filename": "/sprites/wenkai/kick.png"}, {"audio": 0, "start": 67565322, "crunched": 0, "end": 67566879, "filename": "/images/bg2.png"}, {"audio": 0, "start": 67566879, "crunched": 0, "end": 67575343, "filename": "/images/matt2.png"}, {"audio": 0, "start": 67575343, "crunched": 0, "end": 67928751, "filename": "/images/bg1.png"}, {"audio": 0, "start": 67928751, "crunched": 0, "end": 67946012, "filename": "/images/matt1.png"}, {"audio": 0, "start": 67946012, "crunched": 0, "end": 67956981, "filename": "/images/wenkai2.png"}, {"audio": 0, "start": 67956981, "crunched": 0, "end": 67979047, "filename": "/images/hash1.png"}, {"audio": 0, "start": 67979047, "crunched": 0, "end": 67998959, "filename": "/images/wenkai1.png"}, {"audio": 0, "start": 67998959, "crunched": 0, "end": 68012012, "filename": "/images/hash2.png"}], "remote_package_size": 68012012, "package_uuid": "a9877302-cb98-4dbb-bf93-69f17ab3d69f"});

})();
