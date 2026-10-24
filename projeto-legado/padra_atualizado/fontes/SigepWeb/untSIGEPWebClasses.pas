unit untSIGEPWebClasses;

interface

uses
  System.SysUtils, System.StrUtils, Uni, Vcl.Forms, Generics.Collections,
  Xml.XMLDoc, Xml.XMLIntf;

type
  TXmlPLP = Class(TInterfacedObject)
  Public
    id_plp                : String;
    valor_global          : Double;
    mcu_unidade_postagem  : String;
    nome_unidade_postagem : String;
    cartao_postagem       : string;
    Constructor Create;
  End;

  TXmlRemetente = Class(TInterfacedObject)
  Private
    Function fCidadeEstadoToNumeroDiretoria(strNomCid, strEstado : String):String;
  Public
    numero_contrato       : String;
    numero_diretoria      : String;
    codigo_administrativo : String;
    nome_remetente        : String;
    logradouro_remetente  : String;
    numero_remetente      : String;
    complemento_remetente : String;
    bairro_remetente      : String;
    cep_remetente         : String;
    cidade_remetente      : String;
    uf_remetente          : String;
    telefone_remetente    : String;
    fax_remetente         : String;
    email_remetente       : String;
    cpf_cnpj_remetente    : String;
    Constructor Create;
  End;

  TXmlDestinatario = Class(TInterfacedObject)
  Public
    nome_destinatario        : String;
    telefone_destinatario    : String;
    celular_destinatario     : String;
    email_destinatario       : String;
    logradouro_destinatario  : String;
    complemento_destinatario : String;
    numero_end_destinatario  : String;
    Constructor Create;
  End;

  TXmlNacional = Class(TInterfacedObject)
  Public
    bairro_destinatario   : String;
    cidade_destinatario   : String;
    uf_destinatario       : String;
    cep_destinatario      : String;
    codigo_usuario_postal : String;
    centro_custo_cliente  : String;
    numero_nota_fiscal    : String;
    serie_nota_fiscal     : String;
    valor_nota_fiscal     : Double;
    natureza_nota_fiscal  : String;
    descricao_objeto      : String;
    valor_a_cobrar        : Double;
    Constructor Create;
  End;

  TXmlServicoAdicional = Class(TInterfacedObject)
  Public
    codigo_servico_adicional : String;
    valor_declarado          : Double;
    Constructor Create;
  End;

  TXmlDimensaoObjeto = Class(TInterfacedObject)
  Public
    tipo_objeto          : String;
    dimensao_altura      : Integer;
    dimensao_largura     : Integer;
    dimensao_comprimento : Integer;
    dimensao_diametro    : Integer;
    Constructor Create;
  End;

  TXmlObjetoPostal = Class(TInterfacedObject)
  Public
    numero_etiqueta             : String;
    codigo_objeto_cliente       : String;
    codigo_servico_postagem     : String;
    cubagem                     : Double;
    peso                        : Integer;
    rt1                         : String;
    rt2                         : String;
    Destinatario                : TXmlDestinatario;
    Nacional                    : TXmlNacional;
    ServicoAdicional            : TObjectList<TXmlServicoAdicional>;
    DimensaoObjeto              : TXmlDimensaoObjeto;
    data_postagem_sara          : TDate;
    status_processamento        : String;
    numero_comprovante_postagem : String;
    valor_cobrado               : Double;
    Constructor Create;
  End;

  TXmlCorreiosLog = Class(TInterfacedObject)
  Private
    function fCriaObjetoPostal(strNumDoc, strEspDoc, strSerie, strCodEmp, strCodSer : String): Boolean;
  Public
    tipo_arquivo    : String;
    versao_arquivo  : String;
    plp             : TXmlPLP;
    remetente       : TXmlRemetente;
    forma_pagamento : String;
    objeto_postal   : TObjectList<TXmlObjetoPostal>;
    arrObjetos      : Array Of String; //Lista de Objetos sem o digito verificador.
    strCodPLP       : String;
    Constructor Create(strAutoincrem : String = '');

    function fGetXML(strNomArq : String = '') : String;
  End;

implementation

uses
  untFuncoesSimples, untSIGEPWebFuncoes, untDespacho;

{ TXmlPLP }

constructor TXmlPLP.Create;
  Var
    qryCorCfg : TUniQuery;
