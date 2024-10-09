FROM ghcr.io/actions/actions-runner:2.320.0

COPY  scripts/tools.sh ./tools.sh
RUN sudo chmod +x *.sh
RUN ./tools.sh

CMD ["/bin/bash"]