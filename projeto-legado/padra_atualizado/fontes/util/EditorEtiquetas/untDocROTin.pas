unit untDocROTin;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient;

Type

  TLeDocumentoROTin = Class(TLeDocumento)
  Private
    blnAjuste: Boolean;
    blnDesCon: Boolean;
    strImpAju: String;

    strTabTri: String;

    cdsMovGer,
    cdsMovDet: TZClient;

    FLegIPI: String;
    FClaIpi : TStringList;

    function fGetSqlQtdIteVenda: String;
    function fGetSqlGroupByVenda: String;
    function fSQLTabPre: String;
    function fDescontoCliente: Boolean;
    function fSQLPercentualDesconto: String;

    function fSQLMovGer: String;
    function fInsereClientMovGer(Var regClient: TRegClient): Boolean;
    function fInsereClientMovdet: Boolean;
    function fMarcarSeparacaoComoImpresso: Boolean;

    procedure pMontaDuplicatas(cdsMovGer, cdsMovDet: TZClient);
    procedure pSetaNomeTabela;
    procedure pSetaNumeroItens(intNroItens: Integer);
    procedure pPedidosExpedidos(cdsMovGer, cdsMovDet: TZClient);

    Function fExisteCampo(strCampo: String): String;
    procedure pCriaListaClassificacao;
    Procedure pMontaListaClassificacao;
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

constructor TLeDocumentoROTin.Create(Owner: TComponent);
begin
  Inherited Create(Owner);
  pCriaListaClassificacao;
end;

destructor TLeDocumentoROTin.Destroy;
begin
  Inherited;
  FreeAndNil(FClaIpi);
end;

function TLeDocumentoROTin.fDescontoCliente: Boolean;
Begin
  Result := fDescontoClienteProfissional(recDocume.strCodCli);
End;

  {************************************************************************}
  {* BUSCA TODOS OS PEDIDOS QUE FORAM EXPEDIDOS E GERARAM ESSE DOCUMENTO  *}
  {*********************************************************************MA*}

procedure TLeDocumentoROTin.pPedidosExpedidos(cdsMovGer, cdsMovDet: TZClient);
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
      pMensagensErro(E.Message, '[TLeDocumentoROTin.pPedidosExpedidos]');
    End;
  End;
End;

procedure TLeDocumentoROTin.pCriaListaClassificacao;
begin
  FClaIpi := TStringList.Create;
  FClaIpi.Sorted := True;
  FClaIpi.Duplicates := dupIgnore;

  FLegIPI := '';
end;

procedure TLeDocumentoROTin.pMontaDuplicatas(cdsMovGer, cdsMovDet: TZClient);

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
    arrDuplicata: TarrDuplicata;
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

            If (FieldByName('CONPAG').AsString = 'FF') And (fDescontoCliente) Then
              FieldByName('VPAR' + RightStr('0' + IntToStr(intContador+1), 2)).AsFloat := arrDuplicata[intContador].curValor;

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

procedure TLeDocumentoROTin.pMontaListaClassificacao;
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

Function TLeDocumentoROTin.fSQLPercentualDesconto: String;
  Var
    strSQL: String;
Begin
  blnDesCon := False;
  strSQL := ' GER_PORDES ';

  With recDocume Do
  If (strEspDoc = 'FF') And (fDescontoCliente) Then
  Begin
    If fCfgSis('PDVLBR') = '1' Then
      strSQL := ' GER_PORDES '
    Else If fCfgSis('PDVLBR') = '2' Then Begin
      strSQL := ' CLI_DESCON ';
      blnDesCon := True;
    End;
  End;

  Result := strSQL;
End;

Function TLeDocumentoROTin.fExisteCampo(strCampo: String): String;
Begin
  If recDocume.blnRequisicao Then
    Result := '""'
  Else
    Result := strCampo;
End;

