unit untEnderecoEntrega;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Data.DB,
  SysUtils,
  Classes,
  Uni,
  MaskUtils,
  System.Variants,
  System.StrUtils,
  untTypesSistema;

Type
  TEnderecoEntrega = Class(TComponent)
  Private

    FEndSav: TrecEnderecoEntrega;
    FAutSav: String;
    FSalEnd: Boolean;

    FLerEnd: Boolean; // PARA NAO FICAR REPETINDO A LEITURA NO BANCO SEM NECESSIDADE

    procedure pValidaEnderecoEntrega(Var recEndere: TrecEnderecoEntrega);

  Public

    recEndere: TrecEnderecoEntrega;

    Constructor Create(Owner: TComponent); reintroduce;

    {$IFNDEF LINUX}
    Function fSelecionaEnderecoEntrega(strClient: String = '';
                                       blnFormataCep: Boolean = False;
                                       blnNomeCidade: Boolean = False;
                                       strEspDoc: String = ''): Boolean;

    Function fAlteraEnderecoEntrega(blnExibeTelaComUmEndereco: Boolean;
                                    strClient: String = '';
                                    blnSomenteSelecao: Boolean = False;
                                    blnFormataCep: Boolean = False;
                                    blnNomeCidade: Boolean = False;
                                    blnAviso: Boolean = False;
                                    blnAlteraSelecionado: Boolean = True;
                                    strEspDoc: String = ''): Boolean;
   {$ENDIF}

    procedure pRetEnderecoEntregaOrcamento(strAutInc, strClient: String);

    procedure pRetEnderecoEntrega(const strAutInc, strClient: String);

    Function fCarregaEndereco(strTabMov: String; blnTodCam: Boolean = False): String;

    Function fCarregaEnderecoEntrega(strTabMov: String; blnEndFat:Boolean=False): String;

    Function fCarregaEnderecoConsumidor(strClient, strAutInc, strTabMov: String): String;

    Function fLeEnderecoEntrega(strClient, strAutEnt: String;
                                blnFormataCep: Boolean = False;
                                blnNomeCidade: Boolean = False): Boolean;

    Function fRetEnderecoEntrega(strCodCli, strAutInc: String): String;

    Function fRestauraEnderecoEntrega(strAutEnt: String): String;

    Procedure pSalvaEnderecoEntrega(strAutEnt: String);

  End;
  Const
      SQL_INSERT_ENTCLI = 'INSERT INTO ENTCLI (' +
                                       'ETC_CODCLI, ' +
                                       'ETC_SEQIND, ' +
                                       'ETC_CIDENT, ' +
                                       'ETC_ENDENT, ' +
                                       'ETC_BAIENT, ' +
                                       'ETC_CEPENT, ' +
                                       'ETC_TELENT, ' +
                                       'ETC_CONENT, ' +
                                       'ETC_REFENT, ' +
                                       'ETC_CODTRA, ' +
                                       'AUTOINCREM, ' +
                                       'ETC_ENDFAT, ' +
                                       'ETC_COBISS, ' +
                                       'ETC_CODART, ' +
                                       'ETC_CODOBR, ' +
                                       'ETC_CODCNO, ' +
                                       'ETC_INSIMO, ' +
                                       'ETC_CODCIB, ' +
                                       'ETC_SEQVIS, ' +
                                       'ETC_CODREG, ' +
                                       'ETC_SITUAC, ' +
                                       'ETC_TRARED  ' +
                                     ') VALUES (' +
                                       ':CODCLI, ' +
                                       ':SEQIND, ' +
                                       ':CIDENT, ' +
                                       ':ENDENT, ' +
                                       ':BAIENT, ' +
                                       ':CEPENT, ' +
                                       ':TELENT, ' +
                                       ':CONENT, ' +
                                       ':REFENT, ' +
                                       ':CODTRA, ' +
                                       ':INCREM, ' +
                                       ':ENDFAT, ' +
                                       ':COBISS, ' +
                                       ':CODART, ' +
                                       ':CODOBR, ' +
                                       ':CODCNO, ' +
                                       ':INSIMO, ' +
                                       ':CODCIB, ' +
                                       ':SEQVIS, ' +
                                       ':CODREG, ' +
                                       ':SITUAC, ' +
                                       ':TRARED) ';
    SQL_UPDATE_ENTCLI = 'UPDATE ENTCLI SET ' +
                                       'ETC_CODCLI = :CODCLI, ' +
                                       'ETC_CIDENT = :CIDENT, ' +
                                       'ETC_ENDENT = :ENDENT, ' +
                                       'ETC_BAIENT = :BAIENT, ' +
                                       'ETC_CEPENT = :CEPENT, ' +
                                       'ETC_TELENT = :TELENT, ' +
                                       'ETC_CONENT = :CONENT, ' +
                                       'ETC_REFENT = :REFENT, ' +
                                       'ETC_CODTRA = :CODTRA, ' +
                                       'ETC_COBISS = :COBISS, ' +
                                       'ETC_CODART = :CODART, ' +
                                       'ETC_CODOBR = :CODOBR, ' +
                                       'ETC_CODCNO = :CODCNO, ' +
                                       'ETC_INSIMO = :INSIMO, ' +
                                       'ETC_CODCIB = :CODCIB, ' +
                                       'ETC_CODREG = :CODREG, ' +
                                       'ETC_TRARED = :TRARED  ' +
                      'WHERE AUTOINCREM = :AUTOINC';

  Function fIncluirEnderecoEntrega(recEndere: TRecEnderecoEntrega; strEndFat: String = 'N'; blnCliNovoOuMesmoUF: Boolean = false): String;

  Function fAtualizarEnderecoEntrega(recEndere: TRecEnderecoEntrega; strAutoinc: String): Boolean;

  Function fEnderecoJaExiste(recEndere: TRecEnderecoEntrega): Boolean;

  Function fRetEndereco(recEndere: TRecEnderecoEntrega): String;

  Function fRetEnderecoPadraoFat(strCodCli: String): String;

  Function fClientePossuiEnderecoEntrega(strCodCli: String; blnPesqEndFat: Boolean = False): Boolean;
  Function fAtualizarSequenciaEnderecoEntrega(strCodCli, strAutinc: String): Boolean;

  Function fRetornaCidadeUFFatDor(strAutIncFD: String):String;

implementation

{$IFNDEF LINUX}
uses
  untCadCliEndEntrega;
{$ENDIF}

Constructor TEnderecoEntrega.Create(Owner: TComponent);
Begin
  inherited Create(Owner);
  FLerEnd := True;
  FSalEnd := False;
End;