begin
  Try
    qryCorCfg := fCriaQuery(Nil);
    With qryCorCfg, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT * FROM CORCFG WHERE CFG_CODEMP = :CODEMP AND CFG_STATUS = "A"');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      id_plp                := '';
      valor_global          := 0;
      mcu_unidade_postagem  := '';
      nome_unidade_postagem := '';
      cartao_postagem       := FieldByName('CFG_NUMCAR').AsString;

    End;
  Finally
    FreeAndNil(qryCorCfg);
  End;
end;

{ TXmlRemetente }

constructor TXmlRemetente.Create;
  Var
    qryCorCfg : TUniQuery;
begin
  Try
    qryCorCfg := fCriaQuery(Nil);
    With qryCorCfg, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT * FROM CORCFG WHERE CFG_CODEMP = :CODEMP AND CFG_STATUS = "A"');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      numero_contrato       := FieldByName('CFG_NUMCON').AsString;
      codigo_administrativo := FieldByName('CFG_NUMADM').AsString;

      Close;
      Clear;
      Add(' SELECT *                                    ');
      Add(' FROM CADEMP                                 ');
      Add(' LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ');
      Add(' WHERE EMP_CODEMP = :CODEMP                  ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      numero_diretoria      := fCidadeEstadoToNumeroDiretoria(FieldByName('CID_NOMCID').AsString,
                                                              FieldByName('CID_ESTADO').AsString);
      nome_remetente        := FieldByName('EMP_NOMEMP').AsString;
      logradouro_remetente  := FieldByName('EMP_ENDERE').AsString;
      numero_remetente      := FieldByName('EMP_ENDNUM').AsString;
      complemento_remetente := FieldByName('EMP_ENDCMP').AsString;
      bairro_remetente      := FieldByName('EMP_BAIRRO').AsString;
      cep_remetente         := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('EMP_C_E_P_').AsString),' ','');
      cidade_remetente      := FieldByName('CID_NOMCID').AsString;
      uf_remetente          := FieldByName('CID_ESTADO').AsString;
      telefone_remetente    := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('EMP_FONE01').AsString),' ','');
      fax_remetente         := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('EMP_F_A_X_').AsString),' ','');
      email_remetente       := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('EMP_EMAIL_').AsString),' ','');
      cpf_cnpj_remetente    := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('EMP_C_G_C_').AsString),' ','');
    End;
  Finally
    FreeAndNil(qryCorCfg);
  End;
end;

function TXmlRemetente.fCidadeEstadoToNumeroDiretoria(strNomCid, strEstado: String): String;
begin
       If strEstado = 'AC' Then Result := '03'
  Else If strEstado = 'AL' Then Result := '04'
  Else If strEstado = 'AM' Then Result := '06'
  Else If strEstado = 'AP' Then Result := '05'
  Else If strEstado = 'BA' Then Result := '08'
  Else If strEstado = 'DF' Then Result := '10'
  Else If strEstado = 'CE' Then Result := '12'
  Else If strEstado = 'ES' Then Result := '14'
  Else If strEstado = 'GO' Then Result := '16'
  Else If strEstado = 'MA' Then Result := '18'
  Else If strEstado = 'MG' Then Result := '20'
  Else If strEstado = 'MS' Then Result := '22'
  Else If strEstado = 'MT' Then Result := '24'
  Else If strEstado = 'PA' Then Result := '28'
  Else If strEstado = 'PB' Then Result := '30'
  Else If strEstado = 'PE' Then Result := '32'
  Else If strEstado = 'PI' Then Result := '34'
  Else If strEstado = 'PR' Then Result := '36'
  Else If strEstado = 'RJ' Then Result := '50'
  Else If strEstado = 'RN' Then Result := '60'
  Else If strEstado = 'RO' Then Result := '26'
  Else If strEstado = 'RR' Then Result := '65'
  Else If strEstado = 'RS' Then Result := '64'
  Else If strEstado = 'SC' Then Result := '68'
  Else If strEstado = 'SE' Then Result := '70'
  Else If strEstado = 'SP' Then
  Begin
    If (UpperCase(strNomCid) = 'SÃO PAULO') Or (UpperCase(strNomCid) = 'SAO PAULO') Then
      Result := '72'
    Else
      Result := '74';
  End
  Else If strEstado = 'TO' Then Result := '75';