Function TLeDocumentoROTin.fSQLMovGer: String;
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
    End;
  End;

  Function fSQLCamposAuxMov(strTabAux: String): String;
  Begin
    Result := '';
    Result := Result + ' AUX_CODFAZ AS GER_CODFAZ, ';

    If Pos('AUXNOT', strTabAux) > 0 Then
    Begin
      Result := Result + ' CONCAT(LEFT(AUX_PLAVEI,3),"-",RIGHT(AUX_PLAVEI,4)) AS PLAVEI, ';
      Result := Result + ' AUX_KM_VEI AS KM_VEI, ';
      Result := Result + ' " " AS ANOVEI, ';
      Result := Result + ' " " AS MARVEI, ';
      Result := Result + ' " " AS MODVEI, ';
      Result := Result + ' " " AS CORVEI, ';
      Result := Result + ' " " AS NUMGUI, ';
      Result := Result + ' " " AS TRARDP, ';
      Result := Result + ' " " AS RDPNOM, ';
      Result := Result + ' " " AS RDPEND, ';
      Result := Result + ' " " AS RDPIES, ';
      Result := Result + ' " " AS RDPCGC, ';
      Result := Result + ' " " AS RDPFON, ';
      Result := Result + ' " " AS RDPBAI, ';
      Result := Result + ' " " AS RDPCEP, ';
      Result := Result + ' " " AS RDPCID, ';
      Result := Result + ' " " AS RDPEST, ';
    End
    Else
    Begin
      Result := Result + ' CONCAT(LEFT(AUX_PLAVEI,3),"-",RIGHT(AUX_PLAVEI,4)) AS PLAVEI, ';
      Result := Result + ' AUX_KM_VEI AS KM_VEI,    ';
      Result := Result + ' VE.VEI_ANOVEI AS ANOVEI, ';
      Result := Result + ' MV.MAR_DESMAR AS MARVEI, ';
      Result := Result + ' MO.MOD_DESMOD AS MODVEI, ';
      Result := Result + ' CO.COR_DESCOR AS CORVEI, ';
      Result := Result + ' AUX_NUMGUI AS NUMGUI, ';
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
    End;
  End;

Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
  strSQL := strSQL + '  GER_SERIE_ AS SERDOC, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_HORENT AS HORENT, ';
  strSQL := strSQL + '  GER_DTAFAT AS DTAFAT, ';

  strSQL := strSQL + '     GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  OV.OPE_NOMOPE AS NOMVEN, ';

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
  strSQL := strSQL + '  "S"        AS AVISTA, ';
  strSQL := strSQL + '  GER_CODCND AS CODCND, ';
  strSQL := strSQL + '  CND_DESCRI AS DESCND, ';
  strSQL := strSQL + '  CND_PRZMED AS CNDPRZ, ';

  strSQL := strSQL + '  GER_CODFPG AS CODFPG, ';
  strSQL := strSQL + '  FPG_DESCRI AS DESFPG, ';

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
    strSQL := strSQL + ' "S" AS IMPDPN, '
  Else
    strSQL := strSQL + ' "N" AS IMPDPN, ';

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
  strSQL := strSQL + '  GER_NATOPE AS NATOPE, ';
  strSQL := strSQL + '  GER_PRAENT AS PRAENT, ';
  strSQL := strSQL + '  GER_TOTSER AS TOTSER, ';
  strSQL := strSQL + '  GER_VALISS AS VALISS, ';
  strSQL := strSQL + '  GER_PERISS AS PERISS, ';
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
    strSQL := strSQL + '  "N" AS ENTMAT, ';

  strSQL := strSQL + fExisteCampo('GER_NOTESP') + ' AS NOTESP, ';
  strSQL := strSQL + fExisteCampo('GER_TIP_FC') + ' AS TIP_FC, ';
  strSQL := strSQL + '  GER_ORIDOC AS ORIDOC, ';

  If (recDocume.strEspDoc = 'FF') And (fDescontoCliente) Then
    strSQL := strSQL + ' GER_VLRCON / ((100 - ' + fSQLPercentualDesconto + ') / 100) AS VLRCON, '
  Else
    strSQL := strSQL + ' GER_VLRCON AS VLRCON, ';

  strSQL := strSQL + fExisteCampo('GER_NROCEI') + ' AS NROCEI, ';

  strSQL := strSQL + fExisteCampo('GER_NUMFAT') + ' AS NUMFAT, '; // ?
  strSQL := strSQL + fExisteCampo('GER_TIPFAT') + ' AS TIPFAT, '; // ?
  strSQL := strSQL + fExisteCampo('GER_EMPFAT') + ' AS EMPFAT, '; // ?

  strSQL := strSQL + '  0.00    AS DEBCLI, '; // ? DEBITOS DO CLIENTE - ESTÁ SENDO PASSADO COMO PARAMETRO

  strSQL := strSQL + '  CAST("" AS CHAR(1000)) AS PEDEXP, '; // Pedidos expedidos que geraram a MI/FF

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

  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS SEQCON, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS SEQCOE, ';
  strSQL := strSQL + '  CAST("" AS CHAR(500)) AS DUPLIC, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS FORPAG, ';

  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS LEGIPI, ';

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

  strSQL := strSQL + '  CONCAT(IFNULL(CLI_NOMCTT, ""), ' +
    ' IF(IFNULL(CLI_TELCTT, "") = "", "", CONCAT("  TEL.: ", CONCAT("(", LEFT(CLI_TELCTT, 2), ")", SUBSTR(CLI_TELCTT, 3,5), "-", RIGHT(CLI_TELCTT, 4)))), ' +
    ' IF(IFNULL(CLI_CELCTT, "") = "", "", CONCAT("  CEL.: ", CONCAT("(", LEFT(CLI_CELCTT, 2), ")", SUBSTR(CLI_CELCTT, 3,5), "-", RIGHT(CLI_CELCTT, 4))))) AS CLICTT, ';

  strSQL := strSQL + '  TT.CLI_NOMCTT AS NOMCTT,                     ';
  strSQL := strSQL + '  TT.CLI_NUMCPF AS CPFCTT,                     ';
  strSQL := strSQL + '  TT.CLI_NUMR_G AS RG_CTT,                     ';

  strSQL := strSQL + '  0000000.00 AS DUPREC, ';  //?
  strSQL := strSQL + '  G.AUTOINCREM AS AUTGER, ';
  strSQL := strSQL +  QuotedStr(strTabGer) + ' AS TABELA, ';

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + '  FGO_NUMDOC AS NROPED, ';                        // NUMERO DO PEDID0 - DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...
    strSQL := strSQL + '  FGO_ESPDOC AS ESPPED, ';                        // ESPECIE DO PEDIDO DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...
    strSQL := strSQL + '  CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC) AS NUMPED, '; // DOCUMENTO DE ORIGEM FATURAMENTO (PD/OR)...

    strSQL := strSQL + '  EG.FGO_CODROT AS CODROT, ';
    strSQL := strSQL + '     FGO_DTENTR AS DTENTR, ';
    strSQL := strSQL + '  RG.REG_CODREG AS CODREG, ';
    strSQL := strSQL + '  RG.REG_DESREG AS DESREG, ';
    strSQL := strSQL + '  ER.ENT_DTAENT AS ENTREG, ';
  End;

  strSQL := strSQL + fExisteCampo('IF(LOCATE(GER_CLAFIS, ' + CLAFIS_ENTFUT_VEN + ') > 0, "S", "N")') + ' AS BAIFUT, ';

  strSQL := strSQL + '  "N" AS DOCCAN, ';
  strSQL := strSQL + '  CAST("" AS CHAR(300)) AS MOTDEL, ';
  strSQL := strSQL + '  CAST(NULL AS DATE)    AS DTADEL, ';
  strSQL := strSQL + '  CAST("" AS CHAR(3))   AS OPEDEL, ';

  If (Not recDocume.blnRequisicao) Then
    strSQL := strSQL + ' CAMPOS_AUXMOV, ';

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
  strSQL := strSQL + ' "0" AS MIPROC, ';
  strSQL := strSQL + ' (SELECT COUNT(DISTINCT D2.DET_CODITE)';
  strSQL := strSQL + '     FROM ' + strTabDet + ' D2 ';
  strSQL := strSQL + '    WHERE D2.DET_NUMDOC = G.GER_NUMDOC ';
  strSQL := strSQL + '      AND D2.DET_ESPDOC = G.GER_ESPDOC ';
  strSQL := strSQL + '      AND D2.DET_CODEMP = G.GER_CODEMP) AS TOTENV , ';

  If (Not recDocume.blnRequisicao) Then
    strSQL := strSQL + ' (SELECT GROUP_CONCAT(DISTINCT DV.DET_DOCDEV, "-", DV.DET_ESPDEV, "-", DV.DET_EMPDEV SEPARATOR " / " ) FROM ' + strTabDet + ' DV WHERE DV.DET_SEQGER = G.AUTOINCREM) AS DOCDEV, ';

  strSQL := strSQL + ' ( ' +  ReplaceStr(fSqlTotalDebitosClientes('GER_CODCLI', FormatDateTime('dd/mm/yyy', 0), FormatDateTime('dd/mm/yyy', VS_Date), True ), QuotedStr('GER_CODCLI'), ':CODCLI')  + ') AS TOTDEB, ';

  strSQL := strSQL + ' (SELECT GROUP_CONCAT(DISTINCT CONCAT(IFNULL(DET_NUMCMP,"")," ", IFNULL(DET_NITCMP,"")) SEPARATOR " ") ';
  strSQL := strSQL + '  FROM ' + strTabDet + ' D ';
  strSQL := strSQL + '  LEFT JOIN ' + strTabTri + ' T ON T.DET_SEQGER =  D.AUTOINCREM ';
  strSQL := strSQL + '  WHERE D.DET_SEQGER = G.AUTOINCREM ) AS NUMCMP, ';
  strSQL := strSQL + '  G.GER_NROBOX AS NROBOX, ';

  strSQL := strSQL + '  (' + fSQLVarQtdParPedOri(True, 'G.GER_NUMDOC', 'G.GER_ESPDOC', 'G.GER_CODEMP', 'G.GER_CODCLI') + ') AS PCPDOR ';

  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + strTabGer + ' G ';

  strSQL := strSQL + '  LEFT JOIN CADTRA ON GER_CODTRA = CADTRA.TRA_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADCND ON GER_CODCND = CND_CODIGO ';
  strSQL := strSQL + '  LEFT JOIN CADFPG ON FPG_CODIGO = GER_CODFPG ';
  strSQL := strSQL + '  LEFT JOIN SERMOV SV ON SV.GER_SEQGER = G.AUTOINCREM ';

  If (recDocume.strTipFc = 'C') Or (blnDesCon) Then
    strSQL := strSQL + '  INNER JOIN CADCLI  ON CLI_CODCLI = GER_CODCLI ';

  If recDocume.strTipFc = 'C' Then
  Begin
    strSQL := strSQL + '  LEFT JOIN FATGOR     ON FGO_TIPFAT     = GER_ESPDOC AND FGO_NUMFAT = GER_NUMDOC AND FGO_EMPFAT = GER_CODEMP AND FGO_JAFATU = 1 ';
    strSQL := strSQL + '  LEFT JOIN EXTGOR EG  ON EG.FGO_SEQFGO  = FATGOR.AUTOINCREM  ';
    strSQL := strSQL + '  LEFT JOIN ENTREG ER  ON EG.FGO_CODROT  = ER.ENT_CODIGO ';
    strSQL := strSQL + '  LEFT JOIN CADREG RG  ON RG.REG_CODREG  = ER.ENT_CODREG ';
  End;

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

  strSQL := strSQL + 'WHERE ';

  If recDocume.strTipFc = 'C' Then
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND '
  Else
    strSQL := strSQL + '  GER_CODFOR = :CODCLI AND ';

  If SameText(recDocume.strEspDoc, 'ML') Then
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
    strSQL := AnsiReplaceStr(strSQL, '"N" AS DOCCAN','   "S" AS DOCCAN');
    strSQL := AnsiReplaceStr(strSQL, 'CAST("" AS CHAR(300)) AS MOTDEL','MOTDEL AS MOTDEL');
    strSQL := AnsiReplaceStr(strSQL, '"" AS OPEDEL','OPEDEL AS OPEDEL');
    strSQL := AnsiReplaceStr(strSQL, 'CAST(NULL AS DATE) AS DTADEL','DTADEL AS DTADEL');
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
                                       AnsiReplaceStr(strSQL,'GER_NROCEI', '" "'),
                                                             'GER_SEPEXP', '" "'),
                                                             'JOIN_AUXMOV', fSQLJoinAuxMov('AUXNOT')),
                                                             'CAMPOS_AUXMOV,', fSQLCamposAuxMov('AUXNOT')),
                                                             'MOVGER', 'NOTGER'),
                                                             'AUXMOV', 'AUXNOT'),
                                                             '"0" AS MIPROC', '"1" AS MIPROC'),
                                                             'AUX_PRZMED', '0'),
                                                             'GER_MENEXP', '" "'),
                                                             'GER_MENEX2', '" "'),
                                                             'GER_MENEX3', '" "'),
                                                             'GER_OBS_TA', '" "'),
                                                             'GER_MENEX4', '" "');

    strSQL := AnsiReplaceStr(strSQL, 'JOIN_AUXMOV', fSQLJoinAuxMov('AUXMOV'));
    strSQL := AnsiReplaceStr(strSQL, 'CAMPOS_AUXMOV,', fSQLCamposAuxMov('AUXMOV'));
  End;

  Result := strSQL;
