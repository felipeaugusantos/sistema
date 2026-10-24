unit untDocMIFF;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni, System.Variants, untValorPorExtenso;

Type

  TLeDocumentoMIFF = Class(TLeDocumento)
  Private
    blnAjuste: Boolean;
    blnDesCon: Boolean;
    strImpAju: String;

    blnEhUmDocumentoAPrazo: Boolean;
    blnEhUmaDVdeFF        : Boolean;
    blnExibirValorBrutoSeEstiverUsandoDescontoClienteProfissional: Boolean;
    fltPorDesFFOri: Double;

    strTabTri: String;

    cdsMovGer,
    cdsMovDet: TZClient;

    FLegIPI: String;
    FClaIpi : TStringList;

    FSetores: TStringList;

    function fGetSqlQtdIteVenda: String;
    function fGetSqlGroupByVenda: String;
    function fSQLTabPre: String;
    function fDescontoCliente: Boolean;
    function fSQLPercentualDesconto: String;

    function fSQLMovGer: String;
    function fInsereClientMovGer(Var regClient: TRegClient): Boolean;
    function fInsereClientMovdet: Boolean;
    function fMarcarSeparacaoComoImpresso: Boolean;
    function fMontaDuplicatasdeCredito(cdsMovGer: TZClient; strNumDup, strCodEmp : String): String;
    function fMontaProdutosDupCredito(strNumDoc, strEspDoc, strCodEmp, strIncDoc : String): String;

    procedure pMontaDuplicatas(cdsMovGer, cdsMovDet: TZClient);
    procedure pMontaDuplicatasdeCredito(cdsMovGer: TZClient);
    procedure pMontaDuplicatasdeCreditoComProdutos(cdsMovGer: TZClient);
    Procedure pMontaListaCadRec;
    procedure pSetaNomeTabela;
    procedure pSetaNumeroItens(intNroItens: Integer);
    procedure pPedidosExpedidos(cdsMovGer, cdsMovDet: TZClient);
    procedure pSetaModalidadeDePgto(cdsMovGer : TZClient);

    Function fExisteCampo(strCampo: String): String;
    procedure pCriaListaSetores;
    procedure pCriaListaClassificacao;
    Procedure pMontaListaClassificacao;
    function fRetEhReimpressaoDeDocumentoCanceladoWMS: Boolean;
    function fTemDel_LotDor : Boolean;
    function fRetLotDor: String;
    function fRetEmpresaCabecalho(strCodEmp: String): String;
    function fGetSqlQtdRomaneio: String;
    procedure pMontaItensEstrutura;
    procedure pSetaItensDevolvidos(strNumDoc, strEspDoc, strCodEmp: String);
  Public

    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;

    function fSQLItems: String; override;
    constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
  protected
    procedure pSetaParametrosCadcli; Override;
    procedure pSetaParametrosCadFor; Override;
    procedure pSetaParametrosFr3Adicioanais(FReport: TfrxReport); Override;

    function fSQLCamsposExtrasCadCli: String; Override;
    function fSQLInnersExtrasCadCli: String;  Override;
  End;

implementation

uses untConstantes, Data.DB;

constructor TLeDocumentoMIFF.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  pCriaListaSetores;
  pCriaListaClassificacao;
end;

destructor TLeDocumentoMIFF.Destroy;
begin
  Inherited;
  FreeAndNil(FClaIpi);
  FreeAndNil(FSetores);
end;

function TLeDocumentoMIFF.fDescontoCliente: Boolean;
Begin
  Result := fDescontoClienteProfissional(recDocume.strCodCli);
End;

procedure TLeDocumentoMIFF.pSetaModalidadeDePgto(cdsMovGer : TZClient);
  Var
    qryMod : TUniQuery;
    fltTotMod,
    fltValPag,
    fltTotGer: Double;

    strUsaTef,
    strModalidades,
    strTipCar,
    strCarConPag,
    strParcelasCartao: String;
    Function fFormaPagtoAPrazo(strCodFpg: String): Boolean;
      Const
        arrAPrazo : Array[0..4] Of String = ('008','010','012','014','015');
      Var
        i: Integer;
    Begin
      Result := False;

      For i := Low(arrAPrazo) To High(arrAPrazo) Do
      Begin
        If (Not Result) And (strCodFpg = arrAPrazo[i]) Then
          Result := True;
      End;
    End;

begin
  strTipCar := '';
  strModalidades := '';
  strCarConPag := '';
  fltTotMod := 0;
  strParcelasCartao := '';

  qryMod := fCriaQuery(nil);

  try
    try
      qryMod.SQL.Add('SELECT DISTINCT ');
      qryMod.SQL.Add('  FPG_CODIGO, ');
      qryMod.SQL.Add('  FPG_DESCRI, ');
      qryMod.SQL.Add('  SUM(MOD_VALMOD) AS MOD_VALMOD, ');
      qryMod.SQL.Add('  SUM(MOD_VALPAG) AS MOD_VALPAG, ');
      qryMod.SQL.Add('  SUM(MOD_VALMOD) AS MOD_VALMOD, ');
      qryMod.SQL.Add('  MCA_TIPCAR, ');
      If fCampoExiste('MOVCAR', 'MCA_CONPAG', True) then
        qryMod.SQL.Add('  MCA_CONPAG, ');
      If fCampoExiste('CADCAR', 'CAR_CODCAR', True) then
        qryMod.SQL.Add('  CAR_CODCAR, ');
      If fCampoExiste('CADCAR', 'CAR_DESCAR', True) then
        qryMod.SQL.Add('  CAR_DESCAR, ');
      qryMod.SQL.Add('  MCA_VALDUP, ');
      qryMod.SQL.Add('  MCA_VALSTA, ');
      qryMod.SQL.Add('  CASE MOD_CODMOD ');
      qryMod.SQL.Add('    WHEN "001" THEN "01" ');
      qryMod.SQL.Add('    WHEN "002" THEN "02" ');
      qryMod.SQL.Add('    WHEN "006" THEN "02" ');
      qryMod.SQL.Add('    WHEN "007" THEN IF(CAR_TIPCAR="C", "03", "04") ');
      qryMod.SQL.Add('    ELSE "99" ');
      qryMod.SQL.Add('  END AS CODMOD ');
      qryMod.SQL.Add('FROM ');
      qryMod.SQL.Add('  MOVMOD ');
      qryMod.SQL.Add('  JOIN CADFPG ON FPG_CODIGO = MOD_CODMOD ');
      qryMod.SQL.Add('  LEFT JOIN MOVCAR ON MOD_DOCUME = MCA_DOCUME AND MCA_PARCEL = "A" AND MOD_CODMOD = "007" AND TRIM(IFNULL(MOD_DOCUME, "")) <> "" AND MOD_CODCLI = MCA_CODCLI ');
      qryMod.SQL.Add('  LEFT JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ');
      qryMod.SQL.Add('WHERE ');
      qryMod.SQL.Add('  MOD_NUMDOC = :NUMDOC AND ');
      qryMod.SQL.Add('  MOD_ESPDOC = :ESPDOC AND ');
      qryMod.SQL.Add('  MOD_CODEMP = :CODEMP AND ');
      qryMod.SQL.Add('  MOD_CODCLI = :CODCLI ');
      qryMod.SQL.Add(' AND  IFNULL(MOD_SERIE_, "") = :SERIE_ ');
      qryMod.SQL.Add('  GROUP BY ');
      qryMod.SQL.Add('  MOD_NUMDOC, MOD_ESPDOC, MOD_CODEMP, MOD_CODCLI, MOD_SERIE_, MOD_CODMOD ');

      qryMod.ParamByName('NUMDOC').AsString := cdsMovGer.FieldByName('NUMDOC').AsString;
      qryMod.ParamByName('ESPDOC').AsString := cdsMovGer.FieldByName('ESPDOC').AsString;
      qryMod.ParamByName('CODEMP').AsString := cdsMovGer.FieldByName('CODEMP').AsString;
      qryMod.ParamByName('CODCLI').AsString := cdsMovGer.FieldByName('CODCLI').AsString;
      qryMod.ParamByName('SERIE_').AsString := cdsMovGer.FieldByName('SERDOC').AsString;
      qryMod.Open;

      fltTotGer := cdsMovGer.FieldByName('VLRCON').AsFloat;

      If fUsaSat Then
        strUsaTef := fArqIniLocal(0, 'SATCFE', 'TEF', 'N', fCfgSis('PATSAT', varString) + '\opcoes_sat.ini')
      Else
        strUsaTef := fArqIniLocal(0, 'NFCE', 'TEF', 'N', fCfgSis('PTNFCE', varString) + '\opcoes_nfce.ini');

      qryMod.First;
      While (Not qryMod.Eof) Do
      Begin
        {********************************************************************************}
        {* SE A FORMA DE PAGAMENTO FOR A PRAZO, UTILIZA O VALMOD, SE NÃO UTILIZA VALPAG *}
        {*****************************************************************************MM*}
        If fFormaPagtoAPrazo(qryMod.FieldByName('FPG_CODIGO').AsString) Then
          fltValPag := qryMod.FieldByName('MOD_VALMOD').AsFloat
        Else
          fltValPag := qryMod.FieldByName('MOD_VALPAG').AsFloat;

        If fltValPag > 0 Then
        Begin
          If Pos(qryMod.FieldByName('CODMOD').AsString, '03_04_') > 0 Then
          Begin
            If strUsaTef = 'N' Then
            Begin
              strTipCar := 'POS';
            End
            Else
            Begin
              If (qryMod.FieldByName('MCA_TIPCAR').AsString = 'TEF') Then
              Begin
                strTipCar := 'TEF';
              End
              Else
              Begin
                strTipCar := 'POS';
              End;
            End;
          End;

          fltTotMod      := fltTotMod + fltValPag;

          strModalidades := strModalidades +
            IIF(Not fEmptyStr(strTipCar),
              qryMod.FieldByName('FPG_DESCRI').AsString + ' (' + strTipCar + '):', qryMod.FieldByName('FPG_DESCRI').AsString + ':')+ ' ' +
              FloatToStrF(fltValPag, ffNumber, 12, 2) + ' ';

          If Assigned(qryMod.FindField('CAR_CODCAR')) and Assigned(qryMod.FindField('CAR_DESCAR')) and Assigned(qryMod.FindField('MCA_CONPAG')) then
          Begin
            If Pos(qryMod.FieldByName('CODMOD').AsString, '03_04') > 0 Then
            Begin
              strCarConPag := strCarConPag + 'CARTÃO: ' + qryMod.FieldByName('CAR_CODCAR').AsString + ' - ' +
                                                                 qryMod.FieldByName('CAR_DESCAR').AsString + ' - ' +
                                                                 fFormataCondPag(qryMod.FieldByName('MCA_CONPAG').AsString);
              if not fEmptyStr(qryMod.FieldByName('MCA_CONPAG').asString) then
                strParcelasCartao := Copy(qryMod.FieldByName('MCA_CONPAG').asString,1,2)+ ' X ' +
                                     FormatFloat('###,##0.00', qryMod.FieldByName('MCA_VALSTA').asFloat);
            End;
          End;

        End;

        qryMod.Next;
      End;

      If fFormataFloat(fltTotGer, 2) > fFormataFloat(fltTotMod, 2) Then
        strModalidades := strModalidades + 'DINHEIRO: ' +
                          FloatToStrF(fFormataFloat(fltTotGer, 2) - fFormataFloat(fltTotMod, 2), ffNumber, 12, 2);

      cdsMovGer.edit;
      cdsMovGer.FieldByName('MODPGT').AsString := strModalidades;
      cdsMovGer.post;
    except on e : exception do
      pMensagensErro(E.Message, '[TLeDocumentoMIFF.pSetaModalidadeDePgto]');
    end;
  finally
    FreeAndNil(qryMod);
  end;

end;


  {************************************************************************}
  {* BUSCA TODOS OS PEDIDOS QUE FORAM EXPEDIDOS E GERARAM ESSE DOCUMENTO  *}
  {*********************************************************************MA*}

procedure TLeDocumentoMIFF.pPedidosExpedidos(cdsMovGer, cdsMovDet: TZClient);
Var
    stlPedExp: TStringList;
Begin

  If cdsMovGer.IsEmpty  Then
    Exit;

  Try
    With cdsMovDet Do
    Begin

      stlPedExp            := TStringList.Create;
      stlPedExp.Sorted     := True;
      stlPedExp.Duplicates := dupIgnore;
      stlPedExp.Clear;

      First;
      While Not Eof do
      Begin
        stlPedExp.Add(FieldByName('PEDEXP').AsString);
        Next;
      End;
    End;

    cdsMovGer.Edit;
    If fEmptyStr(stlPedExp.Text) then
      cdsMovGer.FieldByName('PEDEXP').AsString := stlPedExp.Text
    Else
      cdsMovGer.FieldByName('PEDEXP').AsString := stlPedExp.CommaText;
    cdsMovGer.Post;
    FreeAndNil(stlPedExp);

  Except
    On E: Exception Do
    Begin
      FreeAndNil(stlPedExp);
      pMensagensErro(E.Message, '[TLeDocumentoMIFF.pPedidosExpedidos]');
    End;
  End;
End;

procedure TLeDocumentoMIFF.pCriaListaClassificacao;
begin
  FClaIpi := TStringList.Create;
  FClaIpi.Sorted := True;
  FClaIpi.Duplicates := dupIgnore;

  FLegIPI := '';
end;

procedure TLeDocumentoMIFF.pCriaListaSetores;
begin
  FSetores := TStringList.Create;
  FSetores.Sorted := True;
  FSetores.Duplicates := dupIgnore;
end;

Procedure TLeDocumentoMIFF.pMontaListaCadRec;
  Var
    qryListaCadRec: TUniQuery;
    strCadRec: string;
Begin

  With cdsMovGer Do
  Begin
    If IsEmpty Then
      Exit;

    qryListaCadRec := fCriaQuery(Nil);
    Try
      qryListaCadRec.SQL.Text := ' SELECT CTR_PARCEL, CTR_VALORI,CTR_DTAVEN FROM CADREC ' +
                                 '  WHERE CTR_NUMDUP = ' + QuotedStr(cdsMovGer.FieldByName('NUMDOC').asString) +
                                 '    AND CTR_ESPDOC = ' + QuotedStr(cdsMovGer.FieldByName('ESPDOC').asString) +
                                 '    AND CTR_CODEMP = ' + QuotedStr(cdsMovGer.FieldByName('CODEMP').asString);
      qryListaCadRec.Open;
      qryListaCadRec.First;
      strCadRec := '';
      While Not qryListaCadRec.Eof Do
      Begin
        strCadRec := strCadRec + qryListaCadRec.FieldByName('CTR_PARCEL').asString + ') '+
                                 qryListaCadRec.FieldByName('CTR_dtaven').asString + '  '+
                                 FormatFloat( '#,##0.00', qryListaCadRec.FieldByName('CTR_VALORI').asFloat) + '  ';
        qryListaCadRec.Next;
      End;
    Finally
      FreeAndNil(qryListaCadRec);
    End;

    Edit;
    FieldByName('LSTREC').AsString := Trim(strCadRec);
    Post;

  End;

End;

procedure TLeDocumentoMIFF.pMontaDuplicatas(cdsMovGer, cdsMovDet: TZClient);

  function fCondicaoPagtoEhAPrazo: Boolean;
  begin
    Result := Not (fStatusCndPag(cdsMovGer.FieldByName('CONPAG').AsString) = A_VISTA);
  end;

  Var
    intQtdDup,
    intContador: Integer;
    strDuplic,
    strSeqCon: String;
    fltTotRes: Currency;
    intParVpar : Integer;
    fltTotVPar : Double;
    strSequen  : String;
    blnMantemParcelasDigitadas: Boolean;
    arrDuplicata: TarrDuplicata;

    procedure pCarregaDuplicatasCND(strNumDoc, strEspDoc, strSerDoc, strCodEmp, strCodCli:String);
    var strSQL: String;
        qryCND: TUniQuery;
      intIndex: Integer;
    Begin
      strSQL := 'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM GERCND '+
                'INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM                  '+
                'WHERE GER_NUMDOC = :NUMDOC                                    '+
                '  AND GER_ESPDOC = :ESPDOC                                    '+
                '  AND GER_SERIE_ = :SERDOC                                    '+
                '  AND GER_CODCLI = :CODCLI                                    '+
                '  AND GER_CODEMP = :CODEMP                                    '+
                'UNION ALL                                                     '+
                'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM NOTCND '+
                'INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM                  '+
                'WHERE GER_NUMDOC = :NUMDOC                                    '+
                '  AND GER_ESPDOC = :ESPDOC                                    '+
                '  AND GER_SERIE_ = :SERDOC                                    '+
                '  AND GER_CODCLI = :CODCLI                                    '+
                '  AND GER_CODEMP = :CODEMP                                    '+
                'ORDER BY PARCEL                                               ';
      Try
        qryCND := fCriaQuery;

        with qryCND, SQL do
        Begin
          Clear;
          Add(strSQL);
          ParamByName('NUMDOC').AsString := strNumDoc ;
          ParamByName('ESPDOC').AsString := strEspDoc ;
          ParamByName('SERDOC').AsString := strSerDoc ;
          ParamByName('CODCLI').AsString := strCodCli ;
          ParamByName('CODEMP').AsString := strCodEmp ;
          Open;

          intIndex := 1;
          While not eof do
          Begin
            cdsMovGer.FieldByName('VPAR' + RightStr('0' + IntToStr(intIndex), 2)).AsFloat := fFormataFloat(FieldByName('VALPAR').AsFloat, 2);
            Inc(intIndex);

            Next;
          End;

        End;

      Finally
        FreeAndNil(qryCND);
      End;

    End;
Begin
  pZeraDigDuplic(arrDuplicata);
  With cdsMovGer Do
  Begin
    If IsEmpty Then
      Exit;

    Edit;

    If Not fEmptyStr(FieldByName('CLAFI2').AsString) Then
      FieldByName('CLA123').AsString := FieldByName('CLA123').AsString + ', ' + FieldByName('CLAFI2').AsString;

    If Not fEmptyStr(FieldByName('CLAFI3').AsString) Then
      FieldByName('CLA123').AsString := FieldByName('CLA123').AsString + ', ' + FieldByName('CLAFI3').AsString;

    If cdsMovDet.fRetSoma('TOTUNI') > cdsMovDet.fRetSoma('TOTORI') Then
      FieldByName('VALBRU').AsFloat := cdsMovDet.fRetSoma('TOTUNI')
    Else
      FieldByName('VALBRU').AsFloat := cdsMovDet.fRetSoma('TOTORI');

    If cdsMovDet.fRetSoma('TOTORI') > cdsMovDet.fRetSoma('TOTUNI') Then
      FieldByName('DESTOT').AsFloat := cdsMovDet.fRetSoma('TOTORI') - cdsMovDet.fRetSoma('TOTUNI')
    Else
      FieldByName('DESTOT').AsFloat := 0;

    FieldByName('TOTENT').AsFloat := cdsMovDet.fRetSoma('TOTENT');
    FieldByName('TOTSAI').AsFloat := cdsMovDet.fRetSoma('TOTSAI');
    FieldByName('TOTQTD').AsFloat := cdsMovDet.fRetSoma('TOTQTD');
    FieldByName('TOTORI').AsFloat := cdsMovDet.fRetSoma('TOTORI');
    FieldByName('PESTOT').AsFloat := cdsMovDet.fRetSoma('PESTOT');
    FieldByName('TOTMLT').AsFloat := cdsMovDet.fRetSoma('TOTMLT');
    FieldByName('VRBREX').AsString := fRetExtensoNumero(FloatToStrF(FieldByName('VALBRU').AsFloat,ffNumber,12,2));
    FieldByName('VRCOEX').AsString := fRetExtensoNumero(FloatToStrF(FieldByName('VLRCON').AsFloat,ffNumber,12,2));

    If (FieldByName('CODFPG').AsString = '002') Or (FieldByName('CODFPG').AsString = '006') Or (FieldByName('CODFPG').AsString = '007') Then
      FieldByName('PRZMED').AsFloat  := FieldByName('AUXPRZ').AsFloat
    Else
      FieldByName('PRZMED').AsFloat  := fCalcMediaPagto(FieldByName('CONPAG').AsString);

    If fStatusCndPag(FieldByName('CONPAG').AsString) = A_VISTA Then
      FieldByName('AVISTA').AsString := 'S'
    Else
      FieldByName('AVISTA').AsString := 'N';

    FieldByName('FORPAG').AsString := fSomaFormasPagamento(FieldByName('NUMDOC').AsString,
                                                           FieldByName('ESPDOC').AsString,
                                                           FieldByName('CODEMP').AsString,
                                                           FieldByName('CODCLI').AsString);

    If fCfgSis('BAIAVI', varBoolean) And (Pos(FieldByName('ESPDOC').AsString, 'MI_FF_') > 0) Then
    Begin
      strSeqCon := fRetSeqConCadRec(FieldByName('NUMDOC').AsString,
                                    FieldByName('ESPDOC').AsString,
                                    'A',
                                    FieldByName('CODEMP').AsString,
                                    FieldByName('CODCLI').AsString,
                                    'S');

      If Not fEmptyStr(strSeqCon) Then
      Begin
        FieldByName('SEQCON').AsString := strSeqCon;
        FieldByName('SEQCOE').AsString := strSeqCon + '-' + FieldByName('CODEMP').AsString;
      End;

    End;

    strDuplic := '';

    fDigDuplicSemTela(arrDuplicata,
                      intQtdDup,
                      fltTotRes,
                      FieldByName('CONPAG').AsString,
                      123,
                      FieldByName('VLRCON').AsFloat,
                      False,
                      False,
                      FieldByName('DTAENT').AsDateTime,
                      False);

    pCarregaDuplicatasCND(FieldByName('NUMDOC').AsString,
                          FieldByName('ESPDOC').AsString,
                          FieldByName('SERDOC').AsString,
                          FieldByName('CODEMP').AsString,
                          FieldByName('CODCLI').AsString);

    If (fCondicaoPagtoEhAPrazo) Then
    Begin
      intParVpar := 0;
      fltTotVPar := 0;
      For intContador := 1 To 12 Do
      Begin
        If (Assigned(cdsMovGer.FindField('VPAR' + fStrZero(intContador, 2)))) And
           (cdsMovGer.FieldByName('VPAR' + fStrZero(intContador, 2)).AsFloat > 0) Then
        Begin
          intParVpar := intParVpar + 1;
          fltTotVPar := fltTotVPar + cdsMovGer.FieldByName('VPAR' + fStrZero(intContador, 2)).AsFloat;
        End;
      End;

      If ((fFormataFloat(cdsMovGer.FieldByName('VLRCON').AsFloat, 2)) = (fFormataFloat(fltTotVPar, 2))) And
         (Not fEmptyStr(cdsMovGer.FieldByName('CONPAG').AsString)) And
         (StrToIntDef(LeftStr(cdsMovGer.FieldByName('CONPAG').AsString, 2), 0) <> intParVpar) And
         (Assigned(cdsMovGer.FindField('VALADT'))) And (cdsMovGer.FieldByName('VALADT').AsFloat > 0) Then
      Begin
        fDigDuplicSemTela(arrDuplicata,
                          intQtdDup,
                          fltTotRes,
                          cdsMovGer.FieldByName('CONPAG').AsString,
                          123,
                          cdsMovGer.FieldByName('VLRCON').AsFloat - cdsMovGer.FieldByName('VALADT').AsFloat,
                          False,
                          False,
                          cdsMovGer.FieldByName('DTAENT').AsDateTime,
                          False);

        strDuplic := strDuplic + '  ' + 'A' + ')' +
                         FormatDateTime('DD/MM/YYYY', cdsMovGer.FieldByName('DTAENT').AsDateTime) + ' ' +
                         fstrEspaco(FloatToStrF(cdsMovGer.FieldByName('VALADT').AsFloat, ffNumber, 15, 2), 12, 2);

        For intContador := 0 To Length(arrDuplicata)-1 Do
        Begin
          If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
          Begin
            FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).AsDateTime := StrToDateDef(arrDuplicata[intContador].dtaDtaVen, 0);
            FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := arrDuplicata[intContador].curValor;

            If (intContador = (Length(arrLetras)-1)) Then
              strSequen := String(arrLetras[intContador])
            Else
              strSequen := String(arrLetras[intContador + 1]);

            strDuplic := strDuplic + '  ' + strSequen + ')' +
                         FormatDateTime('DD/MM/YYYY', FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).AsDateTime) + ' ' +
                         fstrEspaco(FloatToStrF(FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat, ffNumber, 15, 2), 12, 2);
          End
          Else
          Begin
            FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).Clear;
            FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := 0;
          End;
        End;
      End
      Else
      begin
        For intContador := 0 To Length(arrDuplicata)-1 Do
        Begin
          If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
          Begin
            FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).AsDateTime := StrToDateDef(arrDuplicata[intContador].dtaDtaVen, 0);

            If (blnExibirValorBrutoSeEstiverUsandoDescontoClienteProfissional) Then
            Begin
              blnMantemParcelasDigitadas := ((cdsMovGer.FieldByName('OPCDOC').AsString = 'CF') And (cdsMovGer.FieldByName('ESPDOC').AsString = 'FF')) And
                                            ((fFormataFloat(cdsMovGer.FieldByName('VLRCON').AsFloat, 2)) = (fFormataFloat(fltTotVPar, 2))) And
                                            (StrToIntDef(LeftStr(cdsMovGer.FieldByName('CONPAG').AsString, 2), 0) = intParVpar);

              If (Not blnMantemParcelasDigitadas) Then
                FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := arrDuplicata[intContador].curValor;
            End;

            strDuplic := strDuplic + '  ' + arrDuplicata[intContador].strSequen + ')' +
                         FormatDateTime('DD/MM/YYYY', FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).AsDateTime) + ' ' +
                         fstrEspaco(FloatToStrF(FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat, ffNumber, 15, 2), 12, 2);
          End
          Else
          Begin
            FieldByName('DTAV' + RightStr('0' + IntToStr(intContador+1), 2) ).Clear;
            FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := 0;
          End;
        End;
      End;

      FieldByName('DUPLIC').AsString := Trim(strDuplic);
    End;

    Post;
  End;

End;

procedure TLeDocumentoMIFF.pMontaDuplicatasdeCredito(cdsMovGer: TZClient);
var strSQL: String;
    qryCND: TUniQuery;
    strDupCre, strNumDup, strCodEmp: String;