Procedure TEnderecoEntrega.pRetEnderecoEntregaOrcamento(strAutInc, strClient: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Self);
  With qryGen, SQL, recEndere Do
  Begin
    blnAltera := True;

    Clear;
    Add('SELECT        ');
    Add('  AUTOINCREM, ');
    Add('  ETC_ENDENT, ');
    Add('  ETC_BAIENT, ');
    Add('  ETC_CEPENT, ');
    Add('  ETC_CIDENT, ');
    Add('  ETC_REFENT, ');
    Add('  ETC_CODCLI, ');
    Add('  ETC_TELENT, ');
    Add('  ETC_CODTRA, ');
    Add('  ETC_COBISS, ');    
    Add('  ETC_CODOBR, ');
    Add('  ETC_CONENT, ');
    Add('  ETC_CODART, ');
    Add('  ETC_CODCNO, ');
    Add('  ETC_INSIMO, ');
    Add('  ETC_CODCIB, ');
    Add('  ETC_TRARED  ');
    Add('FROM          ');
    Add('  ENTCLI E    ');
    Add('INNER JOIN AUXGOR ON AUX_SEQGER = :AUTINC AND  ');
    Add('                     AUX_ENTGER = E.AUTOINCREM ');
    Add('WHERE ');
    Add('  ETC_CODCLI = :CODCLI ');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODCLI').AsString := strClient;

    strCliAnt := strClient;
    strCodCli := strClient;

    Open;

    If IsEmpty Then
    Begin
      strIncrem := '';
      strEndEnt := '';
      strBaiEnt := '';
      strCepEnt := '';
      strCidEnt := '';
      strCodCid := '';
      strNomCid := '';
      strEstEnt := '';
      strCoIbge := '';
      strTelEnt := '';
      strRefEnt := '';
      strCodTra := '';
      strCobIss := '';
      strCodObr := '';
      strCodART := '';
      strCodCno := '';
      strInsImo := '';
      strCodCib := '';
      strConEnt := '';
      strTraRed := '';
    End
    Else
    Begin
      strIncrem := FieldByName('AUTOINCREM').AsString;
      strEndEnt := FieldByName('ETC_ENDENT').AsString;
      strBaiEnt := FieldByName('ETC_BAIENT').AsString;
      strCepEnt := FieldByName('ETC_CEPENT').AsString;
      strCidEnt := FieldByName('ETC_CIDENT').AsString;
      strCodCid := FieldByName('ETC_CIDENT').AsString;
      strNomCid := fRetNomCidade(FieldByName('ETC_CIDENT').AsString);
      strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 1);
      strCoIbge := fRetornaCodIBGE(FieldByName('ETC_CIDENT').AsString);
      strTelEnt := FieldByName('ETC_TELENT').AsString;
      strRefEnt := FieldByName('ETC_REFENT').AsString;
      strCodTra := FieldByName('ETC_CODTRA').AsString;
      strCobIss := FieldByName('ETC_COBISS').AsString;      
      strCodObr := FieldByName('ETC_CODOBR').AsString;
      strCodArt := FieldByName('ETC_CODART').AsString;
      strCodCno := FieldByName('ETC_CODCNO').AsString;
      strInsImo := FieldByName('ETC_INSIMO').AsString;
      strCodCib := FieldByName('ETC_CODCIB').AsString;
      strConEnt := FieldByName('ETC_CONENT').AsString;

      if fCfgSis('UTTRDP', varBoolean) then
        strTraRed := FieldByName('ETC_TRARED').AsString;
    End;

    Close;
  End;
  FreeAndNil(qryGen);
End;

procedure TEnderecoEntrega.pRetEnderecoEntrega(const strAutInc, strClient: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Self);
  With qryGen, SQL, recEndere Do
  Begin
    blnAltera := True;

    Clear;
    Add('SELECT        ');
    Add('  AUTOINCREM, ');
    Add('  ETC_ENDENT, ');
    Add('  ETC_BAIENT, ');
    Add('  ETC_CEPENT, ');
    Add('  ETC_CIDENT, ');
    Add('  ETC_REFENT, ');
    Add('  ETC_CODCLI, ');
    Add('  ETC_TELENT, ');
    Add('  ETC_CODTRA, ');
    Add('  ETC_COBISS, ');
    Add('  ETC_CODOBR, ');
    Add('  ETC_CODART, ');
    Add('  ETC_CODCNO, ');
    Add('  ETC_INSIMO, ');
    Add('  ETC_CODCIB, ');
    Add('  ETC_TIPFRE, ');
    Add('  ETC_CONENT, ');
    Add('  ETC_TRARED  ');
    Add('FROM          ');
    Add('  ENTCLI      ');
    Add('WHERE         ');
    Add('  ETC_CODCLI = :CODCLI AND ');
    Add('  AUTOINCREM = :AUTINC     ');

    ParamByName('AUTINC').AsString := strAutInc;
    ParamByName('CODCLI').AsString := strClient;

    strCliAnt := strClient;
    strCodCli := strClient;

    Open;

    If IsEmpty Then
    Begin
      strIncrem := '';
      strEndEnt := '';
      strBaiEnt := '';
      strCepEnt := '';
      strCidEnt := '';
      strCodCid := '';
      strNomCid := '';
      strEstEnt := '';
      strCoIbge := '';
      strTelEnt := '';
      strRefEnt := '';
      strCodTra := '';
      strCobIss := '';
      strCodObr := '';
      strCodART := '';
      strCodCno := '';
      strInsImo := '';
      strCodCib := '';
      strConEnt := '';
      strTipFre := '';
      strTraRed := '';
    End
    Else
    Begin
      strIncrem := FieldByName('AUTOINCREM').AsString;
      strEndEnt := FieldByName('ETC_ENDENT').AsString;
      strBaiEnt := FieldByName('ETC_BAIENT').AsString;
      strCepEnt := FieldByName('ETC_CEPENT').AsString;
      strCidEnt := FieldByName('ETC_CIDENT').AsString;
      strCodCid := FieldByName('ETC_CIDENT').AsString;
      strNomCid := fRetNomCidade(FieldByName('ETC_CIDENT').AsString);
      strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 1);
      strCoIbge := fRetornaCodIBGE(FieldByName('ETC_CIDENT').AsString);
      strTelEnt := FieldByName('ETC_TELENT').AsString;
      strRefEnt := FieldByName('ETC_REFENT').AsString;
      strCodTra := FieldByName('ETC_CODTRA').AsString;
      strCobIss := FieldByName('ETC_COBISS').AsString;
      strCodObr := FieldByName('ETC_CODOBR').AsString;
      strCodArt := FieldByName('ETC_CODART').AsString;
      strCodCno := FieldByName('ETC_CODCNO').AsString;
      strInsImo := FieldByName('ETC_INSIMO').AsString;
      strCodCib := FieldByName('ETC_CODCIB').AsString;
      strConEnt := FieldByName('ETC_CONENT').AsString;
      strTipFre := FieldByName('ETC_TIPFRE').AsString;

      if fCfgSis('UTTRDP', varBoolean) then
        strTraRed := FieldByName('ETC_TRARED').AsString;
    End;

    Close;
  End;
  FreeAndNil(qryGen);
end;

{$IFNDEF LINUX}
Function TEnderecoEntrega.fSelecionaEnderecoEntrega(strClient: String = '';
                                                    blnFormataCep: Boolean = False;
                                                    blnNomeCidade: Boolean = False;
                                                    strEspDoc: String = ''): Boolean;
  Var
    qryEndEnt: TUniQuery;
    intNumRec: Integer;