End;

function TLeDocumentoROTin.fGetSqlQtdIteVenda: String;
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
      If (blnDocSep) And (fCfgSis('IMSEPE', varBoolean)) Then
        Result := Result + ' (DET_QTDITE - DET_QTDEXP) '
      Else
        Result := Result + '   DET_QTDITE ';
    End;

    If blnAgruparItensSeparacao Then
      Result := Result + ' ) ';
  End;
end;

function TLeDocumentoROTin.fGetSqlGroupByVenda: String;
begin
  Result := '';

  With recDocume Do
  If blnAgruparItensSeparacao Then
  Begin
    Result := Result + ' GROUP BY ';
    Result := Result + '   DET_CODITE, DET_DESCRI, DET_IDEPRO, DET_NUMLOT ';
  End;

end;

Function TLeDocumentoROTin.fSQLTabPre: String;
Begin
  Result := '';
  With recDocume Do
  If (fCfgSis('TABITE', varBoolean)) And (fCfgSis('IPTPFT', varBoolean)) And (Pos(strEspDoc, fCfgSis('ESPITP')) > 0) Then
    Result := 'IF(DET_PROMOC = "S", "PR", DET_TABPRE), "-", ';
End;

Function TLeDocumentoROTin.fSQLItems: String;
  Var
    strSQL,
    strSQLMec,
    strCampoSetor: String;