{
01 - AC ADMINISTRAÇAO CENTRAL  AC
03 - DR – ACRE                 ACR
04 - DR – ALAGOAS              AL
06 - DR – AMAZONAS             AM
05 - DR – AMAPÁ                AP
08 - DR – BAHIA                BA
10 - DR – BRASÍLIA             BSB
12 - DR – CEARÁ                CE
14 - DR - ESPIRITO SANTO       ES
16 - DR – GOIÁS                GO
18 - DR – MARANHÃO             MA
20 - DR - MINAS GERAIS         MG
22 - DR - MATO GROSSO DO SUL   MS
24 - DR - MATO GROSSO          MT
28 - DR – PARÁ                 PA
30 - DR – PARAÍBA              PB
32 - DR – PERNAMBUCO           PE
34 - DR – PIAUÍ                PI
36 - DR – PARANÁ               PR
50 - DR - RIO DE JANEIRO       RJ
60 - DR - RIO GRANDE DO NORTE  RN
26 - DR – RONDONIA             RO
65 - DR – RORAIMA              RR
64 - DR - RIO GRANDE DO SUL    RS
68 - DR - SANTA CATARINA       SC
70 - DR – SERGIPE              SE
74 - DR - SÃO PAULO INTERIOR   SPI
72 - DR - SÃO PAULO            SPM
75 - DR- TOCANTINS             TO
}
end;

{ TXmlDestinatario }

constructor TXmlDestinatario.Create;
begin
  nome_destinatario        := '';
  telefone_destinatario    := '';
  celular_destinatario     := '';
  email_destinatario       := '';
  logradouro_destinatario  := '';
  complemento_destinatario := '';
  numero_end_destinatario  := '';
end;

{ TXmlNacional }

constructor TXmlNacional.Create;
begin
  bairro_destinatario   := '';
  cidade_destinatario   := '';
  uf_destinatario       := '';
  cep_destinatario      := '';
  codigo_usuario_postal := '';
  centro_custo_cliente  := '';
  numero_nota_fiscal    := '';
  serie_nota_fiscal     := '';
  valor_nota_fiscal     := 0;
  natureza_nota_fiscal  := '';
  descricao_objeto      := '';
  valor_a_cobrar        := 0;
end;

{ TXmlServicoAdicional }

constructor TXmlServicoAdicional.Create;
begin
  codigo_servico_adicional := '025';
  valor_declarado          := 0;
end;

{ TXmlDimensaoObjeto }

constructor TXmlDimensaoObjeto.Create;
begin
  tipo_objeto          := '002';
  dimensao_altura      := 4;
  dimensao_largura     := 11;
  dimensao_comprimento := 16;
  dimensao_diametro    := 0;
end;

{ TXmlObjetoPostal }

constructor TXmlObjetoPostal.Create;
begin
  numero_etiqueta             := '';
  codigo_objeto_cliente       := '';
  codigo_servico_postagem     := '';
  cubagem                     := 0;
  peso                        := 117;
  rt1                         := '';
  rt2                         := '';
  Destinatario                := TXmlDestinatario.Create;
  Nacional                    := TXmlNacional.Create;
  ServicoAdicional            := TObjectList<TXmlServicoAdicional>.Create;
  ServicoAdicional.Add(TXmlServicoAdicional.Create); //Serviço obrigatório (025 - Registro)
  DimensaoObjeto              := TXmlDimensaoObjeto.Create;
  data_postagem_sara          := 0;
  status_processamento        := '0';
  numero_comprovante_postagem := '';
  valor_cobrado               := 0;
end;

{ TXmlCorreiosLog }

constructor TXmlCorreiosLog.Create(strAutoincrem: String);
  Var
    qryPlpDoc : TUniQuery;