Begin
  Result := True;

  recEndere.blnAltera := False;
  pValidaEnderecoEntrega(recEndere);

  If fEmptyStr(recEndere.strIncrem) Then
  Begin
    qryEndEnt := fCriaQuery(Self);
    With qryEndEnt, SQL, recEndere Do
    Begin
      Clear;
      Add('SELECT        ');
      Add('  AUTOINCREM, ');
      Add('  ETC_ENDENT, ');
      Add('  ETC_BAIENT, ');
      Add('  ETC_CEPENT, ');
      Add('  ETC_REFENT, ');
      Add('  ETC_CIDENT, ');
      Add('  ETC_TELENT, ');
      Add('  ETC_CODTRA, ');
      Add('  ETC_COBISS, ');      
      Add('  ETC_CODOBR, ');
      Add('  ETC_CONENT, ');
      Add('  ETC_CODART, ');
      Add('  ETC_CODCNO, ');
      Add('  ETC_INSIMO, ');
      Add('  ETC_CODCIB, ');
      Add('  ETC_TRARED  ');
      Add('FROM          ');
      Add('  ENTCLI      ');
      Add('WHERE (ETC_SITUAC = "A") AND (ETC_CODCLI = :CODCLI) LIMIT 2');
      ParamByName('CODCLI').AsString := recEndere.strCodCli;
      Open;

      First;

      If IsEmpty Then
      Begin
        FLerEnd := False;
        
        recEndere.blnAltera := True;
        recEndere.strIncrem := '';
        recEndere.strEndEnt := '';
        recEndere.strBaiEnt := '';
        recEndere.strCepEnt := '';
        recEndere.strCidEnt := '';
        recEndere.strCodCid := '';
        recEndere.strNomCid := '';
        recEndere.strEstEnt := '';
        recEndere.strCoIbge := '';
        recEndere.strTelEnt := '';
        recEndere.strRefEnt := '';
        recEndere.strCodTra := '';
        recEndere.strCobIss := '';
        recEndere.strCodObr := '';
        recEndere.strCodART := '';
        recEndere.strCodCno := '';
        recEndere.strInsImo := '';
        recEndere.strCodCib := '';
        recEndere.strConEnt := '';
        recEndere.strTraRed := '';
      End
      Else
      Begin

        intNumRec := RecordCount;

        If intNumRec = 1 Then
        Begin
          blnAltera := True;
          strIncrem := FieldByName('AUTOINCREM').AsString;
          strEndEnt := FieldByName('ETC_ENDENT').AsString;
          strBaiEnt := FieldByName('ETC_BAIENT').AsString;
          strCepEnt := FieldByName('ETC_CEPENT').AsString;
          strCodCid := FieldByName('ETC_CIDENT').AsString;
          strCidEnt := FieldByName('ETC_CIDENT').AsString;
          strRefEnt := FieldByName('ETC_REFENT').AsString;
          strNomCid := fRetNomCidade(FieldByName('ETC_CIDENT').AsString);
          strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 1);
          strCoIbge := fRetornaCodIBGE(FieldByName('ETC_CIDENT').AsString);
          strTelEnt := FieldByName('ETC_TELENT').AsString;
          if (fEmptyStr(FieldByName('ETC_CODTRA').AsString)) then
            strCodTra := fCfgSis('TRASUG')
          else
            strCodTra := FieldByName('ETC_CODTRA').AsString;
          strCobIss := FieldByName('ETC_COBISS').AsString;
          strCodObr := FieldByName('ETC_CODOBR').AsString;
          strCodArt := FieldByName('ETC_CODART').AsString;
          strCodCno := FieldByName('ETC_CODCNO').AsString;
          strInsImo := FieldByName('ETC_INSIMO').AsString;
          strCodCib := FieldByName('ETC_CODCIB').AsString;
          strConEnt := FieldByName('ETC_CONENT').AsString;

          if fCfgSis('UTTRDP', varBoolean) then
            strTraRed := FieldByName('ETC_TRARED').AsString;

          If blnNomeCidade Then
            strCidEnt := fRetNomCidade(strCodCid);

          If blnFormataCep Then
            strCepEnt := FormatMaskText('99999-999;0;_', fTiraCaracEspeciais(strCepEnt));

          FLerEnd := False;
        End

        Else If intNumRec > 1 Then
        Begin
          FLerEnd := True;
          Result := fAlteraEnderecoEntrega(False, strClient, True, blnFormataCep, blnNomeCidade, False, True, strEspDoc);
        End;

      End;

      Close;
      FreeAndNil(qryEndEnt);
    End;
  End;
End;
{$ENDIF}

procedure TEnderecoEntrega.pValidaEnderecoEntrega(Var recEndere: TrecEnderecoEntrega);
Begin
  With recEndere Do
  Begin
    If strCliAnt <> strCodCli Then
    Begin
      strIncrem := '';
      blnAltera := True;
    End;

    strCliAnt := strCodCli;
  End;
end;

{$IFNDEF LINUX}
Function TEnderecoEntrega.fAlteraEnderecoEntrega(blnExibeTelaComUmEndereco: Boolean;
                                                 strClient                : String = '';
                                                 blnSomenteSelecao        : Boolean = False;
                                                 blnFormataCep            : Boolean = False;
                                                 blnNomeCidade            : Boolean = False;
                                                 blnAviso                 : Boolean = False;
                                                 blnAlteraSelecionado     : Boolean = True;
                                                 strEspDoc                : String = ''): Boolean;
  Var
    intQtdEndEnt: Integer;
    frmCadCliEndEntrega: TfrmCadCliEndEntrega;

  function fGetQtdEnderecoEntrega(strCodCli: String): Integer;
    Var
      qryEndEntTmp: TUniQuery;
  Begin
    qryEndEntTmp := fCriaQuery(Self);

    With qryEndEntTmp Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT            ');
      SQL.Add('  COUNT(*) AS QTD ');
      SQL.Add('FROM              ');
      SQL.Add('  ENTCLI          ');
      SQL.Add('WHERE (ETC_SITUAC = "A") AND ETC_CODCLI = :CODCLI ');
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('QTD').AsInteger
      Else
        Result := 0;
    End;

    FreeAndNil(qryEndEntTmp);
  End;
