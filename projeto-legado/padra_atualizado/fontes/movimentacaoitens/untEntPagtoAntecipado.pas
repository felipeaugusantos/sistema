unit untEntPagtoAntecipado;

interface

Uses
  Uni,
  Classes,
  SysUtils,
  Controls,
  Math,
  untTypesSistema,
  untFuncoesSimples;

Type
  TDocEntrada = Record
    strNumDocu : string;
    strSerie__ : String;
    strEspecie : string;
    dtaDataEnt : TDate;
    dtaDataDoc : TDate;
    strCondpag : String;
    fltTotDocu : Double;
  End;

  TEntPagtoAntecipado = class(TObject)
    private
      stlLisSel: TStringList;
      strCodFor: String;

      stlLisAtu: TStringList;
      stlNumDupOriginal: TStringList;
      stlSerDupOriginal: TStringList;
      stlForDupOriginal: TStringList;
      stlEmpDupOriginal: TStringList;
      stlSeqDupOriginal: TStringList;
      stlParDupOriginal: TStringList;

      recDocEnt: TDocEntrada;
      FHistoricoRetencao: String;

      blnExisteForGen: Boolean;
     FCfgEmpresaPagamentoAntecipado: tCfgEmpresaPagamentoAntecipado;

     Procedure pAlteraNumeroParcelas(strParcel: Char; var arrDuplicata: TarrDuplicata);
     Function fGravaUsoLivroFiscal(stlLisAtu: TStringList): Boolean;
     Procedure pAtualizaCtpDet(strAutIncCtp, strNovoNumeroDocumento,strNovaParcela, strNovaSerie, strNovoCodFor: String);

    public
      fltTotSel: Double;
      fltTotDoc: Double;
      fltValPreNota: Double;
      fltTotUso: Double;
      intQtdParc: integer;
      strAutIncGerEleLoad: String;


      Function fRetQtdPagamentos: Integer;
      Function fSQLConsulta(blnEhLivroFiscal: Boolean = False; blnApenasSelecionadosPreNota : Boolean = False): String;
      Function fGravaPgtosAntecipados(strSeqGer, strNumDoc, strSerie: String; fltValDoc: Double; strHistoricoRetencao: string = '';
                              strSeqFis: String = ''; strAutoIncGerele: String = ''; strAutoIncGnre: String = ''; ABlnGNRE: Boolean = False): Boolean;
      Function fSelecionaDuplicatas(fltTotNot, fltBonificacao: Double; blnEhLivroFiscal: Boolean = False; strAutoIncGerele: String = ''): Boolean;
      Function fDuplicadaVinculada(strSeqPag: String; Var strNumDoc: String): Boolean;
      Function fGravaPrePga(strAutoIncGerele: String): Boolean;
      Function fRecalculaPagamentosAntecipados(strNumDoc,
                                               strSerie: String;
                                               fltValDoc: Double;
                                               Var arrParcelas: TParcelasArray;
                                               Var arrDuplicata: TarrDuplicata;
                                               blnGravar: Boolean = False;
                                               blnGNRE: Boolean = False): Boolean;

      Procedure pSetaParametrosConsulta(qryConsulta: TUniQuery);
      Procedure pSetaListaSelecao(stlLista: TStringList);
      Procedure pSetaFornecedor(strFornec: String);
      Procedure pRetornaListaSelecao(stlLista: TStringList; Var fltTotalSel: Double);
      procedure pSetarDocumentoEntrada(strNumDocu, strSerie__, strEspecie, strCondpag: string; dtaDataEnt, dtaDataDoc : TDate; fltTotalDocumento: Double);
      function  fSenhaLiberarGrupoFornecedor: boolean;
      function fFornecedorTemPagamentoAntecipado(strCodFor: string; blnEhLivroFiscal: Boolean = False): Boolean;

      procedure pCarregaTotSel;
      Constructor Create; reintroduce;
      Destructor Destroy; override;
  End;

implementation

Uses
     untConstantes, untEntSelPagtoAntecipado, Data.DB,
     untFuncFat, untFuncoesGenerica, untLiberacao,
     untTCadPagRepository, untTCadPag, untLogCtp;

Constructor TEntPagtoAntecipado.Create;
Begin
  Inherited;
  strAutIncGerEleLoad := '';
  fltTotDoc      := 0;
  fltTotSel      := 0;

  stlLisSel :=  TStringList.Create;
  stlLisAtu :=  TStringList.Create;
  stlNumDupOriginal := TStringList.Create;
  stlSerDupOriginal := TStringList.Create;
  stlForDupOriginal := TStringList.Create;
  stlEmpDupOriginal := TStringList.Create;
  stlSeqDupOriginal := TStringList.Create;
  stlParDupOriginal := TStringList.Create;

  blnExisteForGen := fExisteFornecedoresGenericos;
End;

Destructor TEntPagtoAntecipado.Destroy;
Begin
  stlLisSel.Clear;
  stlLisAtu.Clear;
  stlNumDupOriginal.Clear;
  stlSerDupOriginal.Clear;
  FreeAndNil(stlLisSel);
  FreeAndNil(stlLisAtu);
  FreeAndNil(stlNumDupOriginal);
  FreeAndNil(stlSerDupOriginal);
  FreeAndNil(stlForDupOriginal);
  FreeAndNil(stlEmpDupOriginal);
  FreeAndNil(stlSeqDupOriginal);
  FreeAndNil(stlParDupOriginal);

  inherited;
End;

Function TEntPagtoAntecipado.fSQLConsulta(blnEhLivroFiscal: Boolean = False; blnApenasSelecionadosPreNota : Boolean = False): String;
  Var
    strSQL: String;