begin
  cdsMovGer.edit;
  Begin
    strSQL := ' SELECT CONCAT(CTR_NUMDUP,"-",CTR_ESPDOC,"-",CTR_CODEMP) AS DUPCRE, CTR_CODEMP FROM CADREC '+
                'WHERE CTR_SEQCON = :SEQCON                                   '+
                '  AND CTR_CODCLI = :CODCLI                                   '+
                '  AND CTR_VALORI < 0                                         ';

    Try
      qryCND := fCriaQuery;
      qryCND.Close;
      qryCND.SQL.Clear;
      qryCND.SQL.Add(strSQL);
      qryCND.ParamByName('SEQCON').AsString := cdsMovGer.FieldByName('SEQCO1').AsString ;
      qryCND.ParamByName('CODCLI').AsString := recDocume.strCodCli ;
      qryCND.Open;

        While not qryCND.eof do
        Begin
          strDupCre := strDupCre + ' ' + qryCND.FieldByName('DUPCRE').AsString + '-' ;
          strNumDup := Copy(qryCND.FieldByName('DUPCRE').AsString,1,12);
          strCodEmp := qryCND.FieldByName('CTR_CODEMP').AsString;
          strDupCre := strDupCre + fMontaDuplicatasdeCredito(cdsMovGer,strNumDup,strCodEmp) + #13#10 ;
          qryCND.Next;
        End;

        cdsMovGer.FieldByName('DUPCRE').AsString :=  strDupCre;
    Finally
      FreeAndNil(qryCND);
    End;
  End;
end;

procedure TLeDocumentoMIFF.pMontaDuplicatasdeCreditoComProdutos(cdsMovGer: TZClient);
var strSQL, strSQLAd: String;
    qryCND: TUniQuery;
    strCampos, strNumDup, strVariaveis, strMontaVar: String;
    fltTotCre : Double;
begin
  strMontaVar := '';
  cdsMovGer.edit;
  Begin
    fltTotCre := 0;

    strSQL := 'SELECT DISTINCT                                                                               '+
              '   CR2.CTR_NUMDUP AS DUPCRE, CR2.CTR_ESPDOC AS ESPCRE,                                         '+
              '   CR2.CTR_CODEMP AS CODEMP, CR2.CTR_VALORI AS VALORI,                                         '+
              '   CR2.CTR_INCDOC AS INCDOC                                                                    '+
              'FROM MOVGER MG LEFT JOIN CADREC CR1 ON                                                         '+
              '  CR1.CTR_NUMDUP = MG.GER_NUMDOC                                                               '+
              '  AND MG.GER_ESPDOC = CR1.CTR_ESPDOC                                                           '+
              '  AND MG.GER_CODEMP = CR1.CTR_CODEMP                                                           '+
              '  AND MG.GER_CODCLI = CR1.CTR_CODCLI                                                           '+
              '  AND MG.GER_TIP_FC = "C"                                                                      '+
              'LEFT JOIN CADREC CR2 ON                                                                        '+
              '  CR2.CTR_SEQCON = CR1.CTR_SEQCON                                                              '+
              '  AND CR2.CTR_CODCLI = CR1.CTR_CODCLI                                                          '+
              '  AND CR2.CTR_CODEMP = CR1.CTR_CODEMP                                                          '+
              '  AND CR2.CTR_VALORI < 0                                                                       '+
              '  AND CR2.CTR_DTAREC IS NOT NULL                                                               '+
              'WHERE MG.GER_NUMDOC = :NUMDOC                                                                  '+
              '  AND MG.GER_ESPDOC = :ESPDOC                                                                  '+
              '  AND MG.GER_CODEMP = :CODEMP                                                                  '+
              '  AND MG.GER_TIP_FC = "C"                                                                      '+
              '  AND CR1.CTR_SEQCON > 0                                                                       ';

    Try
      qryCND := fCriaQuery;
      qryCND.Close;
      qryCND.SQL.Clear;
      qryCND.SQL.Add(strSQL);
      qryCND.ParamByName('NUMDOC').AsString := cdsMovGer.FieldByName('NUMDOC').AsString ;
      qryCND.ParamByName('ESPDOC').AsString := cdsMovGer.FieldByName('ESPDOC').AsString ;
      qryCND.ParamByName('CODEMP').AsString := cdsMovGer.FieldByName('CODEMP').AsString ;
      qryCND.Open;

      If fEmptyStr(qryCND.FieldByName('DUPCRE').AsString) Then
      Begin
        strSQLAd := ' SELECT DISTINCT                                                                               '+
                    '   CR2.CTR_NUMDUP AS DUPCRE, CR2.CTR_ESPDOC AS ESPCRE,                                         '+
                    '   CR2.CTR_CODEMP AS CODEMP, CR2.CTR_VALORI AS VALORI,                                         '+
                    '   CR2.CTR_INCDOC AS INCDOC                                                                    '+
                    ' FROM MOVGER MG LEFT JOIN FATGOR FG ON                                                          '+
                    '  FG.FGO_NUMFAT = MG.GER_NUMDOC                                                                '+
                    '  AND FG.FGO_TIPFAT = MG.GER_ESPDOC                                                            '+
                    '  AND FG.FGO_EMPFAT = MG.GER_CODEMP                                                            '+
                    '  AND MG.GER_TIP_FC = "C"                                                                      '+
                    ' LEFT JOIN ADTCLI AC ON                                                                         '+
                    '  AC.ADT_NUMDOC = FG.FGO_NUMDOC                                                                '+
                    '  AND AC.ADT_ESPDOC = FG.FGO_ESPDOC                                                            '+
                    '  AND AC.ADT_EMPLAN = FG.FGO_CODEMP                                                            '+
                    '  AND AC.ADT_TIPLAN = "C"                                                                      '+
                    ' LEFT JOIN CADREC CR2 ON                                                                        '+
                    '  CR2.CTR_SEQCON = AC.ADT_SEQCON                                                               '+
                    '  AND CR2.CTR_CODCLI = AC.ADT_CODCLI                                                           '+
                    '  AND CR2.CTR_CODEMP = AC.ADT_CODEMP                                                           '+
                    '  AND CR2.CTR_VALORI < 0                                                                       '+
                    '  AND CR2.CTR_DTAREC IS NOT NULL                                                               '+
                    ' WHERE MG.GER_NUMDOC = :NUMDOC                                                                  '+
                    '  AND MG.GER_ESPDOC = :ESPDOC                                                                  '+
                    '  AND MG.GER_CODEMP = :CODEMP                                                                  '+
                    '  AND MG.GER_TIP_FC = "C"                                                                      ';


        qryCND.Close;
        qryCND.SQL.Clear;
        qryCND.SQL.Add(strSQLAd);
        qryCND.ParamByName('NUMDOC').AsString := cdsMovGer.FieldByName('NUMDOC').AsString ;
        qryCND.ParamByName('ESPDOC').AsString := cdsMovGer.FieldByName('ESPDOC').AsString ;
        qryCND.ParamByName('CODEMP').AsString := cdsMovGer.FieldByName('CODEMP').AsString ;
        qryCND.Open;
      End;

      If Not fEmptyStr(qryCND.FieldByName('DUPCRE').AsString) Then
      Begin
        While not qryCND.eof do
        Begin
          strNumDup := 'DOCUMENTO: ' + qryCND.FieldByName('DUPCRE').AsString + '-' + qryCND.FieldByName('ESPCRE').AsString;
          strCampos := 'CÓD. ITEM | DESCRIÇÃO DO ITEM              | QUANTIDADE |  VALOR  |   DOCUMENTO   |';
          strVariaveis := fMontaProdutosDupCredito(qryCND.FieldByName('DUPCRE').AsString,
                                                   qryCND.FieldByName('ESPCRE').AsString,
                                                   qryCND.FieldByName('CODEMP').AsString,
                                                   qryCND.FieldByName('INCDOC').AsString);
          strMontaVar := strMontaVar + strNumDup + #13#10 + strCampos + #13#10 + strVariaveis + #13#10  + 'TOTAL DE CRÉDITOS UTILIZADOS: R$ ' + FormatFloat('###,##0.00',qryCND.FieldByName('VALORI').asFloat)  + #13#10 + #13#10;
          fltTotCre := fltTotCre + qryCND.FieldByName('VALORI').AsFloat;
          qryCND.Next;
        End;

        cdsMovGer.FieldByName('DUPPRO').AsString :=  strMontaVar;
        cdsMovGer.FieldByName('TOTCRE').AsString :=  FloatToStr(fltTotCre * -1);
      End;
    Finally
      FreeAndNil(qryCND);
    End;
  End;
end;

procedure TLeDocumentoMIFF.pMontaItensEstrutura;
var
  qryItensEstrutura: TUniQuery;
  stlItensEstrutura: TStringList;
begin

  if cdsMovdet.IsEmpty then
    Exit;

  stlItensEstrutura := TStringList.Create;
  qryItensEstrutura := fCriaQuery(Nil);

  Try
    cdsMovdet.First;
    while not cdsMovdet.Eof Do
    Begin

      qryItensEstrutura.SQL.Clear;
      qryItensEstrutura.SQL.Add('SELECT                                   ');
      qryItensEstrutura.SQL.Add('  DMT_ITESUB,                            ');
      qryItensEstrutura.SQL.Add('  ITE2.ITE_DESITE,                       ');
      qryItensEstrutura.SQL.Add('  ROUND(DMT_QTDITE,'+IntToStr(StrToIntDef(fCfgSis('DECUNI', varInteger),2))+') AS DMT_QTDITE, ');
      qryItensEstrutura.SQL.Add('  ITG.ITE_LOCFIS                         ');
      qryItensEstrutura.SQL.Add('FROM                                     ');
      qryItensEstrutura.SQL.Add('  DETMAT DMT                             ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN GERMAT GMT                   ');
      qryItensEstrutura.SQL.Add('    ON GMT.AUTOINCREM = DMT.DMT_SEQGER   ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN CADITE ITE1                  ');
      qryItensEstrutura.SQL.Add('    ON ITE1.ITE_CODITE = GMT.GMT_CODITE  ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN ITEGER ITG                   ');
      qryItensEstrutura.SQL.Add('    ON ITG.ITE_CODITE = ITE1.ITE_CODITE  ');
      qryItensEstrutura.SQL.Add('    AND ITG.ITE_CODEMP = DMT.DMT_CODEMP  ');
      qryItensEstrutura.SQL.Add('  LEFT JOIN CADITE ITE2                  ');
      qryItensEstrutura.SQL.Add('    ON ITE2.ITE_CODITE = DMT.DMT_ITESUB  ');
      qryItensEstrutura.SQL.Add('WHERE ITE1.ITE_CODITE = :CODITE          ');
      qryItensEstrutura.ParamByName('CODITE').AsString := cdsMovdet.FieldByName('CODITE').AsString;
      qryItensEstrutura.Open;

      qryItensEstrutura.First;
      While Not qryItensEstrutura.Eof do
      Begin
        stlItensEstrutura.Add(qryItensEstrutura.FieldByName('DMT_ITESUB').AsString+' | '+
                              fPadR(qryItensEstrutura.FieldByName('ITE_DESITE').AsString, 60, ' ')+' | '+
                              qryItensEstrutura.FieldByName('DMT_QTDITE').AsString+' | '+
                              qryItensEstrutura.FieldByName('ITE_LOCFIS').AsString);
        qryItensEstrutura.Next;
      End;

      cdsMovdet.Edit;
      cdsMovdet.FieldByName('ESTRUT').AsString := stlItensEstrutura.Text;
      cdsMovdet.Post;

      cdsMovdet.Next;
      stlItensEstrutura.Clear;
    end;

    FreeAndNil(stlItensEstrutura);
    FreeAndNil(qryItensEstrutura);

  except
    on E: Exception do
    begin
      fRollBack;
      FreeAndNil(stlItensEstrutura);
      FreeAndNil(qryItensEstrutura);
      pMensagensErro(E.Message, '[TLeDocumentoMIFF.pMontaItensEstrutura]');
    end;
  end;

end;

procedure TLeDocumentoMIFF.pMontaListaClassificacao;
   Var
     intCount: Integer;
Begin
  With cdsMovDet Do
  Begin
    First;
    While Not Eof Do
    Begin
      If Not fEmptyStr(FieldByName('CLAIPI').AsString) Then
        FClaIpi.Add(FieldByName('CLAIPI').AsString);

      If Not fEmptyStr(FieldByName('SETOR_').AsString) Then
        FSetores.Add(FieldByName('SETOR_').AsString);

      Next;
    End;
    First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('LEGEND').AsString := IfThen(FClaIpi.IndexOf(FieldByName('CLAIPI').AsString) >= 0, fGetLetraAlfa(FClaIpi.IndexOf(FieldByName('CLAIPI').AsString) + 1), '');
      Post;
      Next;
    End;

    First;
  End;

  FLegIPI := '';
  For intCount := 1 To FClaIpi.Count Do
  Begin
    FLegIPI := FLegIPI + ' ' + fGetLetraAlfa(intCount) + ': ' + FClaIpi[intCount - 1];
  End;
end;

Function TLeDocumentoMIFF.fSQLPercentualDesconto: String;
  Var
    strSQL: String;

  function fFloatToSQL(fltValor: Double): String;
  begin
    Result := FormatFloat(fMskDigitos(4),fltValor);
    Result := StringReplace(Result,'.','',[rfReplaceAll]);
    Result := StringReplace(Result,',','.',[rfReplaceAll]);
  end;

Begin
  blnDesCon := False;
  strSQL := ' GER_PORDES ';

  With recDocume Do
  Begin
    If (blnExibirValorBrutoSeEstiverUsandoDescontoClienteProfissional) Then
    Begin
      If ((fCfgSis('PDVLBR') = '1') Or (fCfgSis('PDVLAV') = '1')) Then
      Begin
        If (strEspDoc = 'DV') Then
          strSQL := ' '+fFloatToSQL(fltPorDesFFOri)+' '
        Else
          strSQL := ' GER_PORDES '
      End
      Else If ((fCfgSis('PDVLBR') = '2') Or (fCfgSis('PDVLAV') = '2')) Then
      Begin
        strSQL := ' CLI_DESCON ';
        blnDesCon := True;
      End;
    End;
  End;

  Result := strSQL;
End;

Function TLeDocumentoMIFF.fExisteCampo(strCampo: String): String;
Begin
  If recDocume.blnRequisicao Then
    Result := 'CAST("" AS CHAR(1))'
  Else
    Result := strCampo;
End;

Function TLeDocumentoMIFF.fSQLMovGer: String;
  Var
    strSQL: String;

  Function fSQLJoinAuxMov(strTabAux: String): String;
  Begin
    Result := '';
    Result := Result + '  LEFT JOIN ' + strTabAux + ' ON AUX_SEQGER = G.AUTOINCREM  ';

    If Pos('AUXNOT', strTabAux) <= 0 Then
    Begin
      Result := Result + '  LEFT JOIN CADVEI VE ON VE.VEI_PLAVEI = AUX_PLAVEI    ';
      Result := Result + '  LEFT JOIN MARVEI MV ON MV.MAR_CODMAR = VE.VEI_CODMAR ';
      Result := Result + '  LEFT JOIN MODVEI MO ON MO.MOD_CODMOD = VE.VEI_CODMOD ';
      Result := Result + '  LEFT JOIN CORVEI CO ON CO.COR_CODCOR = VE.VEI_CODCOR ';
      Result := Result + '  LEFT JOIN CADTRA TR ON AUX_TRARDP = TR.TRA_CODTRA    ';
      Result := Result + '  LEFT JOIN CADCID CTR ON CTR.CID_CODCID = TR.TRA_CODCID  ';
      Result := Result + '  LEFT JOIN CADPRJ PR  ON  PR.PRJ_CODPRJ = AUX_CODPRJ  ';
      Result := Result + '  LEFT JOIN CADOPE OP  ON  OP.OPE_CODOPE = AUX_OPESOL  ';
      Result := Result + '  LEFT JOIN CADOPE OE  ON  OE.OPE_CODOPE = AUX_OPFAEX  ';
      Result := Result + '  LEFT JOIN FINAJU FJ ON FJ.FAJ_CODIGO = AUX_FINAJU ';
      Result := Result + '  LEFT JOIN ENTCLI EC ON EC.AUTOINCREM = AUX_ENTGER ';
      Result := Result + '  LEFT JOIN CADREG CDR ON CDR.REG_CODREG = EC.ETC_CODREG ';
    End;
  End;

  Function fSQLCamposAuxMov(strTabAux: String): String;
  Begin
    Result := '';
    Result := Result + ' AUX_CODFAZ AS GER_CODFAZ, ';

    Result := Result + IIF(fCampoExiste(strTabAux, 'AUX_TOTCBS'), ' IFNULL(' + strTabAux + '.AUX_TOTCBS, 0)', ' 0.00') + ' AS TOTCBS, ';
    Result := Result + IIF(fCampoExiste(strTabAux, 'AUX_TOTIBS'), ' IFNULL(' + strTabAux + '.AUX_TOTIBS, 0)', ' 0.00') + ' AS TOTIBS, ';
    Result := Result + IIF(fCampoExiste(strTabAux, 'AUX_TOT_IS'), ' IFNULL(' + strTabAux + '.AUX_TOT_IS, 0)', ' 0.00') + ' AS TOT_IS, ';

    If Pos('AUXNOT', strTabAux) > 0 Then
    Begin
      Result := Result + ' CONCAT(LEFT(AUX_PLAVEI,3),"-",RIGHT(AUX_PLAVEI,4)) AS PLAVEI, ';
      Result := Result + ' AUX_KM_VEI AS KM_VEI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS ANOVEI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS MARVEI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS MODVEI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS CORVEI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS NUMGUI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS TRARDP, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPNOM, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPEND, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPIES, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPCGC, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPFON, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPBAI, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPCEP, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPCID, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS RDPEST, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS CODPRJ, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS NOMPRJ, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS NOMSOL, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS NOPFEX, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS FINAJU, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS DESFAJ, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS FINAJU, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS DESFAJ, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS REGENT, ';
      Result := Result + ' CAST("" AS CHAR(1)) AS CELCON, ';
    End
    Else
    Begin
      Result := Result + ' CONCAT(LEFT(AUX_PLAVEI,3),"-",RIGHT(AUX_PLAVEI,4)) AS PLAVEI, ';
      Result := Result + ' AUX_KM_VEI AS KM_VEI,    ';
      Result := Result + ' VE.VEI_ANOVEI AS ANOVEI, ';
      Result := Result + ' MV.MAR_DESMAR AS MARVEI, ';
      Result := Result + ' MO.MOD_DESMOD AS MODVEI, ';
      Result := Result + ' CO.COR_DESCOR AS CORVEI, ';
      Result := Result + ' ' + strTabAux + '.AUX_NUMGUI AS NUMGUI, ';
      Result := Result + ' AUX_TRARDP    AS TRARDP, ';
      Result := Result + ' TR.TRA_NOMTRA AS RDPNOM, ';
      Result := Result + ' TR.TRA_ENDERE AS RDPEND, ';
      Result := Result + ' TR.TRA_I_E_S_ AS RDPIES, ';
      Result := Result + ' TR.TRA_C_G_C_ AS RDPCGC, ';
      Result := Result + ' TR.TRA_FONE01 AS RDPFON, ';
      Result := Result + ' TR.TRA_BAIRRO AS RDPBAI, ';
      Result := Result + ' TR.TRA_C_E_P_ AS RDPCEP, ';
      Result := Result + ' CTR.CID_NOMCID AS RDPCID, ';
      Result := Result + ' CTR.CID_ESTADO AS RDPEST, ';
      Result := Result + ' AUX_CODPRJ     AS CODPRJ, ';
      Result := Result + ' PR.PRJ_DESPRJ  AS NOMPRJ, ';
      Result := Result + ' OP.OPE_NOMOPE  AS NOMSOL, ';
      Result := Result + ' OE.OPE_NOMOPE  AS NOPFEX, ';
      Result := Result + ' AUX_FINAJU AS FINAJU, ';
      Result := Result + ' FAJ_DESCRI AS DESFAJ, ';
      Result := Result + ' AUX_FINAJU AS FINAJU, ';
      Result := Result + ' FAJ_DESCRI AS DESFAJ, ';
      Result := Result + ' CDR.REG_DESREG AS REGENT, ';
      Result := Result + ' AUX_CELCON AS CELCON, ';
    End;
  End;

Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';
  strSQL := strSQL + '  GER_SERIE_ AS SERDOC, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_HORENT AS HORENT, ';
  strSQL := strSQL + '  GER_DTAFAT AS DTAFAT, ';
  strSQL := strSQL + '  DATE_FORMAT(GER_DTADOC, "%d/%m/%Y") AS DTADOC, ';

  strSQL := strSQL + '     GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  OV.OPE_NOMOPE AS NOMVEN, ';
  strSQL := strSQL + '  OV.OPE_E_MAIL AS EMAVEN, ';
  strSQL := strSQL + '  OV.OPE_FONE01 AS FO1VEN, ';
  strSQL := strSQL + '  OV.OPE_FONE02 AS FO2VEN, ';

  strSQL := strSQL + fExisteCampo('GER_SEPEXP') + ' AS SEPEXP, ';
  strSQL := strSQL + 'GER_MEN001 AS OBS_TA, ';
  strSQL := strSQL + fExisteCampo('OS.OPE_NOMOPE') + ' AS NSEPEX, ';

  strSQL := strSQL + fExisteCampo('GER_OPEEXP') + ' AS OPEEXP, ';
  strSQL := strSQL + fExisteCampo('OX.OPE_NOMOPE') + ' AS NOMEXP, ';
  strSQL := strSQL + fExisteCampo('OX.OPE_NOMOPE') + ' AS NOPEEX, ';

  strSQL := strSQL + '     GER_CODDIG AS CODDIG, ';
  strSQL := strSQL + '  OD.OPE_NOMOPE AS NOMDIG, ';

  strSQL := strSQL + fExisteCampo('GER_CONSUM') + ' AS CONSUM, ';
  strSQL := strSQL + '  GER_CONPAG AS CONPAG, ';
  strSQL := strSQL + '  CAST("S" AS CHAR(1)) AS AVISTA, ';
  strSQL := strSQL + '  GER_CODCND AS CODCND, ';
  strSQL := strSQL + '  CND_DESCRI AS DESCND, ';
  strSQL := strSQL + '  CND_PRZMED AS CNDPRZ, ';

  strSQL := strSQL + '  GER_CODFPG AS CODFPG, ';
  strSQL := strSQL + '  FPG_DESCRI AS DESFPG, ';

  If recDocume.strEspDoc = 'RL' Then
  Begin
    strSQL := strSQL + ' IFNULL(EQF_TAXENT,0) AS TAXENT, ';
    strSQL := strSQL + ' CONEQL.EQL_NROCON AS NROCON,    ';
    strSQL := strSQL + ' DATE_FORMAT(EQF_DTAREF, "%d/%m/%Y")  AS DTAREF, ';
    strSQL := strSQL + ' DATE_FORMAT(EQF_HORREF, "%h:%m")   AS HORREF, ';
    strSQL := strSQL + ' EQF_FATOBS AS FATOBS, ';
    strSQL := strSQL + ' DATE_FORMAT(EQF_DTAREF, "%m/%Y")  AS MESREF, ';
    strSQL := strSQL + ' CONEQL.EQL_PEDCOM AS EQLPDC, ';
    strSQL := strSQL + ' EQL_CODIGO AS CODEQP, ';
    strSQL := strSQL + ' EQL_DESCRI AS DESEQP, ';
    strSQL := strSQL + ' FORMAT(D.EQD_TOTEQL, 2, "de_DE") AS TOTEQL, ';
    strSQL := strSQL + ' EQL_DECLAR AS DECLAR, ';
    strSQL := strSQL + ' FORMAT(EQL_TOTCON, 2, "de_DE") AS TOTCON, ';
  End
  else
  begin
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS TAXENT, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS NROCON, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS DTAREF, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS HORREF, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS FATOBS, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS MESREF, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS EQLPDC, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CODEQP, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS DESEQP, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS TOTEQL, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS DECLAR, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS TOTCON, ';
  end;

  strSQL := strSQL + ' CONCAT(CR.CTR_NUMDUP,"-",CR.CTR_ESPDOC,"-",CR.CTR_CODEMP) AS NUMDUP, ';
  strSQL := strSQL + ' DATE_FORMAT(CR.CTR_DTAVEN, "%d/%m/%Y") AS VENDUP, ';
  strSQL := strSQL + ' FORMAT(CR.CTR_VALDUP, 2, "de_DE") AS VALDUP, ';

  strSQL := strSQL + fExisteCampo('GER_CLAFIS') + ' AS CLAFIS, ';
  strSQL := strSQL + fExisteCampo('GER_CLAFIS') + ' AS CLA123, ';
  strSQL := strSQL + fExisteCampo('GER_CLAFI2') + ' AS CLAFI2, ';
  strSQL := strSQL + fExisteCampo('GER_CLAFI3') + ' AS CLAFI3, ';

  strSQL := strSQL + fExisteCampo('GER_TOTPRO') + ' AS TOTPRO, ';
  strSQL := strSQL + '  GER_TOTCUS AS TOTCUS, ';
  strSQL := strSQL + '  GER_DESESP AS DESESP, ';

  strSQL := strSQL +  fSQLPercentualDesconto + ' AS PORDES, ';

  strSQL := strSQL + fExisteCampo('GER_BASRET') + ' AS BASRET, ';
  strSQL := strSQL + fExisteCampo('GER_ALQRET') + ' AS ALQRET, ';
  strSQL := strSQL + fExisteCampo('GER_TOTRET') + ' AS TOTRET, ';

  strSQL := strSQL + fExisteCampo('GER_BARTSP') + ' AS BARTSP, '; // ?
  strSQL := strSQL + fExisteCampo('GER_RET_SP') + ' AS RET_SP, '; // ?
  strSQL := strSQL + fExisteCampo('GER_VLRTSP') + ' AS VLRTSP, '; // ?

  strSQL := strSQL + fExisteCampo('GER_BASICM') + ' AS BASICM, ';
  strSQL := strSQL + fExisteCampo('GER_ALQICM') + ' AS ALQICM, ';
  strSQL := strSQL + fExisteCampo('GER_TOTICM') + ' AS TOTICM, ';

  strSQL := strSQL + fExisteCampo('GER_BASIPI') + ' AS BASIPI, ';
  strSQL := strSQL + fExisteCampo('GER_ALQIPI') + ' AS ALQIPI, ';
  strSQL := strSQL + fExisteCampo('GER_TOTIPI') + ' AS TOTIPI, ';

  If recDocume.blnPenExp Then
    strSQL := strSQL + ' CAST("S" AS CHAR(1)) AS IMPDPN, '
  Else
    strSQL := strSQL + ' CAST("N" AS CHAR(1)) AS IMPDPN, ';

  strSQL := strSQL + '  GER_CODTRA        AS CODTRA, ';
  strSQL := strSQL + '  CADTRA.TRA_NOMTRA AS NOMTRA, ';
  strSQL := strSQL + '  CADTRA.TRA_ENDERE AS ENDTRA, ';
  strSQL := strSQL + '  CADTRA.TRA_BAIRRO AS BAITRA, ';
  strSQL := strSQL + '  CADTRA.TRA_C_E_P_ AS CEPTRA, ';
  strSQL := strSQL + '  CADTRA.TRA_FONE01 AS FONTRA, ';
  strSQL := strSQL + '  CT.CID_NOMCID AS CIDTRA, ';
  strSQL := strSQL + '  CT.CID_ESTADO AS ESTTRA, ';

  strSQL := strSQL + '  GER_TIPFRE AS TIPFRE, ';
  strSQL := strSQL +    fSQLTipoFrete('GER_TIPFRE') +
                                 ' AS DESFRE, ';
  strSQL := strSQL + '  GER_TOTFRE AS TOTFRE, ';
  strSQL := strSQL + '  GER_PESBRU AS PESBRU, ';
  strSQL := strSQL + '  GER_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '  GER_VOLUME AS VOLUME, ';

  strSQL := strSQL + fExisteCampo('GER_NCONHE') + ' AS NCONHE, '; //?
  strSQL := strSQL + fExisteCampo('GER_BASSIM') + ' AS BASSIM, '; //?
  strSQL := strSQL + '  GER_MARCA_ AS MARCA_, '; //?
  strSQL := strSQL + '  GER_ESPECI AS ESPECI, '; //?

  strSQL := strSQL + ' GER_MENEXP AS MENEXP, ';
  strSQL := strSQL + ' GER_MENEX2 AS MENEX2, ';
  strSQL := strSQL + ' GER_MENEX3 AS MENEX3, ';
  strSQL := strSQL + ' GER_MENEX4 AS MENEX4, ';

  strSQL := strSQL + '  GER_MEN001 AS MEN001, ';
  strSQL := strSQL + '  GER_MEN002 AS MEN002, ';
  strSQL := strSQL + '  GER_MEN003 AS MEN003, ';
  strSQL := strSQL + '  GER_MEN004 AS MEN004, ';
  strSQL := strSQL + '  GER_MEN005 AS MEN005, ';

  If fCfgSis('BFUT49', varBoolean) And ((fCfgSis('PEFF11', varString)='2') Or (fCfgSis('PEFF11', varString)='3')) Then
  begin
    strSQL := strSQL + ' ( SELECT DISTINCT ';
    strSQL := strSQL + '     IF( ';
    strSQL := strSQL + '         ((X.GER_CLAFIS > "5000") AND (LOCATE("922", X.GER_CLAFIS) > 0) AND (X.DET_MOTFUT = "F")), ';
    strSQL := strSQL + '         "FATURAMENTO ANTECIPADO", ';
    strSQL := strSQL + '         X.GER_NATOPE) AS NATOPE ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + '     (SELECT D.DET_MOTFUT, ';
    strSQL := strSQL + '             G.GER_CLAFIS, ';
    strSQL := strSQL + '             G.GER_NATOPE ';
    strSQL := strSQL + '        FROM MOVDET D ';
    strSQL := strSQL + '        JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
    strSQL := strSQL + '       WHERE D.DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '         AND D.DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '         AND D.DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '        GROUP BY D.DET_MOTFUT) AS X) AS NATOPE, ';
  end
  else
  begin
    strSQL := strSQL + '  GER_NATOPE AS NATOPE, ';
  end;

  strSQL := strSQL + '  GER_PRAENT AS PRAENT, ';
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, ';
  strSQL := strSQL + '  GER_VALISS AS VALISS, ';
  strSQL := strSQL + '  GER_PERISS AS PERISS, ';
  strSQL := strSQL + '  CAST(0.00 AS DECIMAL(12,2)) AS TOSEOR, ';
  strSQL := strSQL + fExisteCampo('GER_DESACE') + ' AS DESACE, ';

  strSQL := strSQL + fExisteCampo('GER_ALQIRF') + ' AS ALQIRF, ';
  strSQL := strSQL + fExisteCampo('GER_VALIRF') + ' AS VALIRF, ';

  strSQL := strSQL + fExisteCampo('GER_ALQPIS') + ' AS ALQPIS, ';
  strSQL := strSQL + fExisteCampo('GER_VALPIS') + ' AS VALPIS, ';
  strSQL := strSQL + fExisteCampo('GER_PISRET') + ' AS PISRET, ';

  strSQL := strSQL + fExisteCampo('GER_ALQCOF') + ' AS ALQCOF, ';
  strSQL := strSQL + fExisteCampo('GER_VALCOF') + ' AS VALCOF, ';
  strSQL := strSQL + fExisteCampo('GER_COFRET') + ' AS COFRET, ';

  strSQL := strSQL + fExisteCampo('GER_ALQCSL') + ' AS ALQCSL, ';
  strSQL := strSQL + fExisteCampo('GER_VALCSL') + ' AS VALCSL, ';
  strSQL := strSQL + fExisteCampo('GER_CSLRET') + ' AS CSLRET, ';

  strSQL := strSQL + fExisteCampo('GER_NOTRET') + ' AS NOTRET, ';
  strSQL := strSQL + fExisteCampo('GER_IRFRET') + ' AS IRFRET, ';

  strSQL := strSQL + fExisteCampo('GER_SERRET') + ' AS SERRET, ';
  strSQL := strSQL + fExisteCampo('GER_NORESE') + ' AS NORESE, ';

  strSQL := strSQL + fExisteCampo('GER_IRPRRT') + ' AS IRPRRT, ';
  strSQL := strSQL + fExisteCampo('GER_IRPRDV') + ' AS IRPRDV, ';
  strSQL := strSQL + fExisteCampo('GER_IRSERT') + ' AS IRSERT, ';
  strSQL := strSQL + fExisteCampo('GER_IRSEDV') + ' AS IRSEDV, ';

  strSQL := strSQL + fExisteCampo('GER_PIPRRT') + ' AS PIPRRT, ';
  strSQL := strSQL + fExisteCampo('GER_PIPRDV') + ' AS PIPRDV, ';
  strSQL := strSQL + fExisteCampo('GER_PISERT') + ' AS PISERT, ';
  strSQL := strSQL + fExisteCampo('GER_PISEDV') + ' AS PISEDV, ';

  strSQL := strSQL + fExisteCampo('GER_COPRRT') + ' AS COPRRT, ';
  strSQL := strSQL + fExisteCampo('GER_COPRDV') + ' AS COPRDV, ';
  strSQL := strSQL + fExisteCampo('GER_COSERT') + ' AS COSERT, ';
  strSQL := strSQL + fExisteCampo('GER_COSEDV') + ' AS COSEDV, ';

  strSQL := strSQL + fExisteCampo('GER_CSPRRT') + ' AS CSPRRT, ';
  strSQL := strSQL + fExisteCampo('GER_CSPRDV') + ' AS CSPRDV, ';
  strSQL := strSQL + fExisteCampo('GER_CSSERT') + ' AS CSSERT, ';
  strSQL := strSQL + fExisteCampo('GER_CSSEDV') + ' AS CSSEDV, ';

  strSQL := strSQL + fExisteCampo('GER_VLSGSO') + ' AS VLSGSO, ';
  strSQL := strSQL + fExisteCampo('GER_PESGSO') + ' AS PESGSO, ';
  strSQL := strSQL + fExisteCampo('GER_BASORG') + ' AS BASORG, ';

  strSQL := strSQL + fExisteCampo('GER_ICMORG') + ' AS ICMORG, ';

  strSQL := strSQL + fExisteCampo('GER_ENTFAT') + ' AS ENTFAT, ';
  strSQL := strSQL + fExisteCampo('GER_DTENTR') + ' AS DTENTR, ';
  strSQL := strSQL + fExisteCampo('IFNULL(GER_CONENT, "N")') + ' AS CONENT, ';

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
    strSQL := strSQL + fExisteCampo('IFNULL(GER_CONENT, "N")') + ' AS ENTMAT, '
  Else
    strSQL := strSQL + '  CAST("N" AS CHAR(1)) AS ENTMAT, ';

  strSQL := strSQL + fExisteCampo('GER_NOTESP') + ' AS NOTESP, ';
  strSQL := strSQL + fExisteCampo('GER_TIP_FC') + ' AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';

  If (blnExibirValorBrutoSeEstiverUsandoDescontoClienteProfissional) Then
    strSQL := strSQL + ' GER_VLRCON / ((100 - ' + fSQLPercentualDesconto + ') / 100) AS VLRCON, '
  Else
    strSQL := strSQL + ' GER_VLRCON AS VLRCON, ';

  strSQL := strSQL + fExisteCampo('GER_NROCEI') + ' AS NROCEI, ';

  strSQL := strSQL + fExisteCampo('GER_NUMFAT') + ' AS NUMFAT, '; // ?
  strSQL := strSQL + fExisteCampo('GER_TIPFAT') + ' AS TIPFAT, '; // ?
  strSQL := strSQL + fExisteCampo('GER_EMPFAT') + ' AS EMPFAT, '; // ?

  strSQL := strSQL + '  0.00    AS DEBCLI, '; // ? DEBITOS DO CLIENTE - ESTÁ SENDO PASSADO COMO PARAMETRO

  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS PEDEXP, '; // Pedidos expedidos que geraram a MI/FF

  //DADOS DA ASSINATURA WACOM (TABELA ASSGER)
  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + '  ASS_NOMASS AS NOMASS, ';
    strSQL := strSQL + '  ASS_MOTASS AS MOTASS, ';
    strSQL := strSQL + '  ASS_DTAASS AS DTAASS, ';
    strSQL := strSQL + '  FROM_BASE64(ASS_IMGASS) AS IMGASS, ';
  End
  Else
  Begin
    strSQL := strSQL + '  CAST(NULL AS CHAR(255)) AS NOMASS, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(255)) AS MOTASS, ';
    strSQL := strSQL + '  CAST(NULL AS DATE)      AS DTAASS, ';
    strSQL := strSQL + '  CAST(NULL AS CHAR(255)) AS IMGASS, ';
  End;