Begin
  With recDocume Do
  Begin
    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      strCampoSetor := 'IF(IFNULL(DET_NUMLOT, "") = "", LS2.LSE_DESCRI, LS1.LSE_DESCRI) '
    else
    If (fCfgSis('GRUSEP', VarString) = 'S') then
      strCampoSetor := 'LSE_DESCRI'
    Else
      strCampoSetor := 'LEFT(ITE_LOCFIS, 1)';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
    strSQL := strSQL + '    (@ROW := @ROW + 1) AS SEQDET, ';
    strSQL := strSQL + '    D.AUTOINCREM AS AUTDET, ';
    strSQL := strSQL + '    DET_CODITE AS CODITE, ';

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
      strSQL := strSQL + '   IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS LOCFIS, ';
      strSQL := strSQL + '   IF(IFNULL(DET_NUMLOT, "") = "", L2.LOC_DESCRI, L1.LOC_DESCRI) AS DESFIS, ';
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
      strSQL := strSQL + '   (DET_UNITAR * DET_QTDITE) AS VALENT, ';
      strSQL := strSQL + '   0.00 AS VALSAI, ';
      strSQL := strSQL + '   "ENT" AS ENTSAI, ';
    End
    Else
    Begin
      If (strEspDoc = 'FF') And (fDescontoCliente) Then
      Begin
        strSQL := strSQL + '   DET_UNITAR / ((100 - ' +  fSQLPercentualDesconto + ') / 100) AS VALUNI, ';
        strSQL := strSQL + '   DET_UNIORI / ((100 - ' +  fSQLPercentualDesconto + ') / 100) AS UNIORI, ';
        strSQL := strSQL + '   DET_TOTITE AS VALITE, ';

        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_TOTITE, 0) AS VALENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_TOTITE) AS VALSAI, ';
      End

      Else If ((Pos(strEspDoc, 'AJ') > 0) Or blnAjuste) And (Not fEmptyStr(strImpAju)) Then
      Begin
        strSQL := strSQL + '   DET_' + strImpAju + ' / ' + fGetSqlQtdIteVenda + ' AS VALUNI, ';
        strSQL := strSQL + '   DET_' + strImpAju + ' / ' + fGetSqlQtdIteVenda + ' AS UNIORI, ';
        strSQL := strSQL + '   ROUND(DET_' + strImpAju + ', 2) AS VALITE, ';

        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_' + strImpAju + ', 0) AS VALENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_' + strImpAju + ') AS VALSAI, ';
      End

      Else
      Begin
        strSQL := strSQL + '   DET_UNITAR AS VALUNI, ';
        strSQL := strSQL + '   DET_UNIORI AS UNIORI, ';

        If (blnDocSep) And (fCfgSis('IMSEPE', varBoolean)) Then
          strSQL := strSQL + ' ROUND(DET_UNITAR * ' + fGetSqlQtdIteVenda + ', 2) AS VALITE, '
        Else
          strSQL := strSQL + '   DET_TOTITE AS VALITE, ';

        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, DET_TOTITE, 0) AS VALENT, ';
        strSQL := strSQL + '   IF(LEFT(DET_CLAFIS,1)<5, 0, DET_TOTITE) AS VALSAI, ';
      End;

      strSQL := strSQL + '    IF(LEFT(DET_CLAFIS,1)<5,"ENT","SAI")    AS ENTSAI, ';
    End;

    strSQL := strSQL + '    DET_DESCON AS DESCON, ';
    strSQL := strSQL +  fGetSqlQtdIteVenda + ' AS QTDITE, ';

    If (blnDocSep) And (fCfgSis('IMSEPE', varBoolean)) Then
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

    strSQL := strSQL + '    UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '    UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '    UNI_DESUNI AS DESUNI, ';

    strSQL := strSQL + '    UNI_DESUNI AS DESUNI, ';
    strSQL := strSQL + fExisteCampo('DET_BASIPI') + ' AS IBASIP, ';
    strSQL := strSQL + fExisteCampo('DET_ALQIPI') + ' AS IALQIP, ';
    strSQL := strSQL + fExisteCampo('DET_VALIPI') + ' AS VALIPI, ';
    strSQL := strSQL + fExisteCampo('DET_BASRET') + ' AS IBASRE, ';
    strSQL := strSQL + fExisteCampo('DET_ALQRET') + ' AS IALQRE, ';
    strSQL := strSQL + fExisteCampo('DET_VALRET') + ' AS VALRET, ';
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
    strSQL := strSQL + '    DET_DESCRI AS DESCRI, ';
    strSQL := strSQL + '  I.ITE_CODONU AS CODONU, ';
    strSQL := strSQL + '    ONU_DESCRI AS DESONU, ';
    strSQL := strSQL + '    ONU_CODIGO AS CADONU, ';
    strSQL := strSQL + '    ONU_CLARIS AS CLAONU, ';
    strSQL := strSQL + '    ONU_GRUEMB AS EMBONU, ';

    strSQL := strSQL + '    IF(ITE_MLTVEN > 1, DET_QTDITE / ITE_MLTVEN, 0) AS QTDEMB, ';

    If blnDocSep And (Not fEmptyStr(Trim(strSetor))) Then
      strSQL := strSQL + '  ' + strCampoSetor + ' AS SETOR_, ';

    strSQL := strSQL + '  G.ITE_LOCSUP AS LOCSUP, ';
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
    End;

    strSQL := strSQL + fSQLBarDoc('DET') + ' AS BARDOC, ';

    strSQL := strSQL + ' IF(IFNULL(GRU_TIPGRU, "9") = "0", "OUTROS", IF(IFNULL(GRU_TIPGRU, "9") = "1", "PEÇAS", IF(IFNULL(GRU_TIPGRU, "9"), "PNEUS", ""))) AS TIPGRU, ';

    If blnDocSep Then
    Begin
      strSQL := strSQL + ' G.ITE_SALDOS AS SALDOS, ';
      strSQL := strSQL + ' ITE_CNV_ML,      ';
      strSQL := strSQL + ' ITE_SAL_ML,      ';
      strSQL := strSQL + ' 0.000 AS SALDIS, ';
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
      strSQL := strSQL + ' "" AS MECSER, ';

    strSQL := strSQL + ' DET_QTDEXP AS QTDEXP, ';
    strSQL := strSQL + ' DET_TURENT AS TURENT, ';

    strSQL := strSQL + ' "" AS MECPED, ';
    strSQL := strSQL + ' "" AS OBMESR, ';
    strSQL := strSQL + ' "" AS OBMEPD, ';

    strSQL := strSQL + ' CONCAT(IFNULL(DET_NUMCMP,"")," ", IFNULL(DET_NITCMP,"")) AS NUMCMI, ';
    strSQL := strSQL + ' I.ITE_CLAIPI AS CLAIPI, ';
    strSQL := strSQL + ' LOT_NUMLOT AS CODAMZ, ';
    strSQL := strSQL + ' LOT_LOCFIS AS LCFSAZ, ';
    strSQL := strSQL + ' DATE_FORMAT(IFNULL(LOT_DTAFAB, ""), "%d/%m/%Y") AS DTAFAB, ';
    strSQL := strSQL + ' DATE_FORMAT(IFNULL(LOT_DTAVAL, ""), "%d/%m/%Y") AS DTAVAL, ';
    strSQL := strSQL + ' LOT_CAPACI AS CAPACI, ';
    strSQL := strSQL + ' LOT_PONREP AS PONREP, ';

    strSQL := strSQL + ' IF( IFNULL(T.TRI_NCMTIN,"") = "", I.ITE_CLAIPI, T.TRI_NCMTIN) AS CODNCM, ';

    strSQL := strSQL + '  CAST("" AS CHAR(100)) AS LEGEND, ';

    strSQL := strSQL + ' IF(DET_UNIDIG > DET_UNIORI, (DET_UNIDIG * DET_QTDITE), (DET_UNIORI * DET_QTDITE))  AS MAIVAL, ';

    strSQL := strSQL + ' IFNULL(FATDOR.FDO_EMPPRD, FATDOR.FDO_CODEMP) AS EMPPRD,     ';

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

    strSQL := strSQL + ' FROM         ';
    strSQL := strSQL +     strTabDet + ' D ';

    strSQL := strSQL + ' INNER JOIN ' +  strTabGer + ' MG ON MG.AUTOINCREM = D.DET_SEQGER ';

    If Not fEmptyStr(strTabTri) Then
      strSQL := strSQL + ' LEFT JOIN ' + strTabTri + ' T ON T.DET_SEQGER =  D.AUTOINCREM ';

    If (Not fEmptyStr(strSQLMec)) Then
      strSQL := strSQL + ' LEFT JOIN ( ' + strSQLMec + ' ) AS NM ON D.AUTOINCREM = NM.SEQDET';

    strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ';

    strSQL := strSQL + ' LEFT JOIN CADGRU ON GRU_CODGRU = I.ITE_CODGRU ';

    strSQL := strSQL + ' LEFT JOIN FATDOR ON FDO_NUMDOC = DET_NUMFAT AND FDO_CODEMP = DET_EMPFAT ';
    strSQL := strSQL + '   AND FDO_CODVEN = DET_CODVEN AND FDO_CODITE = DET_CODITE  ';

    strSQL := strSQL + ' LEFT JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI  ';

    strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR  ';

    strSQL := strSQL + ' LEFT JOIN CADOPE V1 ON V1.OPE_CODOPE = DET_CODVEN ';
    strSQL := strSQL + ' LEFT JOIN CADOPE V2 ON V2.OPE_CODOPE = DET_CODVE2 ';
    strSQL := strSQL + ' LEFT JOIN CADDIV DI ON DI.DIV_CODDIV = DET_CODDIV ';
    strSQL := strSQL + ' LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = DET_CODREP ';

    strSQL := strSQL + ' LEFT JOIN BRIDET ON BRI_SEQDET = D.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADPAR ON PAR_CODPAR = BRI_CODPAR   ';

    If recDocume.blnSepFut Then
      strSQL := strSQL + ' INNER JOIN ' + AnsiReplaceStr(strTabDet, 'MOVDET', 'SEPFUT') + ' ON SEP_SEQGER = D.AUTOINCREM  ';

    strSQL := strSQL + ' LEFT JOIN ITEGER G ON ';
    strSQL := strSQL + '     G.ITE_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '     G.ITE_CODEMP =   DET_CODEMP     ';

    strSQL := strSQL + ' LEFT JOIN CADDEP ON DEP_CODIGO = I.ITE_CODDEP ';

    If (blnDesCon) Then
      strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';

    // MADEIREIRA
    If (recDocume.strTipFc = 'C') And (Not recDocume.blnRequisicao) Then
      strSQL := strSQL + ' LEFT JOIN ' + AnsiReplaceStr(strTabDet, 'DET', 'MAD') + ' M ON M.DET_SEQGER = D.AUTOINCREM  ';

    strSQL := strSQL + ' LEFT JOIN CADLOT ON DET_NUMLOT = LOT_NUMLOT AND ';
    strSQL := strSQL + '                     DET_CODITE = LOT_CODITE AND ';
    strSQL := strSQL + '                     DET_CODEMP = LOT_CODEMP     ';

    strSQL := strSQL + ' LEFT JOIN CADLOC L1 ON L1.LOC_CODLOC = CADLOT.LOT_LOCFIS AND L1.LOC_CODEMP = CADLOT.LOT_CODEMP  ';
    strSQL := strSQL + ' LEFT JOIN CADLOC L2 ON L2.LOC_CODLOC = G.ITE_LOCFIS AND L2.LOC_CODEMP = G.ITE_CODEMP  ';

    if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
    begin
      strSQL := strSQL + ' LEFT JOIN CADLSE LS1 ON LS1.LSE_CODIGO = L1.LOC_CODLSE ';
      strSQL := strSQL + ' LEFT JOIN CADLSE LS2 ON LS2.LSE_CODIGO = L2.LOC_CODLSE ';
    end
    else
      strSQL := strSQL + ' LEFT JOIN CADLSE LS ON LS.LSE_CODIGO = G.ITE_CODLSE  ';
    strSQL := strSQL + ' LEFT JOIN CADONU ON I.ITE_CODONU = CADONU.ONU_CODONU ';

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

      If SameText(strEspDoc, 'ML') Then
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

      If (blnDocSep) And (fCfgSis('IMSEPE', varBoolean)) Then
        strSQL := strSQL + ' ((ROUND(D.DET_QTDITE,4) - ROUND(IFNULL(T.DET_QTDEXP,0),4)) > 0) AND ';

      strSQL := strSQL + '   DET_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' AND ';
      strSQL := strSQL + '   DET_ESPDOC <> "TM" AND ';
      strSQL := strSQL + '   DET_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';

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
                                           AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'),
                                                                  'MOVTRI', 'NOTTRI'),
                                                                  'MOVDET', 'NOTDET');
      End;

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  DESITE';
    End;

    Result := strSQL;
  End;