Begin
  strSQL := 'SELECT ';
  If blnExisteForGen Then
    strSQL := strSQL + ' DISTINCT ';
  strSQL := strSQL + ' * FROM (';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   C.AUTOINCREM, ';

  strSQL := strSQL + '   F.FOR_CODFOR, ';
  strSQL := strSQL + '   F.FOR_NOMFAN, ';
  strSQL := strSQL + '   F.FOR_C_G_C_, ';
  strSQL := strSQL + '   F.FOR_CGCCPF, ';

  strSQL := strSQL + '   CTP_CODEMP,   ';
  strSQL := strSQL + '   CTP_DTACAD,   ';
  strSQL := strSQL + '   CTP_DTAPAG,   ';
  strSQL := strSQL + '   CTP_NUMDUP,   ';
  strSQL := strSQL + '   CTP_PARCEL,   ';
  strSQL := strSQL + '   CTP_SERIE_,   ';
  strSQL := strSQL + '   CTP_HIST01,   ';
  strSQL := strSQL + '  CAST(CTP_HIST01 AS CHAR(100)) AS CTP_HISTOR,';
  strSQL := strSQL + '   GUI_DESCRI,   ';

  strSQL := strSQL + '   @VALRES := IFNULL((SELECT SUM(IFNULL(PRE_VALUTI, 0)) FROM PREPGA A WHERE A.AUTOINCPAG = C.AUTOINCREM  AND PRE_FINALI = "N"), 0) AS VALRES, ';

  strSQL := strSQL + '   @VALRES_PRA := IFNULL((SELECT SUM(IFNULL(PRE_VALUTI, 0)) FROM PREPGA A WHERE A.AUTOINCPAG = C.AUTOINCREM AND PRE_SEQGER = "'+strAutIncGerEleLoad+'"   AND PRE_FINALI = "N"), 0) AS VALRES_PRA, ';

  strSQL := strSQL + '   (CTP_VALPAG - IFNULL(CTP_VALJUR, 0) + IFNULL(CTP_VALDES, 0) - @VALRES + @VALRES_PRA) AS CTP_VALPAG   ';
  (*
  @SET VALRES := IFNULL(SELECT SUM(VALOR UTILIZADO) TABELA NOVA
                    WHERE CHAVE DA CADPAG C COM A NOVA TABELA E FINALIZADO = N
                      AND GERLE <> DA NOTA DE ENTRADA) , 0),

  @SET VALRES_PRA ESSA NOTA := (SELECT SUM(VALOR UTILIZADO) TABELA NOVA
                    WHERE CHAVE DA CADPAG C COM A NOVA TABELA E FINALIZADO = N
                      AND GERLE = DA NOTA DE ENTRADA),


  strSQL := strSQL + '   (CTP_VALPAG - IFNULL(CTP_VALJUR, 0) + IFNULL(CTP_VALDES, 0)) - @VALRES AS CTP_VALPAG   ';
  *)
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + ' CADPAG C ';
  strSQL := strSQL + ' LEFT JOIN PGOGER P ON P.PGO_SEQPAG = C.AUTOINCREM ';
  strSQL := strSQL + ' LEFT JOIN PGOFIS PF ON PF.PGF_SEQPAG = C.AUTOINCREM ';

  strSQL := strSQL + ' LEFT JOIN CADFOR F ON F.FOR_CODFOR = C.CTP_CODFOR ';
  // strSQL := strSQL + ' LEFT JOIN PREPGA A ON A.AUTOINCPAG = C.AUTOINCREM AND PRE_FINALI = ''N'' ';
  strSQL := strSQL + ' LEFT JOIN GUITRI G ON G.GUI_CODGUI = C.CTP_Q_GUIA ';

  strSQL := strSQL + ' WHERE TRUE';
  If not blnApenasSelecionadosPreNota Then
  Begin
    strSQL := strSQL + '   AND CTP_PAGANT = "S"     AND ';

    {caso seja pessoa juridica pesquisa em todas as filias, senão apenas o codigo informado.  WG}

    strSQL := strSQL + ' ((F.FOR_CGCCPF = 1 AND SUBSTR(F.FOR_C_G_C_, 1 ,8) IN (SELECT SUBSTR(FB.FOR_C_G_C_, 1, 8)';
    strSQL := strSQL + '                                                               FROM CADFOR FB';
    strSQL := strSQL + '                                        WHERE FB.FOR_CODFOR = :CODFOR)) OR';
    strSQL := strSQL + '  (F.FOR_CGCCPF = 2  AND CTP_CODFOR = :CODFOR)) AND ';

    strSQL := strSQL + '   PGO_SEQPAG IS NULL AND   ';
    strSQL := strSQL + '   PGF_SEQPAG IS NULL AND   ';
  strSQL := strSQL + '   CTP_DTAPAG IS NOT NULL   ';


  case FCfgEmpresaPagamentoAntecipado of
    tcepaEmpresaLogada: strSQL := strSQL + ' AND CTP_CODEMP = ' + QuotedStr(VS_StrCodEmp);
    tcepaTodas: ;
    tcepaCNJRaizEmpresaLogada: Begin
                                 strSQL := strSQL + ' AND CTP_CODEMP IN (SELECT EMP_CODEMP  ';
                                 strSQL := strSQL + '                         FROM CADEMP ';
                                 strSQL := strSQL + '                        WHERE SUBSTR(EMP_C_G_C_, 1, 8) = (SELECT SUBSTR(EMP_C_G_C_, 1, 8) FROM CADEMP WHERE EMP_CODEMP = ' + fQuotedStr(VS_StrCodEmp)+ '))';
                               end;
  end;


  if blnEhLivroFiscal then
    strSQL := strSQL + ' AND CTP_USOFIS = "N" ';
  End;

  If blnApenasSelecionadosPreNota Then
    strSQL := strSQL + ' AND C.AUTOINCREM IN (' + fCommaText(stlLisSel, True) + ')';


  If blnExisteForGen Then
  Begin
    strSQL := strSQL + 'UNION ALL ';

    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + '   C.AUTOINCREM, ';

    strSQL := strSQL + '   F.FOR_CODFOR, ';
    strSQL := strSQL + '   F.FOR_NOMFAN, ';
    strSQL := strSQL + '   F.FOR_C_G_C_, ';
    strSQL := strSQL + '   F.FOR_CGCCPF, ';

    strSQL := strSQL + '   CTP_CODEMP,   ';
    strSQL := strSQL + '   CTP_DTACAD,   ';
    strSQL := strSQL + '   CTP_DTAPAG,   ';
    strSQL := strSQL + '   CTP_NUMDUP,   ';
    strSQL := strSQL + '   CTP_PARCEL,   ';
    strSQL := strSQL + '   CTP_SERIE_,   ';
    strSQL := strSQL + '   CTP_HIST01,   ';
    strSQL := strSQL + '  CAST(CTP_HIST01 AS CHAR(100)) AS CTP_HISTOR,';
    strSQL := strSQL + '   GUI_DESCRI,   ';

    strSQL := strSQL + '   @VALRES := IFNULL((SELECT SUM(IFNULL(PRE_VALUTI, 0)) FROM PREPGA A WHERE A.AUTOINCPAG = C.AUTOINCREM  AND PRE_FINALI = "N"), 0) AS VALRES, ';

    strSQL := strSQL + '   @VALRES_PRA := IFNULL((SELECT SUM(IFNULL(PRE_VALUTI, 0)) FROM PREPGA A WHERE A.AUTOINCPAG = C.AUTOINCREM AND PRE_SEQGER = "'+strAutIncGerEleLoad+'"   AND PRE_FINALI = "N"), 0) AS VALRES_PRA, ';

    strSQL := strSQL + '   (CTP_VALPAG - IFNULL(CTP_VALJUR, 0) + IFNULL(CTP_VALDES, 0) - @VALRES + @VALRES_PRA) AS CTP_VALPAG   ';
    (*
    @SET VALRES := IFNULL(SELECT SUM(VALOR UTILIZADO) TABELA NOVA
                      WHERE CHAVE DA CADPAG C COM A NOVA TABELA E FINALIZADO = N
                        AND GERLE <> DA NOTA DE ENTRADA) , 0),

    @SET VALRES_PRA ESSA NOTA := (SELECT SUM(VALOR UTILIZADO) TABELA NOVA
                      WHERE CHAVE DA CADPAG C COM A NOVA TABELA E FINALIZADO = N
                        AND GERLE = DA NOTA DE ENTRADA),


    strSQL := strSQL + '   (CTP_VALPAG - IFNULL(CTP_VALJUR, 0) + IFNULL(CTP_VALDES, 0)) - @VALRES AS CTP_VALPAG   ';
    *)
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + ' FORGEN FG ';
    strSQL := strSQL + ' INNER JOIN CADFOR F ON F.FOR_CODFOR = FG.GEN_CODFOR ';
    strSQL := strSQL + ' INNER JOIN CADPAG C ON C.CTP_CODFOR = F.FOR_CODFOR ';
    strSQL := strSQL + ' LEFT JOIN PGOGER P ON P.PGO_SEQPAG = C.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN PGOFIS PF ON PF.PGF_SEQPAG = C.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN GUITRI G ON G.GUI_CODGUI = C.CTP_Q_GUIA ';

    // strSQL := strSQL + ' LEFT JOIN PREPGA A ON A.AUTOINCPAG = C.AUTOINCREM AND PRE_FINALI = ''N'' ';


    strSQL := strSQL + ' WHERE TRUE';
    If not blnApenasSelecionadosPreNota Then
    Begin
      strSQL := strSQL + '   AND CTP_PAGANT = "S"     AND ';
      strSQL := strSQL + '   PGO_SEQPAG IS NULL AND   ';
      strSQL := strSQL + '   PGF_SEQPAG IS NULL AND   ';
    strSQL := strSQL + '   CTP_DTAPAG IS NOT NULL   ';


    case FCfgEmpresaPagamentoAntecipado of
      tcepaEmpresaLogada: Begin
                            strSQL := strSQL + ' AND CTP_CODEMP = ' + QuotedStr(VS_StrCodEmp);
                            strSQL := strSQL + ' AND FG.GEN_CODEMP = ' + QuotedStr(VS_StrCodEmp);
                          End;
      tcepaTodas: ;
      tcepaCNJRaizEmpresaLogada: Begin
                                   strSQL := strSQL + ' AND CTP_CODEMP IN (SELECT EMP_CODEMP  ';
                                   strSQL := strSQL + '                         FROM CADEMP ';
                                   strSQL := strSQL + '                        WHERE SUBSTR(EMP_C_G_C_, 1, 8) = (SELECT SUBSTR(EMP_C_G_C_, 1, 8) FROM CADEMP WHERE EMP_CODEMP = ' + fQuotedStr(VS_StrCodEmp)+ '))';

                                   strSQL := strSQL + ' AND FG.GEN_CODEMP IN (SELECT EMP_CODEMP  ';
                                   strSQL := strSQL + '                         FROM CADEMP ';
                                   strSQL := strSQL + '                        WHERE SUBSTR(EMP_C_G_C_, 1, 8) = (SELECT SUBSTR(EMP_C_G_C_, 1, 8) FROM CADEMP WHERE EMP_CODEMP = ' + fQuotedStr(VS_StrCodEmp)+ '))';
                                 end;
    end;


    if blnEhLivroFiscal then
      strSQL := strSQL + ' AND CTP_USOFIS = "N" ';
    End;

    If blnApenasSelecionadosPreNota Then
      strSQL := strSQL + ' AND C.AUTOINCREM IN (' + fCommaText(stlLisSel, True) + ')';
  End;


  strSQL := strSQL + ') TMP ';

  strSQL := strSQL + ' WHERE CTP_VALPAG > 0';

  Result := strSQL;