// CAMPOS ALTERADOS APOS A LEITURA - INICIO
  strSQL := strSQL + '  GER_VPAR01 AS VPAR01, ';
  strSQL := strSQL + '  GER_VPAR02 AS VPAR02, ';
  strSQL := strSQL + '  GER_VPAR03 AS VPAR03, ';
  strSQL := strSQL + '  GER_VPAR04 AS VPAR04, ';
  strSQL := strSQL + '  GER_VPAR05 AS VPAR05, ';
  strSQL := strSQL + '  GER_VPAR06 AS VPAR06, ';
  strSQL := strSQL + '  GER_VPAR07 AS VPAR07, ';
  strSQL := strSQL + '  GER_VPAR08 AS VPAR08, ';
  strSQL := strSQL + '  GER_VPAR09 AS VPAR09, ';
  strSQL := strSQL + '  GER_VPAR10 AS VPAR10, ';
  strSQL := strSQL + '  GER_VPAR11 AS VPAR11, ';
  strSQL := strSQL + '  GER_VPAR12 AS VPAR12, ';
  strSQL := strSQL + '  0.00       AS VPAR13, ';
  strSQL := strSQL + '  0.00       AS VPAR14, ';
  strSQL := strSQL + '  0.00       AS VPAR15, ';
  strSQL := strSQL + '  0.00       AS VPAR16, ';
  strSQL := strSQL + '  0.00       AS VPAR17, ';
  strSQL := strSQL + '  0.00       AS VPAR18, ';
  strSQL := strSQL + '  0.00       AS VPAR19, ';
  strSQL := strSQL + '  0.00       AS VPAR20, ';
  strSQL := strSQL + '  0.00       AS VPAR21, ';
  strSQL := strSQL + '  0.00       AS VPAR22, ';
  strSQL := strSQL + '  0.00       AS VPAR23, ';
  strSQL := strSQL + '  0.00       AS VPAR24, ';
  strSQL := strSQL + '  AUX_PRZMED AS AUXPRZ, ';
  strSQL := strSQL + fExisteCampo('AUX_VALADT') + ' AS VALADT, ';

  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV01, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV02, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV03, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV04, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV05, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV06, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV07, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV08, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV09, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV10, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV11, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV12, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV13, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV14, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV15, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV16, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV17, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV18, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV19, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV20, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV21, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV22, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV23, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAV24, ';

  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS SEQCON, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS SEQCOE, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS DUPLIC, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS LSTREC, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS FORPAG, ';

  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS LEGIPI, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS SETORG, ';

  strSQL := strSQL + '  0.00                 AS PRZMED, ';
  strSQL := strSQL + '  0.00                 AS VALBRU, ';
  strSQL := strSQL + '  0.00                 AS DESTOT, ';

  strSQL := strSQL + '  0.00                 AS TOTENT, ';
  strSQL := strSQL + '  0.00                 AS TOTSAI, ';
  strSQL := strSQL + '  0.00                 AS TOTDIG, ';
  strSQL := strSQL + '  0.00                 AS TOTORI, ';

  strSQL := strSQL + '  0                    AS NROITE, ';
  strSQL := strSQL + '  0.00                 AS TOTQTD, ';

  strSQL := strSQL + '  0.00                 AS TOTCPR, ';
  strSQL := strSQL + '  0.00                 AS TOTSPR, ';
  strSQL := strSQL + '  0.00                 AS TOTMAI, ';
  strSQL := strSQL + '  0.00                 AS PESTOT, ';
  strSQL := strSQL + '  0.00                 AS TOTTAB, ';

  // CAMPOS DA REQUISICAO
  strSQL := strSQL + '  CAST("" AS CHAR(70)) AS EMPFOR, '; // CODIGO + NOME DA EMPRESA DO FORNECEDOR
  strSQL := strSQL + '  CAST("" AS CHAR(03)) AS CEMPFO, '; // CODIGO DA EMPRESA DO FORNECEDOR
  strSQL := strSQL + '  CAST("" AS CHAR(70)) AS NEMPFO, '; // NOME DA EMPRESA DO FORNECEDOR

