import socket
import threading
import queue

#not using this anymore!!!!!!!!!!!!!!!!!!!!
class SonoptixUDP:
    def __init__(self, ip, port):
        self.ip = ip
        self.port = port
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.sock.bind((self.ip, self.port))
        self.frame_queue = queue.Queue()
        self.running = True
        self.thread = threading.Thread(target=self.receive_data)
        self.thread.start()

    def receive_data(self):
        while self.running:
            data, addr = self.sock.recvfrom(65536)  # Adjust buffer size as needed
            if data:
                self.frame_queue.put(data)

    def get_frame(self):
        try:
            return self.frame_queue.get_nowait()
        except queue.Empty:
            return None

    def stop(self):
        self.running = False
        self.thread.join()
        self.sock.close()