Begin
  Result := True;

  Try
    If Not fEmptyStr(strClient) Then
      intQtdEndEnt := fGetQtdEnderecoEntrega(strClient)
    Else
      intQtdEndEnt := fGetQtdEnderecoEntrega(recEndere.strCodCli);

    If (intQtdEndEnt = 1) And (Not blnExibeTelaComUmEndereco) Then
      Exit;

    If Not fEmptyStr(strClient) Then
      recEndere.strCodCli := strClient;

    recEndere.blnAltera := False;
    pValidaEnderecoEntrega(recEndere);

    pCriarFormularios(TfrmCadCliEndEntrega, frmCadCliEndEntrega);
    frmCadCliEndEntrega.blnAlteraSelecionado := blnAlteraSelecionado;
    frmCadCliEndEntrega.blnSomenteSelecao    := blnSomenteSelecao;
    frmCadCliEndEntrega.blnAviso             := blnAviso;
    frmCadCliEndEntrega.strEspDoc            := strEspDoc;
    frmCadCliEndEntrega.blnOcultaInativos    := True;

    With frmCadCliEndEntrega Do
    Begin
      strPermiCadCid := 'frmCadCidades';
      blnVendas := True;
      recEndEnt.strIncrem := recEndere.strIncrem;
      recEndEnt.strCodCli := recEndere.strCodCli;

      ShowModal;

      If blnConfirma Then
      Begin
        With recEndEnt Do
        Begin
          recEndere.blnAltera := True;
          recEndere.strIncrem := strIncrem;
          recEndere.strEndEnt := strEndEnt;
          recEndere.strBaiEnt := strBaiEnt;
          recEndere.strCepEnt := strCepEnt;
          recEndere.strCidEnt := strCidEnt;
          recEndere.strRefEnt := strRefEnt;
          recEndere.strCodCid := strCodCid;
          recEndere.strNomCid := strNomCid;
          recEndere.strEstEnt := strEstEnt;
          recEndere.strCoIbge := strCoIbge;
          recEndere.strTelEnt := strTelEnt;
          if (fEmptyStr(strCodTra)) then
            recEndere.strCodTra := fCfgSis('TRASUG')
          else
            recEndere.strCodTra := strCodTra;
          recEndere.strCobIss := strCobIss;
          recEndere.strCodObr := strCodObr;
          recEndere.strCodArt := strCodArt;
          recEndere.strCodCno := strCodCno;
          recEndere.strInsImo := strInsImo;
          recEndere.strCodCib := strCodCib;
          recEndere.strConEnt := strConEnt;
          recEndere.strTipFre := strTipFre;
          recEndere.strCodReg := strCodReg;

          if fCfgSis('UTTRDP', varBoolean) then
            recEndere.strTraRed := strTraRed;

          If blnNomeCidade Then
            recEndere.strCidEnt := fRetNomCidade(recEndere.strCodCid);

          If blnFormataCep Then
            recEndere.strCepEnt := FormatMaskText('99999-999;0;_', fTiraCaracEspeciais(recEndere.strCepEnt));

        End;
      End

      Else Result := False;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAlteraEnderecoEntrega]');
    End;
  End;

  FreeAndNil(frmCadCliEndEntrega);
End;
{$ENDIF}

function fAtualizarEnderecoEntrega(recEndere: TRecEnderecoEntrega; strAutoinc: String): Boolean;
  Var
    qryEndEnt: TUniQuery;
begin
  Result := False;

  Try
    qryEndEnt := fCriaQuery(nil);

    Try
      If (fEmptyStr(recEndere.strCodCli)) Or (fEmptyStr(recEndere.strEndEnt)) Or
         (fEmptyStr(recEndere.strBaiEnt)) Or (fEmptyStr(recEndere.strCepEnt)) Or
         (fEmptyStr(recEndere.strCidEnt)) Or (fEmptyStr(strAutoinc)) Then Begin
        Result := True;
      End Else Begin
        qryEndEnt.Close();
        qryEndEnt.SQL.Clear();
        qryEndEnt.SQL.Add(SQL_UPDATE_ENTCLI);

        qryEndEnt.ParamByName('AUTOINC').AsString := strAutoinc;
   
        qryEndEnt.ParamByName('CODCLI').AsString := recEndere.strCodCli;

        If (fEmptyStr(recEndere.strCodArt)) Then
          qryEndEnt.ParamByName('CODART').Value    := Null
        Else
          qryEndEnt.ParamByName('CODART').AsString := recEndere.strCodArt;

        If (fEmptyStr(recEndere.strCodObr)) Then
          qryEndEnt.ParamByName('CODOBR').Value    := Null
        Else
          qryEndEnt.ParamByName('CODOBR').AsString := recEndere.strCodObr;

        If (fEmptyStr(recEndere.strCodCno)) Then
          qryEndEnt.ParamByName('CODCNO').Value    := Null
        Else
          qryEndEnt.ParamByName('CODCNO').AsString := recEndere.strCodCno;

        If (fEmptyStr(recEndere.strInsImo)) Then
          qryEndEnt.ParamByName('INSIMO').Value    := Null
        Else
          qryEndEnt.ParamByName('INSIMO').AsString := recEndere.strInsImo;

        If (fEmptyStr(recEndere.strCodCib)) Then
          qryEndEnt.ParamByName('CODCIB').Value    := Null
        Else
          qryEndEnt.ParamByName('CODCIB').AsString := recEndere.strCodCib;

        If (fEmptyStr(recEndere.strCodReg)) Then
          qryEndEnt.ParamByName('CODREG').Value    := Null
        Else
          qryEndEnt.ParamByName('CODREG').AsString := recEndere.strCodReg;

        If (fEmptyStr(recEndere.strCodTra)) Then
          qryEndEnt.ParamByName('CODTRA').Value    := Null
        Else
          qryEndEnt.ParamByName('CODTRA').AsString := recEndere.strCodTra;

        qryEndEnt.ParamByName('CIDENT').AsString := recEndere.strCidEnt;
        qryEndEnt.ParamByName('ENDENT').AsString := recEndere.strEndEnt;
        qryEndEnt.ParamByName('BAIENT').AsString := recEndere.strBaiEnt;
        qryEndEnt.ParamByName('CEPENT').AsString := recEndere.strCepEnt;
        qryEndEnt.ParamByName('TELENT').AsString := recEndere.strTelEnt;
        qryEndEnt.ParamByName('CONENT').AsString := recEndere.strConEnt;
        qryEndEnt.ParamByName('REFENT').AsString := recEndere.strRefEnt;
        qryEndEnt.ParamByName('COBISS').AsString := recEndere.strCobIss;

        if fCfgSis('UTTRDP', varBoolean) then
        begin
          if (fEmptyStr(recEndere.strTraRed)) then
            qryEndEnt.ParamByName('TRARED').Value := Null
          else
            qryEndEnt.ParamByName('TRARED').AsString := recEndere.strTraRed;
        end
        else
          qryEndEnt.ParamByName('TRARED').Value := Null;

        qryEndEnt.ExecSQL();

        Result := True;
      End;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, '[TEnderecoEntrega.fAtualizarEnderecoEntrega]');
      End;
    End;
  Finally
    FreeAndNil(qryEndEnt);
  End;
end;

Function TEnderecoEntrega.fCarregaEndereco(strTabMov: String; blnTodCam: Boolean = False): String;
Begin
  {**********************************************************************************************}
  {* RTA - RECURSO TÉCNICO ALTERNATIVO PARA A FUNCÃO fCarregaEndereco                           *}
  {* PRECISEI PUXAR/MOVER O RETORNO DESTA FUNÇÃO PARA untFuncoesSimples POIS PRECISAVA USAR ELA *}
  {* EM TELA COMPARTILHADA COM OUTROS PROJETOS, EX: AutcomTinta.                                *}
  {* ESSA UNIT ESTÁ FAZENDO REFERÊNCIA A CADASTRO DO Autcom NA FUNÇÃO fAlteraEnderecoEntrega >  *}
  {* frmCadCliEndEntrega INVIABILIZANDO ADICIONAR untEnderecoEntrega NO AutcomTinta PARA USO DO *}
  {* OBJETO, POIS TERIA QUE ADICIONAR TODAS AS DEPENDENCIAS DE frmCadCliEndEntrega              *}
  {*******************************************************************************************VA*}
  Result := fRetSQLEnderecoEntregaCli(strTabMov, blnTodCam);