//  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS MSGROD, ';
// CAMPOS ALTERADOS APOS A LEITURA - FIM

  {********************}
  {* DADOS FINANCEIRA *}
  {*****************FC*}
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS FINDES, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS VALFIN, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS QTDPAR, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS VALOPE, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS VALPAR, ';
  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS CARTAO, ';

  strSQL := strSQL + '  GER_CODS01 AS CODS01, ';
  strSQL := strSQL + '  GER_CODS02 AS CODS02, ';
  strSQL := strSQL + '  GER_CODS03 AS CODS03, ';
  strSQL := strSQL + '  GER_CODS04 AS CODS04, ';
  strSQL := strSQL + '  GER_CODS05 AS CODS05, ';
  strSQL := strSQL + '  GER_CODS06 AS CODS06, ';
  strSQL := strSQL + '  GER_CODS07 AS CODS07, ';
  strSQL := strSQL + '  GER_CODS08 AS CODS08, ';
  strSQL := strSQL + '  GER_CODS09 AS CODS09, ';
  strSQL := strSQL + '  GER_CODS10 AS CODS10, ';
  strSQL := strSQL + '  GER_CODS11 AS CODS11, ';
  strSQL := strSQL + '  GER_CODS12 AS CODS12, ';
  strSQL := strSQL + '  GER_CODS13 AS CODS13, ';
  strSQL := strSQL + '  GER_CODS14 AS CODS14, ';
  strSQL := strSQL + '  GER_CODS15 AS CODS15, ';
  strSQL := strSQL + '  GER_CODS16 AS CODS16, ';
  strSQL := strSQL + '  GER_CODS17 AS CODS17, ';
  strSQL := strSQL + '  GER_CODS18 AS CODS18, ';
  strSQL := strSQL + '  GER_CODS19 AS CODS19, ';
  strSQL := strSQL + '  GER_CODS20 AS CODS20, ';
  strSQL := strSQL + '  GER_CODS21 AS CODS21, ';
  strSQL := strSQL + '  GER_CODS22 AS CODS22, ';
  strSQL := strSQL + '  GER_CODS23 AS CODS23, ';
  strSQL := strSQL + '  GER_CODS24 AS CODS24, ';
  strSQL := strSQL + '  GER_CODS25 AS CODS25, ';
  strSQL := strSQL + '  GER_CODS26 AS CODS26, ';
  strSQL := strSQL + '  GER_CODS27 AS CODS27, ';
  strSQL := strSQL + '  GER_CODS28 AS CODS28, ';
  strSQL := strSQL + '  GER_CODS29 AS CODS29, ';
  strSQL := strSQL + '  GER_CODS30 AS CODS30, ';

  strSQL := strSQL + '  GER_DESS01 AS DESS01, ';
  strSQL := strSQL + '  GER_DESS02 AS DESS02, ';
  strSQL := strSQL + '  GER_DESS03 AS DESS03, ';
  strSQL := strSQL + '  GER_DESS04 AS DESS04, ';
  strSQL := strSQL + '  GER_DESS05 AS DESS05, ';
  strSQL := strSQL + '  GER_DESS06 AS DESS06, ';
  strSQL := strSQL + '  GER_DESS07 AS DESS07, ';
  strSQL := strSQL + '  GER_DESS08 AS DESS08, ';
  strSQL := strSQL + '  GER_DESS09 AS DESS09, ';
  strSQL := strSQL + '  GER_DESS10 AS DESS10, ';
  strSQL := strSQL + '  GER_DESS11 AS DESS11, ';
  strSQL := strSQL + '  GER_DESS12 AS DESS12, ';
  strSQL := strSQL + '  GER_DESS13 AS DESS13, ';
  strSQL := strSQL + '  GER_DESS14 AS DESS14, ';
  strSQL := strSQL + '  GER_DESS15 AS DESS15, ';
  strSQL := strSQL + '  GER_DESS16 AS DESS16, ';
  strSQL := strSQL + '  GER_DESS17 AS DESS17, ';
  strSQL := strSQL + '  GER_DESS18 AS DESS18, ';
  strSQL := strSQL + '  GER_DESS19 AS DESS19, ';
  strSQL := strSQL + '  GER_DESS20 AS DESS20, ';
  strSQL := strSQL + '  GER_DESS21 AS DESS21, ';
  strSQL := strSQL + '  GER_DESS22 AS DESS22, ';
  strSQL := strSQL + '  GER_DESS23 AS DESS23, ';
  strSQL := strSQL + '  GER_DESS24 AS DESS24, ';
  strSQL := strSQL + '  GER_DESS25 AS DESS25, ';
  strSQL := strSQL + '  GER_DESS26 AS DESS26, ';
  strSQL := strSQL + '  GER_DESS27 AS DESS27, ';
  strSQL := strSQL + '  GER_DESS28 AS DESS28, ';
  strSQL := strSQL + '  GER_DESS29 AS DESS29, ';
  strSQL := strSQL + '  GER_DESS30 AS DESS30, ';

  strSQL := strSQL + '  GER_VALS01 AS VALS01, ';
  strSQL := strSQL + '  GER_VALS02 AS VALS02, ';
  strSQL := strSQL + '  GER_VALS03 AS VALS03, ';
  strSQL := strSQL + '  GER_VALS04 AS VALS04, ';
  strSQL := strSQL + '  GER_VALS05 AS VALS05, ';
  strSQL := strSQL + '  GER_VALS06 AS VALS06, ';
  strSQL := strSQL + '  GER_VALS07 AS VALS07, ';
  strSQL := strSQL + '  GER_VALS08 AS VALS08, ';
  strSQL := strSQL + '  GER_VALS09 AS VALS09, ';
  strSQL := strSQL + '  GER_VALS10 AS VALS10, ';
  strSQL := strSQL + '  GER_VALS11 AS VALS11, ';
  strSQL := strSQL + '  GER_VALS12 AS VALS12, ';
  strSQL := strSQL + '  GER_VALS13 AS VALS13, ';
  strSQL := strSQL + '  GER_VALS14 AS VALS14, ';
  strSQL := strSQL + '  GER_VALS15 AS VALS15, ';
  strSQL := strSQL + '  GER_VALS16 AS VALS16, ';
  strSQL := strSQL + '  GER_VALS17 AS VALS17, ';
  strSQL := strSQL + '  GER_VALS18 AS VALS18, ';
  strSQL := strSQL + '  GER_VALS19 AS VALS19, ';
  strSQL := strSQL + '  GER_VALS20 AS VALS20, ';
  strSQL := strSQL + '  GER_VALS21 AS VALS21, ';
  strSQL := strSQL + '  GER_VALS22 AS VALS22, ';
  strSQL := strSQL + '  GER_VALS23 AS VALS23, ';
  strSQL := strSQL + '  GER_VALS24 AS VALS24, ';
  strSQL := strSQL + '  GER_VALS25 AS VALS25, ';
  strSQL := strSQL + '  GER_VALS26 AS VALS26, ';
  strSQL := strSQL + '  GER_VALS27 AS VALS27, ';
  strSQL := strSQL + '  GER_VALS28 AS VALS28, ';
  strSQL := strSQL + '  GER_VALS29 AS VALS29, ';
  strSQL := strSQL + '  GER_VALS30 AS VALS30, ';

  strSQL := strSQL + '  GER_VALS01 AS VALS01, ';
  strSQL := strSQL + '  GER_VALS02 AS VALS02, ';
  strSQL := strSQL + '  GER_VALS03 AS VALS03, ';
  strSQL := strSQL + '  GER_VALS04 AS VALS04, ';
  strSQL := strSQL + '  GER_VALS05 AS VALS05, ';
  strSQL := strSQL + '  GER_VALS06 AS VALS06, ';
  strSQL := strSQL + '  GER_VALS07 AS VALS07, ';
  strSQL := strSQL + '  GER_VALS08 AS VALS08, ';
  strSQL := strSQL + '  GER_VALS09 AS VALS09, ';
  strSQL := strSQL + '  GER_VALS10 AS VALS10, ';
  strSQL := strSQL + '  GER_VALS11 AS VALS11, ';
  strSQL := strSQL + '  GER_VALS12 AS VALS12, ';
  strSQL := strSQL + '  GER_VALS13 AS VALS13, ';
  strSQL := strSQL + '  GER_VALS14 AS VALS14, ';
  strSQL := strSQL + '  GER_VALS15 AS VALS15, ';
  strSQL := strSQL + '  GER_VALS16 AS VALS16, ';
  strSQL := strSQL + '  GER_VALS17 AS VALS17, ';
  strSQL := strSQL + '  GER_VALS18 AS VALS18, ';
  strSQL := strSQL + '  GER_VALS19 AS VALS19, ';
  strSQL := strSQL + '  GER_VALS20 AS VALS20, ';
  strSQL := strSQL + '  GER_VALS21 AS VALS21, ';
  strSQL := strSQL + '  GER_VALS22 AS VALS22, ';
  strSQL := strSQL + '  GER_VALS23 AS VALS23, ';
  strSQL := strSQL + '  GER_VALS24 AS VALS24, ';
  strSQL := strSQL + '  GER_VALS25 AS VALS25, ';
  strSQL := strSQL + '  GER_VALS26 AS VALS26, ';
  strSQL := strSQL + '  GER_VALS27 AS VALS27, ';
  strSQL := strSQL + '  GER_VALS28 AS VALS28, ';
  strSQL := strSQL + '  GER_VALS29 AS VALS29, ';
  strSQL := strSQL + '  GER_VALS30 AS VALS30, ';

  strSQL := strSQL + '  GER_QTDS01 AS QTDS01, ';
  strSQL := strSQL + '  GER_QTDS02 AS QTDS02, ';
  strSQL := strSQL + '  GER_QTDS03 AS QTDS03, ';
  strSQL := strSQL + '  GER_QTDS04 AS QTDS04, ';
  strSQL := strSQL + '  GER_QTDS05 AS QTDS05, ';
  strSQL := strSQL + '  GER_QTDS06 AS QTDS06, ';
  strSQL := strSQL + '  GER_QTDS07 AS QTDS07, ';
  strSQL := strSQL + '  GER_QTDS08 AS QTDS08, ';
  strSQL := strSQL + '  GER_QTDS09 AS QTDS09, ';
  strSQL := strSQL + '  GER_QTDS10 AS QTDS10, ';
  strSQL := strSQL + '  GER_QTDS11 AS QTDS11, ';
  strSQL := strSQL + '  GER_QTDS12 AS QTDS12, ';
  strSQL := strSQL + '  GER_QTDS13 AS QTDS13, ';
  strSQL := strSQL + '  GER_QTDS14 AS QTDS14, ';
  strSQL := strSQL + '  GER_QTDS15 AS QTDS15, ';
  strSQL := strSQL + '  GER_QTDS16 AS QTDS16, ';
  strSQL := strSQL + '  GER_QTDS17 AS QTDS17, ';
  strSQL := strSQL + '  GER_QTDS18 AS QTDS18, ';
  strSQL := strSQL + '  GER_QTDS19 AS QTDS19, ';
  strSQL := strSQL + '  GER_QTDS20 AS QTDS20, ';
  strSQL := strSQL + '  GER_QTDS21 AS QTDS21, ';
  strSQL := strSQL + '  GER_QTDS22 AS QTDS22, ';
  strSQL := strSQL + '  GER_QTDS23 AS QTDS23, ';
  strSQL := strSQL + '  GER_QTDS24 AS QTDS24, ';
  strSQL := strSQL + '  GER_QTDS25 AS QTDS25, ';
  strSQL := strSQL + '  GER_QTDS26 AS QTDS26, ';
  strSQL := strSQL + '  GER_QTDS27 AS QTDS27, ';
  strSQL := strSQL + '  GER_QTDS28 AS QTDS28, ';
  strSQL := strSQL + '  GER_QTDS29 AS QTDS29, ';
  strSQL := strSQL + '  GER_QTDS30 AS QTDS30, ';

  strSQL := strSQL + '  GER_UNIS01 AS UNIS01, ';
  strSQL := strSQL + '  GER_UNIS02 AS UNIS02, ';
  strSQL := strSQL + '  GER_UNIS03 AS UNIS03, ';
  strSQL := strSQL + '  GER_UNIS04 AS UNIS04, ';
  strSQL := strSQL + '  GER_UNIS05 AS UNIS05, ';
  strSQL := strSQL + '  GER_UNIS06 AS UNIS06, ';
  strSQL := strSQL + '  GER_UNIS07 AS UNIS07, ';
  strSQL := strSQL + '  GER_UNIS08 AS UNIS08, ';
  strSQL := strSQL + '  GER_UNIS09 AS UNIS09, ';
  strSQL := strSQL + '  GER_UNIS10 AS UNIS10, ';
  strSQL := strSQL + '  GER_UNIS11 AS UNIS11, ';
  strSQL := strSQL + '  GER_UNIS12 AS UNIS12, ';
  strSQL := strSQL + '  GER_UNIS13 AS UNIS13, ';
  strSQL := strSQL + '  GER_UNIS14 AS UNIS14, ';
  strSQL := strSQL + '  GER_UNIS15 AS UNIS15, ';
  strSQL := strSQL + '  GER_UNIS16 AS UNIS16, ';
  strSQL := strSQL + '  GER_UNIS17 AS UNIS17, ';
  strSQL := strSQL + '  GER_UNIS18 AS UNIS18, ';
  strSQL := strSQL + '  GER_UNIS19 AS UNIS19, ';
  strSQL := strSQL + '  GER_UNIS20 AS UNIS20, ';
  strSQL := strSQL + '  GER_UNIS21 AS UNIS21, ';
  strSQL := strSQL + '  GER_UNIS22 AS UNIS22, ';
  strSQL := strSQL + '  GER_UNIS23 AS UNIS23, ';
  strSQL := strSQL + '  GER_UNIS24 AS UNIS24, ';
  strSQL := strSQL + '  GER_UNIS25 AS UNIS25, ';
  strSQL := strSQL + '  GER_UNIS26 AS UNIS26, ';
  strSQL := strSQL + '  GER_UNIS27 AS UNIS27, ';
  strSQL := strSQL + '  GER_UNIS28 AS UNIS28, ';
  strSQL := strSQL + '  GER_UNIS29 AS UNIS29, ';
  strSQL := strSQL + '  GER_UNIS30 AS UNIS30, ';

  strSQL := strSQL + '  GER_PARS01 AS PARS01, ';
  strSQL := strSQL + '  GER_PARS02 AS PARS02, ';
  strSQL := strSQL + '  GER_PARS03 AS PARS03, ';
  strSQL := strSQL + '  GER_PARS04 AS PARS04, ';
  strSQL := strSQL + '  GER_PARS05 AS PARS05, ';
  strSQL := strSQL + '  GER_PARS06 AS PARS06, ';
  strSQL := strSQL + '  GER_PARS07 AS PARS07, ';
  strSQL := strSQL + '  GER_PARS08 AS PARS08, ';
  strSQL := strSQL + '  GER_PARS09 AS PARS09, ';
  strSQL := strSQL + '  GER_PARS10 AS PARS10, ';
  strSQL := strSQL + '  GER_PARS11 AS PARS11, ';
  strSQL := strSQL + '  GER_PARS12 AS PARS12, ';
  strSQL := strSQL + '  GER_PARS13 AS PARS13, ';
  strSQL := strSQL + '  GER_PARS14 AS PARS14, ';
  strSQL := strSQL + '  GER_PARS15 AS PARS15, ';
  strSQL := strSQL + '  GER_PARS16 AS PARS16, ';
  strSQL := strSQL + '  GER_PARS17 AS PARS17, ';
  strSQL := strSQL + '  GER_PARS18 AS PARS18, ';
  strSQL := strSQL + '  GER_PARS19 AS PARS19, ';
  strSQL := strSQL + '  GER_PARS20 AS PARS20, ';
  strSQL := strSQL + '  GER_PARS21 AS PARS21, ';
  strSQL := strSQL + '  GER_PARS22 AS PARS22, ';
  strSQL := strSQL + '  GER_PARS23 AS PARS23, ';
  strSQL := strSQL + '  GER_PARS24 AS PARS24, ';
  strSQL := strSQL + '  GER_PARS25 AS PARS25, ';
  strSQL := strSQL + '  GER_PARS26 AS PARS26, ';
  strSQL := strSQL + '  GER_PARS27 AS PARS27, ';
  strSQL := strSQL + '  GER_PARS28 AS PARS28, ';
  strSQL := strSQL + '  GER_PARS29 AS PARS29, ';
  strSQL := strSQL + '  GER_PARS30 AS PARS30, ';

  strSQL := strSQL + '  GER_IDES01 AS IDES01, ';
  strSQL := strSQL + '  GER_IDES02 AS IDES02, ';
  strSQL := strSQL + '  GER_IDES03 AS IDES03, ';
  strSQL := strSQL + '  GER_IDES04 AS IDES04, ';
  strSQL := strSQL + '  GER_IDES05 AS IDES05, ';
  strSQL := strSQL + '  GER_IDES06 AS IDES06, ';
  strSQL := strSQL + '  GER_IDES07 AS IDES07, ';
  strSQL := strSQL + '  GER_IDES08 AS IDES08, ';
  strSQL := strSQL + '  GER_IDES09 AS IDES09, ';
  strSQL := strSQL + '  GER_IDES10 AS IDES10, ';
  strSQL := strSQL + '  GER_IDES11 AS IDES11, ';
  strSQL := strSQL + '  GER_IDES12 AS IDES12, ';
  strSQL := strSQL + '  GER_IDES13 AS IDES13, ';
  strSQL := strSQL + '  GER_IDES14 AS IDES14, ';
  strSQL := strSQL + '  GER_IDES15 AS IDES15, ';
  strSQL := strSQL + '  GER_IDES16 AS IDES16, ';
  strSQL := strSQL + '  GER_IDES17 AS IDES17, ';
  strSQL := strSQL + '  GER_IDES18 AS IDES18, ';
  strSQL := strSQL + '  GER_IDES19 AS IDES19, ';
  strSQL := strSQL + '  GER_IDES20 AS IDES20, ';
  strSQL := strSQL + '  GER_IDES21 AS IDES21, ';
  strSQL := strSQL + '  GER_IDES22 AS IDES22, ';
  strSQL := strSQL + '  GER_IDES23 AS IDES23, ';
  strSQL := strSQL + '  GER_IDES24 AS IDES24, ';
  strSQL := strSQL + '  GER_IDES25 AS IDES25, ';
  strSQL := strSQL + '  GER_IDES26 AS IDES26, ';
  strSQL := strSQL + '  GER_IDES27 AS IDES27, ';
  strSQL := strSQL + '  GER_IDES28 AS IDES28, ';
  strSQL := strSQL + '  GER_IDES29 AS IDES29, ';
  strSQL := strSQL + '  GER_IDES30 AS IDES30, ';

  strSQL := strSQL + '  GER_SEROBS AS SEROBS, ';

  strSQL := strSQL + '  CONCAT(IFNULL(CLI_NOMCTT, ""), ' +
    ' IF(IFNULL(CLI_TELCTT, "") = "", "", CONCAT("  TEL.: ", CONCAT("(", LEFT(CLI_TELCTT, 2), ")", SUBSTR(CLI_TELCTT, 3,5), "-", RIGHT(CLI_TELCTT, 4)))), ' +
    ' IF(IFNULL(CLI_CELCTT, "") = "", "", CONCAT("  CEL.: ", CONCAT("(", LEFT(CLI_CELCTT, 2), ")", SUBSTR(CLI_CELCTT, 3,5), "-", RIGHT(CLI_CELCTT, 4))))) AS CLICTT, ';

  strSQL := strSQL + '  TT.CLI_NOMCTT AS NOMCTT,                     ';
  strSQL := strSQL + '  TT.CLI_NUMCPF AS CPFCTT,                     ';
  strSQL := strSQL + '  TT.CLI_NUMR_G AS RG_CTT,                     ';

  strSQL := strSQL + '  0000000.00 AS DUPREC, ';  //?
  strSQL := strSQL + '  G.AUTOINCREM AS AUTGER, ';
  strSQL := strSQL +  QuotedStr(strTabGer) + ' AS TABELA, ';

  strSQL := strSQL + '  (SELECT GROUP_CONCAT( CONCAT(TAB.UNIDAD, " ", TAB.QTDUNI) SEPARATOR "@" ) ';
  strSQL := strSQL + '      FROM (SELECT U.UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '                   CAST( FORMAT( SUM(D.DET_QTDITE), 2, "de_DE") AS CHAR(10) ) AS QTDUNI ';
  strSQL := strSQL + '              FROM '+strTabGer+' G ';
  strSQL := strSQL + '             INNER JOIN '+strTabDet+' D ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '             INNER JOIN CADUNI U ON U.UNI_CODUNI = D.DET_UNIDAD ';
  strSQL := strSQL + '             WHERE G.GER_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '               AND G.GER_ESPDOC = :ESPDOC ';

  If recDocume.strTipFc = 'C' Then
    strSQL := strSQL + '               AND G.GER_CODCLI = :CODCLI '
  Else
    strSQL := strSQL + '               AND G.GER_CODFOR = :CODCLI ';

  strSQL := strSQL + '               AND G.GER_CODEMP = :CODEMP ';
  strSQL := strSQL + '             GROUP BY U.UNI_SIGUNI ';
  strSQL := strSQL + '             ORDER BY U.UNI_SIGUNI) AS TAB) AS GRPUNI, ';

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + '  FGO_NUMDOC AS NROPED, ';                        // NUMERO DO PEDID0 - DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...
    strSQL := strSQL + '  FGO_ESPDOC AS ESPPED, ';                        // ESPECIE DO PEDIDO DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...
    strSQL := strSQL + '  CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC) AS NUMPED, '; // DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...

    strSQL := strSQL + '  EG.FGO_CODROT AS CODROT, ';
    strSQL := strSQL + '  FGO_DTENTR AS DTENTR,    ';
    strSQL := strSQL + '  FGO_HORENT AS PDHORA,    ';
    strSQL := strSQL + '  RG.REG_CODREG AS CODREG, ';
    strSQL := strSQL + '  RG.REG_DESREG AS DESREG, ';
    strSQL := strSQL + '  ER.ENT_DTAENT AS ENTREG, ';
    strSQL := strSQL + '  EM.EMP_NOMEMP AS EMPANT, ';
    strSQL := strSQL + '  IF(IFNULL(EG.FGO_EMP_TE, "") = "", "", CONCAT(EG.FGO_EMP_TE, "-", EM.EMP_NOMEMP)) AS EMPSOL, ';
  End
  else
  begin
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS NROPED, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ESPPED, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS NUMPED, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CODROT, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS DTENTR, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS PDHORA, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CODREG, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS DESREG, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS ENTREG, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS EMPANT, ';
    strSQL := strSQL + '  CAST("" AS CHAR(1)) AS EMPSOL, ';
  end;

  strSQL := strSQL + fExisteCampo('IF(LOCATE(GER_CLAFIS, ' + CLAFIS_ENTFUT_VEN + ') > 0, "S", "N")') + ' AS BAIFUT, ';

  strSQL := strSQL + '  CAST("N" AS CHAR(1))  AS DOCCAN, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS MOTDEL, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)    AS DTADEL, ';
  strSQL := strSQL + '  CAST("" AS CHAR(3))   AS OPEDEL, ';

  If (Not recDocume.blnRequisicao) Then
    strSQL := strSQL + ' CAMPOS_AUXMOV, '
  else
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CAMPOS_AUXMOV, 0.00 AS TOTCBS, 0.00 AS TOTIBS, 0.00 AS TOT_IS, ';

  strSQL := strSQL + ' GER_ENDCON,   ';
  strSQL := strSQL + ' GER_BAICON,   ';
  strSQL := strSQL + ' GER_CEPCON,   ';
  strSQL := strSQL + ' GER_CIDCON,   ';
  strSQL := strSQL + ' GER_CGCCPF,   ';
  strSQL := strSQL + ' GER_NOMCON,   ';
  strSQL := strSQL + ' GER_TELCON,   ';
  strSQL := strSQL + ' GER_R_GCON,   ';
  strSQL := strSQL + ' GER_CGCCON,   ';
  strSQL := strSQL + ' GER_IESCON,   ';
  strSQL := strSQL + ' GER_IESCON,   ';
  strSQL := strSQL + ' CAST("0" AS CHAR(1)) AS MIPROC, ';
  strSQL := strSQL + ' (SELECT COUNT(DISTINCT D2.DET_CODITE)';
  strSQL := strSQL + '     FROM ' + strTabDet + ' D2 ';
  strSQL := strSQL + '    WHERE D2.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '      AND D2.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '      AND D2.DET_CODEMP = G.GER_CODEMP) AS TOTENV , ';

  If (Not recDocume.blnRequisicao) Then
    strSQL := strSQL + ' (SELECT GROUP_CONCAT(DISTINCT DV.DET_DOCDEV, "-", '+
                       '                               DV.DET_ESPDEV, "-", '+
                       '                               DV.DET_EMPDEV, "-", '+
                       '                               IFNULL((SELECT DATE_FORMAT(GER_DTAENT, "%d/%m/%Y") FROM MOVGER WHERE GER_ESPDOC = DV.DET_ESPDEV AND GER_NUMDOC = DV.DET_DOCDEV AND  GER_CODEMP = DV.DET_EMPDEV LIMIT 1),"")  '+
                       '                               SEPARATOR " / ") '+
                       '   FROM ' + strTabDet + ' DV WHERE DV.DET_SEQGER = G.AUTOINCREM '+
                       ' ) AS DOCDEV, ';

  strSQL := strSQL + ' ( ' +  ReplaceStr(fSqlTotalDebitosClientes('GER_CODCLI', FormatDateTime('dd/mm/yyy', 0), FormatDateTime('dd/mm/yyy', VS_Date), True ), QuotedStr('GER_CODCLI'), ':CODCLI')  + ') AS TOTDEB, ';

  strSQL := strSQL + ' ( ' +  ReplaceStr(fSqlTotalDebitosClientes('GER_CODCLI', '', '', True ), QuotedStr('GER_CODCLI'), ':CODCLI')  + ') AS TOTDBG, ';

  strSQL := strSQL + ' ( ' +  ReplaceStr(fSqlTotalDebitosClientes('GER_CODCLI', '', '', True, 'FF' ), QuotedStr('GER_CODCLI'), ':CODCLI')  + ') AS TOTDFF, ';

  strSQL := strSQL + ' (SELECT GROUP_CONCAT(DISTINCT CONCAT(IFNULL(DET_NUMCMP,"")," ", IFNULL(DET_NITCMP,"")) SEPARATOR " ") ';
  strSQL := strSQL + '  FROM ' + strTabDet + ' D ';
  strSQL := strSQL + '  LEFT JOIN ' + strTabTri + ' T ON T.DET_SEQGER =  D.AUTOINCREM ';
  strSQL := strSQL + '  WHERE D.DET_SEQGER = G.AUTOINCREM ) AS NUMCMP, ';
  strSQL := strSQL + '  G.GER_NROBOX AS NROBOX, ';

  strSQL := strSQL + '  (' + fSQLVarQtdParPedOri(True, 'G.GER_NUMDOC', 'G.GER_ESPDOC', 'G.GER_CODEMP', 'G.GER_CODCLI') + ') AS PCPDOR, ';

  strSQL := strSQL + ' COALESCE((SELECT CLU2.FID_QTDPTO FROM CLUFID CLU2 ';
  strSQL := strSQL + ' JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU2.FID_CODCLI ';
  strSQL := strSQL + ' WHERE CLU2.FID_CODCLI = G.GER_CODCLI ';
  strSQL := strSQL + ' AND   CLU2.FID_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + ' AND   CLU2.FID_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + ' AND   CLU2.FID_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + ' AND   CLU2.FID_CREDEB = "C" ';
  strSQL := strSQL + ' AND   CLI2.CLI_CLUFID = "S"  ';
  strSQL := strSQL + ' ),0)- ';
  strSQL := strSQL + ' COALESCE((SELECT CLU2.FID_QTDPTO FROM CLUFID CLU2 ';
  strSQL := strSQL + ' JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU2.FID_CODCLI ';
  strSQL := strSQL + ' WHERE CLU2.FID_CODCLI = G.GER_CODCLI ';
  strSQL := strSQL + ' AND   CLU2.FID_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + ' AND   CLU2.FID_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + ' AND   CLU2.FID_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + ' AND   CLU2.FID_CREDEB = "D" ';
  strSQL := strSQL + ' AND   CLI2.CLI_CLUFID = "S"  ';
  strSQL := strSQL + ' ),0) AS PTOVEN, ';

  strSQL := strSQL + ' COALESCE((SELECT SUM(IF(CLU1.FID_CREDEB = "C", CLU1.FID_QTDPTO, -CLU1.FID_QTDPTO)) FROM CLUFID CLU1 ';
  strSQL := strSQL + ' JOIN CADCLI CLI2 ON CLI2.CLI_CODCLI = CLU1.FID_CODCLI ';
  strSQL := strSQL + '  WHERE CLU1.FID_CODCLI = G.GER_CODCLI ';
  strSQL := strSQL + '  AND   CLU1.FID_DTACAD <= G.GER_DTAENT ';
  strSQL := strSQL + '  AND   CLI2.CLI_CLUFID = "S"  ';
  strSQL := strSQL + '  AND   CLU1.FID_DTABAI IS NULL ';
  strSQL := strSQL + '  AND   CLU1.FID_HRABAI IS NULL ';
  strSQL := strSQL + '  AND CLU1.AUTOINCREM <> CF.AUTOINCREM ';
  strSQL := strSQL + ' ),0) AS PTOANT ';

  If fCfgSis('MIFFM3', varBoolean) Then
  Begin
    strSQL := strSQL + ' ,(SELECT ';
    strSQL := strSQL + '    IFNULL( ';
    strSQL := strSQL + '      ( ';
    strSQL := strSQL + '        CASE ';
    strSQL := strSQL + '          WHEN ( ';
    strSQL := strSQL + '            IFNULL(S1.ITE_EXPLAR, 0) * IFNULL(S1.ITE_EXPALT, 0) * IFNULL(S1.ITE_EXPPRO, 0) ';
    strSQL := strSQL + '          ) > 0 ';
    strSQL := strSQL + '          THEN SUM( ';
    strSQL := strSQL + '            X1.DET_QTDITE * ( ';
    strSQL := strSQL + '              IFNULL(S1.ITE_EXPLAR, 0) * IFNULL(S1.ITE_EXPALT, 0) * IFNULL(S1.ITE_EXPPRO, 0) ';
    strSQL := strSQL + '            ) ';
    strSQL := strSQL + '          ) ';
    strSQL := strSQL + '          ELSE SUM( ';
    strSQL := strSQL + '            X1.DET_QTDITE * D1.DMT_QTDITE * ( ';
    strSQL := strSQL + '              IFNULL(S2.ITE_EXPLAR, 0) * IFNULL(S2.ITE_EXPALT, 0) * IFNULL(S2.ITE_EXPPRO, 0) ';
    strSQL := strSQL + '            ) ';
    strSQL := strSQL + '          ) + SUM( ';
    strSQL := strSQL + '            X1.DET_QTDITE * D1.DMT_QTDITE * ( ';
    strSQL := strSQL + '              IFNULL(S3.ITE_EXPLAR, 0) * IFNULL(S3.ITE_EXPALT, 0) * IFNULL(S3.ITE_EXPPRO, 0) ';
    strSQL := strSQL + '            ) ';
    strSQL := strSQL + '          ) ';
    strSQL := strSQL + '        END ';
    strSQL := strSQL + '      ), ';
    strSQL := strSQL + '      0 ';
    strSQL := strSQL + '    ) ';
    strSQL := strSQL + '  FROM MOVDET X1 ';
    strSQL := strSQL + '    LEFT JOIN GERMAT G1 ';
    strSQL := strSQL + '      ON G1.GMT_CODITE = X1.DET_CODITE ';
    strSQL := strSQL + '    LEFT JOIN DETMAT D1 ';
    strSQL := strSQL + '      ON D1.DMT_SEQGER = G1.AUTOINCREM ';
    strSQL := strSQL + '    LEFT JOIN GERMAT G2 ';
    strSQL := strSQL + '      ON G2.GMT_CODITE = D1.DMT_ITESUB ';
    strSQL := strSQL + '    LEFT JOIN DETMAT D2 ';
    strSQL := strSQL + '      ON D2.DMT_SEQGER = G2.AUTOINCREM ';
    strSQL := strSQL + '    LEFT JOIN DESSIT S1 ';
    strSQL := strSQL + '      ON X1.DET_CODITE = S1.ITE_CODITE ';
    strSQL := strSQL + '    LEFT JOIN DESSIT S2 ';
    strSQL := strSQL + '      ON D1.DMT_ITESUB = S2.ITE_CODITE ';
    strSQL := strSQL + '    LEFT JOIN DESSIT S3 ';
    strSQL := strSQL + '      ON D2.DMT_ITESUB = S3.ITE_CODITE ';
    strSQL := strSQL + '  WHERE X1.DET_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '    AND X1.DET_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '    AND X1.DET_CODEMP = G.GER_CODEMP ) AS SOMAM3 ';

  End
  Else
    strSQL := strSQL + ' ,0.000 as SOMAM3 ';

  If fCfgSis('PDPENC', varBoolean) Then
  Begin
    strSQL := strSQL + ' ,(SELECT COUNT(*) ';
    strSQL := strSQL + '     FROM FATGOR ';
    strSQL := strSQL + '    WHERE FGO_CODCLI = G.GER_CODCLI ';
    strSQL := strSQL + '      AND FGO_ESPDOC = "PD" ';
    strSQL := strSQL + '      AND FGO_JAFATU = 0 ';
    strSQL := strSQL + '      AND FGO_CODEMP = '+QuotedStr(VS_strCodEmp)+' ) AS PDPDEM ';

    strSQL := strSQL + ' ,(SELECT COUNT(*) ';
    strSQL := strSQL + '     FROM FATGOR ';
    strSQL := strSQL + '    WHERE FGO_CODCLI = G.GER_CODCLI ';
    strSQL := strSQL + '      AND FGO_ESPDOC = "PD" ';
    strSQL := strSQL + '      AND FGO_JAFATU = 0 ) AS PDPDGR ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,CAST("0" AS CHAR(1)) AS PDPDEM ';
    strSQL := strSQL + ' ,CAST("0" AS CHAR(1)) AS PDPDGR ';
  End;

  If (Not recDocume.blnRequisicao) Then
    strSQL := strSQL + ' ,AUX_OPCDOC AS OPCDOC '
  Else
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS OPCDOC ';

  if (strTabGer = 'ENTGER') or (strTabGer = 'DEL_ENTGER') then
  begin
    strSQL := strSQL + ' ,(SELECT MOVOCO.OCO_PROTOC ';
    strSQL := strSQL + '     FROM MOVOCO ';
    strSQL := strSQL + '    WHERE MOVOCO.OCO_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '      AND MOVOCO.OCO_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '      AND MOVOCO.OCO_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '    ORDER BY MOVOCO.OCO_DTAINC +  MOVOCO.OCO_HORINC ASC ';
    strSQL := strSQL + '    LIMIT 1) PROTOC ';
  end
  else if (strTabGer = 'MOVGER') or (strTabGer = 'DEL_MOVGER') then
  begin
    strSQL := strSQL + '      ,COALESCE( ';
    strSQL := strSQL + '                (SELECT MOVOCO.OCO_PROTOC ';
    strSQL := strSQL + '                   FROM MOVOCO ';
    strSQL := strSQL + '                  WHERE MOVOCO.OCO_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '                    AND MOVOCO.OCO_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '                    AND MOVOCO.OCO_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '                  ORDER BY MOVOCO.OCO_DTAINC ASC,  MOVOCO.OCO_HORINC ASC ';
    strSQL := strSQL + '                  LIMIT 1), ';
    strSQL := strSQL + '                (SELECT MOVOCO.OCO_PROTOC ';
    strSQL := strSQL + '                   FROM MOVOCO ';
    strSQL := strSQL + '                   JOIN MOVDET ';
    strSQL := strSQL + '                     ON MOVOCO.OCO_ESPDOC = MOVDET.DET_ESP_PD ';
    strSQL := strSQL + '                    AND MOVOCO.OCO_NUMDOC = MOVDET.DET_NUM_PD ';
    strSQL := strSQL + '                    AND MOVOCO.OCO_CODEMP = MOVDET.DET_EMP_PD ';
    strSQL := strSQL + '                  WHERE MOVDET.DET_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '                    AND MOVDET.DET_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '                    AND MOVDET.DET_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '                    AND IFNULL(MOVDET.DET_NUM_PD, "") <> "" ';
    strSQL := strSQL + '                  ORDER BY MOVOCO.OCO_DTAINC ASC, MOVOCO.OCO_HORINC ASC ';
    strSQL := strSQL + '                  LIMIT 1) ';
    strSQL := strSQL + '       ) PROTOC ';
  end;

  if (strTabGer = 'MOVGER') then
  begin
    strSQL := strSQL + '  , IF(G.GER_ENTFAT = "N" , "RETIRA", IF(G.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS ENTRET ';

    strSQL := strSQL + '  , (SELECT GROUP_CONCAT( E1.EQU_NUMOSE )              ';
    strSQL := strSQL + '       FROM EQUGER E1                                  ';
    strSQL := strSQL + '       JOIN FATGOR F1 ON F1.FGO_NUMDOC = E1.EQU_NUMPED ';
    strSQL := strSQL + '                     AND F1.FGO_ESPDOC = E1.EQU_TIPPED ';
    strSQL := strSQL + '                     AND F1.FGO_CODEMP = E1.EQU_EMPPED ';
    strSQL := strSQL + '      WHERE F1.FGO_NUMFAT = G.GER_NUMDOC               ';
    strSQL := strSQL + '        AND F1.FGO_TIPFAT = G.GER_ESPDOC               ';
    strSQL := strSQL + '        AND F1.FGO_EMPFAT = G.GER_CODEMP) AS NUMOSE    ';

  end
  else
  begin

    strSQL := strSQL + '  , CAST("" AS CHAR(1)) AS ENTRET ';
    strSQL := strSQL + '  , CAST("" AS CHAR(1)) AS NUMOSE ';
  end;

  If (recDocume.strTipFc = 'C') Or (blnDesCon) Then
    strSQL := strSQL + '  , CLI_CONTAT AS CONCTT '
  else
    strSQL := strSQL + '  , CAST("" AS CHAR(1)) AS CONCTT ';

  strSQL := strSQL + '  , 0.00 AS TOTRAT ';

  If SameText(recDocume.strEspDoc, 'DV') Then
  begin

    strSQL := strSQL + ' , (SELECT GROUP_CONCAT(DISTINCT D.DET_NUMDOC, "-", D.DET_ESPDOC, "-", D.DET_CODEMP SEPARATOR " / " ) ';
    strSQL := strSQL + '      FROM MOVDET D ';
    strSQL := strSQL + '     WHERE D.AUTOINCREM IN (SELECT DISTINCT DET_INCFUT ';
    strSQL := strSQL + '                              FROM MOVDET A ';
    strSQL := strSQL + '                             INNER JOIN MOVTRI B ON A.AUTOINCREM = B.DET_SEQGER ';
    strSQL := strSQL + '                             WHERE DET_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '                               AND DET_INCFUT IS NOT NULL ';
    strSQL := strSQL + '                               AND DET_NUMDOC IN (SELECT DISTINCT DV.DET_DOCDEV ';
    strSQL := strSQL + '                                                    FROM MOVDET DV ';
    strSQL := strSQL + '                                                   WHERE DV.DET_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '                                                     AND DV.DET_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '                                                     AND DV.DET_CODEMP = G.GER_CODEMP))) AS DOCOEF ';

  end
  else
  begin

    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS DOCOEF ';

  end;

  strSQL := strSQL + ' ,0.00 AS TOTCHP ';
  strSQL := strSQL + ' ,0.00 AS TOTMLT ';

  strSQL := strSQL + ' ,0.00 AS TTQTEN ';
  strSQL := strSQL + ' ,0.00 AS TTQTSD ';

  strSQL := strSQL + ' ,CAST("" AS CHAR(1000)) AS VRBREX ';
  strSQL := strSQL + ' ,CAST("" AS CHAR(1000)) AS VRCOEX ';

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + ' , (SELECT GROUP_CONCAT(DISTINCT TPA_DESCRI SEPARATOR ", ") ';
    strSQL := strSQL + '     FROM FATGOR ';
    strSQL := strSQL + '       LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + '       LEFT JOIN CADTPA TP ON TP.TPA_CODIGO = EXTGOR.FGO_CODTPA ';
    strSQL := strSQL + '     WHERE FATGOR.FGO_TIPFAT = G.GER_ESPDOC ';
    strSQL := strSQL + '       AND FATGOR.FGO_NUMFAT = G.GER_NUMDOC ';
    strSQL := strSQL + '       AND FATGOR.FGO_EMPFAT = G.GER_CODEMP ';
    strSQL := strSQL + '       AND FATGOR.FGO_JAFATU = 1 ';
    strSQL := strSQL + '     ORDER BY TPA_DESCRI) AS DESTPA ';

    strSQL := strSQL + ' , ED.EMP_CODEMP AS CODEMD ';
    strSQL := strSQL + ' , ED.EMP_NOMEMP AS NOMEMD ';
  End
  else
  begin
    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS DESTPA ';
    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS CODEMD ';
    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS NOMEMD ';
  end;

  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + ' , CAST((SELECT GROUP_CONCAT(MCU_NUMCUP SEPARATOR ", ") ';
    strSQL := strSQL + '         FROM MOVCUP ';
    strSQL := strSQL + '         WHERE MCU_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '           AND MCU_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '           AND MCU_CODEMP = G.GER_CODEMP) AS CHAR(255))  AS NUMCUP ';
  End
  Else
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS NUMCUP ';

  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + ' , (SELECT DISTINCT  ';
    strSQL := strSQL + '    SG.FGO_DISSER ';
    strSQL := strSQL + '      FROM FATGOR FG ';
    strSQL := strSQL + '      LEFT JOIN SERGOR SG ON SG.FGO_SEQFGO = FG.AUTOINCREM ';
    strSQL := strSQL + '    WHERE FG.FGO_NUMFAT = G.GER_NUMDOC ';
    strSQL := strSQL + '      AND FG.FGO_TIPFAT = G.GER_ESPDOC ';
    strSQL := strSQL + '      AND FG.FGO_EMPFAT = G.GER_CODEMP ';
    strSQL := strSQL + '    LIMIT 1) AS DSSERV ';
  End
  Else
    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS DSSERV ';

  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + ' , (SELECT GROUP_CONCAT(NC.CMP_NUMCMP  SEPARATOR ", ")  ';
    strSQL := strSQL + '      FROM FATGOR FG ';
    strSQL := strSQL + '      LEFT JOIN NUMCMP NC ON NC.CMP_SEQGER = FG.AUTOINCREM ';
    strSQL := strSQL + '    WHERE FG.FGO_NUMFAT = G.GER_NUMDOC ';
    strSQL := strSQL + '      AND FG.FGO_TIPFAT = G.GER_ESPDOC ';
    strSQL := strSQL + '      AND FG.FGO_EMPFAT = G.GER_CODEMP) ';
    strSQL := strSQL + '      AS NROCMP ';
  End
  Else
    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS NROCMP ';

  strSQL := strSQL + ', OV.OPE_NOMFAN AS NOFAOP ';
  strSQL := strSQL + ', EP.EMP_HOMEPA AS HOMEPG  ';

  strSQL := strSQL + ', IFNULL(ICD.ICD_VALFCP, 0.0000)  AS VALFCP  ';
  strSQL := strSQL + ', IFNULL(ICD.ICD_VALDES, 0.0000)  AS VDPDES  ';
  strSQL := strSQL + ', IFNULL(ICD.ICD_VALORI, 0.0000)  AS VDPORI  ';

  strSQL := strSQL + ',   CR.CTR_SEQCON AS SEQCO1 ';
  strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS DUPCRE ';
  strSQL := strSQL + ' , CAST("" AS CHAR(3000)) AS DUPPRO ';
  strSQL := strSQL + ' , 0.00 AS TOTCRE ';

  if (strTabGer = 'MOVGER') then
  Begin
    strSQL := strSQL + ', (SELECT CTT.CLI_TELCTT                            ';
    strSQL := strSQL + '  FROM CLICTT CTT                                   ';
    strSQL := strSQL + '  LEFT JOIN FATGOR F1 ON F1.FGO_CLICTT = CTT.AUTOINCREM  ';
    strSQL := strSQL + '  WHERE F1.FGO_NUMFAT = G.GER_NUMDOC                ';
    strSQL := strSQL + '  AND F1.FGO_TIPFAT = G.GER_ESPDOC                  ';
    strSQL := strSQL + '  AND F1.FGO_EMPFAT = G.GER_CODEMP)                 ';
    strSQL := strSQL + '  AS TELCTA ';
  End
  else
  begin
    strSQL := strSQL + ', CAST("" AS CHAR(1)) AS TELCTA ';
  end;

  if (strTabGer = 'MOVGER') then
  Begin
    strSQL := strSQL + ', (SELECT CTT.CLI_EMACTT                            ';
    strSQL := strSQL + '  FROM CLICTT CTT                                   ';
    strSQL := strSQL + '  LEFT JOIN FATGOR F1 ON F1.FGO_CLICTT = CTT.AUTOINCREM  ';
    strSQL := strSQL + '  WHERE F1.FGO_NUMFAT = G.GER_NUMDOC                ';
    strSQL := strSQL + '  AND F1.FGO_TIPFAT = G.GER_ESPDOC                  ';
    strSQL := strSQL + '  AND F1.FGO_EMPFAT = G.GER_CODEMP)                 ';
    strSQL := strSQL + '  AS EMACTA ';
  End
  else
  begin
    strSQL := strSQL + ', CAST("" AS CHAR(1)) AS EMACTA ';
  end;

  strSQL := strSQL + ', IG.OPE_NOMOPE AS MENOSE ';

  strSQL := strSQL + ', OG.GER_OBSERV AS OBERVI ';

  strSQL := strSQL + ', SS.STS_DESCRI AS STASER ';

  strSQL := strSQL + ', CS.SER_TMPMED AS TMPMED ';

  strSQL := strSQL + ', CONCAT (DATE_FORMAT(SG.FGO_DTAGES, "%d/%m/%Y"), " - ", SG.FGO_HRAGES)  AS DTAGES ';
  strSQL := strSQL + ', CONCAT (DATE_FORMAT(SG.FGO_DTENTS, "%d/%m/%Y"), " - ", SG.FGO_HRENTS)  AS DTENTS ';

     //IIF ( TOTDIG <> TOTORI , DSVLDG , DSVLOR )
  strSQL := strSQL + ' ,(SELECT ';
  strSQL := strSQL + '   SUM(X.VLRDSC) FROM ';
  strSQL := strSQL + '   (SELECT (D.DET_QTDITE * D.DET_UNIDIG) * (D.DET_DESCON / 100) AS VLRDSC ';
  strSQL := strSQL + '      FROM ';
  strSQL := strSQL + '    MOVDET D ';
  strSQL := strSQL + '     WHERE D.DET_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '       AND D.DET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '       AND D.DET_CODEMP = :CODEMP) AS X) AS DSVLDG ';

  strSQL := strSQL + ' ,(SELECT ';
  strSQL := strSQL + '   SUM(X.VLRDSC) FROM ';
  strSQL := strSQL + '   (SELECT (D.DET_QTDITE * D.DET_UNIORI) * (D.DET_DESCON / 100) AS VLRDSC ';
  strSQL := strSQL + '      FROM ';
  strSQL := strSQL + '    MOVDET D ';
  strSQL := strSQL + '     WHERE D.DET_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '       AND D.DET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '       AND D.DET_CODEMP = :CODEMP) AS X) AS DSVLOR ';

  If (recDocume.strTipFc = 'C') Or (blnDesCon) Then
  Begin
    strSQL := strSQL + ', CLI_DESCON AS CLIDES ';
    strSQL := strSQL + ', CLI_CELULA AS CELCLI ';
    strSQL := strSQL + ', EG.FGO_VALCRE AS VALCRE' ;
    strSQL := strSQL + ', CLI_MSGPED AS MSGCLI ';
  End
  Else
  Begin
    strSQL := strSQL + ', 0.00       AS CLIDES ';
    strSQL := strSQL + ', ""         AS CELCLI ';
    strSQL := strSQL + ', 0.00       AS VALCRE ';
    strSQL := strSQL + ', ""         AS MSGCLI ';
  End;

  strSQL := strSQL + ', IFNULL(AUXMOV.AUX_FRECOT, 0) AS FRECOT ';

  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + ',IF(';
    strSQL := strSQL + ' (SELECT COUNT(AUTOINCREM) ';
    strSQL := strSQL + '      FROM ';
    strSQL := strSQL + '    MOVDET D ';
    strSQL := strSQL + '     WHERE D.DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '       AND D.DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '       AND D.DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '       AND LOCATE(D.DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0)';
    strSQL := strSQL + ' > 0, CADOCO.OCO_DESOCO, " ") AS DESOCO ';

    strSQL := strSQL + ',IF(';
    strSQL := strSQL + ' (SELECT COUNT(AUTOINCREM) ';
    strSQL := strSQL + '      FROM ';
    strSQL := strSQL + '    MOVDET D ';
    strSQL := strSQL + '     WHERE D.DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '       AND D.DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '       AND D.DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '       AND LOCATE(D.DET_CLAFIS, ' + QuotedStr(VS_strClaDev) + ') > 0)';
    strSQL := strSQL + ' > 0, G.GER_CODOCO, " ") AS CODOCO ';
  End
  else
  begin
    strSQL := strSQL + ', CAST("" AS CHAR(1)) AS DESOCO ';
    strSQL := strSQL + ', CAST("" AS CHAR(1)) AS CODOCO ';
  end;


  strSQL := strSQL + ',(SELECT GROUP_CONCAT(DET_KEY_EP SEPARATOR " - ") ';
  strSQL := strSQL + '         FROM MOVDET ';
  strSQL := strSQL + '         WHERE DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '           AND DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '           AND DET_CODEMP = G.GER_CODEMP) AS KEY_EP ';
  strSQL := strSQL + ', "" AS MODPGT ';

  if (strTabGer = 'MOVGER') then
  begin
    strSQL := strSQL + ',(SELECT SUM(DET_VLRCON) AS VCPROM ';
    strSQL := strSQL + '         FROM MOVDET ';
    strSQL := strSQL + '         WHERE DET_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '           AND DET_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '           AND DET_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '           AND DET_PROMOC = "S") AS VCPROM ';

    strSQL := strSQL + '  , (SELECT CADEQU.EQU_DESCRI AS EQUIPA                         ';
    strSQL := strSQL + '       FROM EQUGER E1                                           ';
    strSQL := strSQL + '       JOIN FATGOR F1 ON F1.FGO_NUMDOC  = E1.EQU_NUMPED         ';
    strSQL := strSQL + '                     AND F1.FGO_ESPDOC  = E1.EQU_TIPPED         ';
    strSQL := strSQL + '                     AND F1.FGO_CODEMP  = E1.EQU_EMPPED         ';
    strSQL := strSQL + '       JOIN CADEQU ON CADEQU.EQU_CODIGO = E1.EQU_CODEQU         ';
    strSQL := strSQL + '      WHERE F1.FGO_NUMFAT = G.GER_NUMDOC                        ';
    strSQL := strSQL + '        AND F1.FGO_TIPFAT = G.GER_ESPDOC                        ';
    strSQL := strSQL + '        AND F1.FGO_EMPFAT = G.GER_CODEMP LIMIT 1) AS EQUIPA     ';
  end
  else
  begin
    strSQL := strSQL + ', 0.00 AS VCPROM ';
    strSQL := strSQL + ', CAST("" AS CHAR(1)) AS EQUIPA ';
  end;

  strSQL := strSQL + ', G.GER_NUMREG AS NUMREG ';

  strSQL := strSQL + ', (SELECT RCX_CODCAX  ';
  strSQL := strSQL + '          FROM CADRCXX ';
  strSQL := strSQL + '          WHERE RCX_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '            AND RCX_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '            AND RCX_CODEMP = G.GER_CODEMP ';
  strSQL := strSQL + '            AND RCX_CODCLI = G.GER_CODCLI ';
  strSQL := strSQL + '          LIMIT 1) AS CODCAX ';

  strSQL := strSQL + ' , MOV_DISSER AS DISSER ';

  If (recDocume.strTipFc = 'C') Or (blnDesCon) Then
    strSQL := strSQL + ' ,CADCLI.CLI_FONE02   AS FONE02 '
  else
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS FONE02 ';

  strSQL := strSQL + ' ,(SELECT ';
  strSQL := strSQL + '     DI.DIV_CODDIV ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     MOVDET ';
  strSQL := strSQL + '     LEFT JOIN CADDIV DI ';
  strSQL := strSQL + '       ON DI.DIV_CODDIV = DET_CODDIV ';
  strSQL := strSQL + '    WHERE DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '    LIMIT 1) AS CDDVSR ';
  strSQL := strSQL + ' ,(SELECT ';
  strSQL := strSQL + '     DI.DIV_NOMDIV ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     MOVDET ';
  strSQL := strSQL + '     LEFT JOIN CADDIV DI ';
  strSQL := strSQL + '       ON DI.DIV_CODDIV = DET_CODDIV ';
  strSQL := strSQL + '    WHERE DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '    LIMIT 1) AS NMDVSR ';
  strSQL := strSQL + '  ,0.00 AS TOTMT3 ';

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + '  ,EG.FGO_DTCOAG AS DTCOAG ';
  End;

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + ' ,FGO_NUMORI AS NUMORI ';
    strSQL := strSQL + ' ,FGO_ESPORI AS ESPORI ';
    strSQL := strSQL + ' ,FGO_EMPORI AS EMPORI ';

    strSQL := strSQL + ',  COALESCE((SELECT ';
    strSQL := strSQL + '             CONCAT(EQU_NUMOSE,"-","OS") AS DOCORI ';//NUMERO DA ORDEM DE SERVIÇO CASO FOI GERADO ESSE PEDIDO DO CONSERTO DE EQUIPAMENTOS
    strSQL := strSQL + '             FROM EQUGER ';
    strSQL := strSQL + '             WHERE (EQU_TIPPED = "PD"       AND ';
    strSQL := strSQL + '                    EQU_NUMPED = FGO_NUMDOC AND ';
    strSQL := strSQL + '                    EQU_EMPPED = FGO_CODEMP AND ';
    strSQL := strSQL + '                    EQU_TIPPED = FGO_ESPDOC) ';
    strSQL := strSQL + '             UNION  ';
    strSQL := strSQL + '             SELECT CONCAT(EQU_NUMOSE,"-","OS") AS DOCORI ';
    strSQL := strSQL + '             FROM EQUGER ';
    strSQL := strSQL + '             INNER JOIN EQUGOR ON FGO_SEQEQU = EQUGER.AUTOINCREM ';
    strSQL := strSQL + '             WHERE FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + '             LIMIT 1), ';

    strSQL := strSQL + '           COALESCE((SELECT ';
    strSQL := strSQL + '                     CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC) AS DOCORI ';//DOCUMENTO DE ORIGEM FATURAMENTO (OR)
    strSQL := strSQL + '                     FROM FATDOR ';
    strSQL := strSQL + '                    WHERE FDO_TIPFAT = FGO_ESPDOC AND ';
    strSQL := strSQL + '                          FDO_NUMFAT = FGO_NUMDOC AND ';
    strSQL := strSQL + '                          FDO_EMPFAT = FGO_CODEMP AND ';
    strSQL := strSQL + '                          FDO_JAFATU = 1 ';
    strSQL := strSQL + '                    LIMIT 1), "")  ';
    strSQL := strSQL + '            ) AS DOCORI  ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,"" AS NUMORI ';
    strSQL := strSQL + ' ,"" AS ESPORI ';
    strSQL := strSQL + ' ,"" AS EMPORI ';
    strSQL := strSQL + ' ,"" AS DOCORI ';
  End;

  strSQL := strSQL + ' ,0.00 AS MARBRU ';

  strSQL := strSQL + ' ,(SELECT MOE_DOLVEN FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE WHERE MOE_CODEMP = G.GER_CODEMP) AND MOE_CODEMP = G.GER_CODEMP) AS VLCTAT ';
  strSQL := strSQL + ' ,(SELECT MOE_EURCOM FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE WHERE MOE_CODEMP = G.GER_CODEMP) AND MOE_CODEMP = G.GER_CODEMP) AS EURCOM ';
  strSQL := strSQL + ' ,(SELECT MOE_EURVEN FROM CADMOE WHERE MOE_DTAMOE = (SELECT MAX(MOE_DTAMOE) FROM CADMOE WHERE MOE_CODEMP = G.GER_CODEMP) AND MOE_CODEMP = G.GER_CODEMP) AS EURVEN ';

  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + strTabGer + ' G ';
  strSQL := strSQL + '  LEFT JOIN MOVOBS ON G.AUTOINCREM = MOVOBS.MOV_SEQGER          ';
  strSQL := strSQL + '  LEFT JOIN CADTRA ON GER_CODTRA = CADTRA.TRA_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCND ON GER_CODCND = CND_CODIGO ';
  strSQL := strSQL + '  LEFT JOIN CADEMP EP ON EP.EMP_CODEMP   = G.GER_CODEMP    ';
  strSQL := strSQL + '  LEFT JOIN CADFPG ON FPG_CODIGO = GER_CODFPG ';
  strSQL := strSQL + '  LEFT JOIN SERMOV SV ON SV.GER_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN MOVDET MD ON MD.DET_SEQGER = G.AUTOINCREM   ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM   ';
  strSQL := strSQL + '  LEFT JOIN MOVICD ICD ON ICD.ICD_SEQGER = MD.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN CADREC CR ON ';
  strSQL := strSQL + '        CR.CTR_CODEMP = G.GER_CODEMP AND ';
  strSQL := strSQL + '        CR.CTR_ESPDOC = G.GER_ESPDOC AND ';
  strSQL := strSQL + '        CR.CTR_NUMDUP = G.GER_NUMDOC AND ';
  strSQL := strSQL + '        CR.CTR_CODCLI = G.GER_CODCLI ';

  If (recDocume.strTipFc = 'C') Or (blnDesCon) Then
    strSQL := strSQL + '  INNER JOIN CADCLI  ON CLI_CODCLI = GER_CODCLI ';

  If (strTabGer = 'MOVGER') Then
  Begin
    strSQL := strSQL + '  LEFT JOIN ASSGER ON ASS_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADOCO ON CADOCO.OCO_CODOCO = G.GER_CODOCO ';
  End;

  If recDocume.strEspDoc = 'RL' Then
  Begin
    strSQL := strSQL + '  LEFT JOIN EQLFAT ON (GER_CODEMP = EQF_EMPDOC AND GER_ESPDOC = EQF_ESPDOC AND GER_NUMDOC = EQF_NUMDOC)';
    strSQL := strSQL + '  LEFT JOIN CONEQL ON (EQF_SEQCON = CONEQL.AUTOINCREM)';
    strSQL := strSQL + '  LEFT JOIN EQLDET D ON D.EQD_SEQCON = CONEQL.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADEQL L ON EQL_CODIGO = EQD_SEQEQL ';
  End;

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.AUTOINCREM = (SELECT MAX(FGO.AUTOINCREM) FROM FATGOR FGO '+
                       '                     WHERE FGO.FGO_TIPFAT = G.GER_ESPDOC '+
                       '                       AND FGO.FGO_NUMFAT = G.GER_NUMDOC '+
                       '                       AND FGO.FGO_EMPFAT = G.GER_CODEMP '+
                       '                       AND FGO.FGO_JAFATU = 1)           ';
    strSQL := strSQL + '  LEFT JOIN EXTGOR EG  ON EG.FGO_SEQFGO  = FATGOR.AUTOINCREM  ';
    strSQL := strSQL + '  LEFT JOIN ENTREG ER  ON EG.FGO_CODROT  = ER.ENT_CODIGO ';
    strSQL := strSQL + '  LEFT JOIN CADREG RG  ON RG.REG_CODREG  = ER.ENT_CODREG ';
    strSQL := strSQL + '  LEFT JOIN CADEMP EM ON EM.EMP_CODEMP = EG.FGO_EMP_TE ';
    strSQL := strSQL + '  LEFT JOIN CADEMP ED ON ED.EMP_CLIFIL = G.GER_CODCLI ';
  End;

  strSQL := strSQL + '  LEFT JOIN FATDOR FD  '+
                     '                     ON FD.FDO_TIPFAT = G.GER_ESPDOC   '+
                     '                     AND FD.FDO_NUMFAT = G.GER_NUMDOC  '+
                     '                     AND FD.FDO_EMPFAT = G.GER_CODEMP  '+
                     '                     AND FD.FDO_JAFATU = 1             '+
                     '                     AND FD.FDO_CODITE = MD.DET_CODITE '+
                     '                     AND FD.FDO_SEQIND = MD.DET_IND_PD ';

  strSQL := strSQL + ' LEFT JOIN MECGER ON MECGER.GER_SEQGER = G.AUTOINCREM  ';
  strSQL := strSQL + ' LEFT JOIN CADOPE IG ON OPE_CODOPE = MECGER.GER_CODMEC  ';
  strSQL := strSQL + ' LEFT JOIN OBSGER OG ON OG.GER_SEQGER = G.AUTOINCREM  ';
  strSQL := strSQL + ' LEFT JOIN STASER SS ON SS.STS_CODIGO = SV.GER_STAS01 ';
  strSQL := strSQL + ' LEFT JOIN CADSER CS ON CS.SER_CODSER = G.GER_CODS01 ';
  strSQL := strSQL + ' LEFT JOIN SERGOR SG ON SG.FGO_SEQFGO = FD.FDO_SEQGER ';

  strSQL := strSQL + '  LEFT JOIN CADCID CT ON CT.CID_CODCID = CADTRA.TRA_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OV ON OV.OPE_CODOPE = GER_CODVEN ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OD ON OD.OPE_CODOPE = GER_CODDIG ';

  if (Not recDocume.blnRequisicao) then
  Begin
    strSQL := strSQL + '  LEFT JOIN CADOPE OS ON OS.OPE_CODOPE = GER_SEPEXP ';
    strSQL := strSQL + '  LEFT JOIN CADOPE OX ON OX.OPE_CODOPE = GER_OPEEXP ';
    strSQL := strSQL + '  JOIN_AUXMOV '; // Será substituído antes de executar o SQL
  End;

  strSQL := strSQL + '  LEFT JOIN CLICTT TT ON AUX_CLICTT = TT.AUTOINCREM ';

  strSQL := strSQL + '  LEFT JOIN CLUFID CF ON ';
  strSQL := strSQL + '        CF.FID_CODEMP = GER_CODEMP AND ';
  strSQL := strSQL + '        CF.FID_ESPDOC = GER_ESPDOC AND ';
  strSQL := strSQL + '        CF.FID_NUMDOC = GER_NUMDOC AND ';
  strSQL := strSQL + '        CF.FID_CODCLI = GER_CODCLI ';

  strSQL := strSQL + 'WHERE ';

  If recDocume.strTipFc = 'C' Then
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND '
  Else
    strSQL := strSQL + '  GER_CODFOR = :CODCLI AND ';

  If SameText(recDocume.strEspDoc, 'ML') Or recDocume.blnAjMl Then
  Begin
    strSQL := strSQL + '  GER_NUMFAT = :NUMDOC AND ';
    strSQL := strSQL + '  GER_TIPFAT = :ESPDOC AND ';
    strSQL := strSQL + '  GER_EMPFAT = :CODEMP     ';
  End Else
  Begin
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP     ';
  End;

  If recDocume.blnDocCan Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'CAST("N" AS CHAR(1))  AS DOCCAN','CAST("S" AS CHAR(1)) AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'CAST("" AS CHAR(300)) AS MOTDEL','MOTDEL AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, 'CAST("" AS CHAR(3))   AS OPEDEL','OPEDEL AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'CAST(NULL AS DATE)    AS DTADEL','DTADEL AS DTADEL');
  End;

  if (Not recDocume.blnRequisicao) then
  Begin
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(strSQL,
                                        'LEFT JOIN CADOCO ON CADOCO.OCO_CODOCO = G.GER_CODOCO', ' '),
                                                             'G.GER_CODOCO', 'CAST(" " AS CHAR(1))'),
                                                             'CADOCO.OCO_DESOCO', 'CAST(" " AS CHAR(1))'),
                                                             'GER_NROCEI', 'CAST(" " AS CHAR(1))'),
                                                             'GER_SEPEXP', 'CAST(" " AS CHAR(1))'),
                                                             'JOIN_AUXMOV', fSQLJoinAuxMov('AUXNOT')),
                                                             'CAMPOS_AUXMOV,', fSQLCamposAuxMov('AUXNOT')),
                                                             'MOVGER', 'NOTGER'),
                                                             'MOVDET', 'NOTDET'),
                                                             'AUXMOV', 'AUXNOT'),
                                                             'CAST("0" AS CHAR(1)) AS MIPROC', 'CAST("1" AS CHAR(1)) AS MIPROC'),
                                                             'AUX_PRZMED', '0'),
                                                             'GER_MENEXP', 'CAST(" " AS CHAR(1))'),
                                                             'GER_MENEX2', 'CAST(" " AS CHAR(1))'),
                                                             'GER_MENEX3', 'CAST(" " AS CHAR(1))'),
                                                             'GER_OBS_TA', 'CAST(" " AS CHAR(1))'),
                                                             'GER_MENEX4', 'CAST(" " AS CHAR(1))'),
                                                             'DET_KEY_EP', 'CAST(" " AS CHAR(1))'),
                                                             'DET_BAIEMP', '0'),
                                                             'GER_DTADOC', 'CAST(" " AS CHAR(1))');

    strSQL := AnsiReplaceStr(strSQL, 'JOIN_AUXMOV', fSQLJoinAuxMov('AUXMOV'));
    strSQL := AnsiReplaceStr(strSQL, 'CAMPOS_AUXMOV,', fSQLCamposAuxMov('AUXMOV'));
  End;

  Result := strSQL;
