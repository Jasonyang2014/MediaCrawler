
let socket = io();

socket.on('connect', function () {
    console.log('Connected to server');
});

socket.on('searchStatus', function (data) {
    console.log('Search status:', data.message);
    updateStatus(data.message)
});

socket.on('searchResult', function (data) {
    console.log('Search result:', data.results);
    displayResults(data.results)
});

// 发起搜索
function startSearch(keywords) {
    console.log("search keywords ", keywords)
    socket.emit('search', {data: {keywords: keywords}});
}


document.getElementById('searchForm').addEventListener('submit', function (event) {
    event.preventDefault();

    const formData = new FormData(this);
    const jsonData = {};
    formData.forEach((value, key) => {
        jsonData[key] = value;
    });

    fetch('/run', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(jsonData),
    })
        .then(response => response.json())
        .then(data => {
            console.log('Success:', data);
            alert('搜索任务提交成功！');
            startSearch(JSON.stringify(jsonData))
        })
        .catch((error) => {
            console.error('Error:', error);
            alert('提交搜索任务时发生错误。');
        });
});


function updateStatus(message) {
    document.getElementById('status').textContent = message;
}


function displayResults(results) {
    const resultsBody = document.getElementById('resultsBody');
    if (results && results.length > 0) {
        results.forEach(function (result) {
            const row = resultsBody.insertRow();
            const idCell = row.insertCell(0);
            const nameCell = row.insertCell(1);
            const keyCell = row.insertCell(2);
            const startCell = row.insertCell(3);
            const endCell = row.insertCell(4);

            idCell.textContent = result.id
            nameCell.textContent = result.name;
            keyCell.textContent = result.keywords;
            startCell.textContent = result.start;
            endCell.textContent = result.end;

        });

    } else {
        resultsBody.innerHTML = '<p>没有找到相关结果。</p>';
    }
}