End;

function TEnderecoEntrega.fCarregaEnderecoConsumidor(strClient, strAutInc, strTabMov: String): String;
Begin
  {**********************************************************************************************}
  {* RTA - RECURSO TÉCNICO ALTERNATIVO PARA A FUNCÃO fCarregaEnderecoConsumidor                 *}
  {* PRECISEI PUXAR/MOVER O RETORNO DESTA FUNÇÃO PARA untFuncoesSimples POIS PRECISAVA USAR ELA *}
  {* EM TELA COMPARTILHADA COM OUTROS PROJETOS, EX: AutcomTinta.                                *}
  {* ESSA UNIT ESTÁ FAZENDO REFERÊNCIA A CADASTRO DO Autcom NA FUNÇÃO fAlteraEnderecoEntrega >  *}
  {* frmCadCliEndEntrega INVIABILIZANDO ADICIONAR untEnderecoEntrega NO AutcomTinta PARA USO DO *}
  {* OBJETO, POIS TERIA QUE ADICIONAR TODAS AS DEPENDENCIAS DE frmCadCliEndEntrega              *}
  {*******************************************************************************************VA*}
  Result := fRetSQLEnderecoEntregaCliConsumidor(strClient, strAutInc, strTabMov);
end;

Function TEnderecoEntrega.fCarregaEnderecoEntrega(strTabMov: String; blnEndFat:Boolean=False): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strTabMov) Then
  Begin
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  E.AUTOINCREM,      ';
    strSQL := strSQL + '  ETC_ENDENT,        ';
    strSQL := strSQL + '  ETC_BAIENT,        ';
    strSQL := strSQL + '  ETC_CIDENT,        ';
    strSQL := strSQL + '  ETC_REFENT,        ';
    strSQL := strSQL + '  ETC_CEPENT,        ';
    strSQL := strSQL + '  ETC_TELENT,        ';
    strSQL := strSQL + '  ETC_CONENT,        ';
    strSQL := strSQL + '  ETC_CODTRA,        ';
    strSQL := strSQL + '  ETC_COBISS,        ';
    strSQL := strSQL + '  ETC_CODOBR,        ';
    strSQL := strSQL + '  ETC_CODART,        ';
    strSQL := strSQL + '  ETC_CODCNO,        ';
    strSQL := strSQL + '  ETC_INSIMO,        ';
    strSQL := strSQL + '  ETC_CODCIB,        ';
    strSQL := strSQL + '  ETC_TIPFRE,        ';
    strSQL := strSQL + '  ETC_TRARED,        ';
    strSQL := strSQL + '  -1 AS ETC_SEQIND   ';
    strSQL := strSQL + 'FROM                 ';
    strSQL := strSQL + '  ENTCLI E           ';
    strSQL := strSQL + 'INNER JOIN ' + fRetNomTabAuxMov(strTabMov) + ' ON ';
    strSQL := strSQL + '  AUX_ENTGER = E.AUTOINCREM AND ';
    strSQL := strSQL + '  AUX_SEQGER = :AUTINC          ';

    strSQL := strSQL + ' UNION ';
  End;

  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  E.AUTOINCREM,     ';
  strSQL := strSQL + '  ETC_ENDENT,       ';
  strSQL := strSQL + '  ETC_BAIENT,       ';
  strSQL := strSQL + '  ETC_CIDENT,       ';
  strSQL := strSQL + '  ETC_REFENT,       ';
  strSQL := strSQL + '  ETC_CEPENT,       ';
  strSQL := strSQL + '  ETC_TELENT,       ';
  strSQL := strSQL + '  ETC_CONENT,       ';
  strSQL := strSQL + '  ETC_CODTRA,       ';
  strSQL := strSQL + '  ETC_COBISS,       ';
  strSQL := strSQL + '  ETC_CODOBR,       ';
  strSQL := strSQL + '  ETC_CODART,       ';
  strSQL := strSQL + '  ETC_CODCNO,        ';
  strSQL := strSQL + '  ETC_INSIMO,        ';
  strSQL := strSQL + '  ETC_CODCIB,        ';
  strSQL := strSQL + '  ETC_TIPFRE,       ';
  strSQL := strSQL + '  ETC_TRARED,        ';
  strSQL := strSQL + '  ETC_SEQIND        ';
  strSQL := strSQL + 'FROM                ';
  strSQL := strSQL + '  ENTCLI E          ';
  strSQL := strSQL + 'WHERE               ';
  strSQL := strSQL + '  ETC_CODCLI = :CODCLI      ';

  If blnEndFat Then
    strSQL := strSQL + '  AND ETC_ENDFAT = "S" ';

  strSQL := strSQL + 'ORDER BY ETC_SEQIND  LIMIT 1 ';
  Result := strSQL;
End;

function fClientePossuiEnderecoEntrega(strCodCli: String; blnPesqEndFat: Boolean): Boolean;
  Var
    strTemp: String;
begin
  If (fEmptyStr(strCodCli)) Then Begin
    Result := True;
  End Else Begin
    If (blnPesqEndFat) Then
      strTemp := fCampoTabela('COUNT(AUTOINCREM)', 'ENTCLI', ['ETC_CODCLI', 'ETC_ENDFAT'], [strCodCli, 'S'])
    Else
      strTemp := fCampoTabela('COUNT(AUTOINCREM)', 'ENTCLI', ['ETC_CODCLI'], [strCodCli]);

    If (fEmptyStr(strTemp)) Then strTemp := '0';

    Result := (StrToInt(strTemp) > 0);
  End;
end;

function fEnderecoJaExiste(recEndere: TRecEnderecoEntrega): Boolean;
  Var
    qryEndEnt: TUniQuery;