End;

Procedure TEntPagtoAntecipado.pSetaParametrosConsulta(qryConsulta: TUniQuery);
Begin
  With qryConsulta Do
  Begin
    ParamByName('CODFOR').AsString := strCodFor;
  End;
End;

procedure TEntPagtoAntecipado.pSetarDocumentoEntrada(strNumDocu, strSerie__,
  strEspecie, strCondpag: string; dtaDataEnt, dtaDataDoc: TDate; fltTotalDocumento: Double);
begin
  recDocEnt.strNumDocu := strNumDocu;
  recDocEnt.strSerie__ := strSerie__;
  recDocEnt.strEspecie := strEspecie;
  recDocEnt.strCondpag := strCondpag;
  recDocEnt.dtaDataEnt := dtaDataEnt;
  recDocEnt.dtaDataDoc := dtaDataDoc;
  recDocEnt.fltTotDocu := fltTotalDocumento;
end;

Procedure TEntPagtoAntecipado.pSetaListaSelecao(stlLista: TStringList);
Begin
  If Assigned(stlLista) Then
    stlLisSel.Text := stlLista.Text
  Else
  Begin
    stlLisSel.Clear;
    fltTotSel := 0;
  End;  
End;

Procedure TEntPagtoAntecipado.pRetornaListaSelecao(stlLista: TStringList; Var fltTotalSel: Double);
Begin
  fltTotalSel := 0;
  If Assigned(stlLista) Then
  Begin
    stlLista.Text := stlLisSel.Text;
    fltTotalSel   := fltTotSel;
  End;
End;


Function TEntPagtoAntecipado.fRetQtdPagamentos: Integer;
Begin
  Result :=  stlLisSel.Count;
End;

Function TEntPagtoAntecipado.fRecalculaPagamentosAntecipados(strNumDoc, strSerie: String;
                                                             fltValDoc: Double;
                                                             Var arrParcelas: TParcelasArray;
                                                             Var arrDuplicata: TarrDuplicata;
                                                             blnGravar: Boolean = False;
                                                             blnGNRE: Boolean = False): Boolean;
  Var
    qryCadNew: TUniQuery;
    qryCadPag: TUniQuery;
    fltTotRes: Double;
    intContador: Integer;
    strParcel: Char;
    qryPrePga: TUniQuery;
    blnGeraPga: Boolean;
    strIncNewCadPag: String;
