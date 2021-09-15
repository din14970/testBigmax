# start from a base image providing conda
FROM continuumio/miniconda3
# add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]
# install the necessary dependencies
RUN conda install -c conda-forge hyperspy=1.6.4 scikit-learn=0.24.2 atomap=0.3.1 beautifulsoup4=4.10.0 elabapy=0.8.2
# copy all the necessary files into the container
RUN mkdir notebook && mkdir notebook/data
WORKDIR notebook/
COPY analysis.ipynb .
RUN wget https://owncloud.gwdg.de/index.php/s/utJfj0388mp8W1S/download -O data/dataset.emd
# command that runs when we spin up the container
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