End;

function TLeDocumentoMIFF.fGetSqlQtdIteVenda: String;
begin
  Result := '';

  With recDocume Do
  Begin
    If blnAgruparItensSeparacao Then
      Result := Result + ' SUM( ';

    If blnSepFut Then
      Result := Result + '   SEP_QTDITE '
    Else
    Begin
      If blnDocSep Then
      Begin
        Result := Result + ' (DET_QTDITE ';

        If fCfgSis('IMSEPE', varBoolean) Then
          Result := Result + ' - DET_QTDEXP ';

        If blnSepPendRomaneio Then
          Result := Result + ' - ' + fGetSqlQtdRomaneio;

        Result := Result + ' ) ';
      End
      Else
        Result := Result + '   DET_QTDITE ';
    End;

    If blnAgruparItensSeparacao Then
      Result := Result + ' ) ';
  End;
end;

function TLeDocumentoMIFF.fGetSqlQtdRomaneio: String;
begin
  Result := '';
  Result := Result + ' (SELECT IFNULL(SUM(DET_QTDBAI),0) ';
  Result := Result + '  FROM ROMDETX RD ';
  Result := Result + '  WHERE RD.DET_NUMDOC = D.DET_NUMDOC  ';
  Result := Result + '    AND RD.DET_ESPDOC = D.DET_ESPDOC  ';
  Result := Result + '    AND RD.DET_CODEMP = D.DET_CODEMP  ';
  Result := Result + '    AND RD.DET_CODCLI = D.DET_CODCLI  ';
  Result := Result + '    AND RD.DET_AUTINC = D.AUTOINCREM) ';