begin
  Result := False;

  Try
    qryEndEnt := fCriaQuery(nil);

    Try
      If (Not ((fEmptyStr(recEndere.strCodCli)) Or (fEmptyStr(recEndere.strEndEnt)) Or
               (fEmptyStr(recEndere.strBaiEnt)) Or (fEmptyStr(recEndere.strCepEnt)) Or
               (fEmptyStr(recEndere.strCidEnt))
              )
         ) Then Begin
        qryEndEnt.Close();
        qryEndEnt.SQL.Clear();
        qryEndEnt.SQL.Add('SELECT COUNT(AUTOINCREM) AS ENDERECOS FROM ENTCLI');
        qryEndEnt.SQL.Add('WHERE ETC_CODCLI = :CODCLI');
        qryEndEnt.SQL.Add('  AND ETC_CIDENT = :CIDENT');
        qryEndEnt.SQL.Add('  AND ETC_ENDENT = :ENDENT');
        qryEndEnt.SQL.Add('  AND ETC_BAIENT = :BAIENT');
        qryEndEnt.SQL.Add('  AND ETC_CEPENT = :CEPENT');

        qryEndEnt.ParamByName('CODCLI').AsString := recEndere.strCodCli;
        qryEndEnt.ParamByName('CIDENT').AsString := recEndere.strCidEnt;
        qryEndEnt.ParamByName('ENDENT').AsString := recEndere.strEndEnt;
        qryEndEnt.ParamByName('BAIENT').AsString := recEndere.strBaiEnt;
        qryEndEnt.ParamByName('CEPENT').AsString := recEndere.strCepEnt;

        qryEndEnt.Open();

        Result := (qryEndEnt.FieldByName('ENDERECOS').AsInteger > 0);
      End;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, '[TEnderecoEntrega.fEnderecoJaExiste]');
      End;
    End;
  Finally
    FreeAndNil(qryEndEnt);
  End;
end;

function fIncluirEnderecoEntrega(recEndere: TRecEnderecoEntrega; strEndFat: String = 'N'; blnCliNovoOuMesmoUF: Boolean = false): String;
  Var
    strAutInc: String;
    qryEndEnt: TUniQuery;
begin
  Result := '';

  Try
    qryEndEnt := fCriaQuery(nil);

    Try
      If (fEmptyStr(recEndere.strCodCli)) Or (fEmptyStr(recEndere.strEndEnt)) Or
         (fEmptyStr(recEndere.strBaiEnt)) Or (fEmptyStr(recEndere.strCepEnt)) Or
         (fEmptyStr(recEndere.strCidEnt)) Then Begin
        Result := '';
      End Else If (fEnderecoJaExiste(recEndere)) Then Begin
        Result := '';
      End Else Begin
        qryEndEnt.Close();
        qryEndEnt.SQL.Clear();
        qryEndEnt.SQL.Add(SQL_INSERT_ENTCLI);

        strAutInc := fRetAutoIncrem('ENTCLI', VS_strCodEmp);

        qryEndEnt.ParamByName('INCREM').AsString  := strAutInc;
        qryEndEnt.ParamByName('SEQIND').AsInteger := fRetSeqIndEndereco(recEndere.strCodCli, 'ETC_SEQIND');
        qryEndEnt.ParamByName('SEQVIS').AsInteger := fRetSeqIndEndereco(recEndere.strCodCli, 'ETC_SEQVIS');

        qryEndEnt.ParamByName('CODCLI').AsString := recEndere.strCodCli;

        If (fEmptyStr(recEndere.strCodArt)) Then
          qryEndEnt.ParamByName('CODART').Value    := Null
        Else
          qryEndEnt.ParamByName('CODART').AsString := recEndere.strCodArt;

        If (fEmptyStr(recEndere.strCodObr)) Then
          qryEndEnt.ParamByName('CODOBR').Value    := Null
        Else
          qryEndEnt.ParamByName('CODOBR').AsString := recEndere.strCodObr;

        If (fEmptyStr(recEndere.strCodCno)) Then
          qryEndEnt.ParamByName('CODCNO').Value    := Null
        Else
          qryEndEnt.ParamByName('CODCNO').AsString := recEndere.strCodCno;

        If (fEmptyStr(recEndere.strInsImo)) Then
          qryEndEnt.ParamByName('INSIMO').Value    := Null
        Else
          qryEndEnt.ParamByName('INSIMO').AsString := recEndere.strInsImo;

        If (fEmptyStr(recEndere.strCodCib)) Then
          qryEndEnt.ParamByName('CODCIB').Value    := Null
        Else
          qryEndEnt.ParamByName('CODCIB').AsString := recEndere.strCodCib;

        If (fEmptyStr(recEndere.strCodReg)) Then
          qryEndEnt.ParamByName('CODREG').Value    := Null
        Else
          qryEndEnt.ParamByName('CODREG').AsString := recEndere.strCodReg;

        If (fEmptyStr(recEndere.strCodTra)) Then
          qryEndEnt.ParamByName('CODTRA').Value    := Null
        Else
          qryEndEnt.ParamByName('CODTRA').AsString := recEndere.strCodTra;

        qryEndEnt.ParamByName('CIDENT').AsString := recEndere.strCidEnt;
        qryEndEnt.ParamByName('ENDENT').AsString := recEndere.strEndEnt;
        qryEndEnt.ParamByName('BAIENT').AsString := recEndere.strBaiEnt;
        qryEndEnt.ParamByName('CEPENT').AsString := recEndere.strCepEnt;
        qryEndEnt.ParamByName('TELENT').AsString := recEndere.strTelEnt;
        qryEndEnt.ParamByName('CONENT').AsString := LeftStr(recEndere.strConEnt, 25);
        qryEndEnt.ParamByName('REFENT').AsString := recEndere.strRefEnt;
        qryEndEnt.ParamByName('ENDFAT').AsString := strEndFat;
        qryEndEnt.ParamByName('COBISS').AsString := recEndere.strCobIss;
        qryEndEnt.ParamByName('SITUAC').AsString := 'A';

        if fCfgSis('UTTRDP', varBoolean) then
        begin
          if (fEmptyStr(recEndere.strTraRed)) then
            qryEndEnt.ParamByName('TRARED').Value := Null
          else
            qryEndEnt.ParamByName('TRARED').AsString := recEndere.strTraRed;
        end
        else
          qryEndEnt.ParamByName('TRARED').Value := Null;

        qryEndEnt.ExecSQL();

        Result := strAutInc;

        if blnCliNovoOuMesmoUF then
          fAtualizarSequenciaEnderecoEntrega(recEndere.strCodCli, strAutInc);

      End;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, '[TEnderecoEntrega.fIncluirEnderecoEntrega]');
      End;
    End;
  Finally
    FreeAndNil(qryEndEnt);
  End;
end;

Function TEnderecoEntrega.fLeEnderecoEntrega(strClient, strAutEnt: String;
                                             blnFormataCep: Boolean = False;
                                             blnNomeCidade: Boolean = False): Boolean;
  Var
    qryEndEnt: TUniQuery;