Begin
  Result := True;

  SetLength(arrParcelas, 0);

  stlLisAtu.Clear;
  stlNumDupOriginal.Clear;
  stlSerDupOriginal.Clear;
  stlForDupOriginal.Clear;
  stlEmpDupOriginal.Clear;
  stlSeqDupOriginal.Clear;
  stlParDupOriginal.Clear;

  fltTotRes := fltValDoc;
  fltTotUso := 0;
  intQtdParc := 0;

  blnGeraPga := False;

  qryCadPag := fCriaQuery(Nil);
  qryPrePga := fCriaQuery;

  qryCadNew := fCriaQuery(Nil);
  qryCadNew.SQL.Text := 'SELECT * FROM CADPAG WHERE FALSE';

  strParcel := 'A';

  If stlLisSel.Count <= 0 Then
    Exit;

  With qryCadPag, SQL Do
  Begin
    Add('SELECT CADPAG.* ,');
    Add(' IFNULL((SELECT SUM(IFNULL(PRE_VALUTI, 0)) FROM PREPGA A WHERE A.AUTOINCPAG = CADPAG.AUTOINCREM AND PRE_SEQGER <> "" AND PRE_FINALI = "N"), 0) AS VALRES ');
    Add(' FROM CADPAG ');
    Add('WHERE AUTOINCREM IN (' + fCommaText(stlLisSel, True) + ')');
    Add('ORDER BY CTP_VALPAG DESC ');
    Open;

    If blnGravar Then
    Begin
      qryPrePga.Sql.Text := 'SELECT * FROM PREPGA WHERE PRE_SEQGER = "'+strAutIncGerEleLoad+'"';
      qryPrePga.Open;

      If qryPrePga.RecordCount > 0 Then
      Begin
        qryPrePga.SQL.Text := 'DELETE FROM PREPGA WHERE PRE_SEQGER = "'+strAutIncGerEleLoad+'"';
        qryPrePga.ExecSQL;
        blnGeraPga := True;
      End;

      qryPrePga.Sql.Text := 'SELECT * FROM PREPGA WHERE FALSE';
      qryPrePga.Open;
    End;


    While (Not Eof) And (fltTotRes > 0) Do
    Begin

      If blnGNRE Then
        strParcel := fNextParcelaValida(fStrZero(strNumDoc, 12),
                                        strSerie,
                                        strCodFor,
                                        qryCadPag.FieldByName('CTP_CODEMP').AsString);

      If RoundTo(qryCadPag.FieldByName('CTP_VALPAG').AsFloat - qryCadPag.FieldByName('CTP_VALJUR').AsFloat + qryCadPag.FieldByName('VALRES').AsFloat, -2) <= RoundTo(fltTotRes, -2) Then
      Begin

        fltTotRes := fltTotRes - FieldByName('CTP_VALPAG').AsFloat;

        stlLisAtu.Add(FieldByName('AUTOINCREM').AsString);
        stlNumDupOriginal.Add(FieldByName('CTP_NUMDUP').AsString);
        stlSerDupOriginal.Add(FieldByName('CTP_SERIE_').AsString);
        stlForDupOriginal.Add(FieldByName('CTP_CODFOR').AsString);
        stlEmpDupOriginal.Add(FieldByName('CTP_CODEMP').AsString);
        stlSeqDupOriginal.Add(FieldByName('CTP_SEQBAI').AsString);
        stlParDupOriginal.Add(FieldByName('CTP_PARCEL').AsString);


        SetLength(arrParcelas, Succ(Length(arrParcelas)));
        arrParcelas[High(arrParcelas)].strData  := FormatDateTime('dd/mm/yy', FieldByName('CTP_DTAVEN').AsDateTime);
        arrParcelas[High(arrParcelas)].strValor := FloatToStrF(FieldByName('CTP_VALPAG').AsFloat, ffNumber, 15, 2);

        fltTotUso := fltTotUso + FieldByName('CTP_VALPAG').AsFloat;
        Inc(intQtdParc);

        If blnGravar Then
        Begin
          If blnGeraPga Then
          Begin
            qryPrePga.Insert;
            qryPrePga.FieldByName('AUTOINCPAG').AsString := qryCadPag.FieldByName('AUTOINCREM').AsString;
            qryPrePga.FieldByName('PRE_SEQGER').AsString := strAutIncGerEleLoad;
            qryPrePga.FieldByName('PRE_CODFOR').AsString := qryCadPag.FieldByName('CTP_CODFOR').AsString;
            qryPrePga.FieldByName('PRE_NUMDUP').AsString := qryCadPag.FieldByName('CTP_NUMDUP').AsString;
            qryPrePga.FieldByName('PRE_PARCEL').AsString := qryCadPag.FieldByName('CTP_PARCEL').AsString;
            qryPrePga.FieldByName('PRE_CODEMP').AsString := qryCadPag.FieldByName('CTP_CODEMP').AsString;
            qryPrePga.FieldByName('PRE_SEQBAI').AsString := qryCadPag.FieldByName('CTP_SEQBAI').AsString;
            qryPrePga.FieldByName('PRE_SERIE_').AsString := qryCadPag.FieldByName('CTP_SERIE_').AsString;
            qryPrePga.FieldByName('PRE_FINALI').AsString := 'S';
            qryPrePga.FieldByName('PRE_VALUTI').AsFloat  := FieldByName('CTP_VALPAG').AsFloat;
            qryPrePga.Post;
          End;

          pAtualizaCtpDet(qryCadPag.FieldByName('AUTOINCREM').AsString, fStrZero(strNumDoc, 12), strParcel, strSerie, strCodFor);

          Edit;
          If blnGNRE Then
            strParcel := fNextParcelaValida(fStrZero(strNumDoc, 12), strSerie, strCodFor, FieldByName('CTP_CODEMP').AsString);
          FieldByName('CTP_NUMDUP').AsString := fStrZero(strNumDoc, 12);
          FieldByName('CTP_HIST01').AsString := FieldByName('CTP_HIST01').AsString + FHistoricoRetencao;
          FieldByName('CTP_PARCEL').AsString := strParcel;
          FieldByName('CTP_SERIE_').AsString := strSerie;
          FieldByName('CTP_CODFOR').AsString := strCodFor;
          Post;
        End;

      End Else
      Begin
        If blnGravar Then
        Begin
          qryCadNew.Close;
          qryCadNew.Open;
          qryCadNew.Insert;

          For intContador := 0 To qryCadNew.Fields.Count - 1 Do
            qryCadNew.Fields[intContador].Value := qryCadPag.Fields[intContador].Value;


          strIncNewCadPag :=  fRetAutoIncrem('CADPAG', VS_strCodEmp);

          qryCadNew.FieldByName('AUTOINCREM').AsString := strIncNewCadPag;

          stlNumDupOriginal.Add(qryCadNew.FieldByName('CTP_NUMDUP').AsString);
          stlSerDupOriginal.Add(qryCadNew.FieldByName('CTP_SERIE_').AsString);
          stlForDupOriginal.Add(qryCadNew.FieldByName('CTP_CODFOR').AsString);
          stlEmpDupOriginal.Add(qryCadNew.FieldByName('CTP_CODEMP').AsString);
          stlSeqDupOriginal.Add(qryCadNew.FieldByName('CTP_SEQBAI').AsString);
          stlParDupOriginal.Add(qryCadNew.FieldByName('CTP_PARCEL').AsString);

          qryCadNew.FieldByName('CTP_DTACAD').AsDateTime := VS_Date;
          qryCadNew.FieldByName('CTP_NUMDUP').AsString := fStrZero(strNumDoc, 12);
          qryCadNew.FieldByName('CTP_PARCEL').AsString := strParcel;
          qryCadNew.FieldByName('CTP_SERIE_').AsString := strSerie;
          qryCadNew.FieldByName('CTP_HIST01').AsString := FieldByName('CTP_HIST01').AsString + FHistoricoRetencao;

          qryCadNew.FieldByName('CTP_VALPAG').AsFloat  := fltTotRes;
          qryCadNew.FieldByName('CTP_VALORI').AsFloat  := fltTotRes;
          qryCadNew.FieldByName('CTP_VALDES').AsFloat  := 0;
          qryCadNew.FieldByName('CTP_VALJUR').AsFloat  := 0;
          qryCadNew.Post;
          If blnGeraPga Then
          Begin

            qryPrePga.Insert;
            qryPrePga.FieldByName('AUTOINCPAG').AsString := strIncNewCadPag;
            qryPrePga.FieldByName('PRE_SEQGER').AsString := strAutIncGerEleLoad;
            qryPrePga.FieldByName('PRE_CODFOR').AsString := qryCadPag.FieldByName('CTP_CODFOR').AsString;
            qryPrePga.FieldByName('PRE_NUMDUP').AsString := qryCadPag.FieldByName('CTP_NUMDUP').AsString;
            qryPrePga.FieldByName('PRE_PARCEL').AsString := qryCadPag.FieldByName('CTP_PARCEL').AsString;
            qryPrePga.FieldByName('PRE_CODEMP').AsString := qryCadPag.FieldByName('CTP_CODEMP').AsString;
            qryPrePga.FieldByName('PRE_SEQBAI').AsString := qryCadPag.FieldByName('CTP_SEQBAI').AsString;
            qryPrePga.FieldByName('PRE_SERIE_').AsString := qryCadPag.FieldByName('CTP_SERIE_').AsString;
            qryPrePga.FieldByName('PRE_FINALI').AsString := 'S';
            qryPrePga.FieldByName('PRE_VALUTI').AsFloat  := fltTotRes;
            qryPrePga.Post;
          End;



          stlLisAtu.Add(qryCadNew.FieldByName('AUTOINCREM').AsString);

          Edit;

          If FieldByName('CTP_VALORI').AsFloat > fltTotRes Then
            FieldByName('CTP_VALORI').AsFloat := FieldByName('CTP_VALORI').AsFloat - fltTotRes
          Else
            FieldByName('CTP_VALORI').AsFloat := FieldByName('CTP_VALORI').AsFloat * ( (FieldByName('CTP_VALPAG').AsFloat - fltTotRes) / FieldByName('CTP_VALORI').AsFloat);

          FieldByName('CTP_VALPAG').AsFloat := FieldByName('CTP_VALPAG').AsFloat - fltTotRes;

          Post;
        End;

        SetLength(arrParcelas, Succ(Length(arrParcelas)));
        arrParcelas[High(arrParcelas)].strData  := FormatDateTime('dd/mm/yy', FieldByName('CTP_DTAVEN').AsDateTime);
        arrParcelas[High(arrParcelas)].strValor := FloatToStrF(fltTotRes, ffNumber, 15, 2);

        fltTotUso := fltTotUso + fltTotRes;
        Inc(intQtdParc);

        fltTotRes := 0;
      End;

      strParcel := Char(Succ(Byte(strParcel)));

      Next;
    End;

  End;

  FreeAndNil(qryCadPag);
  FreeAndNil(qryCadNew);
  FreeAndNil(qryPrePga);

  If Not blnGravar Then
    pAlteraNumeroParcelas(strParcel, arrDuplicata);