end;

function TLeDocumentoMIFF.fGetSqlGroupByVenda: String;
begin
  Result := '';

  With recDocume Do
  If blnAgruparItensSeparacao Then
  Begin
    Result := Result + ' GROUP BY ';
    Result := Result + '   DET_CODITE, DET_DESCRI, DET_IDEPRO, DET_NUMLOT ';
  End;

end;

Function TLeDocumentoMIFF.fSQLTabPre: String;
Begin
  Result := '';
  With recDocume Do
  If (fCfgSis('TABITE', varBoolean)) And (fCfgSis('IPTPFT', varBoolean)) And (Pos(strEspDoc, fCfgSis('ESPITP')) > 0) Then
    Result := 'IF(DET_PROMOC = "S", "PR", DET_TABPRE), "-", ';
End;

function TLeDocumentoMIFF.fTemDel_LotDor: Boolean;
const
  SQL_ITENS = 'SELECT AUTOINCREM '+
              'FROM DEL_MOVDET '+
              'WHERE DET_NUMDOC = :NUMDOC '+
              'AND DET_SERIE_ = :SERIE_ '+
              'AND DET_TIP_FC = :TIP_FC '+
              'AND DET_ESPDOC = :ESPDOC '+
              'AND DET_CODCLI = :CODCLI '+
              'AND DET_CODEMP = :CODEMP';
var
  qryDel : TUniQuery;
begin
  qryDel := fCriaQuery;
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add('SELECT COUNT(*) AS TOT FROM DEL_LOTDOR WHERE LDO_SEQFDO IN ('+SQL_ITENS+')');
    qryDel.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    qryDel.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
    qryDel.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
    qryDel.ParamByName('SERIE_').AsString := recDocume.strSerie_;
    qryDel.ParamByName('TIP_FC').AsString := recDocume.strTipFc;
    qryDel.ParamByName('CODCLI').AsString := recDocume.strCodCli;

    qryDel.Open;

    Result := (Not qryDel.IsEmpty) And (qryDel.FieldByName('TOT').AsInteger > 0);
  Finally
    FreeAndNil(qryDel);
  End;
end;

Function TLeDocumentoMIFF.fSQLItems: String;
  Var
    strSQL,
    strSQLMec,
    strCampoSetor: String;
    intTab: integer;
