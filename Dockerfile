FROM ghcr.io/actions/actions-runner:latest

COPY  scripts/tools.sh ./tools.sh
RUN sudo chmod +x *.sh
RUN ./tools.sh

CMD ["/bin/bash"]
