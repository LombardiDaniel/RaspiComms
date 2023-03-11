#ifndef INTER_RASPI_COMM_HPP
#define INTER_RASPI_COMM_HPP

#include <thread>

#include <zmq.hpp>

#include "utils.hpp"


#define DEFAULT_ZSOCKET_PORT                             5555
#define DEFAULT_CONN_PROTOCOL                           "tcp"
#define ENDPOINT_STR_MAX_LEN                              100
#define DEAFULT_REQ_MSG                                   "R"


class RaspiComm {
public:
    struct msgStruct {
        float ang;
        float dist;
        float c;
        float d;
    };
    enum CommType : unsigned short {CONTROL = 0, IMG_PROCESSING};
    RaspiComm(unsigned short endType);
    ~RaspiComm();

    void setStructVal(RaspiComm::msgStruct &msg);
    void initService(const char *endpointIp, unsigned int port);
    void initService(RaspiComm::msgStruct &firstMsg, const char *endpointIp, unsigned int port);
    RaspiComm::msgStruct getStruct();

private:
    utils::Logger logger;
    unsigned short endType;
    msgStruct *sharedThreadStruct;
    std::string endpointIp;
    zmq::socket_t requester;
    zmq::socket_t responder;

    static void hangingZmqThread(RaspiComm::msgStruct *msg, zmq::socket_t *responder);
    // static void hangingZmqThread(RaspiComm::msgStruct *msg);
    void checkCommEndType(unsigned short neededEndType);


};

#endif
