SOCKET=$TEMPDIR/$USER
PORT=8888
PORT1=7797
SERVERHOST=incline256.itservices.manchester.ac.uk
ssh -S $SOCKET -L${PORT}:localhost:${PORT1} -t -X $SERVERHOST "PORT2=${PORT} start-jupyter-notebook-ver-dc.sh ${PORT1} $ANACONDAVER && exit"
