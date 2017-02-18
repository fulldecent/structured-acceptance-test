'use babel'

import {CompositeDisposable} from 'atom'

const linterName = 'example-process'
let subscriptions

export function activate() {
    subscriptions = new CompositeDisposable()
}

export function deactivate() {
    subscriptions.dispose()
}

export function consumeLinter(indieRegistry) {
    const linter = indieRegistry.register({
        name: linterName,
    })
    subscriptions.add(linter)

    var exec = require('child_process').exec;
    var linterProcess = exec(linterName + ' ' + atom.workspace.getActiveTextEditor().getPath());
    var stat = null;

    linterProcess.stdout.on('data', function (data) {
        var statObj = parseSTATJson(data);

        if (statObj) {
            if (stat) {
                if (!stat.findings)
                    stat.findings = [];
                if (Object.prototype.toString.call(statObj) === '[object Array]') {
                    statObj.forEach(function (el) {
                        stat.findings.push(el);
                    });
                }
                else if (isFinding(statObj))
                    stat.findings.push(statObj);
            } else {
                linter.deleteMessages()
                stat = statObj;
            }
        }
        if (stat) {
            var messages = [];
            stat.findings.forEach(function (el) {
                var location = [];
                if (el.location) {
                    console.log(el.location);
                    if (el.location.beginLine && el.location.endLine) {
                        if (el.location.beginColumn && el.location.endColumn)
                            location = [
                                [el.location.beginLine, el.location.beginColumn],
                                [el.location.endLine, el.location.endColumn]
                            ];
                        else {
                            location = [
                                [el.location.beginLine, 0],
                                [el.location.endLine, 0]
                            ];
                        }
                    }
                }

                messages.push({
                    type: el.failure ? 'Error' : 'Warning',
                    text: el.description,
                    range: location,
                    filePath: atom.workspace.getActiveTextEditor().getPath(),
                });
            });

            linter.setMessages(messages);
        }
    });

    linterProcess.stderr.on('data', function (data) {
        console.log('stderr: ' + data.toString());
    });
}

function isFinding(statObj) {
    return statObj != null && statObj.failure != null && statObj.rule != null && statObj.description != null;
}

function parseSTATJson(str) {
    if (isJson(str = str.trim()))
        return JSON.parse(str);
    if (isJson(str = str.replace(/~+$/, '')))
        return JSON.parse(str);
    if (isJson(str + "]}"))
        return JSON.parse(str + "]}");
    if (isJson('{ "findings" : [' + str))
        return JSON.parse('{ "findings" : [' + str).findings;
    return false;
}

function isJson(str) {
    try {
        return JSON.parse(str);
    }
    catch (e) {
        return false;
    }
}
