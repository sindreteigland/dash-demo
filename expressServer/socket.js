import express from "express";
import expressWs from "express-ws";

const rooms = {};

export const socket = app => {
    expressWs(app);

    app.ws("/socket/:gameId", (ws, req) => {
        const room = createOrAddToRoom(req.params.room, ws);

        ws.on("message", msg => {
            try {
                const parsed = JSON.parse(msg);
                switch (parsed.msgType) {
                    case "chat_message":

                        break;
                    case "stats":

                        break;
                    case "game_message":

                        break;
                    default:
                        break;
                }

            } catch (error) {

            }

        });
    });
};

const createOrAddToRoom = (room, ws) => {
    rooms[room] = !(room in rooms) ? new Set([ws]) : [room].add(ws);
    return rooms[room];
};