End;

Procedure TEntPagtoAntecipado.pAlteraNumeroParcelas(strParcel: Char; var arrDuplicata: TarrDuplicata);
  Var
    intContador: Integer;
Begin
  For intContador := Low(ArrDuplicata) To High(ArrDuplicata) Do
  Begin
    If ArrDuplicata[intContador].curValor <= 0 Then
      Break;

    ArrDuplicata[intContador].strSequen := strParcel;
    strParcel := Char(Succ(Byte(strParcel)));
  End;
End;

Procedure TEntPagtoAntecipado.pAtualizaCtpDet(strAutIncCtp, strNovoNumeroDocumento,strNovaParcela, strNovaSerie, strNovoCodFor: String);
Var
  qrySelectCtp,
  qryUpdate: TUniQuery;
begin

  qrySelectCtp := fCriaQuery;
  qryUpdate := fCriaQuery;
  Try
    qrySelectCtp.Sql.Clear;
    qrySelectCtp.Sql.Add(' SELECT D.AUTOINCREM AS AUTINCCTPDET ');
    qrySelectCtp.Sql.Add(' FROM CADPAG G                       ');
    qrySelectCtp.Sql.Add(' INNER JOIN CTPDET D                 ');
    qrySelectCtp.Sql.Add('    ON G.CTP_CODFOR = D.CTP_CODFOR   ');
    qrySelectCtp.Sql.Add('   AND G.CTP_NUMDUP = D.CTP_NUMDUP   ');
    qrySelectCtp.Sql.Add('   AND G.CTP_PARCEL = D.CTP_PARCEL   ');
    qrySelectCtp.Sql.Add('   AND G.CTP_SERIE_ = D.CTP_SERIE_   ');
    qrySelectCtp.Sql.Add(' WHERE G.AUTOINCREM = :AUTINCCADPAG  ');

    qrySelectCtp.ParamByName('AUTINCCADPAG').AsString := strAutIncCtp;

    qrySelectCtp.Close;
    qrySelectCtp.Open;

    qrySelectCtp.First;
    If (Not qrySelectCtp.isEmpty) Then
    Begin
      While not qrySelectCtp.eof Do
      Begin
        qryUpdate.Sql.Clear;
        qryUpdate.Sql.Add(' UPDATE CTPDET                      ');
        qryUpdate.Sql.Add('    SET CTP_NUMDUP = :NUMDUP,       ');
        qryUpdate.Sql.Add('        CTP_CODFOR = :CODFOR,       ');
        qryUpdate.Sql.Add('        CTP_PARCEL = :PARCEL,       ');
        qryUpdate.Sql.Add('        CTP_SERIE_ = :SERIE_        ');
        qryUpdate.Sql.Add('  WHERE AUTOINCREM = :AUTINCCTPDET  ');

        qryUpdate.ParamByName('NUMDUP').AsString := strNovoNumeroDocumento;
        qryUpdate.ParamByName('CODFOR').AsString := strNovoCodFor;
        qryUpdate.ParamByName('PARCEL').AsString := strNovaParcela;
        qryUpdate.ParamByName('SERIE_').AsString := strNovaSerie;

        qryUpdate.ParamByName('AUTINCCTPDET').AsString := qrySelectCtp.FieldByName('AUTINCCTPDET').AsString;

        qryUpdate.ExecSQL;

        qrySelectCtp.next;
      End
    End;

  Finally
    FreeAndNil(qrySelectCtp);
    FreeAndNil(qryUpdate);
  End;
