const optionInput = document.getElementById('optionInput');
const addBtn = document.getElementById('addBtn');
const optionsList = document.getElementById('options');
const emptyMsg = document.getElementById('emptyMsg');
const wheel = document.getElementById('wheel');
const wheelContainer = document.getElementById('wheelContainer');
const spinBtn = document.getElementById('spinBtn');
const resultSection = document.getElementById('resultSection');
const resultValue = document.getElementById('resultValue');

const API = '/api';

async function loadOptions() {
  const res = await fetch(`${API}/options`);
  const data = await res.json();
  renderOptions(data);
  updateWheelSegments(data);
  spinBtn.disabled = data.length === 0;
}

function renderOptions(options) {
  optionsList.innerHTML = '';
  emptyMsg.hidden = options.length > 0;
  options.forEach((opt) => {
    const li = document.createElement('li');
    li.innerHTML = `<span>${escapeHtml(opt.text)}</span><button class="remove" data-id="${escapeHtml(opt.id)}" aria-label="Remove">×</button>`;
    optionsList.appendChild(li);
  });
  document.querySelectorAll('.options-list .remove').forEach((btn) => {
    btn.addEventListener('click', () => removeOption(btn.dataset.id));
  });
}

function escapeHtml(s) {
  const div = document.createElement('div');
  div.textContent = s;
  return div.innerHTML;
}

const SEGMENT_COLORS = ['#e94560', '#0f3460', '#533483', '#2ec96a', '#ffc93c', '#ff6b6b', '#4ecdc4', '#95e1d3'];

function updateWheelSegments(options) {
  wheel.className = 'wheel';
  const svg = wheel.querySelector('.wheel-svg');
  if (!svg) return;
  svg.innerHTML = '';
  if (options.length === 0) return;
  const cx = 110;
  const cy = 110;
  const r = 98;
  const n = options.length;
  const startOffset = -90; // first segment starts at top
  for (let i = 0; i < n; i++) {
    const angleStart = startOffset + (i * 360 / n);
    const angleEnd = startOffset + ((i + 1) * 360 / n);
    const radStart = (angleStart * Math.PI) / 180;
    const radEnd = (angleEnd * Math.PI) / 180;
    const x1 = cx + r * Math.cos(radStart);
    const y1 = cy + r * Math.sin(radStart);
    const x2 = cx + r * Math.cos(radEnd);
    const y2 = cy + r * Math.sin(radEnd);
    const largeArc = angleEnd - angleStart > 180 ? 1 : 0;
    const d = `M ${cx} ${cy} L ${x1} ${y1} A ${r} ${r} 0 ${largeArc} 1 ${x2} ${y2} Z`;
    const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('d', d);
    path.setAttribute('fill', SEGMENT_COLORS[i % SEGMENT_COLORS.length]);
    svg.appendChild(path);
    const midAngle = (angleStart + angleEnd) / 2;
    const midRad = (midAngle * Math.PI) / 180;
    const labelRadius = 58;
    const tx = cx + labelRadius * Math.cos(midRad);
    const ty = cy + labelRadius * Math.sin(midRad);
    const text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
    text.setAttribute('x', tx);
    text.setAttribute('y', ty);
    text.setAttribute('transform', `rotate(${midAngle}, ${tx}, ${ty})`);
    const label = options[i].text.length > 12 ? options[i].text.slice(0, 11) + '…' : options[i].text;
    text.textContent = label;
    svg.appendChild(text);
  }
}

async function addOption() {
  const text = optionInput.value.trim();
  if (!text) return;
  try {
    await fetch(`${API}/options`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ text }),
    });
    optionInput.value = '';
    loadOptions();
  } catch (e) {
    console.error(e);
  }
}

async function removeOption(id) {
  try {
    await fetch(`${API}/options/${id}`, { method: 'DELETE' });
    loadOptions();
  } catch (e) {
    console.error(e);
  }
}

async function spin() {
  const res = await fetch(`${API}/spin`);
  if (!res.ok) return;
  const pick = await res.json();
  const options = await fetch(`${API}/options`).then((r) => r.json());
  const index = options.findIndex((o) => o.id === pick.id);
  const segmentAngle = 360 / options.length;
  const targetAngle = 360 * 4 + (options.length - index - 1) * segmentAngle + segmentAngle / 2;
  const currentRotation = (wheel.style.transform && parseFloat(wheel.style.transform.replace(/[^0-9.-]/g, ''))) || 0;
  wheel.classList.add('spinning');
  wheel.style.transform = `rotate(${currentRotation + targetAngle}deg)`;
  setTimeout(() => {
    wheel.classList.remove('spinning');
    resultValue.textContent = pick.text;
    resultValue.classList.add('reveal');
    resultValue.addEventListener('animationend', () => resultValue.classList.remove('reveal'), { once: true });
  }, 3000);
}

addBtn.addEventListener('click', addOption);
optionInput.addEventListener('keydown', (e) => e.key === 'Enter' && addOption());
spinBtn.addEventListener('click', spin);

loadOptions();