End;

Function TLeDocumentoROTin.fInsereClientMovGer(Var regClient: TRegClient): Boolean;
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

Function TLeDocumentoROTin.fInsereClientMovdet: Boolean;
Begin
  With arrClients[0], recDocume Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLItems);
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

    pCriaSoma('', 'TOTUNI', 'SUM(VALUNI * QTDITE)');
    pCriaSoma('', 'TOTORI', 'SUM(UNIORI * QTDITE)');
    pCriaSoma('', 'TOTQTD', 'SUM(QTDITE)');

    pCriaSoma('', 'TOTENT', 'SUM(VALENT)');
    pCriaSoma('', 'TOTSAI', 'SUM(VALSAI)');
    pCriaSoma('', 'TOTDIG', 'SUM(UNIDIG * QTDITE)');

    pCriaSoma('', 'TOTITE', 'SUM(VALITE)');

    pCriaSoma('', 'TOTDES', 'SUM(DESCON)');
    pCriaSoma('', 'TOTMAI', 'SUM(MAIVAL)');

    Result := fAbreClient(True, 'fInsereClientMovdet');
  End;

End;

Procedure TLeDocumentoROTin.pSetaNomeTabela;
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

  With recDocume Do
  Begin
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
  End;
End;

Procedure TLeDocumentoROTin.pSetaParametrosCadcli;
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