begin
  Try
    tipo_arquivo    := 'Postagem';
    versao_arquivo  := '2.3';
    plp             := TXmlPLP.Create;
    remetente       := TXmlRemetente.Create;
    forma_pagamento := '';
    objeto_postal   := TObjectList<TXmlObjetoPostal>.Create;

    qryPlpDoc := fCriaQuery;
    With qryPlpDoc, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT DISTINCT                                  ');
      Add('        PLD_NUMDOC,                               ');
      Add('        PLD_ESPDOC,                               ');
      Add('        PLD_SERIE_,                               ');
      Add('        PLD_EMPDOC,                               ');
      Add('        CSE_CODSER,                               ');
      Add('        PLP_CODIGO                                ');
      Add(' FROM PLPDOC A                                    ');
      Add(' INNER JOIN CORPLP B ON B.AUTOINCREM = PLD_SEQPLP ');
      Add(' INNER JOIN COROBJ C ON C.COB_NUMOBJ = PLD_NUMOBJ ');
      If fEmptyStr(strAutoincrem) Then
      Begin
        Add(' INNER JOIN CORSER D ON D.CSE_CODIGO = COB_CODSER ');
        Add(' WHERE PLP_CODEMP = :CODEMP                       ');
        Add('   AND PLP_DTAENV IS NULL                         ');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
      End
      Else
      Begin
        if fCfgSis('USIGEP', varString) = 'O' then
          Add(' LEFT JOIN CORSER D ON D.CSE_CODIGO = COB_CODSER ')
        else
          Add(' INNER JOIN CORSER D ON D.CSE_CODIGO = COB_CODSER ');

        Add(' WHERE B.AUTOINCREM = :AUTINC ');
        ParamByName('AUTINC').AsString := strAutoincrem;
      End;

      Add(' AND COB_INATVO = "N" ');

      Add(' ORDER BY A.AUTOINCREM                            ');

      Open;

      strCodPLP := FieldByName('PLP_CODIGO').AsString;

      While Not Eof Do
      Begin
        fCriaObjetoPostal(FieldByName('PLD_NUMDOC').AsString,
                          FieldByName('PLD_ESPDOC').AsString,
                          FieldByName('PLD_SERIE_').AsString,
                          FieldByName('PLD_EMPDOC').AsString,
                          FieldByName('CSE_CODSER').AsString);

        Next;
      End;
    End;
  Finally
    FreeAndNil(qryPlpDoc);
  End;
end;

function TXmlCorreiosLog.fCriaObjetoPostal(strNumDoc, strEspDoc, strSerie,
  strCodEmp, strCodSer: String): Boolean;
  Var
    qryPlpDoc : TuniQuery;
    objPostal : TXmlObjetoPostal;
    objSerguro: TXmlServicoAdicional;
begin
  Try
    Result := True;
    qryPlpDoc := fCriaQuery;
    With qryPlpDoc, SQL Do
    Begin
      Close;
      Clear;
      Add( fSQLDespacho(False, fNomTab(strEspDoc), 'C', strNumDoc, strEspDoc, False,  True) );
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      While Not Eof Do
      Begin
        objPostal := TXmlObjetoPostal.Create;

        SetLength(arrObjetos, Length(arrObjetos)+1);
        arrObjetos[High(arrObjetos)] := FieldByName('NUMOBJ').AsString;
        With objPostal Do
        Begin
          numero_etiqueta             := FieldByName('OBJDIG').AsString;
          codigo_objeto_cliente       := FieldByName('OBJDIG').AsString;
          codigo_servico_postagem     := Trim(strCodSer);
          cubagem                     := 0;
          rt1                         := '';
          rt2                         := '';

          With Destinatario Do
          Begin
            nome_destinatario        := LeftStr(FieldByName('NOMCLI').AsString, 50);
            telefone_destinatario    := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('FONCLI').AsString),' ','');
            celular_destinatario     := '';
            email_destinatario       := '';
            logradouro_destinatario  := FieldByName('ENDCLI').AsString;
            complemento_destinatario := FieldByName('ENDCOM').AsString;
            numero_end_destinatario  := '00000';
          End;

          With Nacional Do
          Begin
            bairro_destinatario   := FieldByName('BAICLI').AsString;
            cidade_destinatario   := FieldByName('NOMCID').AsString;
            uf_destinatario       := FieldByName('ESTADO').AsString;
            cep_destinatario      := AnsiReplaceStr(fTiraCaracEspeciaisPonto(FieldByName('CEPCLI').AsString),' ','');
            codigo_usuario_postal := '';
            centro_custo_cliente  := '';
            numero_nota_fiscal    := Copy(FieldByName('NUMDOCXML').AsString, Length(FieldByName('NUMDOCXML').AsString) -7, 8);
            serie_nota_fiscal     := FieldByName('SERDOC').AsString;
            valor_nota_fiscal     := 0;
            natureza_nota_fiscal  := '';
            descricao_objeto      := '';
            valor_a_cobrar        := 0;
          End;

          //ServicoAdicional // Gerado com valores Fixos para o Serviço obrigatório!
          If FieldByName('VALSEG').AsFloat > 0 Then
          Begin

            If Pos('PAC', fRetDescricaoServicoCorreio(strCodSer)) > 0 Then
            Begin
              objSerguro := TXmlServicoAdicional.Create;
              objSerguro.codigo_servico_adicional := '064';
              objSerguro.valor_declarado := FieldByName('VALSEG').AsFloat;
              ServicoAdicional.Add(objSerguro);
            End
            Else
            Begin
              objSerguro := TXmlServicoAdicional.Create;
              objSerguro.codigo_servico_adicional := '019';
              objSerguro.valor_declarado := FieldByName('VALSEG').AsFloat;
              ServicoAdicional.Add(objSerguro);
            End;

          End;

          //DimensaoObjeto; // Gerado com valores Fixos (esta no create da classe)
          data_postagem_sara          := 0;
          status_processamento        := '0';
          numero_comprovante_postagem := '';
          valor_cobrado               := 0;
        End;
        objeto_postal.Add(objPostal);

        Next;
      End;
    End;

  Finally
    FreeAndNil(qryPlpDoc);
  End;