end;

procedure TEntPagtoAntecipado.pCarregaTotSel;
var i: integer;

  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  try
    qryConsulta.SQL.Text := Self.fSQLConsulta(False, True);
    qryConsulta.Open;
    Self.fltTotSel := 0;
    For i := 0 To stlLisSel.Count -1 do
    begin
      qryConsulta.First;
      If qryConsulta.Locate('AUTOINCREM', stlLisSel[i], []) Then
        Self.fltTotSel := Self.fltTotSel + qryConsulta.FieldByname('CTP_VALPAG').AsFloat;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End
end;

Function TEntPagtoAntecipado.fGravaPgtosAntecipados(strSeqGer, strNumDoc, strSerie: String; fltValDoc: Double; strHistoricoRetencao: string = '';
                                                        strSeqFis: String = ''; strAutoIncGerele: String = ''; strAutoIncGnre: String = '';
                                                        ABlnGNRE: Boolean = False): Boolean;
  Var
    qryPgoGer: TUniQuery;
    intContador: Integer;
    arrParcelas: TParcelasArray;
    arrDuplicata: TarrDuplicata;
    objRep: TCadPagRepository;
    objPag: TCadPag;
Begin
  pZeraDigDuplic(arrDuplicata);
  objRep := TCadPagRepository.Create;
  Try
    Try
      FHistoricoRetencao:= strHistoricoRetencao;
      Result := fRecalculaPagamentosAntecipados(strNumDoc, strSerie, fltValDoc, arrParcelas, arrDuplicata, True, ABlnGNRE);

      If Not Result Then
        Exit;

      If (strSeqGer = '') And (fEmptyStr(strAutoIncGnre)) Then
      Begin
        Result := fGravaUsoLivroFiscal(stlLisAtu);

        If Not(fEmptyStr(strSeqFis)) Then
        Begin
          qryPgoGer := fCriaQuery;

          Begin
            qryPgoGer.SQL.Clear;
            qryPgoGer.SQL.Add('SELECT * FROM PGOFIS ');
            qryPgoGer.SQL.Add('WHERE FALSE');
            qryPgoGer.Open;

            For intContador := 0 To stlLisAtu.Count - 1 Do
            Begin
              qryPgoGer.Insert;
              qryPgoGer.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PGOFIS', VS_strCodEmp);
              qryPgoGer.FieldByName('PGF_SEQFIS').AsString := strSeqFis;
              qryPgoGer.FieldByName('PGF_SEQPAG').AsString := stlLisAtu[intContador];
              qryPgoGer.FieldByName('PGF_DUPORI').AsString := stlNumDupOriginal[intContador];
              qryPgoGer.FieldByName('PGF_SERORI').AsString := stlSerDupOriginal[intContador];
              qryPgoGer.FieldByName('PGF_FORORI').AsString := stlForDupOriginal[intContador];
              qryPgoGer.FieldByName('PGF_EMPORI').AsString := stlEmpDupOriginal[intContador];
              qryPgoGer.FieldByName('PGF_SEQORI').AsString := stlSeqDupOriginal[intContador];
              qryPgoGer.FieldByName('PGF_PARORI').AsString := stlParDupOriginal[intContador];
              qryPgoGer.Post;

              objPag := objRep.fRetDuplicata(stlLisAtu[intContador]);

              If Assigned(objPag) Then
                pGravaLogCtp(objPag, 'Ref. uso de pagamento antecipado no livro fiscal', 'TEntPagtoAntecipado');

            End;

          end;

          FreeAndNil(qryPgoGer);

        End;

        Exit;

      End;

      qryPgoGer := fCriaQuery;

      With qryPgoGer, SQL Do
      Begin
        Clear;
        Add('SELECT * FROM PGOGER ');
        Add('WHERE FALSE');
        Open;

        For intContador := 0 To stlLisAtu.Count - 1 Do
        Begin
          qryPgoGer.Insert;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PGOGER', VS_strCodEmp);
          FieldByName('PGO_SEQGER').AsString := strSeqGer;
          If (fEmptyStr(strSeqGer)) Then
             FieldByName('PGO_SEQGER').clear;
          
          FieldByName('PGO_SEQPAG').AsString := stlLisAtu[intContador];
          FieldByName('PGO_DUPORI').AsString := stlNumDupOriginal[intContador];
          FieldByName('PGO_SERORI').AsString := stlSerDupOriginal[intContador];
          FieldByName('PGO_FORORI').AsString := stlForDupOriginal[intContador];
          FieldByName('PGO_EMPORI').AsString := stlEmpDupOriginal[intContador];
          FieldByName('PGO_SEQORI').AsString := stlSeqDupOriginal[intContador];
          FieldByName('PGO_PARORI').AsString := stlParDupOriginal[intContador];

          FieldByName('PGO_SEQGNR').AsString := strAutoIncGnre;  //MF: 318719
          If (fEmptyStr(strAutoIncGnre)) Then
            FieldByName('PGO_SEQGNR').clear;

          Post;
          objPag := objRep.fRetDuplicata(stlLisAtu[intContador]);

          If Assigned(objPag) Then
            pGravaLogCtp(objPag, 'Ref. uso de pagamento antecipado na entrada de mercadorias', 'TEntPagtoAntecipado');

        End;
      End;

      Result := True;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TEntPagtoAntecipado.fGravaPgtosAntecipados]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryPgoGer);
    FreeAndNil(objRep);
  End;
End;

function TEntPagtoAntecipado.fGravaPrePga(strAutoIncGerele: String): Boolean;
var
  fltTotRes,
  fltTotUsoParc: Double;
  qryPrePga,qryCadPag: TUniQuery;
