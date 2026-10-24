unit untEntTestaCFOPS;

interface

Uses
  untFuncoesSimples, untZClient, untFuncFat, untTypesSistema, DB;

Type

  TEntTestaCFOPS = Class(TZClient)
  Private

    FDtaEnt: TDate;
    FDtaDoc: TDate;
    FNumDoc: String;
    FEspDoc: String;
    FSerie_: String;
    FCodFor: String;

    Function fSQLItens: String;


  Public

    Class Function fVerificaCFOPS(blnTravar: Boolean;
                                  dtaDtaEnt: TDate = 0;
                                  dtaDtaDoc: TDate = 0;
                                  strNumDoc: String = '';
                                  strEspDoc: String = '';
                                  strSerie_: String = '';
                                  strCodFor: String = '';
                                  blnCliente: Boolean = False): Boolean;

  End;

implementation

Uses
  SysUtils, untLiberacao, untMsgLiberacao;

Function TEntTestaCFOPS.fSQLItens: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  SELECT ';

  strSQL := strSQL + '    ENT_CODITE, ';
  strSQL := strSQL + '    ENT_DESITE, ';
  strSQL := strSQL + '    UNI_SIGUNI, ';
  strSQL := strSQL + '    ENT_CODFIS, ';
  strSQL := strSQL + '    ENT_CLAFIS, ';
  strSQL := strSQL + '    TRI_CFOPSP  ';

  strSQL := strSQL + '  FROM ';

  strSQL := strSQL + '    TMP_ENTMER ';

  strSQL := strSQL + '  INNER JOIN CADTRI ON ENT_CODFIS = TRI_CODTRI ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ON ENT_CODUNI = UNI_CODUNI ';

  strSQL := strSQL + ' WHERE ';

  strSQL := strSQL + '  IFNULL(TRI_CFOPSP, "") <> "" AND LOCATE(ENT_CLAFIS, TRI_CFOPSP) = 0  ';

  Result := strSQL;
End;

Class Function TEntTestaCFOPS.fVerificaCFOPS(blnTravar: Boolean;
                              dtaDtaEnt: TDate = 0;
                              dtaDtaDoc: TDate = 0;
                              strNumDoc: String = '';
                              strEspDoc: String = '';
                              strSerie_: String = '';
                              strCodFor: String = '';
                              blnCliente: Boolean = False): Boolean;
  Var
    objLiberacao : TLiberacao;
    objTeste: TEntTestaCFOPS;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;

Begin

  objTeste     := TEntTestaCFOPS.Create(Nil);
  objLiberacao := TLiberacao.Create;

  With objTeste Do
  Begin
    qryQuery.SQL.Text := fSQLItens;

    Result := fAbreClient(True, 'TEntTestaCFOPS.fVerificaCFOPS') And IsEmpty;

    If (Not IsEmpty) Then
    Begin
      FieldByName('TRI_CFOPSP').EditMask := '9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-9999-;1;_';

      If blnTravar Then
      Begin
        FDtaEnt := dtaDtaEnt;
        FDtaDoc := dtaDtaDoc;
        FNumDoc := strNumDoc;
        FEspDoc := strEspDoc;
        FSerie_ := strSerie_;
        FCodFor := strCodFor;

        objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO PARA DIVERGÊNCIA ENTRE ( CST ) E ( CFOP )', alCentro, teAmbos, '', 114);
        objLiberacao.objMsgLibera.pAddSeparador(114);
        objLiberacao.objMsgLibera.pAddTextoCaption('Data Entrada'   , FormatDateTime('DD/MM/YYY', FDtaEnt)        , 14);
        objLiberacao.objMsgLibera.pAddTextoCaption('Data Documento' , FormatDateTime('DD/MM/YYY', FDtaDoc)        , 14);
        objLiberacao.objMsgLibera.pAddTextoCaption('N.Documento'    , FNumdoc                                     , 14);
        objLiberacao.objMsgLibera.pAddTextoCaption('Série'          , FSerie_                                     , 14);
        objLiberacao.objMsgLibera.pAddTextoCaption('Espécie'        , FEspDoc                                     , 14);
        if blnCliente Then
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'     , FCodFor + ' - ' +fRetNomCliente(FCodFor) , 14)
        Else
          objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'     , FCodFor + ' - ' +fRetNomFornecedor(FCodFor) , 14);

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'COD.'            , fTamCodIte , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'PRODUTO'         , 35 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'UN'              , 4  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CST'             , 3  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CFOP INFORMADA'  , 14 , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CFOPs PERMITIDAS', 40 , alEsquerda , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        First;

        While Not Eof Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna('COD.'            , FieldByName('ENT_CODITE').AsString , fTamCodIte , alCentro );
          objLinha.pAddColuna('PRODUTO'         , FieldByName('ENT_DESITE').AsString , 35 , alEsquerda );
          objLinha.pAddColuna('UN'              , FieldByName('UNI_SIGUNI').AsString , 6  , alCentro   );
          objLinha.pAddColuna('CST'             , FieldByName('ENT_CODFIS').AsString , 3  , alCentro   );
          objLinha.pAddColuna('CFOP INFORMADA'  , FieldByName('ENT_CLAFIS').AsString , 14 , alCentro   );
          objLinha.pAddColuna('CFOPs PERMITIDAS', FieldByName('TRI_CFOPSP').AsString , 40 , alEsquerda );
          objTabela.lstLinhas.Add(objLinha);

          Next;
        End;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'LIBCFOP';
        objLiberacao.strMsgSen := 'LIBERAÇÃO PARA DIVERGÊNCIA ENTRE ( CST ) E ( CFOP )';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      End Else
      Begin
        Result := True;
        pMensagemOk('Há CFOPs com divergências cadastrais para a Situação Tributária,' + #13#10 +
                    'posteriormente será solicitada uma senha de liberação para o finalizar a entrada.');
      End;

    End;
  End;

  FreeAndNil(objTeste);
  FreeAndNil(objLiberacao);
End;

end.