Begin
  If fEmptyStr(strTabDet) Then
    pSetaNomeTabela;

  With recDocume Do
  Begin
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      strCampoSetor := 'IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) AS LSE_DESCRI'
    else
    If (fCfgSis('GRUSEP', VarString) = 'S') then
      strCampoSetor := 'LSE_DESCRI'
    Else
      strCampoSetor := 'LEFT(ITE_LOCFIS, 1)';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
    strSQL := strSQL + '    (@ROW := @ROW + 1) AS SEQDET, ';

    strSQL := strSQL + '    DET_CODITE, ';
    strSQL := strSQL + '    DET_TIP_FC, ';
    strSQL := strSQL + '    DET_UNITAR, ';

    strSQL := strSQL + '    D.AUTOINCREM AS AUTDET, ';
    strSQL := strSQL + '    DET_CODITE AS CODITE, ';

    If fCfgSis('MIFFM3', varBoolean) Then
    Begin
      strSQL := strSQL + '  (SELECT ';
      strSQL := strSQL + '    IFNULL( ';
      strSQL := strSQL + '      ( ';
      strSQL := strSQL + '        CASE ';
      strSQL := strSQL + '          WHEN ( ';
      strSQL := strSQL + '            IFNULL(S1.ITE_EXPLAR, 0) * IFNULL(S1.ITE_EXPALT, 0) * IFNULL(S1.ITE_EXPPRO, 0) ';
      strSQL := strSQL + '          ) > 0 ';
      strSQL := strSQL + '          THEN SUM( ';
      strSQL := strSQL + '            X1.DET_QTDITE * ( ';
      strSQL := strSQL + '              IFNULL(S1.ITE_EXPLAR, 0) * IFNULL(S1.ITE_EXPALT, 0) * IFNULL(S1.ITE_EXPPRO, 0) ';
      strSQL := strSQL + '            ) ';
      strSQL := strSQL + '          ) ';
      strSQL := strSQL + '          ELSE SUM( ';
      strSQL := strSQL + '            X1.DET_QTDITE * D1.DMT_QTDITE * ( ';
      strSQL := strSQL + '              IFNULL(S2.ITE_EXPLAR, 0) * IFNULL(S2.ITE_EXPALT, 0) * IFNULL(S2.ITE_EXPPRO, 0) ';
      strSQL := strSQL + '            ) ';
      strSQL := strSQL + '          ) + SUM( ';
      strSQL := strSQL + '            X1.DET_QTDITE * D1.DMT_QTDITE * ( ';
      strSQL := strSQL + '              IFNULL(S3.ITE_EXPLAR, 0) * IFNULL(S3.ITE_EXPALT, 0) * IFNULL(S3.ITE_EXPPRO, 0) ';
      strSQL := strSQL + '            ) ';
      strSQL := strSQL + '          ) ';
      strSQL := strSQL + '        END ';
      strSQL := strSQL + '      ), ';
      strSQL := strSQL + '      0 ';
      strSQL := strSQL + '    ) ';
      strSQL := strSQL + '  FROM MOVDET X1 ';
      strSQL := strSQL + '    LEFT JOIN GERMAT G1 ';
      strSQL := strSQL + '      ON G1.GMT_CODITE = X1.DET_CODITE ';
      strSQL := strSQL + '    LEFT JOIN DETMAT D1 ';
      strSQL := strSQL + '      ON D1.DMT_SEQGER = G1.AUTOINCREM ';
      strSQL := strSQL + '    LEFT JOIN GERMAT G2 ';
      strSQL := strSQL + '      ON G2.GMT_CODITE = D1.DMT_ITESUB ';
      strSQL := strSQL + '    LEFT JOIN DETMAT D2 ';
      strSQL := strSQL + '      ON D2.DMT_SEQGER = G2.AUTOINCREM ';
      strSQL := strSQL + '    LEFT JOIN DESSIT S1 ';
      strSQL := strSQL + '      ON X1.DET_CODITE = S1.ITE_CODITE ';
      strSQL := strSQL + '    LEFT JOIN DESSIT S2 ';
      strSQL := strSQL + '      ON D1.DMT_ITESUB = S2.ITE_CODITE ';
      strSQL := strSQL + '    LEFT JOIN DESSIT S3 ';
      strSQL := strSQL + '      ON D2.DMT_ITESUB = S3.ITE_CODITE ';
      strSQL := strSQL + '  WHERE X1.AUTOINCREM = D.AUTOINCREM ) AS TOT_M3, ';
    End
    Else
      strSQL := strSQL + ' 0.000 as TOT_M3, ';

    // Pedido que gerou a MI/FF.
    strSQL := strSQL + fExisteCampo('CONCAT(D.DET_NUM_PD,"-",D.DET_ESP_PD,"-",D.DET_EMP_PD)') + ' AS PEDEXP, ';

    strSQL := strSQL + fExisteCampo('DET_ENTFUT') + ' AS ENTFUT, ';
    strSQL := strSQL + '    DET_IDEPRO AS IDEPRO, ';

    If blnEnt_CD Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpCD('DET_NUMLOT', 'I.ITE_CODITE', 'DET_CODEMP');
      strSQL := strSQL + fRetDesFisicaEmpCD('DET_NUMLOT', 'I.ITE_CODITE', 'DET_CODEMP');
    End
    Else If blnLocFisEmpEmi Then
    Begin
      strSQL := strSQL + fRetLocFisicaEmpEmissora('DET_NUMLOT', 'I.ITE_CODITE', 'DET_CODEMP');
      strSQL := strSQL + fRetDesFisicaEmpEmissora('DET_NUMLOT', 'I.ITE_CODITE', 'DET_CODEMP');
    End
    Else
    Begin
      strSQL := strSQL + '   IFNULL(T.DET_LOCFIS, IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, CL.LOT_LOCFIS)) AS LOCFIS, ';
      strSQL := strSQL + '   IF(T.DET_LOCFIS IS NULL, IF(IFNULL(DET_NUMLOT, "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI), L3.LOC_DESCRI) AS DESFIS, ';
    End;

    strSQL := strSQL + '    CONCAT(IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), DET_DESCRI) AS DESITE, ';

    strSQL := strSQL + '    DET_DESNES AS DESNES, ';

    strSQL := strSQL + '    DET_REFERE AS REFERE, ';
    strSQL := strSQL + '    DET_CODMAR AS CODMAR, ';
    strSQL := strSQL + '    MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '    DET_CODFIS AS CODFIS, ';
    strSQL := strSQL + '    DET_VFCPST AS VFCPST, ';

    strSQL := strSQL + '    (SELECT SUM(MT.DET_VFCPST) AS TOTFCP ';
    strSQL := strSQL + '       FROM ';
    strSQL := strSQL + '     MOVDET MD ';
    strSQL := strSQL + '      INNER JOIN MOVTRI MT ';
    strSQL := strSQL + '         ON MD.AUTOINCREM = MT.DET_SEQGER ';
    strSQL := strSQL + '      WHERE MD.DET_NUMDOC = MG.GER_NUMDOC ';
    strSQL := strSQL + '        AND MD.DET_CODEMP = MG.GER_CODEMP ';
    strSQL := strSQL + '        AND MD.DET_ESPDOC = MG.GER_ESPDOC ';
    strSQL := strSQL + '        AND MD.DET_CODCLI = MG.GER_CODCLI) AS TOTFCP, ';

    If recDocume.blnRequisicao Then
    Begin
      strSQL := strSQL + '   DET_UNITAR AS VALUNI, ';
      strSQL := strSQL + '   DET_UNIORI AS UNIORI, ';
      strSQL := strSQL + '   (DET_UNITAR * DET_QTDITE) AS VALITE, ';
      strSQL := strSQL + '   0.00 AS QTEENT, ';
      strSQL := strSQL + '   0.00 AS QTESAI, ';
      strSQL := strSQL + '   (DET_UNITAR * DET_QTDITE) AS VALENT, ';
      strSQL := strSQL + '   0.00 AS VALSAI, ';
      strSQL := strSQL + '   "ENT" AS ENTSAI, ';
    End
    Else
    Begin
      If (blnExibirValorBrutoSeEstiverUsandoDescontoClienteProfissional) Then
      Begin
        strSQL := strSQL + '   DET_UNITAR / ((100 - ' +  fSQLPercentualDesconto + ') / 100) AS VALUNI, ';
        strSQL := strSQL + '   DET_UNIORI / ((100 - ' +  fSQLPercentualDesconto + ') / 100) AS UNIORI, ';
        strSQL := strSQL + '   DET_TOTITE AS VALITE, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_QTDITE, 0) AS QTEENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_QTDITE) AS QTESAI, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_TOTITE, 0) AS VALENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_TOTITE) AS VALSAI, ';
      End

      Else If ((Pos(strEspDoc, 'AJ') > 0) Or blnAjuste) And (Not fEmptyStr(strImpAju)) Then
      Begin
        strSQL := strSQL + '   DET_' + strImpAju + ' / ' + fGetSqlQtdIteVenda + ' AS VALUNI, ';
        strSQL := strSQL + '   DET_' + strImpAju + ' / ' + fGetSqlQtdIteVenda + ' AS UNIORI, ';
        strSQL := strSQL + '   ROUND(DET_' + strImpAju + ', 2) AS VALITE, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_QTDITE, 0) AS QTEENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_QTDITE) AS QTESAI, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_' + strImpAju + ', 0) AS VALENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_' + strImpAju + ') AS VALSAI, ';
      End

      Else
      Begin
        strSQL := strSQL + '   DET_UNITAR AS VALUNI, ';
        strSQL := strSQL + '   DET_UNIORI AS UNIORI, ';

        If (blnDocSep) And (fCfgSis('IMSEPE', varBoolean) Or blnSepPendRomaneio) Then
          strSQL := strSQL + ' ROUND(DET_UNITAR * ' + fGetSqlQtdIteVenda + ', 2) AS VALITE, '
        Else If (blnAgruparItensSeparacao) and (blnDocSep) Then
          strSQL := strSQL + ' ROUND(DET_UNIDIG * ' + fGetSqlQtdIteVenda + ', 2) AS VALITE, '
        Else
          strSQL := strSQL + ' DET_TOTITE AS VALITE, ';

        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_QTDITE, 0) AS QTEENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_QTDITE) AS QTESAI, ';

        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_TOTITE, 0) AS VALENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_TOTITE) AS VALSAI, ';
      End;

      strSQL := strSQL + '    IF(LEFT(DET_CLAFIS,1)<5,"ENT","SAI")    AS ENTSAI, ';
    End;

    strSQL := strSQL + '    DET_DESCON AS DESCON, ';
    strSQL := strSQL +  fGetSqlQtdIteVenda + ' AS QTDITE, ';

    If (blnDocSep) And (fCfgSis('IMSEPE', varBoolean) Or blnSepPendRomaneio) Then
      strSQL := strSQL + '  ROUND((DET_DESESP/DET_QTDITE) * ' + fGetSqlQtdIteVenda + ',2) AS DESESI, '
    Else
      strSQL := strSQL + '    DET_DESESP AS DESESI, ';

    strSQL := strSQL + fExisteCampo('DET_ALQICM') + ' AS IALQIC, ';
    strSQL := strSQL + '    DET_NUMLOT AS NUMLOT, ';

    strSQL := strSQL + '    DET_CODVEN AS VENITE, ';
    strSQL := strSQL + ' V1.OPE_NOMOPE AS NVENIT, ';

    strSQL := strSQL + fExisteCampo('DET_CODACA') + ' AS CODACA, ';
    strSQL := strSQL + fExisteCampo('DET_EMPACA') + ' AS EMPACA, ';

    strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR AS CODBAR, ';

    strSQL := strSQL + '  I.ITE_DESSIM AS DESSIM, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESCAD, ';

    strSQL := strSQL + '  I.ITE_APLICA AS APLICA, ';
    strSQL := strSQL + fRetSTRCampoBlobToCast255('I.ITE_APLICA', 'APLICA');

    strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), IF(DET_IDEPRO <> "NOR" OR LOCATE("ITEM ESPECIAL", DET_DESCRI) > 0, DET_DESCRI, ITE_DESITE)) AS DESIT1, ';
    strSQL := strSQL + '    CONCAT(' + fSQLTabPre + 'IF(DET_IDEPRO <> "NOR", CONCAT(DET_IDEPRO, " - "), ""), DET_DESCRI) AS DESIT2, ';

    strSQL := strSQL + '    DEP_DESCRI AS NOMDEP, ';

    strSQL := strSQL + '    UN.UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '    UN.UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '    UN.UNI_DESUNI AS DESUNI, ';
    strSQL := strSQL + '    UC.UNI_DESUNI AS UNICOM, ';

    strSQL := strSQL + '    CAST("" AS CHAR(10)) AS RESUNI, ';

    strSQL := strSQL + fExisteCampo('DET_BASIPI') + ' AS IBASIP, ';
    strSQL := strSQL + fExisteCampo('DET_ALQIPI') + ' AS IALQIP, ';
    strSQL := strSQL + fExisteCampo('DET_VALIPI') + ' AS VALIPI, ';
    strSQL := strSQL + fExisteCampo('DET_BASRET') + ' AS IBASRE, ';
    strSQL := strSQL + fExisteCampo('DET_ALQRET') + ' AS IALQRE, ';
    strSQL := strSQL + fExisteCampo('DET_VALRET') + ' AS VALRET, ';
    strSQL := strSQL + IIF(recDocume.blnRequisicao, '0.00', '(0.00 + ' + fSqlCampoReformaRef('MOVREF', 'REF_CBSVAL', 'D.AUTOINCREM') + ')') + ' AS VALCBS, ';
    strSQL := strSQL + IIF(recDocume.blnRequisicao, '0.00', '(0.00 + ' + fSqlCampoReformaRef('MOVREF', 'REF_VALIBS', 'D.AUTOINCREM') + ')') + ' AS VALIBS, ';
    strSQL := strSQL + IIF(recDocume.blnRequisicao, '0.00', '(0.00 + ' + fSqlCampoReformaRef('MOVREF', 'REF_SELVAL', 'D.AUTOINCREM') + ')') + ' AS VAL_IS, ';
    strSQL := strSQL + fExisteCampo('DET_BASICM') + ' AS IBASIC, ';
    strSQL := strSQL + fExisteCampo('DET_VALICM') + ' AS IVALIC, ';
    strSQL := strSQL + fExisteCampo('DET_QTDROM') + ' AS QTBAIV, ';

    strSQL := strSQL + '    DET_CODVE2 AS CODVE2, ';
    strSQL := strSQL + ' V2.OPE_NOMOPE AS NOMVE2, ';

    strSQL := strSQL + '    DET_CODDIV AS CODDIV, ';
    strSQL := strSQL + ' DI.DIV_NOMDIV AS NOMDIV, ';

    strSQL := strSQL + '    PAR_CODPAR AS CODPAR, ';
    strSQL := strSQL + '    PAR_NOMPAR AS NOMPAR, ';

    strSQL := strSQL + '    DET_CODREP AS CODREP, ';
    strSQL := strSQL + ' OP.OPE_NOMOPE AS NOMREP, ';

    strSQL := strSQL + '    DET_TABPRE AS TABPVE, ';
    strSQL := strSQL + '    DET_PROMOC AS PROMOC, ';

    strSQL := strSQL + '    ITE_MLTVEN AS MLTVEN, ';
    strSQL := strSQL + '    ITE_MLTCOM AS MLTCOM, ';

    strSQL := strSQL + '    DET_DESCRI AS DESCRI, ';
    strSQL := strSQL + '  I.ITE_CODONU AS CODONU, ';
    strSQL := strSQL + '    ONU_DESCRI AS DESONU, ';
    strSQL := strSQL + '    ONU_CODIGO AS CADONU, ';
    strSQL := strSQL + '    ONU_CLARIS AS CLAONU, ';
    strSQL := strSQL + '    ONU_GRUEMB AS EMBONU, ';

    If blnAgruparItensSeparacao Then
      strSQL := strSQL + ' SUM(';

    strSQL := strSQL + '    IF(ITE_MLTVEN > 1, DET_QTDITE / ITE_MLTVEN, 0) ';

    If blnAgruparItensSeparacao Then
      strSQL := strSQL + ')';

    strSQL := strSQL + ' AS QTDEMB, ';

    strSQL := strSQL + '  ' + strCampoSetor + ' AS SETOR_, ';

    strSQL := strSQL + '  G.ITE_LOCSUP AS LOCSUP, ';

    If SameText(strEspDoc, 'UC') Then
      strSQL := strSQL + '  (SELECT GROUP_CONCAT(DISTINCT CTP_CODCTA) FROM CADPAG WHERE CTP_USODOC = DET_NUMDOC AND CTP_USOESP = "UC" AND CTP_USOEMP = DET_CODEMP AND CTP_USOCLI = DET_CODCLI) AS CODCTA, '
    Else
      strSQL := strSQL + '  "" AS CODCTA, ';

    If fCfgSis('CLIPRO', varBoolean) then
    begin
      strSQL := strSQL + ' CLIPRO.CLI_COD_NF, ';
      strSQL := strSQL + ' CLIPRO.CLI_DES_NF, ';
    end
    else
    begin
      strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CLI_COD_NF, ';
      strSQL := strSQL + ' CAST("" AS CHAR(70)) AS CLI_DES_NF, ';
    end;

    strSQL := strSQL + fExisteCampo('DET_MOTFUT') + ' AS MOTFUT, ';

    If (recDocume.strTipFc = 'C') And (Not recDocume.blnRequisicao) Then
    Begin
      // MADEIREIRA - INICIO
      strSQL := strSQL + '    DET_QTDPEC AS QTDPEC, ';
      strSQL := strSQL + '    DET_COMPEC AS COMPEC, ';
      strSQL := strSQL + '    DET_LARPEC AS LARPEC, ';
      strSQL := strSQL + '    DET_ESPPEC AS ESPPEC, ';
      strSQL := strSQL + '    DET_APAREL AS APAREL, ';
      strSQL := strSQL + '    DET_BENEFI AS BENEFI, ';
      // MADEIREIRA - FIM
    End
    else
    Begin
      strSQL := strSQL + '    0.00 AS QTDPEC, ';
      strSQL := strSQL + '    0.00 AS COMPEC, ';
      strSQL := strSQL + '    0.00 AS LARPEC, ';
      strSQL := strSQL + '    0.00 AS ESPPEC, ';
      strSQL := strSQL + '    CAST("" AS CHAR(1)) AS APAREL, ';
      strSQL := strSQL + '    CAST("" AS CHAR(1)) AS BENEFI, ';
    End;


    strSQL := strSQL + fSQLBarDoc('DET') + ' AS BARDOC, ';

    strSQL := strSQL + ' IF(IFNULL(GRU_TIPGRU, "9") = "0", "OUTROS", IF(IFNULL(GRU_TIPGRU, "9") = "1", "PEÇAS", IF(IFNULL(GRU_TIPGRU, "9"), "PNEUS", ""))) AS TIPGRU, ';

    If blnDocSep Then
    Begin
      strSQL := strSQL + ' G.ITE_SALDOS AS SALDOS, ';
      strSQL := strSQL + ' ITE_CNV_ML,      ';
      strSQL := strSQL + ' ITE_SAL_ML,      ';
      strSQL := strSQL + ' 0.000 AS SALDIS, ';
    End
    else
    Begin
      strSQL := strSQL + ' 0.000 AS SALDOS,     ';
      strSQL := strSQL + ' 0.000 AS ITE_CNV_ML, ';
      strSQL := strSQL + ' 0.000 AS ITE_SAL_ML, ';
    end;

    If (Pos(strEspDoc, '_AJ_TE_') > 0) and not (blnDocSep) Then
    Begin
      strSQL := strSQL + ' G.ITE_SALDOS AS SALFIS, ';
      strSQL := strSQL + '(' + fSQLSaldoDisponivel('G', True) + ') AS SALDIS, ';
    End;

    If recDocume.blnRequisicao Then Begin
      strSQL := strSQL + '    DET_UNITAR AS UNIDIG, ';
      strSQL := strSQL + '    (DET_QTDITE * DET_UNITAR) AS VALDIG, ';
    End Else Begin
      strSQL := strSQL + '    DET_UNIDIG AS UNIDIG, ';
      strSQL := strSQL + '    (DET_QTDITE * DET_UNIDIG) AS VALDIG, ';
    End;

    strSQLMec := fRetornarMecanicos(strTabDet,
                                    strNumDoc,
                                    strEspDoc,
                                    strCodCli,
                                    strCodEmp);

    If (Not fEmptyStr(strSQLMec)) Then
      strSQL := strSQL + ' NM.CODMEC AS MECSER, '
    Else
      strSQL := strSQL + ' CAST("" AS CHAR(20)) AS MECSER, ';

    strSQL := strSQL + ' DET_QTDEXP AS QTDEXP, ';
    strSQL := strSQL + ' DET_TURENT AS TURENT, ';

    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS MECPED, ';
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS OBMESR, ';
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS OBMEPD, ';

    strSQL := strSQL + ' CONCAT(IFNULL(DET_NUMCMP,"")," ", IFNULL(DET_NITCMP,"")) AS NUMCMI, ';
    strSQL := strSQL + ' I.ITE_CLAIPI AS CLAIPI, ';

    strSQL := strSQL + ' CL.LOT_NUMLOT AS CODAMZ, ';
    strSQL := strSQL + ' IFNULL(CADAMZ.AMZ_DESCRI, "") AS DESAMZ, ';
    strSQL := strSQL + ' CL.LOT_LOCFIS AS LCFSAZ, ';
    strSQL := strSQL + ' DATE_FORMAT(IFNULL(CL.LOT_DTAFAB, ""), "%d/%m/%Y") AS DTAFAB, ';
    strSQL := strSQL + ' DATE_FORMAT(IFNULL(CL.LOT_DTAVAL, ""), "%d/%m/%Y") AS DTAVAL, ';
    strSQL := strSQL + ' CL.LOT_CAPACI AS CAPACI, ';
    strSQL := strSQL + ' CL.LOT_PONREP AS PONREP, ';
    strSQL := strSQL + ' LC.LOT_NUMLOT AS CDAMZC, ';
    strSQL := strSQL + ' LV.LOT_NUMLOT AS CDAMZV, ';

    strSQL := strSQL + ' IF( IFNULL(T.TRI_NCMTIN,"") = "", I.ITE_CLAIPI, T.TRI_NCMTIN) AS CODNCM, ';

    If Not fEmptyStr(strTabTri) Then
      strSQL := strSQL + ' T.DET_CLIBUS AS CLIBUS, '
    Else
      strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CLIBUS, ';

    strSQL := strSQL + '  CAST("" AS CHAR(100)) AS LEGEND, ';

    strSQL := strSQL + ' DET_DTAFUT AS DTAFUT, ';

    strSQL := strSQL + ' DET_QTDENT AS QTDENT, ';

    If recDocume.blnSepFut Then
    Begin
      strSQL := strSQL + ' SEPFUT.SEP_QTDITE AS SEPITE, ';
      strSQL := strSQL + ' SEPFUT.SEP_QTDIMP AS SEPIMP, ';
    End
    Else
    Begin
      strSQL := strSQL + ' 0 AS SEPITE, ';
      strSQL := strSQL + ' 0 AS SEPIMP, ';
    End;

    strSQL := strSQL + ' IF(DET_UNIDIG > DET_UNIORI, (DET_UNIDIG * DET_QTDITE), (DET_UNIORI * DET_QTDITE))  AS MAIVAL, ';

    {Localizações Adicionais}
    If fCfgSis('CADLOC', varBoolean) Then
    Begin
      strSQL := strSQL + ' (SELECT                                 ';
      strSQL := strSQL + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
      strSQL := strSQL + '  FROM                                   ';
      strSQL := strSQL + '    LOCFIS                               ';
      strSQL := strSQL + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
      strSQL := strSQL + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
      strSQL := strSQL + '  WHERE                                  ';
      strSQL := strSQL + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
      strSQL := strSQL + '    LOCFIS.LOC_CODEMP = DET_CODEMP AND ';
      strSQL := strSQL + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
    End
    Else
    Begin
      strSQL := strSQL + ' (SELECT                                 ';
      strSQL := strSQL + '    GROUP_CONCAT(LOC_LOCFIS)             ';
      strSQL := strSQL + '  FROM                                   ';
      strSQL := strSQL + '    LOCFIS                               ';
      strSQL := strSQL + '  WHERE                                  ';
      strSQL := strSQL + '    LOC_CODITE = I.ITE_CODITE AND        ';
      strSQL := strSQL + '    LOC_CODEMP = DET_CODEMP) AS LOCADI ';
    End;

    strSQL := strSQL + ' , (SELECT                                     ';
    strSQL := strSQL + '      DISTINCT CONCAT(NOTGER.GER_NUMDOC, "-", NOTGER.GER_ESPDOC, "-", NOTGER.GER_CODEMP ) AS NUMDOC  ';
    strSQL := strSQL + '    FROM                                      ';
    strSQL := strSQL + '      NOTGER                                  ';
    strSQL := strSQL + '  LEFT JOIN CNFMNO ON MNO_SEQGER = AUTOINCREM ';
    strSQL := strSQL + '    WHERE                                     ';
    strSQL := strSQL + '      MNO_NUMFAT = :NUMDOC AND                ';
    strSQL := strSQL + '      MNO_ESPFAT = :ESPDOC AND                ';
    strSQL := strSQL + '      MNO_EMPFAT = :CODEMP) AS DOCESP         ';

    for intTab := 1 to 7 do
      strSQL := strSQL + ' ,G.ITE_PREVE'+IntToStr(intTab)+' AS TBPRE'+IntToStr(intTab);

    strSQL := strSQL + ' , G.ITE_PRECUS AS PRECST ';

    strSQL := strSQL + ' , IFNULL(DET_FRERAT, 0) AS FRERAT ';

    strSQL := strSQL + ' , I.ITE_MSGLV1 AS MSGLV1 ';
    strSQL := strSQL + ' , I.ITE_MSGLV2 AS MSGLV2 ';
    strSQL := strSQL + ' , G.ITE_DTAULT AS DTAULT ';

    strSQL := strSQL + ' ,COALESCE(DC.DET_MEDB_L, CL.LOT_MEDB_L) AS MEDB_L ';
    strSQL := strSQL + ' ,COALESCE(DC.DET_MEDB_A, CL.LOT_MEDB_A) AS MEDB_A ';
    strSQL := strSQL + ' ,COALESCE(DC.DET_MEDL_L, CL.LOT_MEDL_L) AS MEDL_L ';
    strSQL := strSQL + ' ,COALESCE(DC.DET_MEDL_A, CL.LOT_MEDL_A) AS MEDL_A ';
    strSQL := strSQL + ' ,COALESCE(DC.DET_ESPESS, CL.LOT_ESPESS) AS ESPESS ';

    strSQL := strSQL + ' , DET_TOTPES AS TOTPES ';

    if (fCfgSis('MARMOR') = 'S') then
    begin
      if (fCfgSis('CTRLCH') = '2') then
      begin
        strSQL := strSQL + ' ,IF( CL.LOT_MEDL_L <> 0 AND CL.LOT_MEDL_A <> 0, DET_QTDITE / CL.LOT_MEDL_L / CL.LOT_MEDL_A, 0 ) AS QTDCHP ';
      end
      else
      begin
        strSQL := strSQL + ' ,DET_QTDITE AS QTDCHP ';
      end;
    end
    else
    begin
      strSQL := strSQL + ' ,0.00 AS QTDCHP ';
    end;

    strSQL := strSQL + ' , IF (ITE_MLTVEN > 1, DET_QTDITE / ITE_MLTVEN, DET_QTDITE) AS QTDTOT ';
    strSQL := strSQL + ' , PRD_DESGRU AS GRUDES ';

    strSQL := strSQL + ' , T.DET_LOCFIS AS LOCENT ';

    strSQL := strSQL + ' ,(IF(D.DET_IDEPRO="NOR", ""             ' ;
    strSQL := strSQL + ' ,(SELECT                                 ' ;
    strSQL := strSQL + '    T1.DET_TIPFOR                         ' ;
    strSQL := strSQL + '  FROM                                    ' ;
    strSQL := strSQL +    strTabDet + ' M3                        ' ;
    strSQL := strSQL + '    INNER JOIN TINDET T1                  ' ;
    strSQL := strSQL + '      ON M3.DET_NUMDOC = T1.DET_NUMDOC    ' ;
    strSQL := strSQL + '      AND M3.DET_ESPDOC = T1.DET_ESPDOC   ' ;
    strSQL := strSQL + '      AND M3.DET_CODEMP = T1.DET_CODEMP   ' ;
    strSQL := strSQL + '      AND M3.DET_EMPACA = T1.DET_EMPACA   ' ;
    strSQL := strSQL + '      AND M3.DET_CODACA = T1.DET_CODACA   ' ;
    strSQL := strSQL + '      AND M3.DET_PROEMB = "N"             ' ;
    strSQL := strSQL + '  WHERE M3.DET_NUMDOC = D.DET_NUMDOC      ' ;
    strSQL := strSQL + '    AND M3.DET_CODEMP = D.DET_CODEMP      ' ;
    strSQL := strSQL + '    AND M3.DET_ESPDOC = D.DET_ESPDOC      ' ;
    strSQL := strSQL + '    AND M3.DET_CODCLI = D.DET_CODCLI     ' ;
    strSQL := strSQL + '    AND M3.DET_ITETIN = D.DET_ITETIN     ' ;
    strSQL := strSQL + '    AND M3.DET_CODACA = D.DET_CODACA     ' ;
    strSQL := strSQL + '    AND M3.DET_EMPACA = D.DET_EMPACA     ' ;
    strSQL := strSQL + '    AND M3.DET_PROEMB = "N" LIMIT 1))) AS TIPFOR ' ;
    strSQL := strSQL + ' , DET_TOTFRE as VALFRE ';

    If Not fEmptyStr(strTabTri) Then
      strSQL := strSQL + ' ,DET_COMPLE as COMPLE '
    Else
      strSQL := strSQL + ' ,CAST("" AS CHAR(30)) as COMPLE ';

    strSQL := strSQL + ' ,I.ITE_VALOBR AS VALOBR   ';

    Case VarToStr(fCfgSis('NROPRO', VarString))[1] Of
      '2': strSQL := strSQL + ' ,CONCAT(DET_CODDIV,"-",DI.DIV_NOMDIV) AS LISDIV ';
      '3': strSQL := strSQL + ' ,( SELECT                                       '+
                              '      TRIM(                                      '+
                              '        GROUP_CONCAT(                            '+
                              '          CONCAT(                                '+
                              '            " ",                                 '+
                              '            CADDIV.DIV_CODDIV,                   '+
                              '            "-",                                 '+
                              '            CADDIV.DIV_NOMDIV                    '+
                              '          )                                      '+
                              '        )                                        '+
                              '      )                                          '+
                              '    FROM                                         '+
                              '      DIVFAT                                     '+
                              '      INNER JOIN CADDIV                          '+
                              '        ON DIVFAT.DIV_CODDIV = CADDIV.DIV_CODDIV '+
                              '    WHERE DIVFAT.DIV_SEQGER IN                   '+
                              '      (SELECT                                    '+
                              '        FDO_SEQGER                               '+
                              '      FROM                                       '+
                              '        FATDOR                                   '+
                              '      WHERE FDO_CODEMP = DET_EMP_PD              '+
                              '        AND FDO_ESPDOC = DET_ESP_PD              '+
                              '        AND FDO_NUMDOC = DET_NUM_PD)) AS LISDIV  ';
      Else strSQL := strSQL + ' ," " AS LISDIV '                                 ;
    End;

    strSQL := strSQL + ', 0.00 AS QTDSDV ';

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      strSQL := strSQL + '    ,IF(IFNULL(FATDOR.FDO_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI)  AS LOCSEP '
    Else If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS) Then
      strSQL := strSQL + '    ,CL.LOT_LOCSEP AS LOCSEP '
    Else
      strSQL := strSQL + '    ,LSE_DESCRI AS LOCSEP ';

    strSQL := strSQL + ', DET_EMP_PD AS EMP_PD ';

    strSQL := strSQL + ', G.ITE_LOCFIS AS LOCFIS ';

    strSQL := strSQL + ', (SELECT E.FDO_ENTRET                                 '+
                       '     FROM                                              '+
                       '   FATDOR F                                            '+
                       '     LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM '+
                       '    WHERE F.FDO_CODEMP = D.DET_EMP_PD                  '+
                       '      AND F.FDO_ESPDOC = D.DET_ESP_PD                  '+
                       '      AND F.FDO_NUMDOC = D.DET_NUM_PD                  '+
                       '      AND F.FDO_SEQIND = D.DET_IND_PD                  '+
                       '      AND F.FDO_CODITE = D.DET_CODITE) AS ENTRET       ';


    strSQL := strSQL + ', I.ITE_PESOIT AS PESITE ';
    strSQL := strSQL + ', DET_PROACA AS PROACA    ';

    strSQL := strSQL + ', CASE D.DET_TABPRE ';
    strSQL := strSQL + '   WHEN "1" THEN G.ITE_PREVE1 ';
    strSQL := strSQL + '   WHEN "2" THEN G.ITE_PREVE2 ';
    strSQL := strSQL + '   WHEN "3" THEN G.ITE_PREVE3 ';
    strSQL := strSQL + '   WHEN "4" THEN G.ITE_PREVE4 ';
    strSQL := strSQL + '   WHEN "5" THEN G.ITE_PREVE5 ';
    strSQL := strSQL + '   WHEN "6" THEN G.ITE_PREVE6 ';
    strSQL := strSQL + '   WHEN "7" THEN G.ITE_PREVE7 ';
    strSQL := strSQL + ' END AS PRETAB                ';

    strSQL := strSQL + ' ,CAST("" AS CHAR(1000)) AS ESTRUT ';

    strSQL := strSQL + ' ,I.ITE_CEREPI AS CEREPI ';
    strSQL := strSQL + ' ,I.ITE_FATPM3 AS FATPM3 ';
    strSQL := strSQL + ' ,I.ITE_DTAEPI AS DTAEPI ';
    strSQL := strSQL + ' ,I.ITE_CODDEP AS CODDEP ';
    strSQL := strSQL + ' ,  (SELECT GROUP_CONCAT(DETSER.SER_NUMSER)             ';
    strSQL := strSQL + '      FROM DETSER                                       ';
    strSQL := strSQL + '     WHERE DETSER.SER_SEQGER = D.AUTOINCREM) AS NUMSER  ';
    strSQL := strSQL + ' ,"N" AS DELETA_DEVOLUCAO ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(12)) AS NUMDOC ';

    strSQL := strSQL + ' ,(SELECT                                  ';
    strSQL := strSQL + '    IFNULL(TIN.DET_EMPPRD, TIN.DET_CODEMP) ';
    strSQL := strSQL + '   FROM                                    ';
    strSQL := strSQL +     strTabDet + ' DET                       ';
    strSQL := strSQL + '     INNER JOIN TINDET TIN                 ';
    strSQL := strSQL + '        ON DET.DET_NUMDOC = TIN.DET_NUMDOC ';
    strSQL := strSQL + '       AND DET.DET_ESPDOC = TIN.DET_ESPDOC ';
    strSQL := strSQL + '       AND DET.DET_CODEMP = TIN.DET_CODEMP ';
    strSQL := strSQL + '       AND DET.DET_EMPACA = TIN.DET_EMPACA ';
    strSQL := strSQL + '       AND DET.DET_CODACA = TIN.DET_CODACA ';
    strSQL := strSQL + '       AND DET.DET_PROEMB = "N"            ';
    strSQL := strSQL + '   WHERE DET.DET_NUMDOC = D.DET_NUMDOC     ';
    strSQL := strSQL + '     AND DET.DET_CODEMP = D.DET_CODEMP     ';
    strSQL := strSQL + '     AND DET.DET_ESPDOC = D.DET_ESPDOC     ';
    strSQL := strSQL + '     AND DET.DET_CODCLI = D.DET_CODCLI     ';
    strSQL := strSQL + '     AND DET.DET_ITETIN = D.DET_ITETIN     ';
    strSQL := strSQL + '     AND DET.DET_CODACA = D.DET_CODACA     ';
    strSQL := strSQL + '     AND DET.DET_EMPACA = D.DET_EMPACA     ';
    strSQL := strSQL + '     AND DET.DET_PROEMB = "N"              ';
    strSQL := strSQL + '   LIMIT 1) AS EMPPRD                      ';

    strSQL := strSQL + ', D.DET_VLRCON AS VLRCTB ';

    strSQL := strSQL + ' FROM         ';
    strSQL := strSQL +     strTabDet + ' D ';

    If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS) Then
      strSQL := strSQL + ' INNER JOIN '+fRetLotDor+' L ON L.LDO_SEQFDO = D.AUTOINCREM ';

    strSQL := strSQL + ' INNER JOIN ' +  strTabGer + ' MG ON MG.AUTOINCREM = D.DET_SEQGER ';

    If Not fEmptyStr(strTabTri) Then
      strSQL := strSQL + ' LEFT JOIN ' + strTabTri + ' T ON T.DET_SEQGER =  D.AUTOINCREM ';

    If (Not fEmptyStr(strSQLMec)) Then
      strSQL := strSQL + ' LEFT JOIN ( ' + strSQLMec + ' ) AS NM ON D.AUTOINCREM = NM.SEQDET';

    strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ';

    If fCfgSis('CLIPRO', varBoolean) then
    begin
      strSQL := strSQL + ' LEFT JOIN CLIPRO ON DET_CODITE = CLIPRO.CLI_CODITE AND ';
      strSQL := strSQL + '                     DET_CODCLI = CLIPRO.CLI_CODCLI ';
      strSQL := strSQL + ' LEFT JOIN CADUNI UN ON COALESCE(CLI_CODUNI, ITE_CODUNI) = UN.UNI_CODUNI  ';
    end
    else
      strSQL := strSQL + ' LEFT JOIN CADUNI UN ON ITE_CODUNI = UN.UNI_CODUNI  ';

    strSQL := strSQL + ' LEFT JOIN CADGRU ON GRU_CODGRU = I.ITE_CODGRU ';

    strSQL := strSQL + ' LEFT JOIN CADUNI UC ON ITE_UNICOM = UC.UNI_CODUNI  ';

    strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR  ';

    strSQL := strSQL + ' LEFT JOIN CADOPE V1 ON V1.OPE_CODOPE = DET_CODVEN ';
    strSQL := strSQL + ' LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = DET_CODVE2 ';
    strSQL := strSQL + ' LEFT JOIN CADDIV DI ON DI.DIV_CODDIV = DET_CODDIV ';
    strSQL := strSQL + ' LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = DET_CODREP ';

    strSQL := strSQL + ' LEFT JOIN BRIDET ON BRI_SEQDET = D.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADPAR ON PAR_CODPAR = BRI_CODPAR   ';

    If recDocume.blnSepFut Then
    begin
      strSQL := strSQL + ' INNER JOIN ' + AnsiReplaceStr(strTabDet, 'MOVDET', 'SEPFUT') + ' ON SEP_SEQGER = D.AUTOINCREM AND SEP_QTDITE > 0 ';
      if (not fCfgSis('ISEFIE', varBoolean)) and (recDocume.dtaSepFut > 0) then
        strSQL := strSQL + '   AND SEP_DTAIMP = :DTASEPFUT AND SEP_HORIMP = :HRASEPFUT ';
    end;

    strSQL := strSQL + ' LEFT JOIN ITEGER G ON ';
    strSQL := strSQL + '     G.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '     G.ITE_CODEMP =   DET_CODEMP     ';

    strSQL := strSQL + ' LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP ';

    If (blnDesCon) Then
      strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';

    // MADEIREIRA
    If (recDocume.strTipFc = 'C') And (Not recDocume.blnRequisicao) Then
      strSQL := strSQL + ' LEFT JOIN ' + AnsiReplaceStr(strTabDet, 'DET', 'MAD') + ' M ON M.DET_SEQGER = D.AUTOINCREM  ';

    If (fUsaRotinaWMS And recDocume.blnDocSep) Or (fRetEhReimpressaoDeDocumentoCanceladoWMS) Then
      strSQL := strSQL + ' LEFT JOIN CADLOT CL ON IFNULL(LDO_NUMLOT, DET_NUMLOT) = CL.LOT_NUMLOT AND '
    Else
      strSQL := strSQL + ' LEFT JOIN CADLOT CL ON DET_NUMLOT = CL.LOT_NUMLOT AND ';

    strSQL := strSQL + '                     DET_CODITE = CL.LOT_CODITE AND ';
    strSQL := strSQL + '                     DET_CODEMP = CL.LOT_CODEMP     ';

    strSQL := strSQL + ' LEFT JOIN CADLOT LC ON LC.AUTOINCREM = (SELECT C.AUTOINCREM FROM CADLOT C WHERE ';
    strSQL := strSQL + '                                           DET_CODITE = LOT_CODITE AND ';
    strSQL := strSQL + '                                           DET_CODEMP = LOT_CODEMP ';
    strSQL := strSQL + '                                          AND LOT_ARMPRC  = "S" LIMIT 1) ';

    strSQL := strSQL + ' LEFT JOIN CADLOT LV ON LV.AUTOINCREM = (SELECT C.AUTOINCREM FROM CADLOT C WHERE ';
    strSQL := strSQL + '                                           DET_CODITE = LOT_CODITE AND ';
    strSQL := strSQL + '                                           DET_CODEMP = LOT_CODEMP ';
    strSQL := strSQL + '                                          AND LOT_ARMPRI  = "S" LIMIT 1) ';

    strSQL := strSQL + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CL.LOT_LOCFIS AND L1.LOC_CODEMP = CL.LOT_CODEMP  ';
    strSQL := strSQL + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = G.ITE_LOCFIS AND L2.LOC_CODEMP = G.ITE_CODEMP  ';
    strSQL := strSQL + ' LEFT JOIN CADLOC L3 ON L3.LOC_CODLOC = T.DET_LOCFIS AND L3.LOC_CODEMP = D.DET_CODEMP  ';

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      strSQL := strSQL + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = L1.LOC_CODLSE ';
      strSQL := strSQL + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = L2.LOC_CODLSE ';
    end
    else
      strSQL := strSQL + ' LEFT JOIN CADLSE LS ON LS.LSE_CODIGO = G.ITE_CODLSE  ';

    strSQL := strSQL + ' LEFT JOIN CADONU ON I.ITE_CODONU = CADONU.ONU_CODONU ';

    strSQL := strSQL + ' LEFT JOIN CADAMZ ON (CADAMZ.AMZ_CODAMZ = D.DET_NUMLOT AND CADAMZ.AMZ_CODEMP = D.DET_CODEMP) ';
    strSQL := strSQL + ' LEFT JOIN GRPPRD ON PRD_CODGRU = ITE_PRDGRU ';
    strSQL := strSQL + ' LEFT JOIN DETCHA DC ON DC.DET_SEQGER = D.AUTOINCREM ';

    strSQL := strSQL + ' WHERE        ';

    If Assigned(cdsLogSeparacao) Then
    Begin
      strSQL := strSQL + ' FALSE    ';
    End Else
    Begin
      If recDocume.strTipFc = 'C' Then
        strSQL := strSQL + '   DET_CODCLI = :CODCLI AND '
      Else
        strSQL := strSQL + '   DET_CODFOR = :CODCLI AND ';

      If SameText(strEspDoc, 'ML') Or recDocume.blnAjMl  Then
      Begin
        strSQL := strSQL + '  DET_NUMFAT = :NUMDOC AND ';
        strSQL := strSQL + '  DET_TIPFAT = :ESPDOC AND ';
        strSQL := strSQL + '  DET_EMPFAT = :CODEMP AND ';
      End Else
      Begin
        strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
      End;

      If blnDocSep Then
      Begin
        strSQL := strSQL + ' ((ROUND(DET_QTDITE, 4) ';

        If fCfgSis('IMSEPE', varBoolean) Then
          strSQL := strSQL + ' - ROUND(IFNULL(DET_QTDEXP,0), 4) ';

        If blnSepPendRomaneio Then
          strSQL := strSQL + ' - ' + fGetSqlQtdRomaneio;

        strSQL := strSQL + ' ) > 0) AND ';
      End;

      strSQL := strSQL + '   IFNULL(DET_PROEMB, "N") <> "S"         AND ';
      strSQL := strSQL + '   DET_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
      strSQL := strSQL + '   DET_ESPDOC <> "TM" AND ';
      strSQL := strSQL + '   DET_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';

      {Req.: 186067 - Desconsiderar os itens baixados totalmente na entrega futura}
      If (blnDocSep) And (recDocume.blnSepFut) Then
        strSQL := strSQL + '   AND (DET_QTDENT < DET_QTDITE) ';

      If (recDocume.blnDocSep) And (Not(fCfgSis('IMPVEN', varBoolean))) and (fCfgSis('PEGPED', varBoolean)) Then
      Begin
        strSQL := strSQL +'  AND (D.DET_CODITE NOT IN ( '
                         +'                             SELECT FDO_CODITE     '
                         +'                             FROM FATDOR FD        '
                         +'                             LEFT JOIN FATGOR FG ON FG.AUTOINCREM = FD.FDO_SEQGER '
                         +'                             LEFT JOIN EXTDOR ED ON ED.FDO_SEQFDO = FD.AUTOINCREM '
                         +'                             WHERE ED.FDO_PEGOU_ = "S" '
                         +'                               AND FGO_NUMDOC = D.DET_NUM_PD '
                         +'                               AND FGO_CODEMP = D.DET_EMP_PD '
                         +'                               AND FGO_ESPDOC = D.DET_ESP_PD '
                         +'                           ) '
                         +'      ) '
                         +'  AND (T.DET_PEGOU_ = "N")'

      End;


      If blnDocSep And (opcAbastecimento In [opcSolicitado, opcNaoSolicitado]) Then
      Begin
        strSQL := strSQL + ' AND IFNULL( ( SELECT SQL_NO_CACHE ';
        strSQL := strSQL + IIF(blnSomenteEmpDifSep, 'NULLIF(FDO_EMPFOR, IFNULL(FDO_EMPITE, FDO_CODEMP))', 'FDO_EMPFOR');
        strSQL := strSQL + '               FROM ';
        strSQL := strSQL + '                 FATDOR ';
        strSQL := strSQL + '                 LEFT JOIN EXTDOR E ON E.FDO_SEQFDO = FATDOR.AUTOINCREM  ';
        strSQL := strSQL + '               WHERE ';
        strSQL := strSQL + '                 FDO_NUMDOC = DET_NUM_PD AND ';
        strSQL := strSQL + '                 FDO_ESPDOC = DET_ESP_PD AND ';
        strSQL := strSQL + '                 FDO_CODEMP = DET_EMP_PD AND ';
        strSQL := strSQL + '                 FDO_SEQIND = DET_IND_PD AND ';
        strSQL := strSQL + '                 FDO_CODITE = DET_CODITE ), "" ) ';

        Case opcAbastecimento Of
          opcSolicitado    : strSQL := strSQL + ' <> "" ';
          opcNaoSolicitado : strSQL := strSQL + ' =  "" ';
        End;
      End;

      If Not fEmptyStr(strWhereSep) Then
        strSQL := strSQL + IIF(LeftStr(Trim(strWhereSep), 3) = 'AND', '', ' AND ') + strWhereSep;

      strSQL := strSQL + fGetSqlGroupByVenda;

      If blnDocSep And (Not fEmptyStr(Trim(strSetor))) Then
        strSQL := strSQL + ' HAVING SETOR_ = ' + QuotedStr(strSetor);

      If (Not recDocume.blnRequisicao) Then
      Begin

        strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr(
                                           AnsiReplaceStr( strSQL,'SER_SEQGER', 'SER_SEQNOT'),
                                                                  'DET_KEY_EP', '""'    ),
                                                                  'MOVGER'    , 'NOTGER'),
                                                                  'MOVTRI'    , 'NOTTRI'),
                                                                  'MOVDET'    , 'NOTDET'),
                                                                  'DET_QTDENT',      '0'),
                                                                  'DET_FRERAT',      '0'),
                                                                  'DET_COMPLE', ' CAST("" AS CHAR(30)) '),
                                                                  'T.DET_PEGOU_',  '"N"'),
                                                                  'MOVREF'    , 'NOTREF');

      End;

      strSQL := strSQL + ' ORDER BY ';

      If Not fEmptyStr(recDocume.strOrdem) Then
      Begin
        Case recDocume.strOrdem[1] Of
          '1': strSQL := strSQL + '   DESITE ';
          '2': strSQL := strSQL + '   AUTDET ';
          '3': strSQL := strSQL + '   SIGUNI, DESITE ';
          '4': strSQL := strSQL + '   DEP_DESCRI, DESITE ';
          '6': strSQL := strSQL + '   IF(IFNULL(ENTRET, "R") = "R",0, IF(IFNULL(ENTFUT, "N") = "N", 1, 2)), DESITE ';
          Else strSQL := strSQL + '   IFNULL(IF(IFNULL(CODAMZ, "") = "", LOCFIS, LCFSAZ), ""), DESITE ';
        End;

      End
      Else
        strSQL := strSQL + '   AUTDET ';

    End;

    Result := strSQL;
  End;