Begin
  If stlLisSel.Count <= 0 Then
    Exit(True);

  fltTotRes := fltValPreNota;
  qryCadPag := fCriaQuery(Nil);
  qryPrePga := fCriaQuery;
  Try
    qryPrePga.SQL.Add('SELECT * FROM PREPGA WHERE FALSE');
    qryPrePga.Open;

    qryCadPag.SQL.Add('SELECT CADPAG.* ,');
    qryCadPag.SQL.Add(' IFNULL((SELECT SUM(IFNULL(PRE_VALUTI, 0)) FROM PREPGA A WHERE A.AUTOINCPAG = CADPAG.AUTOINCREM AND PRE_SEQGER <> "" AND PRE_FINALI = "N"), 0) AS VALRES ');
    qryCadPag.SQL.Add(' FROM CADPAG ');
    qryCadPag.SQL.Add('WHERE AUTOINCREM IN (' + fCommaText(stlLisSel, True) + ')');
    qryCadPag.SQL.Add('ORDER BY CTP_VALPAG DESC ');
    qryCadPag.Open;

    While (Not qryCadPag.Eof) And (fltTotRes > 0) Do
    Begin
      qryPrePga.Insert;
      If RoundTo(qryCadPag.FieldByName('CTP_VALPAG').AsFloat + qryCadPag.FieldByName('VALRES').AsFloat, -2) <= RoundTo(fltTotRes, -2) Then
      Begin

        fltTotUsoParc := qryCadPag.FieldByName('CTP_VALPAG').AsFloat;
        fltTotRes := fltTotRes - qryCadPag.FieldByName('CTP_VALPAG').AsFloat;

      End Else
      Begin
        fltTotUsoParc := fltTotRes;
        fltTotRes := 0;
      End;
      qryPrePga.FieldByName('AUTOINCPAG').AsString := qryCadPag.FieldByName('AUTOINCREM').AsString;
      qryPrePga.FieldByName('PRE_SEQGER').AsString := strAutoIncGerele;
      qryPrePga.FieldByName('PRE_CODFOR').AsString := qryCadPag.FieldByName('CTP_CODFOR').AsString;
      qryPrePga.FieldByName('PRE_NUMDUP').AsString := qryCadPag.FieldByName('CTP_NUMDUP').AsString;
      qryPrePga.FieldByName('PRE_PARCEL').AsString := qryCadPag.FieldByName('CTP_PARCEL').AsString;
      qryPrePga.FieldByName('PRE_CODEMP').AsString := qryCadPag.FieldByName('CTP_CODEMP').AsString;
      qryPrePga.FieldByName('PRE_SEQBAI').AsString := qryCadPag.FieldByName('CTP_SEQBAI').AsString;
      qryPrePga.FieldByName('PRE_SERIE_').AsString := qryCadPag.FieldByName('CTP_SERIE_').AsString;
      qryPrePga.FieldByName('PRE_FINALI').AsString := 'N';
      qryPrePga.FieldByName('PRE_VALUTI').AsFloat:= fltTotUsoParc;
      qryPrePga.Post;


      qryCadPag.Next;

    End;

    Result := True;
  finally
    FreeAndNil(qryCadPag);
    FreeAndNil(qryPrePga);
  end;
end;

function TEntPagtoAntecipado.fGravaUsoLivroFiscal(stlLisAtu: TStringList): Boolean;
var
  qryCtpFis: TUniQuery;
  intContador: integer;
begin
  try
    Result := False;

    qryCtpFis := fCriaQuery;
    qryCtpFis.Close;
    qryCtpFis.SQL.Clear;
    qryCtpFis.SQL.Add('UPDATE CADPAG SET CTP_USOFIS = "S" WHERE AUTOINCREM = :AUTINC');

    for intContador := 0 to stlLisAtu.Count - 1 do
    begin
      qryCtpFis.ParamByName('AUTINC').AsString := stlLisAtu[intContador];
      qryCtpFis.ExecSQL;
    end;

    Result := True;
  finally
    FreeAndNil(qryCtpFis);
  end;
end;


Procedure TEntPagtoAntecipado.pSetaFornecedor(strFornec: String);
Begin
  strCodFor := strFornec;
End;

Function TEntPagtoAntecipado.fSelecionaDuplicatas(fltTotNot, fltBonificacao: Double; blnEhLivroFiscal: Boolean = False; strAutoIncGerele: String = ''): Boolean;
Begin
  pCriarFormularios(TfrmEntSelPagtoAntecipado, frmEntSelPagtoAntecipado);
  If fltBonificacao > 0 Then
    frmEntSelPagtoAntecipado.lblTotNot.Caption := 'Total da Nota - Bonificação:';

  frmEntSelPagtoAntecipado.objPgoAnt := Self;
  frmEntSelPagtoAntecipado.fltTotNot := fltTotNot;
  frmEntSelPagtoAntecipado.blnEhLivroFiscal := blnEhLivroFiscal;
  Result := frmEntSelPagtoAntecipado.ShowModal = mrOk;
  FreeAndNil(frmEntSelPagtoAntecipado);
End;

