##########################################
#  _____  ___   __  __                _  # 
# /__   \/ __\ / / / _\ ___ _ __   __| | #
#   / /\/ /   / /  \ \ / _ \ '_ \ / _` | #
#  / / / /___/ /____\ \  __/ | | | (_| | #
#  \/  \____/\____/\__/\___|_| |_|\__,_| #
#                Versão 2.0 por Smurf    #
##########################################
# Credits: moto x kNocA`is`geil x dollar #
# Quel x ^Mari x Malaria x Friend x Bull #
# firehell x onkko                       #
##########################################


# Configure Corretamente, respeitando as letras maiusculas e minusculas:

#Aqui coloque o arquivo de configuração do bot:
#Ex: set conf "eggdrop.conf"

set conf "Smurf.conf"

#Aqui coloque o NICK do bot:
#Ex: set probobot "EggDrop"

set probot "Smurf"

#Aqui Coloque o EMAIL de contato da empresa:
#Ex: set mailz "contato@botplus.com"


####################################################################
# *************** A partir daqui, não altere nada. *************** #
####################################################################


bind dcc m addtcl addtcl
bind dcc m listtcl tcls
bind dcc m deltcl deltcl

proc addtcl {hand idx args} {
	if {[lindex [lindex $args 0] 0] == ""}  {
		putdcc $idx "15(5TCL2Send15)7 Erro. Comando:2 .addtcl NOMEDATCL.tcl"
    		return 0
	}
  	global conf
        global mailz
  	set file [open $conf a] 
	puts $file "source dccscripts/$args" 
	close $file
	putdcc $idx "15(5TCL2Send15)7 TCL implementada."
	putdcc $idx "15(5TCL2Send15)7 Reiniciando arquivo de configuração..."
	putdcc $idx "15(5TCL2Send15)2 Se seu bot cair nesse momento, um erro foi detectado na tcl adicionada. Envie um email imediatamente 15(7 $mailz 15)2 para que o bot seja reativado."
	rehash
	putdcc $idx "15(5TCL2Send15)7 TCL adicionada com sucesso." 
} 

proc tcls {hand idx args} {
	set n 0
	putdcc $idx "15(5TCL2Send15)7 Lista de TCLs:"
	global conf
	foreach blah [split [read [open $conf r]] \n] {
		if {[string match "source *" $blah]} {
			incr n
			set merda "7(2 $n 7)5 $blah"
			putdcc $idx "$merda"
  		}
	}
	putdcc $idx "15(5TCL2Send15)7 Fim da lista. Para apagar, digite:2 .deltcl NUMERO"
        putdcc $idx "15(5TCL2Send15)2 Para saber o numero, observe ao lado esquerdo da linha que corresponde a tcl desejada."
}

proc deltcl {hand idx args} { 
  if {[lindex $args 0] == ""} { 
    putdcc $idx "15(5TCL2Send15)7 Erro. Comando:2 .deltcl NUMERO" 
    putdcc $idx "15(5TCL2Send15)2 Para saber o numero, observe ao lado esquerdo da linha que corresponde a tcl desejada."
    return 0 
  } 

  global conf 
  set confz $conf.temp 
  set a [open $conf r] 
  set b [open $confz w] 
  set x 0 
  while {[eof $a] != 1} { 
      set msg [gets $a] 
       if {[string match "source *" $msg]} { 
        incr x 
        set msgz "$msg" 
        if {$x != [lindex $args 0]} { 
          puts $b $msgz 
        } else { 
          set m "$x $msgz" 
        } 
           }  else {
               puts $b $msg
}
  } 

  close $a 
  close $b 

  if {[info exists m]} { 
    exec cp $confz $conf 
    putdcc $idx "15(5TCL2Send15)7 Apagado numero2 [lindex $m 0] 7que corresponde a:2 [lrange $m 1 end] " 
  putdcc $idx "15(5TCL2Send15)7 Reiniciando arquivo de configuração..."
  putdcc $idx "15(5TCL2Send15)7 Reconectando ao servidor..."
  restart
  putdcc $idx "15(5TCL2Send15)7 TCL apagada."
  } else { 
    putdcc $idx "15(5TCL2Send15)7 TCL não encontrada." 
  } 

  file delete bots/$confz 
} 

bind dcc - tclsend dcc_tclsend
proc dcc_tclsend {hand idx arg} {
global botnick
putdcc $idx "       5B2ot5P2lus14:7 Arquivo de ajuda ao TCLSend"
putdcc $idx "7.2addtcl NOMEDATCL 15x5 Adiciona uma tcl ao bot."
putdcc $idx "7.2listtcl 15x5 Lista todas as tcls carregadas, incluindo um numero ao lado."
putdcc $idx "7.2deltcl NUMERO 15x5 Descarrega uma tcl do bot."
putdcc $idx "8,5Antes de adicionar alguma tcl, você precisa digitar 7/say !Permitir8 e enviar a tcl pro bot chamado 11EnvieTCLs8.0 Tenha sempre certeza de que sua tcl não tem bugs e está configurada corretamente."
putdcc $idx "4NUNCA APAGUE O tclsendMEUNICK.tcl"
}


putlog "15(5TCL2Send15)2 Versão 2.0 por 7Smurf2 para $probot"