Begin
  Result := False;

  qryEndEnt := fCriaQuery(Self);
  With qryEndEnt, SQL, recEndere Do
  Begin
    Clear;
    Add('SELECT        ');
    Add('  AUTOINCREM, ');
    Add('  ETC_ENDENT, ');
    Add('  ETC_BAIENT, ');
    Add('  ETC_CEPENT, ');
    Add('  ETC_REFENT, ');
    Add('  ETC_CIDENT, ');
    Add('  ETC_TELENT, ');
    Add('  ETC_CONENT, ');
    Add('  ETC_CODTRA, ');
    Add('  ETC_COBISS, ');
    Add('  ETC_CODOBR, ');
    Add('  ETC_TRARED, ');
    Add('  ETC_CODART, ');
    Add('  ETC_CODCNO, ');
    Add('  ETC_INSIMO, ');
    Add('  ETC_CODCIB  ');
    Add('FROM          ');
    Add('  ENTCLI      ');
    Add('WHERE ETC_CODCLI = :CODCLI AND');
    Add('      AUTOINCREM = :AUTENT    ');

    ParamByName('CODCLI').AsString := strClient;
    ParamByName('AUTENT').AsString := strAutEnt;

    Open;

    If Not IsEmpty Then
    Begin
      blnAltera := True;
      strIncrem := FieldByName('AUTOINCREM').AsString;
      strEndEnt := FieldByName('ETC_ENDENT').AsString;
      strBaiEnt := FieldByName('ETC_BAIENT').AsString;
      strCepEnt := FieldByName('ETC_CEPENT').AsString;
      strCodCid := FieldByName('ETC_CIDENT').AsString;      
      strCidEnt := FieldByName('ETC_CIDENT').AsString;
      strRefEnt := FieldByName('ETC_REFENT').AsString;
      strNomCid := fRetNomCidade(FieldByName('ETC_CIDENT').AsString);
      strEstEnt := fRetNomCidade(FieldByName('ETC_CIDENT').AsString, 1);
      strCoIbge := fRetornaCodIBGE(FieldByName('ETC_CIDENT').AsString);
      strTelEnt := FieldByName('ETC_TELENT').AsString;
      strCodTra := FieldByName('ETC_CODTRA').AsString;
      strCobIss := FieldByName('ETC_COBISS').AsString;
      strCodObr := FieldByName('ETC_CODOBR').AsString;
      strCodArt := FieldByName('ETC_CODART').AsString;
      strCodCno := FieldByName('ETC_CODCNO').AsString;
      strInsImo := FieldByName('ETC_INSIMO').AsString;
      strCodCib := FieldByName('ETC_CODCIB').AsString;
      strConCli := FieldByName('ETC_CONENT').AsString;

      if fCfgSis('UTTRDP', varBoolean) then
        strTraRed := FieldByName('ETC_TRARED').AsString;

      If blnNomeCidade Then
        strCidEnt := fRetNomCidade(strCodCid);

      If blnFormataCep Then
        strCepEnt := FormatMaskText('99999-999;0;_', fTiraCaracEspeciais(strCepEnt));

      FLerEnd := False;

      Result := True;
    End
  End;

End;

Function TEnderecoEntrega.fRetEnderecoEntrega(strCodCli, strAutInc: String): String;
  Var
    qryGenCli: TUniQuery;
Begin
  qryGenCli := fCriaQuery;
  With qryGenCli Do
  Begin
    If (Not fClienteConsumidor(strCodCli, True, True)) Then
      SQL.Text := fCarregaEndereco('FATGOR')
    Else
      SQL.Text := fCarregaEnderecoConsumidor(strCodCli, strAutInc, 'FATGOR');

    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('SEQGER').AsString := strAutInc;

    Open;

    Result := 'END.ENTREGA: ' + FieldByName('ETC_ENDENT').AsString + ' - ' +
               FieldByName('ETC_BAIENT').AsString + ' - ' +
               fRetNomCidade(FieldByName('ETC_CIDENT').AsString) + ' - ' +
               'CEP.: ' + fFormataCEP(FieldByName('ETC_CEPENT').AsString);
               
    If Not fEmptyStr(FieldByName('ETC_REFENT').AsString) Then
      Result := Result + ' - REFERENCIA: ' + FieldByName('ETC_REFENT').AsString;

    Result := Result + ' - CONTATO: '+ FieldByName('ETC_CONENT').AsString;
  End;
  FreeAndNil(qryGenCli);
End;

function fRetEndereco(recEndere: TRecEnderecoEntrega): String;
  Var
    qryEndEnt: TUniQuery;
begin
  Result := '';

  Try
    qryEndEnt := fCriaQuery(nil);

    Try
      If (Not ((fEmptyStr(recEndere.strCodCli)) Or (fEmptyStr(recEndere.strEndEnt)) Or
               (fEmptyStr(recEndere.strBaiEnt)) Or (fEmptyStr(recEndere.strCepEnt)) Or
               (fEmptyStr(recEndere.strCidEnt))
              )
         ) Then Begin
        qryEndEnt.Close();
        qryEndEnt.SQL.Clear();
        qryEndEnt.SQL.Add('SELECT AUTOINCREM FROM ENTCLI');
        qryEndEnt.SQL.Add('WHERE ETC_CODCLI = :CODCLI');
        qryEndEnt.SQL.Add('  AND ETC_CIDENT = :CIDENT');
        qryEndEnt.SQL.Add('  AND ETC_ENDENT = :ENDENT');
        qryEndEnt.SQL.Add('  AND ETC_BAIENT = :BAIENT');
        qryEndEnt.SQL.Add('  AND ETC_CEPENT = :CEPENT');

        qryEndEnt.ParamByName('CODCLI').AsString := recEndere.strCodCli;
        qryEndEnt.ParamByName('CIDENT').AsString := recEndere.strCidEnt;
        qryEndEnt.ParamByName('ENDENT').AsString := recEndere.strEndEnt;
        qryEndEnt.ParamByName('BAIENT').AsString := recEndere.strBaiEnt;
        qryEndEnt.ParamByName('CEPENT').AsString := recEndere.strCepEnt;

        qryEndEnt.Open();

        If (Not qryEndEnt.IsEmpty) Then
          Result := qryEndEnt.FieldByName('AUTOINCREM').AsString;
      End;
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, '[TEnderecoEntrega.fRetEndereco]');
      End;
    End;
  Finally
    FreeAndNil(qryEndEnt);
  End;
end;

Function fRetEnderecoPadraoFat(strCodCli: String): String;
begin
  Result := fCampoTabela('AUTOINCREM', 'ENTCLI', ['ETC_CODCLI', 'ETC_ENDFAT'], [strCodCli, 'S']);
end;

Function fAtualizarSequenciaEnderecoEntrega(strCodCli, strAutinc: String): Boolean;
Var
  qryEndEnt: TUniQuery;
  qryEndUpd: TUniQuery;
  intSeqInd: Integer;