function TEntPagtoAntecipado.fSenhaLiberarGrupoFornecedor: boolean;
  var
    qryValidaForn: TUniQuery;

  function fFormatCNPJ(strCNPJ: String): string;
  Begin
    Insert('.', strCNPJ, 3);
    Insert('.', strCNPJ, 6);
    Insert('/', strCNPJ, 11);
    Insert('-', strCNPJ, 16);
    Result := strCNPJ;
  End;
  function fPedeSenha: boolean;
    var
      objLiberacao : TLiberacao;
    Const
      cTitulo = 'UTILIZAÇÃO DE PAGAMENTO ANTECIPADO DE OUTRO FORNECEDOR DO MESMO GRUPO DE CNPJ';
  Begin

    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddTexto(cTitulo);
      objLiberacao.objMsgLibera.pAddSeparador(90);
      objLiberacao.objMsgLibera.pAddTexto('Dados do Documento de Entrada');
      objLiberacao.objMsgLibera.pAddSeparador(90);
      objLiberacao.objMsgLibera.pAddTexto('Documento de Entrada:' + recDocEnt.strNumDocu + ' - ' + recDocEnt.strEspecie + ' Série: ' +recDocEnt.strSerie__ );
      objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'            , Copy(strCodFor + ' - ' + fRetNomeLinhaGrupo(strCodFor), 1, 69)                           , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('CNPJ'                  , fFormatCNPJ(fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR'], [strCodFor]))           , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'               , VS_strCodEmp + ' - ' + fRetNomeEmpresa                                                   , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('Data Entrada'          , FormatDateTime('DD/MM/YYYY', recDocEnt.dtaDataEnt)                                       , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('Data Documento'        , FormatDateTime('DD/MM/YYYY', recDocEnt.dtaDataDoc)                                       , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('Condição de Pagamento' , recDocEnt.strCondpag                                                                     , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor Documento'       , FormatFloat('#,###,#0.00', recDocEnt.fltTotDocu)                                         , 21);

      objLiberacao.objMsgLibera.pAddSeparador(90);
      objLiberacao.objMsgLibera.pAddTexto('Dados do Pagamento Antecipado');
      objLiberacao.objMsgLibera.pAddSeparador(90);

      While Not qryValidaForn.Eof Do
      Begin
        With qryValidaForn Do
        Begin
          objLiberacao.objMsgLibera.pAddTexto('Título Contas à Pagar:' + FieldByName('CTP_NUMDUP').AsString + ' Série: ' + FieldByName('CTP_SERIE_').AsString);
          objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'            , Copy(FieldByName('FOR_CODFOR').AsString + ' - ' + FieldByName('FOR_NOME__').AsString, 1, 69) , 21);
          objLiberacao.objMsgLibera.pAddTextoCaption('CNPJ'                  , fFormatCNPJ(FieldByName('FOR_C_G_C_').AsString)                                              , 21);
          objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'               , Copy(FieldByName('EMP_CODEMP').AsString +  ' - ' + FieldByName('EMP_NOME__').AsString, 1, 69), 21);
          objLiberacao.objMsgLibera.pAddTextoCaption('Data Cadastro'         , FormatDateTime('DD/MM/YYYY', FieldByName('CTP_DTACAD').AsDateTime)                           , 21);
          objLiberacao.objMsgLibera.pAddTextoCaption('Data Vencimento'       , FormatDateTime('DD/MM/YYYY', FieldByName('CTP_DTAVEN').AsDateTime)                           , 21);
          objLiberacao.objMsgLibera.pAddTextoCaption('Data Pagamento'        , FormatDateTime('DD/MM/YYYY', FieldByName('CTP_DTAPAG').AsDateTime)                           , 21);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor Pago'            , FormatFloat('#,##0.00', FieldByName('CTP_VALPAG').AsFloat)                                   , 21);

          objLiberacao.objMsgLibera.pAddSeparador(90);
       End;
       qryValidaForn.Next;
      End;

      objLiberacao.strDirAce := 'LCPGFO';
      objLiberacao.strMsgSen := cTitulo;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;
      objLiberacao.pInformaNumDocEspDocCodEmp(
                         recDocEnt.strNumDocu,
                         recDocEnt.strEspecie,
                         VS_strCodEmp);

      Result := objLiberacao.fLibera;
    finally
      FreeAndNil(objLiberacao);
    end;
  End;
begin
  Result := True;
  If Assigned(stlLisSel) Then
  Begin
    If stlLisSel.Count > 0 Then
    Begin
      qryValidaForn := fCriaQuery;
      Try
        qryValidaForn.SQL.Add('SELECT P.CTP_NUMDUP,');
        qryValidaForn.SQL.Add('       P.CTP_SERIE_,');
        qryValidaForn.SQL.Add('       F.FOR_CODFOR,');
        qryValidaForn.SQL.Add('       IFNULL(F.FOR_NOMFAN, F.FOR_NOMFOR) AS FOR_NOME__,');
        qryValidaForn.SQL.Add('       F.FOR_C_G_C_,');
        qryValidaForn.SQL.Add('       E.EMP_CODEMP,');
        qryValidaForn.SQL.Add('       IFNULL(E.EMP_NOMFAN, E.EMP_NOMEMP) AS EMP_NOME__,');
        qryValidaForn.SQL.Add('       P.CTP_DTACAD,');
        qryValidaForn.SQL.Add('       P.CTP_DTAVEN,');
        qryValidaForn.SQL.Add('       P.CTP_DTAPAG,');
        qryValidaForn.SQL.Add('       P.CTP_VALPAG');
        qryValidaForn.SQL.Add('  FROM CADPAG P');
        qryValidaForn.SQL.Add('  LEFT JOIN CADFOR F ON F.FOR_CODFOR = P.CTP_CODFOR');
        qryValidaForn.SQL.Add('  LEFT JOIN CADEMP E ON E.EMP_CODEMP = P.CTP_CODEMP');
        qryValidaForn.SQL.Add(' WHERE P.AUTOINCREM IN(' + fCommaText(stlLisSel, True) + ')');
        qryValidaForn.SQL.Add('   AND P.CTP_CODFOR <> ' + strCodFor );

        If blnExisteForGen Then
        Begin
          qryValidaForn.SQL.Add(' AND F.FOR_CODFOR NOT IN (SELECT GEN_CODFOR FROM FORGEN WHERE GEN_CODEMP = ' + QuotedStr(VS_strCodEmp) + ')');
        End;

        qryValidaForn.SQL.Add(' ORDER BY CTP_CODFOR');

        qryValidaForn.Open;
        qryValidaForn.FieldByName('FOR_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);

        {apenas se tiver algum fornecedor alem do informado no documento de entrada então deve solicitar a senha - WG}
        If qryValidaForn.RecordCount = 0 Then
          Exit;
        Result := fPedeSenha;
      Finally
        stlLisSel.Clear;
        FreeAndNil(qryValidaForn);
      End;
    End;
  End;
end;

Function TEntPagtoAntecipado.fDuplicadaVinculada(strSeqPag: String; Var strNumDoc: String): Boolean;
  Var
    qryPgoEnt: TUniQuery;
Begin
  strNumDoc := '';
  qryPgoEnt := fCriaQuery;

  With qryPgoEnt, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE');
    Add('  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", IFNULL(GER_SERIE_, "")) AS NUMDOC');
    Add('FROM PGOGER ');
    Add('  INNER JOIN MOVGER G ON G.AUTOINCREM = PGO_SEQGER');
    Add('WHERE');
    Add('  PGO_SEQPAG = :SEQPAG');

    ParamByName('SEQPAG').AsString := strSeqPag;

    Open;

    Result := Not IsEmpty;

    strNumDoc := FieldByName('NUMDOC').AsString;
    Close;

  End;

  FreeAndNil(qryPgoEnt);
End;

function TEntPagtoAntecipado.fFornecedorTemPagamentoAntecipado(strCodFor: string; blnEhLivroFiscal: Boolean = False): Boolean;
  var
    qryConsulta: TUniQuery;
Begin
  Result := False;
  qryConsulta := fCriaQuery();
  Try
    Try
      FCfgEmpresaPagamentoAntecipado := tcepaEmpresaLogada;
      case fCfgSis('REGANT', varInteger) of
        2: FCfgEmpresaPagamentoAntecipado := tcepaTodas;
        3: FCfgEmpresaPagamentoAntecipado := tcepaCNJRaizEmpresaLogada;
      end;

      qryConsulta.Sql.Text := fSqlConsulta(blnEhLivroFiscal);

      qryConsulta.ParamByName('CODFOR').AsString := strCodFor;

      qryConsulta.Open;
      Result := Not qryConsulta.IsEmpty;
    Except
      on E: Exception do
        pMensagensErro(e.Message, '[untFuncoesSimples.fFornecedorTemPagamentoAntecipado]');
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

end.