end;

function TXmlCorreiosLog.fGetXML(strNomArq: String): String;
  Var
    XmlDoc : IXmlDocument;
    nodCorLog : IXMLNode;
    nodPLP    : IXMLNode;
    nodRemete : IXMLNode;
    nodObjeto : IXMLNode;
    nodDestin : IXMLNode;
    nodNacion : IXMLNode;
    nodSerAdc : IXMLNode;
    nodDimens : IXMLNode;
    objPostal : TXmlObjetoPostal;
    objServAdc : TXmlServicoAdicional;
begin
  XmlDoc := TXmlDocument.Create(Application);
  XmlDoc.Active := True;
  XmlDoc.Encoding := 'ISO-8859-1';
  Try
    nodCorLog := XmlDoc.AddChild('correioslog');
    nodCorLog.AddChild('tipo_arquivo').Text   := tipo_arquivo;
    nodCorLog.AddChild('versao_arquivo').Text := versao_arquivo;

    nodPLP := nodCorLog.AddChild('plp');
    nodPLP.AddChild('id_plp').Text                := plp.id_plp;
    nodPLP.AddChild('valor_global').Text          := '';//plp.valor_global;
    nodPLP.AddChild('mcu_unidade_postagem').Text  := plp.mcu_unidade_postagem;
    nodPLP.AddChild('nome_unidade_postagem').Text := plp.nome_unidade_postagem;
    nodPLP.AddChild('cartao_postagem').Text       := plp.cartao_postagem;

    nodRemete := nodCorLog.AddChild('remetente');
    nodRemete.AddChild('numero_contrato').Text       := remetente.numero_contrato;
    nodRemete.AddChild('numero_diretoria').Text      := remetente.numero_diretoria;
    nodRemete.AddChild('codigo_administrativo').Text := remetente.codigo_administrativo;
    nodRemete.AddChild('nome_remetente').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( remetente.nome_remetente ));
    nodRemete.AddChild('logradouro_remetente').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( remetente.logradouro_remetente ));
    nodRemete.AddChild('numero_remetente').Text      := remetente.numero_remetente;
    nodRemete.AddChild('complemento_remetente').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( remetente.complemento_remetente ));
    nodRemete.AddChild('bairro_remetente').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( remetente.bairro_remetente ));
    nodRemete.AddChild('cep_remetente').Text         := remetente.cep_remetente;
    nodRemete.AddChild('cidade_remetente').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( remetente.cidade_remetente ));
    nodRemete.AddChild('uf_remetente').Text          := remetente.uf_remetente;
    nodRemete.AddChild('telefone_remetente').Text    := remetente.telefone_remetente;
    nodRemete.AddChild('fax_remetente').Text         := remetente.fax_remetente;
    nodRemete.AddChild('email_remetente').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( remetente.email_remetente ));
    nodRemete.AddChild('cpf_cnpj_remetente').Text    := remetente.cpf_cnpj_remetente;

    nodCorLog.addChild('forma_pagamento').Text := forma_pagamento;

    For objPostal in objeto_postal Do
    Begin
      With objPostal Do
      Begin
        nodObjeto := nodCorLog.addChild('objeto_postal');
        nodObjeto.AddChild('numero_etiqueta').Text         := numero_etiqueta;
        nodObjeto.AddChild('codigo_objeto_cliente').Text   := codigo_objeto_cliente;
        nodObjeto.AddChild('codigo_servico_postagem').Text := codigo_servico_postagem;
        nodObjeto.AddChild('cubagem').Text                 := FormatFloat('0.00', cubagem);
        nodObjeto.AddChild('peso').Text                    := IntToStr(peso);
        nodObjeto.AddChild('rt1').Text                     := rt1;
        nodObjeto.AddChild('rt2').Text                     := rt2;

        nodDestin := nodObjeto.addChild('destinatario');
        nodDestin.AddChild('nome_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Destinatario.nome_destinatario ));
        nodDestin.AddChild('telefone_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Destinatario.telefone_destinatario ));
        nodDestin.AddChild('celular_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Destinatario.celular_destinatario ));
        nodDestin.AddChild('email_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Destinatario.email_destinatario ));
        nodDestin.AddChild('logradouro_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Destinatario.logradouro_destinatario ));
        nodDestin.AddChild('complemento_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Destinatario.complemento_destinatario ));
        nodDestin.AddChild('numero_end_destinatario').Text := Destinatario.numero_end_destinatario;

        nodNacion := nodObjeto.addChild('nacional');
        nodNacion.AddChild('bairro_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Nacional.bairro_destinatario ));
        nodNacion.AddChild('cidade_destinatario').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Nacional.cidade_destinatario ));
        nodNacion.AddChild('uf_destinatario').Text       := Nacional.uf_destinatario;
        nodNacion.AddChild('cep_destinatario').Text      := Nacional.cep_destinatario;
        nodNacion.AddChild('codigo_usuario_postal').Text := Nacional.codigo_usuario_postal;
        nodNacion.AddChild('centro_custo_cliente').Text  := Nacional.centro_custo_cliente;
        nodNacion.AddChild('numero_nota_fiscal').Text    := Nacional.numero_nota_fiscal;
        nodNacion.AddChild('serie_nota_fiscal').Text     := Nacional.serie_nota_fiscal;
        nodNacion.AddChild('valor_nota_fiscal').Text     := FormatFloat('0.00', Nacional.valor_nota_fiscal);
        nodNacion.AddChild('natureza_nota_fiscal').Text  := Nacional.natureza_nota_fiscal;
        nodNacion.AddChild('descricao_objeto').DOMNode.AppendChild(XMLDoc.DOMDocument.createCDATASection( Nacional.descricao_objeto ));
        nodNacion.AddChild('valor_a_cobrar').Text        := FormatFloat('0.00', Nacional.valor_a_cobrar);

        nodSerAdc := nodObjeto.addChild('servico_adicional');
        For objServAdc in ServicoAdicional Do
        Begin
          nodSerAdc.AddChild('codigo_servico_adicional').Text := objServAdc.codigo_servico_adicional;
          If (objServAdc.valor_declarado > 0) or (ServicoAdicional.Count = 1) Then
            nodSerAdc.AddChild('valor_declarado').Text          := FormatFloat('0.00', objServAdc.valor_declarado);
        End;

        nodDimens := nodObjeto.addChild('dimensao_objeto');
        nodDimens.AddChild('tipo_objeto').Text          := DimensaoObjeto.tipo_objeto;
        nodDimens.AddChild('dimensao_altura').Text      := IntToStr(DimensaoObjeto.dimensao_altura);
        nodDimens.AddChild('dimensao_largura').Text     := IntToStr(DimensaoObjeto.dimensao_largura);
        nodDimens.AddChild('dimensao_comprimento').Text := IntToStr(DimensaoObjeto.dimensao_comprimento);
        nodDimens.AddChild('dimensao_diametro').Text    := IntToStr(DimensaoObjeto.dimensao_diametro);

        nodObjeto.AddChild('data_postagem_sara').Text          := ''; //data_postagem_sara
        nodObjeto.AddChild('status_processamento').Text        := objPostal.status_processamento;
        nodObjeto.AddChild('numero_comprovante_postagem').Text := objPostal.numero_comprovante_postagem;
        nodObjeto.AddChild('valor_cobrado').Text               := FormatFloat('0.00', objPostal.valor_cobrado);
      End;
    End;

  Finally
    If fEmptyStr(strNomArq) Then
    Begin
      XmlDoc.SaveTofile(ExtractFileDir(Application.ExeName) + '\WS_Sigep.xml');
      If FileExists(ExtractFileDir(Application.ExeName) + '\WS_Sigep.xml') Then
        XmlDoc.XML.LoadFromFile(ExtractFileDir(Application.ExeName) + '\WS_Sigep.xml');
    End
    Else
    Begin
      XmlDoc.SaveTofile(strNomArq);
      XmlDoc.XML.LoadFromFile(strNomArq);
    End;

    Result := XmlDoc.XML.Text;
  End;
end;

end.
