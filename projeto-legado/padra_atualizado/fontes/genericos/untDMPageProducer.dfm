object dmPageProducer: TdmPageProducer
  OldCreateOrder = False
  Height = 150
  Width = 215
  object pageJsonBoaVistaAcerta: TPageProducer
    HTMLDoc.Strings = (
      '<!DOCTYPE html>'
      '<html lang="pt-br">'
      ''
      '<head>'
      '   <title>Retorno Consulta SCPC Boa Vista - Acerta</title>'
      '    <!-- Bootstrap core CSS -->'
      
        '    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.' +
        'com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gV' +
        'Q4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" c' +
        'rossorigin="anonymous">'
      '</head>'
      ''
      '<body class="default" onload="CriarTabela()">'
      '    <div class="container">'
      '        <div class="table-responsive">'
      '        </div>'
      '    </div>'
      ''
      '    <!-- Bootstrap core JavaScript'
      '    ================================================== -->'
      
        '    <!-- Placed at the end of the document so the pages load fas' +
        'ter -->'
      
        '    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.j' +
        's" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp' +
        '4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>'
      
        '    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.j' +
        's/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATL' +
        'dqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="ano' +
        'nymous"></script>'
      
        '    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.' +
        '1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4A' +
        'Hf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonym' +
        'ous"></script>'
      '    <script type="text/javascript">'
      '        function CriarTabela() {'
      '            var objJson = #JsonValue ; '
      ''
      '            //Montando Tabela com Dados Iniciais da Consulta'
      
        '            var content = "<table class='#39'table table-striped tab' +
        'le-bordered table-hover table-sm'#39'>"'
      '            content += "<thead class='#39'thead-dark'#39'><tr>"'
      
        '            content += "<th scope='#39'col'#39' width='#39'400'#39'>Dados Inicia' +
        'is da Consulta</th><th></th></tr></thead>";'
      '            content += "<tbody>";'
      '            for (var propName in objJson) {'
      
        '                if (propName != "Blocos" && propName != "DadosIn' +
        'formados" && objJson[propName] != null) {'
      
        '                    content += '#39'<tr><td class="font-weight-bold"' +
        '>'#39' + InserirEspacos(propName) + '#39'</td>'#39';'
      
        '                    content += '#39'<td>'#39' + objJson[propName].trim()' +
        ' + '#39'</td></tr>'#39';'
      '                }'
      '            }'
      '            content += "</tbody></table>"'
      ''
      '            $('#39'.table-responsive'#39').append(content);'
      ''
      
        '            content = "<table class='#39'table table-striped table-b' +
        'ordered table-hover table-sm'#39'>"'
      '            content += "<thead class='#39'thead-dark'#39'><tr>"'
      
        '            content += "<th scope='#39'col'#39' width='#39'400'#39'>Dados Inform' +
        'ados</th><th></th></tr></thead>";'
      '            content += "<tbody>";'
      '            var dadosInformados = objJson.DadosInformados;'
      '            for (var propName in dadosInformados) {'
      
        '                if (propName != "Blocos" && propName != "DadosIn' +
        'formados" && dadosInformados[propName] != null && dadosInformado' +
        's[propName] != "") {'
      
        '                    content += '#39'<tr><td class="font-weight-bold"' +
        '>'#39' + InserirEspacos(propName) + '#39'</td>'#39';'
      
        '                    content += '#39'<td>'#39' + PegarConteudoTratado(dad' +
        'osInformados[propName], propName) + '#39'</td></tr>'#39';'
      '                }'
      '            }'
      ''
      '            content += "</tbody></table>"'
      ''
      '            $('#39'.table-responsive'#39').append(content);'
      ''
      '            var blocos = objJson.Blocos;'
      '            for (var objBloco in blocos) {'
      '                objResultado = blocos[objBloco];'
      
        '                if (objResultado != null && objResultado.length ' +
        '> 0) {'
      
        '                    content = "<table class='#39'table table-striped' +
        ' table-bordered table-hover table-sm'#39'>"'
      '                    content += "<thead class='#39'thead-dark'#39'><tr>"'
      
        '                    content += "<th scope='#39'col'#39' width='#39'400'#39'>" + ' +
        'InserirEspacos(objBloco).substring(0, InserirEspacos(objBloco).i' +
        'ndexOf('#39'_'#39')) + "</th><th></th></tr></thead>";'
      '                    content += "<tbody>";'
      '                    for (var objDetalhe in objResultado) {'
      '                        obj = objResultado[objDetalhe];'
      '                        for (var propName in obj) {'
      
        '                            if (propName != "Blocos" && propName' +
        ' != "DadosInformados" && obj[propName] != null && obj[propName] ' +
        '!= "") {'
      
        '                                content += '#39'<tr><td class="font-' +
        'weight-bold">'#39' + InserirEspacos(propName) + '#39'</td>'#39';'
      
        '                                content += '#39'<td>'#39' + PegarConteud' +
        'oTratado(obj[propName], propName) + '#39'</td></tr>'#39';'
      '                            }'
      '                        }'
      
        '                        content += '#39'<tr class="table-Secondary">' +
        '<td></td><td></td></tr>'#39';'
      '                    }'
      '                    $('#39'.table-responsive'#39').append(content);'
      '                }'
      '            }'
      '        };'
      ''
      '        String.prototype.mask = function(m) {'
      '            var m, l = (m = m.split("")).length,'
      '                s = this.split(""),'
      '                j = 0,'
      '                h = "";'
      '            for (var i = -1; ++i < l;)'
      '                if (m[i] != "#") {'
      '                    if (m[i] == "\\" && (h += m[++i])) continue;'
      '                    h += m[i];'
      '                    i + 1 == l && (s[j - 1] += h, h = "");'
      '                }'
      '            else {'
      '                if (!s[j] && !(h = "")) break;'
      '                (s[j] = h + s[j++]) && (h = "");'
      '            }'
      '            return s.join("") + h;'
      '        };'
      ''
      '        function PegarConteudoTratado(Conteudo, Nome) {'
      '            if (Nome == "TipoCredito") {'
      '                switch (Conteudo) {'
      '                    case "OU":'
      '                        return "OU - Outros";'
      '                        break;'
      '                    case "CH":'
      '                        return "CH '#8211' Cheque";'
      '                        break;'
      '                    case "CV":'
      '                        return "CV '#8211' Cr'#233'dito Ve'#237'culo";'
      '                        break;'
      '                    case "CC":'
      '                        return "CC '#8211' Cart'#227'o de Cr'#233'dito";'
      '                        break;'
      '                    case "CP":'
      '                        return "CP - Cr'#233'dito Pessoal";'
      '                        break;'
      '                    case "CD":'
      '                        return "CD - Cr'#233'dito Direto";'
      '                        break;'
      '                }'
      '            } else if (Nome == "Produto") {'
      '                switch (Conteudo) {'
      '                    case "S":'
      '                        return "SCPC Completo";'
      '                        break;'
      '                    case "N":'
      '                        return "SCPC";'
      '                        break;    '
      '                }'
      '            } else if (Nome == "TipoScore") {'
      '                switch (Conteudo) {'
      '                    case "1":'
      '                        return "PF";'
      '                        break;'
      '                    case "2":'
      '                        return "PJ";'
      '                        break;    '
      '                }    '
      '            } else if (Nome == "Registro") {'
      '                switch (Conteudo) {'
      '                    case "S":'
      '                        return "Existe";'
      '                        break;'
      '                    case "N":'
      '                        return "N'#227'o Existe";'
      '                        break;    '
      '                }'
      '            } else if (Nome == "PlanoExecucao") {'
      '                switch (Conteudo) {'
      '                    case "S":'
      '                        return "Sim";'
      '                        break;'
      '                    case "N":'
      '                        return "N'#227'o";'
      '                        break;    '
      '                }    '
      '            } else if (Nome == "TipoOcorrencia") {'
      '                switch (Conteudo) {'
      '                    case "RG":'
      '                        return "RG - Registrado";'
      '                        break;'
      '                    case "IA":'
      
        '                        return "IA - Imob. e Administra'#231#227'o de Be' +
        'ns";'
      '                        break;'
      '                    case "EC":'
      '                        return "EC - Cons'#243'rcio";'
      '                        break;'
      '                    case "AL":'
      '                        return "AL - Locadora";'
      '                        break;'
      '                    case "SF":'
      '                        return "SF - Emp. Cr'#233'dito Imobili'#225'rio";'
      '                        break;'
      '                    case "OJ":'
      '                        return "OJ - Outras Ativ. Econ'#244'micas";'
      '                        break;'
      '                    case "TP":'
      '                        return "TP - T'#237'tulo Protestado";'
      '                        break;    '
      '                }    '
      '            } else if (Nome.indexOf("Data") >= 0) {'
      '                if (Conteudo == "00000000"){'
      '                    return "";'
      '                } else {'
      '                    return Conteudo.mask("##/##/####") ;'
      '                }            '
      '            } else if (Nome == "Valor") {'
      '                var v = parseFloat(Conteudo);'
      '                if (!isNaN(v)) {'
      '                    v = v / 100;                    '
      '                    return NumeroParaReal(v);;'
      '                }'
      '            } else if (Nome == "Probabilidade") {'
      '                var v = parseFloat(Conteudo);'
      '                if (!isNaN(v)) {'
      '                    v = v / 100;                    '
      '                    return NumeroParaReal(v);;'
      '                }    '
      '            } else if (Nome == "CPF" || Nome == "CNPJ") {'
      '                if (Conteudo.length <= 11) {'
      '                    return Conteudo.mask("###.###.###-##")'
      '                } else {'
      '                    return Conteudo.mask("##.###.###/####-##")'
      '                }'
      ''
      '            };'
      ''
      '            return Conteudo;'
      '        }'
      ''
      '        function NumeroParaReal(numero) {'
      '            var numero = numero.toFixed(2).split('#39'.'#39');'
      
        '            numero[0] = numero[0].split(/(?=(?:...)*$)/).join('#39'.' +
        #39');'
      '            return numero.join('#39','#39');'
      '        }'
      ''
      '        function InserirEspacos(string) {'
      '            string = string.replace(/([a-z])([A-Z])/g, '#39'$1 $2'#39');'
      
        '            string = string.replace(/([A-Z])([A-Z][a-z])/g, '#39'$1 ' +
        '$2'#39')'
      '            return string;'
      '        }'
      ''
      '    </script>'
      ''
      '</body>'
      ''
      '</html>')
    Left = 48
    Top = 8
  end
end