Function TLeDocumentoROTin.fSQLCamsposExtrasCadCli: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + '  OPE_CODOPE  AS CREPCL,  ';
  strSQL := strSQL + '  OPE_NOMOPE  AS NREPCL,  ';

  Result := strSQL;
End;

Function TLeDocumentoROTin.fSQLInnersExtrasCadCli: String;
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

Procedure TLeDocumentoROTin.pSetaParametrosFr3Adicioanais(FReport: TfrxReport);
Begin
  With recDocume Do
  Begin
    If (Pos(strEspDoc, 'MI_FF_BR_TR_DV_AJ_') > 0) And fTemParametro(FReport, 'MSROTin') Then
      FReport.Script.Variables['MSROTin'] := fCfgSis('MSROTin');
  End;
End;

Procedure TLeDocumentoROTin.pSetaNumeroItens(intNroItens: Integer);
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
    Post;
  End;
End;

function TLeDocumentoROTin.fMarcarSeparacaoComoImpresso: Boolean;
begin
  Result := True;

  With recDocume Do
  Begin
    If blnDocSep Then
      Result := fMarcaSeparacaoComoImpresso(strNumDoc, strEspDoc, strCodEmp);
  End;
end;

Function TLeDocumentoROTin.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
  Var
    strEmpFun: String;
    regClient: TRegClient;
    strCodFaz: String;
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

    //A ordenacao deve definida antes de inserir as informacoes dos itens de Madeira
    pSetaOrdenacao;

    If (Pos(recDocume.strEspDoc, 'MI-FF-BR' + IIF(fCfgSis('VENMTL', VarBoolean), '-NF', '')) > 0) And
       (recDocume.strTipFc = 'C') And (Not recDocume.blnRequisicao) Then
      pInsereItensMadeireira(cdsMovDet);

    pMontaDuplicatas(cdsMovGer, cdsMovDet);

    If (Not recDocume.blnRequisicao) Then
      pMontaDadosFinanceira(cdsMovGer);

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

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

Procedure TLeDocumentoROTin.pSetaParametrosCadFor;
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

end.

