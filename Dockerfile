FROM ghcr.io/actions/actions-runner:latest

COPY  scripts/tools.sh ./tools.sh
RUN sudo chmod +x *.sh
ENV PATH="/home/runner/.local/bin:$PATH"
RUN ./tools.sh
CMD ["/bin/bash"]