End;

Function TLeDocumentoMIFF.fInsereClientMovGer(Var regClient: TRegClient): Boolean;
Begin

  With regClient Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLMovGer);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With regClient, cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := IfThen(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc);
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    Result := fAbreClient(True, 'fInsereClientMovGer');
  End;

End;

Function TLeDocumentoMIFF.fInsereClientMovdet: Boolean;
  Var
    intTab: integer;
Begin
  With arrClients[0], recDocume Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLItems);

    if (fCfgSis('DEVROM', VarString) = '6') and (recDocume.blnDocSep) then
    begin
      cdsDados.Filtered := False;
      cdsDados.Filter   := 'DELETA_DEVOLUCAO = ' + QuotedStr('N');
      cdsDados.Filtered := True;
    end;

    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[0], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := IfThen(SameText(strEspDoc, 'ML'), 'AJ', strEspDoc);
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    if (not fCfgSis('ISEFIE', varBoolean)) and (recDocume.blnSepFut) and (recDocume.dtaSepFut > 0) then
    begin
      ParamByName('DTASEPFUT').AsDate := recDocume.dtaSepFut;
      ParamByName('HRASEPFUT').AsTime := recDocume.hraSepFut;
    end;

    pCriaSoma('', 'TOTUNI', 'SUM(VALUNI * QTDITE)');
    pCriaSoma('', 'TOTORI', 'SUM(UNIORI * QTDITE)');
    pCriaSoma('', 'TOTQTD', 'SUM(QTDITE)');

    pCriaSoma('', 'TOTENT', 'SUM(VALENT)');
    pCriaSoma('', 'TOTSAI', 'SUM(VALSAI)');
    pCriaSoma('', 'TOTDIG', 'SUM(UNIDIG * QTDITE)');

    pCriaSoma('', 'TOTITE', 'SUM(VALITE)');

    pCriaSoma('', 'TOTDES', 'SUM(DESCON)');
    pCriaSoma('', 'TOTMAI', 'SUM(MAIVAL)');

    pCriaSoma('', 'TOTRAT', 'SUM(FRERAT)');

    pCriaSoma('', 'PESTOT', 'SUM(TOTPES)');

    pCriaSoma('', 'TOTTAB', 'SUM(QTDITE * PRETAB)');

    for intTab := 1 to 7 do
      pCriaSoma('', 'TOTTB'+IntToStr(intTab), 'SUM(QTDITE * TBPRE'+IntToStr(intTab)+')');

    pCriaSoma('', 'TOTCHP', 'SUM(QTDCHP)');

    pCriaSoma('', 'TOTMLT', 'SUM(QTDTOT)');

    pCriaSoma('', 'TTQTEN', 'SUM(QTEENT)');
    pCriaSoma('', 'TTQTSD', 'SUM(QTESAI)');
    pCriaSoma('', 'TOTMT3', 'SUM(QTDITE * FATPM3)');

    Result := fAbreClient(True, 'fInsereClientMovdet');
  End;

End;

Procedure TLeDocumentoMIFF.pSetaNomeTabela;
  Var
    strDocOri,
    strDocDev,
    strEspDev,
    strEmpDev: String;
Begin
  With recDocume Do
  Begin
    if blnRequisicao then
    Begin
      strTabGer := 'ENTGER';
      strTabDet := 'ENTDET';
    End
    Else
    Begin
      strTabGer := 'MOVGER';
      strTabDet := 'MOVDET';
    End;

    If blnDocCan Then
    Begin
      strTabGer := 'DEL_' + strTabGer;
      strTabDet := 'DEL_' + strTabDet;
    End;
  End;

  strTabTri := '';
  If Pos('MOVDET', strTabDet) > 0 Then
    strTabTri := AnsiReplaceStr(strTabDet, 'MOVDET', 'MOVTRI')
  Else If Pos('NOTDET', strTabDet) > 0 Then
    strTabDet := AnsiReplaceStr(strTabDet, 'NOTDET', 'NOTTRI');

  blnEhUmDocumentoAPrazo := False;
  blnEhUmaDVdeFF         := False;
  fltPorDesFFOri         := 0.00;
  With recDocume Do
  Begin
    If (Pos(strTabGer, 'MOVGER/NOTGER/DEL_MOVGER/DEL_NOTGER/') > 0) Then
    Begin
      blnEhUmDocumentoAPrazo := (fStatusCndPag(fCampoTabela('GER_CONPAG', strTabGer, ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'GER_CODCLI'], [strNumDoc, strEspDoc, strCodEmp, strCodCli])) = A_PRAZO);
      If (strEspDoc = 'DV') Then
      Begin
        strDocOri := fCampoTabela('CONCAT(DET_DOCDEV,"-",DET_ESPDEV,"-",DET_EMPDEV)', strTabDet, ['DET_NUMDOC', 'DET_ESPDOC', 'DET_CODEMP', 'DET_CODCLI'], [strNumDoc, strEspDoc, strCodEmp, strCodCli]);
        strDocDev := Copy(strDocOri, 01,12);
        strEspDev := Copy(strDocOri, 14,02);
        strEmpDev := Copy(strDocOri, 17,03);

        blnEhUmaDVdeFF := strEspDev = 'FF';
        fltPorDesFFOri := fRetPorDesDocVenda(strDocDev, strEspDev, strEmpDev, strCodCli);
      End;
    End;

    If (strEspDoc = 'ML') And (Pos('MOVDET', strTabDet) > 0 ) Then
    Begin
      blnAjuste := (fCampoTabela('GER_TIPFAT', 'MOVGER', ['GER_NUMFAT', 'GER_ESPDOC', 'GER_CODEMP'], [strNumDoc, strEspDoc, strCodEmp] ) = 'AJ');
    End
    Else
      blnAjuste := False;

    If blnAjuste Or (strEspDoc = 'AJ') Then
      strImpAju := fCfgSis('IMPAJU', varString)
    Else
      strImpAju := '';

    blnExibirValorBrutoSeEstiverUsandoDescontoClienteProfissional := (((blnEhUmDocumentoAPrazo) Or ((Not blnEhUmDocumentoAPrazo) And (Pos(fCfgSis('PDVLAV', varString), '1_2_') > 0))) And
                                                                     (Pos(strEspDoc, 'FF_'+IIF(blnEhUmaDVdeFF, 'DV_', '')) > 0) And
                                                                     (fDescontoCliente)) And (fCfgSis('DEPRFF', varString) = '1');
  End;
End;

Procedure TLeDocumentoMIFF.pSetaParametrosCadcli;
Begin
  inherited;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CIDCON').AsString := cdsMovGer.FieldByName('GER_CIDCON').AsString;
    ParamByName('ENDCON').AsString := cdsMovGer.FieldByName('GER_ENDCON').AsString;
    ParamByName('BAICON').AsString := cdsMovGer.FieldByName('GER_BAICON').AsString;
    ParamByName('CEPCON').AsString := cdsMovGer.FieldByName('GER_CEPCON').AsString;
    ParamByName('TELCON').AsString := cdsMovGer.FieldByName('GER_TELCON').AsString;
    ParamByName('R_GCON').AsString := cdsMovGer.FieldByName('GER_R_GCON').AsString;
    ParamByName('CGCCPF').AsString := cdsMovGer.FieldByName('GER_CGCCPF').AsString;
    ParamByName('CGCCON').AsString := cdsMovGer.FieldByName('GER_CGCCON').AsString;
    ParamByName('IESCON').AsString := cdsMovGer.FieldByName('GER_IESCON').AsString;
    ParamByName('NOMCON').AsString := cdsMovGer.FieldByName('GER_NOMCON').AsString;

    If (Not recDocume.blnRequisicao) Then
      ParamByName('CODFAZ').AsString := cdsMovGer.FieldByName('GER_CODFAZ').AsString
    Else
      ParamByName('CODFAZ').AsString := '';

    ParamByName('GER_NUMDOC').AsString := strNumDoc;
    ParamByName('GER_ESPDOC').AsString := strEspDoc;
    ParamByName('GER_CODEMP').AsString := strCodEmp;
  End;
End;

Function TLeDocumentoMIFF.fSQLCamsposExtrasCadCli: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  OPE_CODOPE  AS CREPCL,  ';
  strSQL := strSQL + '  OPE_NOMOPE  AS NREPCL,  ';

  Result := strSQL;
End;

Function TLeDocumentoMIFF.fSQLInnersExtrasCadCli: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  LEFT JOIN  FATGOR ON FGO_TIPFAT = :GER_ESPDOC AND FGO_NUMFAT = :GER_NUMDOC AND FGO_EMPFAT = :GER_CODEMP AND FGO_JAFATU = 1 ';

  strSQL := strSQL + '  LEFT JOIN  CADOPE ON OPE_CODOPE =                    ';
  strSQL := strSQL + '          IFNULL((SELECT FDO_CODREP FROM FATDOR        ';
  strSQL := strSQL + '                  WHERE FDO_SEQGER = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '                   LIMIT 1), CLI_CODREP)               ';
  Result := strSQL;
End;

Procedure TLeDocumentoMIFF.pSetaParametrosFr3Adicioanais(FReport: TfrxReport);
Begin
  With recDocume Do
  Begin
    If (Pos(strEspDoc, 'MI_FF_BR_TR_DV_AJ_') > 0) And fTemParametro(FReport, 'MSMIFF') Then
      FReport.Script.Variables['MSMIFF'] := fCfgSis('MSMIFF');
  End;
End;

Procedure TLeDocumentoMIFF.pSetaNumeroItens(intNroItens: Integer);
var
  fltTotCpr,
  fltTotSpr: Double;
Begin
  With cdsMovGer Do
  Begin
    If IsEmpty Then
      Exit;

    fltTotCpr := 0;
    fltTotSpr := 0;

    Edit;
    FieldByname('NROITE').AsInteger := intNroItens;
    FieldByName('LEGIPI').AsString  := FLegIPI;
    FieldByName('SETORG').AsString  := FSetores.CommaText.Replace('"', '');
    FieldByName('TOTDIG').AsFloat   := cdsMovDet.fRetSoma('TOTDIG');
    FieldByName('TOTMAI').AsFloat   := cdsMovDet.fRetSoma('TOTMAI');

    Try
      cdsMovDet.DisableControls;
      cdsMovDet.First;
      While not cdsMovDet.eof Do
      Begin
        If (cdsMovDet.FieldByName('PROMOC').AsString = 'S') Then
          fltTotCpr := fltTotCpr + cdsMovDet.FieldByName('VALITE').AsFloat
        Else
          fltTotSpr := fltTotSpr + cdsMovDet.FieldByName('VALITE').AsFloat;

        cdsMovDet.Next;
      End;
    Finally
      cdsMovDet.EnableControls;
    End;

    FieldByName('TOTCPR').AsFloat := fltTotCpr;
    FieldByName('TOTSPR').AsFloat := fltTotSpr;

    FieldByName('TOTCHP').AsFloat := cdsMovDet.fRetSoma('TOTCHP');

    FieldByName('TTQTEN').AsFloat := cdsMovDet.fRetSoma('TTQTEN');
    FieldByName('TTQTSD').AsFloat := cdsMovDet.fRetSoma('TTQTSD');
    FieldByName('TOTTAB').AsFloat := cdsMovDet.fRetSoma('TOTTAB');
    FieldByName('TOTMT3').AsFloat := cdsMovDet.fRetSoma('TOTMT3');

    FieldByName('MARBRU').AsFloat := fFormataFloat(fCalculaPrecoVenda(2,
                                                                      FieldByName('TOTCUS').AsFloat,
                                                                      FieldByName('TOTPRO').AsFloat - FieldByName('DESESP').AsFloat ,
                                                                      0, 0, 0, 0, 0, fMarMpkParaVenda(fCfgSis('MARMKP')),
                                                                      fCfgSis('PCMPRO'), fCfgSis('DECUNI'), 0, False, 0, 0, 0, False), 2);

    Post;
  End;
End;

function TLeDocumentoMIFF.fMarcarSeparacaoComoImpresso: Boolean;
begin
  Result := True;

  With recDocume Do
  Begin
    If blnDocSep Then
      Result := fMarcaSeparacaoComoImpresso(strNumDoc, strEspDoc, strCodEmp);
  End;
end;

Function TLeDocumentoMIFF.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
  Var
    strEmpFun: String;
    regClient: TRegClient;
    strCodFaz: String;

  function fMontaResumoUnidades: Boolean;
    var
      intContador: Integer;
      stlResumoUnidade: TStringList;
  Begin
    stlResumoUnidade := TStringList.Create;
    Try
      ExtractStrings(['@'], [], PChar(cdsMovGer.FieldByName('GRPUNI').AsString), stlResumoUnidade);

      if not cdsMovDet.IsEmpty then
      begin
        cdsMovDet.First;
        for intContador := 0 to Pred(stlResumoUnidade.Count) do
        begin
          cdsMovDet.Edit;
          cdsMovDet.FieldByName('RESUNI').AsString := stlResumoUnidade.Strings[intContador];
          cdsMovDet.Post;
          cdsMovDet.Next;

          if cdsMovDet.Eof then
            Break;
        end;
      end;

      Result := True;
    Finally
      FreeAndNil(stlResumoUnidade);
    End;
  End;

Begin
  Try
    Result := True;

    pSetaNomeTabela;

    SetLength(arrClients, 2);
    Result         := Result And fInsereClientMovGer(regClient);

    If Not Result Then
      Exit;

    arrClients[1]  := regClient;
    cdsMovGer      := arrClients[1].cdsDados;

    Result := Result And fInsereClientMovdet;
    cdsMovDet := arrClients[0].cdsDados;

    pMontaListaClassificacao;

    If recDocume.strTipFc = 'C' Then
    Begin

      If Not cdsMovDet.IsEmpty Then
      Begin
        recDocume.strEntFut := cdsMovDet.FieldByName('ENTFUT').AsString;
        recDocume.strGerRom := cdsMovGer.FieldByName('ENTFAT').AsString;
      End;

    End;

    If Not Result Then
      Exit;

    pSetaNumeroItens(cdsMovDet.RecordCount);

    pPedidosExpedidos(cdsMovGer, cdsMovDet);

    If Not recDocume.blnDocSep Then
      pInsereItensServico(cdsMovDet, cdsMovGer)
    Else
      pCalculaSaldoDisponivelItens(cdsMovDet);

    pInsereTotalServicoValorOriginal(cdsMovGer);

    if recDocume.blnDocSep then
      pInsereQtdeDevolvidasEntregaFutura(cdsMovGer, cdsMovDet);

    //A ordenacao deve definida antes de inserir as informacoes dos itens de Madeira
    pSetaOrdenacao;

    If (Pos(recDocume.strEspDoc, 'MI-FF-BR-IF-TE' + IIF((fCfgSis('VENMTL', VarString) = 'S') or (fCfgSis('VENMAD', VarString) = 'S'), '-NF', '')) > 0) And
       (recDocume.strTipFc = 'C') And (Not recDocume.blnRequisicao) Then
      pInsereItensMadeireira(cdsMovDet);

    pMontaDuplicatas(cdsMovGer, cdsMovDet);

    pMontaListaCadRec;

    if recDocume.blnDocSep then
      pMontaItensEstrutura;

    If not fEmptyStr(cdsMovGer.FieldByName('SEQCO1').AsString) Then
    Begin
      pMontaDuplicatasdeCredito(cdsMovGer);
      pMontaDuplicatasdeCreditoComProdutos(cdsMovGer);
    End;

    If (Not recDocume.blnRequisicao) Then
      pMontaDadosFinanceira(cdsMovGer);

    pSetaModalidadeDePgto(cdsMovGer);

    if (fCfgSis('DEVROM', VarString) = '6') and (recDocume.blnDocSep) then
      pSetaItensDevolvidos(cdsMovGer.FieldByName('NUMDOC').AsString, cdsMovGer.FieldByName('ESPDOC').AsString, cdsMovGer.FieldByName('CODEMP').AsString);

    With cdsMovGer Do
    If (recDocume.strTipFc = 'C') And fImprimirCabecalhoDocEmpresaPedidoCD(FieldByName('NUMFAT').AsString,
                                            FieldByName('TIPFAT').AsString,
                                            FieldByName('EMPFAT').AsString, strEmpFun) Then
      recDocume.strCodEmp := strEmpFun
    Else
    Begin
      If (Not recDocume.blnReimpr) Or fEmptyStr(recDocume.strCodEmp) Then
        recDocume.strCodEmp := VS_strCodEmp;
    End;

    If ( (fCfgSis('EMPFAT', varString) = 'S') And
         (fCfgSis('EMPDFF', varString) = 'S') And
         (cdsMovGer.FieldByName('ESPDOC').asString = 'FF') ) Then
      recDocume.strEmpDoctoVenda := fRetEmpresaCabecalho(cdsMovGer.FieldByName('CODEMP').asString)
    Else
      recDocume.strEmpDoctoVenda := '';

    Result := Result And fInsereClientEmpresa;

    If recDocume.strTipFc = 'C' Then
    Begin
      If (Not recDocume.blnRequisicao) Then
        strCodFaz := cdsMovGer.FieldByName('GER_CODFAZ').AsString
      Else
        strCodFaz := '';

      Result := Result And fInsereClientCliente;
      Result := Result And fInsereClientEnderecoEntrega(cdsMovGer.FieldByName('AUTGER').AsString,
                                                        cdsMovGer.FieldByName('TABELA').AsString,
                                                        strCodFaz);
    End Else
    Begin
      Result := Result And fInsereClientFornecedor;
    End;

    Result := Result And fPreparaImpressaoDocumentos;
    Result := Result And fMarcarSeparacaoComoImpresso;
    Result := Result And Not cdsMovDet.IsEmpty;
    Result := Result And fMontaResumoUnidades;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

function TLeDocumentoMIFF.fMontaDuplicatasdeCredito(cdsMovGer: TZClient; strNumDup, strCodEmp : String): String;
var strSQL: String;
    qryCND: TUniQuery;
begin
  cdsMovGer.edit;
  strSQL := strSQL + ' SELECT CTR_HIST01 AS HISDCR ';
  strSQL := strSQL + '      FROM CADREC ';
  strSQL := strSQL + '     WHERE CTR_NUMDUP = :NUMDUP ';
  strSQL := strSQL + '      AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '      AND CTR_CODCLI = :CODCLI ';

  Try
    qryCND := fCriaQuery;
    qryCND.Close;
    qryCND.SQL.Clear;
    qryCND.SQL.Add(strSQL);
    qryCND.ParamByName('NUMDUP').AsString := strNumDup ;
    qryCND.ParamByName('CODEMP').AsString := strCodEmp ;
    qryCND.ParamByName('CODCLI').AsString := recDocume.strCodCli ;
    qryCND.Open;

    Result := qryCND.FieldByName('HISDCR').AsString;
  Finally
    FreeAndNil(qryCND);
  End;
end;

function TLeDocumentoMIFF.fMontaProdutosDupCredito(strNumDoc, strEspDoc, strCodEmp, strIncDoc: String): String;
var
strSQL, strMontaVar: String;
qryCND: TUniQuery;
begin
  cdsMovGer.edit;
  strSQL := strSQL + ' SELECT DET_CODITE AS CODITE,                          ';
  strSQL := strSQL + '    RPAD(DET_DESCRI, 30, " ") AS DESITE,               ';
  strSQL := strSQL + '    LPAD(FORMAT(DET_QTDITE,2), 12, " ") AS QTDITE,     ';
  strSQL := strSQL + '    LPAD(FORMAT(DET_TOTITE,2), 9, " ") AS TOTITE,      ';
  If strIncDoc = '' Then
  Begin
    strSQL := strSQL + '    DET_DOCDEV AS DOCDEV,                              ';
    strSQL := strSQL + '    DET_ESPDEV AS ESPDEV                               ';
  End
  Else If strIncDoc <> '' Then
  Begin
    strSQL := strSQL + '    DET_NUMDOC AS DOCDEV,                              ';
    strSQL := strSQL + '    DET_ESPDOC AS ESPDEV                               ';
  End;

  strSQL := strSQL + '      FROM MOVDET                                      ';
  strSQL := strSQL + '    WHERE TRUE                                         ';

  If strIncDoc = '' Then
  Begin
    strSQL := strSQL + '      AND DET_NUMDOC = :NUMDOC                        ';
    strSQL := strSQL + '      AND DET_ESPDOC = :ESPDOC                        ';
    strSQL := strSQL + '      AND DET_CODEMP = :CODEMP                        ';
  End
  Else If strIncDoc <> '' Then
  Begin
    strSQL := strSQL + '      AND DET_SEQGER = :SEQGER                        ';
  End;

  Try
    qryCND := fCriaQuery;
    qryCND.Close;
    qryCND.SQL.Clear;
    qryCND.SQL.Add(strSQL);

    If strIncDoc = '' Then
    Begin
      qryCND.ParamByName('NUMDOC').AsString := strNumDoc ;
      qryCND.ParamByName('CODEMP').AsString := strCodEmp ;
      qryCND.ParamByName('ESPDOC').AsString := strEspdoc ;
    End
    Else If strIncDoc <> '' Then
    Begin
      qryCND.ParamByName('SEQGER').AsString := strIncDoc ;
    End;

    qryCND.Open;

    While not qryCND.eof do
    Begin
      strMontaVar := strMontaVar + qryCND.FieldByName('CODITE').AsString + '      ' + qryCND.FieldByName('DESITE').AsString + '   ' + qryCND.FieldByName('QTDITE').AsString +
                    ' ' + qryCND.FieldByName('TOTITE').AsString + ' ' + qryCND.FieldByName('DOCDEV').AsString + '-' + qryCND.FieldByName('ESPDEV').AsString + #13#10;
      qryCND.Next;
    End;

    Result := strMontaVar;
  Finally
    FreeAndNil(qryCND);
  End;
end;

function TLeDocumentoMIFF.fRetEhReimpressaoDeDocumentoCanceladoWMS: Boolean;
begin
  Result := False;

  If Not fUsaRotinaWMS Then
    Exit;

  If Not recDocume.blnReimpr Then
    Exit;

  If Not recDocume.blnDocCan Then
    Exit;

  If Not fTemDel_LotDor Then
    Exit;

  Result := True;
end;

function TLeDocumentoMIFF.fRetLotDor: String;
const
  TAB_LOTDOR     = 'LOTDOR';
  TAB_DEL_LOTDOR = 'DEL_LOTDOR';
begin
  Result := IIF(fRetEhReimpressaoDeDocumentoCanceladoWMS, TAB_DEL_LOTDOR, TAB_LOTDOR);
end;

Procedure TLeDocumentoMIFF.pSetaParametrosCadFor;
Begin
  inherited;

  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CIDCON').AsString := cdsMovGer.FieldByName('GER_CIDCON').AsString;
    ParamByName('ENDCON').AsString := cdsMovGer.FieldByName('GER_ENDCON').AsString;
    ParamByName('BAICON').AsString := cdsMovGer.FieldByName('GER_BAICON').AsString;
    ParamByName('CEPCON').AsString := cdsMovGer.FieldByName('GER_CEPCON').AsString;
    ParamByName('TELCON').AsString := cdsMovGer.FieldByName('GER_TELCON').AsString;

    ParamByName('R_GCON').AsString := cdsMovGer.FieldByName('GER_R_GCON').AsString;
    ParamByName('CGCCPF').AsString := cdsMovGer.FieldByName('GER_CGCCPF').AsString;
    ParamByName('CGCCON').AsString := cdsMovGer.FieldByName('GER_CGCCON').AsString;
    ParamByName('IESCON').AsString := cdsMovGer.FieldByName('GER_IESCON').AsString;
    ParamByName('NOMCON').AsString := cdsMovGer.FieldByName('GER_NOMCON').AsString;
  End;

End;

function TLeDocumentoMIFF.fRetEmpresaCabecalho(strCodEmp: String): String;
begin
  Result := '';
  cdsMovDet.DisableControls;
  try
    cdsMovDet.First;
    While Not cdsMovDet.Eof do
    Begin
      If (Not (strCodEmp = cdsMovDet.FieldByName('EMP_PD').asString)) And
         (Not fEmptyStr(cdsMovDet.FieldByName('EMP_PD').asString)) Then
      begin
        Result := cdsMovDet.FieldByName('EMP_PD').asString;
        Exit(Result);
      end;
      cdsMovDet.Next;
    End;
  finally
    cdsMovDet.First;
    cdsMovDet.EnableControls;
  end;
end;

Procedure TLeDocumentoMIFF.pSetaItensDevolvidos(strNumDoc, strEspDoc, strCodEmp: String);
var
  qryDocDev: TUniQuery;
Begin

  if cdsMovDet.IsEmpty Then
    Exit;

  cdsMovDet.DisableControls;

  Try
    qryDocDev := fCriaQuery;
    qryDocDev.Close;
    qryDocDev.SQL.Clear;
    qryDocDev.SQL.Add('SELECT                       ');
    qryDocDev.SQL.Add('  D.DET_CODITE AS CODITE,    ');
    qryDocDev.SQL.Add('  D.DET_QTDITE AS QTDITE     ');
    qryDocDev.SQL.Add('FROM                         ');
    qryDocDev.SQL.Add('  MOVDET D                   ');
    qryDocDev.SQL.Add('WHERE D.DET_DOCDEV = :NUMDOC ');
    qryDocDev.SQL.Add('  AND D.DET_ESPDEV = :ESPDOC ');
    qryDocDev.SQL.Add('  AND D.DET_EMPDEV = :CODEMP ');

    qryDocDev.ParamByName('NUMDOC').AsString := strNumDoc ;
    qryDocDev.ParamByName('CODEMP').AsString := strCodEmp ;
    qryDocDev.ParamByName('ESPDOC').AsString := strEspDoc ;

    qryDocDev.Open;

    cdsMovDet.First;
    while not cdsMovDet.eof Do
    begin
      if qryDocDev.Locate('CODITE', cdsMovDet.FieldByName('CODITE').AsString, []) Then
      begin
        if ( cdsMovDet.FieldByName('QTDITE').AsFloat = qryDocDev.FieldByName('QTDITE').AsFloat ) then
        begin
          cdsMovDet.Edit;
          cdsMovDet.FieldByName('DELETA_DEVOLUCAO').asString := 'S';
          cdsMovDet.Post;
        end
        else
        begin
          cdsMovDet.Edit;
          cdsMovDet.FieldByName('QTDITE').AsFloat := cdsMovDet.FieldByName('QTDITE').AsFloat - qryDocDev.FieldByName('QTDITE').AsFloat;
          cdsMovDet.Post;
        end
      end;
      cdsMovDet.Next;
    end;

  Finally
    cdsMovDet.EnableControls;
    FreeAndNil(qryDocDev);
  End;
end;

end.

