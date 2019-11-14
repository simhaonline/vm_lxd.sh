### Script shell para configurar um laboratório de VM LXD (Linux Containers) para fins de teste.


Esse script shell de amostra para criar um laboratório de VM LXD (Linux Containers) 
no servidor Ubuntu Linux 16.04 ou 18.04 LTS.

### Como eu uso esse script?

Primeiro instale e configure o servidor LXD conforme descrito aqui no Ubuntu 16.04 ou configure o LXD no servidor Ubuntu 18.04 LTS ou superior (consulte Como configurar o LXD no Fedora Linux 28 ): Edite e personalize a variável de script. 
Uma vez feito, execute-o da seguinte maneira: Resultados de amostra:

```bash
sudo apt-get install lxd
## config your storage like zfs and bridge setup
sudo lxd init


./vm_lxd.sh
```