begin
  Result := False;
  intSeqInd := 0;

  fStartTransaction;

  Try
    // Altera seguência para não causar erro de Unique Key
    Try
      qryEndUpd := fCriaQuery(nil);
      qryEndUpd.SQL.Add('UPDATE ENTCLI SET ETC_ENDFAT = "N", ETC_SEQIND = ETC_SEQIND + 100 ');
      qryEndUpd.SQL.Add('WHERE ETC_CODCLI = :CODCLI ');
      qryEndUpd.ParamByName('CODCLI').AsString := strCodCli;
      qryEndUpd.ExecSQL;

    Finally
      FreeAndNil(qryEndUpd);
    End;

    // Indica o endereço principal
    Try
      qryEndUpd := fCriaQuery(nil);
      qryEndUpd.SQL.Add('UPDATE ENTCLI SET ETC_ENDFAT = "S", ETC_SEQIND = 0 ');
      qryEndUpd.SQL.Add('WHERE ETC_CODCLI = :CODCLI ');
      qryEndUpd.SQL.Add('  AND AUTOINCREM = :AUTINC ');
      qryEndUpd.ParamByName('CODCLI').AsString := strCodCli;
      qryEndUpd.ParamByName('AUTINC').AsString := strAutinc;
      qryEndUpd.ExecSQL;

    Finally
      FreeAndNil(qryEndUpd);
    End;

    // Ordena a sequência dos endereços
    Try
      qryEndEnt := fCriaQuery(nil);
      qryEndEnt.SQL.Add('SELECT AUTOINCREM FROM ENTCLI');
      qryEndEnt.SQL.Add('WHERE ETC_CODCLI = :CODCLI ');
      qryEndEnt.SQL.Add('ORDER BY ETC_SEQIND ');
      qryEndEnt.ParamByName('CODCLI').AsString := strCodCli;
      qryEndEnt.Open;

      While not qryEndEnt.Eof Do
      Begin
        Try
          qryEndUpd := fCriaQuery(nil);
          qryEndUpd.SQL.Add('UPDATE ENTCLI SET ETC_SEQIND = :SEQIND, ETC_SEQVIS = :SEQVIS ');
          qryEndUpd.SQL.Add('WHERE ETC_CODCLI = :CODCLI ');
          qryEndUpd.SQL.Add('  AND AUTOINCREM = :AUTINC ');
          qryEndUpd.ParamByName('SEQIND').AsInteger := intSeqInd;
          qryEndUpd.ParamByName('SEQVIS').AsInteger := intSeqInd;
          qryEndUpd.ParamByName('CODCLI').AsString  := strCodCli;
          qryEndUpd.ParamByName('AUTINC').AsString  := qryEndEnt.FieldByName('AUTOINCREM').AsString;
          qryEndUpd.ExecSQL;

        Finally
          FreeAndNil(qryEndUpd);
        End;

        qryEndEnt.Next;
        Inc(intSeqInd);
      End;

    Finally
      FreeAndNil(qryEndEnt);
    End;

    fCommit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TEnderecoEntrega.fAtualizarSequenciaEnderecoEntrega]');
    End;
  End;
end;

Procedure TEnderecoEntrega.pSalvaEnderecoEntrega(strAutEnt: String);
Begin
  FEndSav := recEndere;
  FAutSav := strAutEnt;
  FSalEnd := True;
End;

Function TEnderecoEntrega.fRestauraEnderecoEntrega(strAutEnt: String): String;
Begin
  If FSalEnd Then
  Begin
    recEndere := FEndSav;
    Result    := FAutSav;
    FSalEnd   := False;
  End

  Else Result    := strAutEnt;
End;

Function fRetornaCidadeUFFatDor(strAutIncFD: String):String;
Var qryAux: TUniQuery;
Begin
  Result    := '';

  qryAux := fCriaQuery();

  Try
    qryAux.SQL.Add('  SELECT                                                                ');
    qryAux.SQL.Add('    CONCAT(CCGOR.CID_NOMCID,  "-", CCGOR.CID_ESTADO)  AS CIDGOR,        ');
    qryAux.SQL.Add('    CONCAT(CCMOV.CID_NOMCID,  "-", CCMOV.CID_ESTADO)  AS CIDMOV,        ');
    qryAux.SQL.Add('    CONCAT(CCCGOR.CID_NOMCID, "-", CCCGOR.CID_ESTADO) AS CIDCGOR,       ');
    qryAux.SQL.Add('    CONCAT(CCCMOV.CID_NOMCID, "-", CCCMOV.CID_ESTADO) AS CIDCMOV        ');
    qryAux.SQL.Add('  FROM                                                                  ');
    qryAux.SQL.Add('    FATDOR FD                                                           ');
    qryAux.SQL.Add('    LEFT JOIN AUXGOR AG     ON (FD.FDO_SEQGER     = AG.AUX_SEQGER)      ');
    qryAux.SQL.Add('    LEFT JOIN MOVGER MG     ON (FD.FDO_TIPFAT     = MG.GER_ESPDOC       ');
    qryAux.SQL.Add('                           AND FD.FDO_NUMFAT      = MG.GER_NUMDOC       ');
    qryAux.SQL.Add('                           AND FD.FDO_EMPFAT      = MG.GER_CODEMP       ');
    qryAux.SQL.Add('                           AND MG.GER_TIP_FC      = "C"                 ');
    qryAux.SQL.Add('                           AND MG.GER_ORIDOC      = "V")                ');
    qryAux.SQL.Add('    LEFT JOIN AUXMOV AM     ON (MG.AUTOINCREM     = AM.AUX_SEQGER)      ');
    qryAux.SQL.Add('    LEFT JOIN ENTCLI ECGOR  ON (ECGOR.AUTOINCREM  = AG.AUX_ENTGER)      ');
    qryAux.SQL.Add('    LEFT JOIN CADCID CCGOR  ON (CCGOR.CID_CODCID  = ECGOR.ETC_CIDENT)   ');
    qryAux.SQL.Add('    LEFT JOIN ENTCLI ECMOV  ON (ECMOV.AUTOINCREM  = AM.AUX_ENTGER)      ');
    qryAux.SQL.Add('    LEFT JOIN CADCID CCMOV  ON (CCMOV.CID_CODCID  = ECMOV.ETC_CIDENT)   ');
    qryAux.SQL.Add('    LEFT JOIN ENTCLI ECCGOR ON (ECCGOR.ETC_CODCLI = FD.FDO_CODCLI       ');
    qryAux.SQL.Add('                           AND ECCGOR.ETC_ENDFAT  = "S")                ');
    qryAux.SQL.Add('    LEFT JOIN CADCID CCCGOR ON (CCCGOR.CID_CODCID = ECCGOR.ETC_CIDENT)  ');
    qryAux.SQL.Add('    LEFT JOIN ENTCLI ECCMOV ON (ECCMOV.ETC_CODCLI = MG.GER_CODCLI       ');
    qryAux.SQL.Add('                           AND ECCMOV.ETC_ENDFAT  = "S")                 ');
    qryAux.SQL.Add('    LEFT JOIN CADCID CCCMOV ON (CCCMOV.CID_CODCID = ECCMOV.ETC_CIDENT)  ');
    qryAux.SQL.Add('  WHERE                                                                 ');
    qryAux.SQL.Add('    FD.AUTOINCREM =:AUTINC                                              ');

    qryAux.ParamByName('AUTINC').AsString := strAutIncFD;

    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin
      If (Not fEmptyStr(qryAux.FieldByName('CIDMOV').AsString)) Then
        Result := qryAux.FieldByName('CIDMOV').AsString

      Else If (Not fEmptyStr(qryAux.FieldByName('CIDCMOV').AsString)) Then
        Result := qryAux.FieldByName('CIDCMOV').AsString

      Else If (Not fEmptyStr(qryAux.FieldByName('CIDGOR').AsString)) Then
        Result := qryAux.FieldByName('CIDGOR').AsString

      Else If (Not fEmptyStr(qryAux.FieldByName('CIDCGOR').AsString)) Then
        Result := qryAux.FieldByName('CIDCGOR').AsString;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
End;


end.
