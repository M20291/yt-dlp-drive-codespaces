import https from 'https';

const GITHUB_TOKEN = process.env.GITHUB_TOKEN;
const REPO_OWNER = process.env.REPO_OWNER || 'M20291';
const REPO_NAME = process.env.REPO_NAME || 'yt-dlp-drive-codespaces';

async function makeRequest(path, method, data = null) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'api.github.com',
      path: path,
      method: method,
      headers: {
        'Authorization': `token ${GITHUB_TOKEN}`,
        'User-Agent': 'YouTube-Downloader-Trigger',
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.github.v3+json'
      }
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => {
        try {
          resolve(JSON.parse(body));
        } catch (e) {
          resolve(body);
        }
      });
    });

    req.on('error', reject);

    if (data) {
      req.write(JSON.stringify(data));
    }

    req.end();
  });
}

async function triggerDownload(videoUrl, platform = 'youtube', cookies = '') {
  if (!GITHUB_TOKEN) {
    console.error('ג GITHUB_TOKEN environment variable is required');
    console.log('Please set: export GITHUB_TOKEN=your_token');
    process.exit(1);
  }

  try {
    console.log('נ€ Starting download trigger...');
    console.log('נ”— Video URL:', videoUrl);
    console.log('נ¥ Platform:', platform);
    console.log('נ× Cookies:', cookies ? 'Provided' : 'Not provided');

    // Update config.json with the parameters
    console.log('נ“ Updating config.json...');
    const configContent = JSON.stringify({
      video_url: videoUrl,
      platform: platform,
      cookies: cookies
    });

    const encodedConfig = Buffer.from(configContent).toString('base64');

    // Get current config file info
    const currentConfig = await makeRequest(
      `/repos/${REPO_OWNER}/${REPO_NAME}/contents/config.json`,
      'GET'
    );

    await makeRequest(
      `/repos/${REPO_OWNER}/${REPO_NAME}/contents/config.json`,
      'PUT',
      {
        message: 'Update config for download',
        content: encodedConfig,
        sha: currentConfig.sha
      }
    );

    console.log('ג… Config updated successfully');

    // Create codespace
    console.log('נ€ Creating codespace...');
    const codespaceData = {
      name: `yt-dlp-${Date.now()}`,
      repository: `${REPO_OWNER}/${REPO_NAME}`,
      devcontainer_path: '.devcontainer/devcontainer.json'
    };

    const codespaceResponse = await makeRequest(
      `/repos/${REPO_OWNER}/${REPO_NAME}/codespaces`,
      'POST',
      codespaceData
    );

    console.log('ג… Codespace created successfully!');
    console.log('נ“ Codespace name:', codespaceResponse.name);
    console.log('נ”— Codespace URL:', codespaceResponse.web_url);
    console.log('נ“ Codespace ID:', codespaceResponse.id);

    // Wait for codespace to be ready
    console.log('ג³ Waiting for codespace to be ready...');
    await waitForCodespaceReady(codespaceResponse.id);

    console.log('ג… Download process completed!');
    console.log('נ“ Note: The download script should run automatically via postCreateCommand');
    console.log('נ”— Check the codespace for results: ' + codespaceResponse.web_url);

    return codespaceResponse;
  } catch (error) {
    console.error('ג Error triggering download:', error.message);
    process.exit(1);
  }
}

async function waitForCodespaceReady(codespaceId) {
  let ready = false;
  let attempts = 0;
  const maxAttempts = 30; // 5 minutes max

  while (!ready && attempts < maxAttempts) {
    await new Promise(resolve => setTimeout(resolve, 10000)); // Wait 10 seconds
    
    const codespace = await makeRequest(
      `/repos/${REPO_OWNER}/${REPO_NAME}/codespaces/${codespaceId}`,
      'GET'
    );

    if (codespace.state === 'Available' && codespace.ready) {
      ready = true;
    } else {
      attempts++;
      console.log(`ג³ Codespace status: ${codespace.state} (attempt ${attempts}/${maxAttempts})`);
    }
  }

  if (!ready) {
    throw new Error('Codespace did not become ready in time');
  }
}

async function executeCommandInCodespace(codespaceId, command) {
  // This would require SSH access or Codespaces API for command execution
  // For now, we'll rely on the postCreateCommand
  console.log('נ“ Note: Script execution depends on postCreateCommand');
  console.log('נ”— Check the codespace logs for progress');
}

// Get parameters from command line
const videoUrl = process.argv[2];
const platform = process.argv[3] || 'youtube';
const cookies = process.argv[4] || '';

if (!videoUrl) {
  console.error('ג Please provide a video URL');
  console.log('Usage: node trigger_download.js <video_url> [platform] [cookies]');
  process.exit(1);
}

triggerDownload(videoUrl, platform, cookies);