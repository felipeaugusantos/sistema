unit untFatAltComissaoManualCTR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB,
  Uni, BitBtnLockedIncrem, Grids, DBGridCitel, DBGrids, UniClientDataSet, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatAltComissaoManualCTR = class(TfrmPai)
    pnlBusca: TPanel;
    lblDoc: TLabel;
    lblEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtDtaVen: TEditFocus;
    edtDesCli: TEditFocus;
    lblEsp: TLabel;
    edtDocum: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblParcel: TLabel;
    edtParcel: TEditFocus;
    lbl2: TLabel;
    edtDtaCad: TEditFocus;
    lbl3: TLabel;
    edtDtaRec: TEditFocus;
    edtValDup: TEditFocus;
    lbl4: TLabel;
    pnlComissoes: TPanel;
    pnlComVe1: TPanel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtCodVe1: TEditFocus;
    edtPerCo1: TEditFocus;
    edtDesVe1: TEditFocus;
    edtTotCo1: TEditFocus;
    pnlComPa1: TPanel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtCodPa1: TEditFocus;
    edtPerPa1: TEditFocus;
    edtDesPa1: TEditFocus;
    edtTotPa1: TEditFocus;
    pnlComPj1: TPanel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    edtCodPj1: TEditFocus;
    edtPerPj1: TEditFocus;
    edtDesPj1: TEditFocus;
    edtTotPj1: TEditFocus;
    pnlComPa2: TPanel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    edtCodPa2: TEditFocus;
    edtPerPa2: TEditFocus;
    edtDesPa2: TEditFocus;
    edtTotPa2: TEditFocus;
    pnlComPj2: TPanel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    edtCodPj2: TEditFocus;
    edtPerPj2: TEditFocus;
    edtDesPj2: TEditFocus;
    edtTotPj2: TEditFocus;
    pnlComVe2: TPanel;
    lbl20: TLabel;
    edtCodVe2: TEditFocus;
    edtDesVe2: TEditFocus;
    lbl21: TLabel;
    edtPerCo2: TEditFocus;
    lbl22: TLabel;
    edtTotCo2: TEditFocus;
    lblValDupSemImposto: TLabel;
    edtValSeI: TEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodVe1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPerCo1Exit(Sender: TObject);
  private
    procedure pLimpaTela;
    procedure pCarregaDados(qryDados: TUniQuery);
    procedure pAlteraComissao;
    function fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp, strParcel: String): Boolean;
    procedure pAtualizaTotCom;
    function fGetComponentDescricao(Sender: TEditFocus): TEditFocus;
    procedure pSetaParametros(qryParam: TUniQuery);
    function fValDup : String;
    function fValDupSemImpostos : String;
  public
    blnBuscaDoc : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pHabilitaBusca(blnHabilita: Boolean);
  end;

implementation

uses StrUtils, untConsultas, untFuncoesSimples, untFuncoes, untTypesSistema;

{$R *.dfm}

procedure TfrmFatAltComissaoManualCTR.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltComissaoManualCTR.edtCodVe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTmp: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, (Sender As TEditFocus), fGetComponentDescricao(Sender As TEditFocus), Nil, Key, arrTmp, True, True) Then
  Begin
    If fValidaCampos((Sender As TEditFocus)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatAltComissaoManualCTR.edtPerCo1Exit(Sender: TObject);
begin
  inherited;
  (Sender As TEditFocus).Text := fFloatToStrVirgula(fStrToFloat((Sender As TEditFocus).Text), 12, 2);
end;

function TfrmFatAltComissaoManualCTR.fBuscaDocumento(strNumdoc, strEspDoc, strCodEmp, strParcel: String): Boolean;

  function fGetSQLDocumentos: String;
  begin
    Result := '';
    Result := Result + '  SELECT SQL_NO_CACHE                           ';
    Result := Result + '    CTR_CODCLI AS CODCLI,                       ';
    Result := Result + '    CLI_NOMCLI AS NOMCLI,                       ';
    Result := Result + '    CTR_DTACAD AS DTACAD,                       ';
    Result := Result + '    CTR_DTAVEN AS DTAVEN,                       ';
    Result := Result + fValDup +  '    AS VALDUP,                       ';
    Result := Result +fValDupSemImpostos  + ' AS VALSEI,                ';
    Result := Result + '    CTR_DTAREC AS DTAREC,                       ';
    Result := Result + '    CTR_CODVEN AS CODVEN,                       ';
    Result := Result + '    CTR_CODREP AS CODREP,                       ';
    Result := Result + '    OPE_NOMOPE AS NOMVEN,                       ';
    Result := Result + '    CTR_FATCOM AS FATCO1,                       ';
    Result := Result + '    CTR_FATREP AS FATCO2,                       ';
    Result := Result + '    CTR_CODPA1 AS CODPA1,                       ';
    Result := Result + '    CTR_FATPA1 AS FATPA1,                       ';
    Result := Result + '    CTR_CODPJ1 AS CODPJ1,                       ';
    Result := Result + '    CTR_FATPJ1 AS FATPJ1,                       ';
    Result := Result + '    CTR_CODPA2 AS CODPA2,                       ';
    Result := Result + '    CTR_FATPA2 AS FATPA2,                       ';
    Result := Result + '    CTR_CODPJ2 AS CODPJ2,                       ';
    Result := Result + '    CTR_FATPJ2 AS FATPJ2,                       ';
    Result := Result + '    "CADREC" AS TABELA                          ';
    Result := Result + '  FROM                                          ';
    Result := Result + '    CADREC                                      ';
    Result := Result + '    LEFT JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
    Result := Result + '    LEFT JOIN CADOPE ON OPE_CODOPE = CTR_CODVEN ';
    Result := Result + '  WHERE CTR_NUMDUP = :NUMDOC                    ';
    Result := Result + '    AND CTR_ESPDOC = :ESPDOC                    ';
    Result := Result + '    AND CTR_CODEMP = :CODEMP                    ';
    Result := Result + '    AND CTR_PARCEL = :PARCEL                    ';
    Result := Result + '    AND CTR_SEQBAI = 0 ';
  end;

  Var
    qryGen : TUniQuery;
    strSql : String;
begin
  If Not blnBuscaDoc Then
  Begin
    Result := True;
    Exit;
  End;

  strSQL := fGetSQLDocumentos;

  qryGen := fCriaQuery(Self);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumdoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PARCEL').AsString := strParcel;
    Open;

    If IsEmpty Then
      Result := False
    Else
    Begin
      pCarregaDados(qryGen);
      Result := True;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
end;

function TfrmFatAltComissaoManualCTR.fGetComponentDescricao(
  Sender: TEditFocus): TEditFocus;
begin
  If (Sender As TEditFocus).Name = 'edtCodVe1' Then
    Result := edtDesVe1
  Else If (Sender As TEditFocus).Name = 'edtCodVe2' Then
    Result := edtDesVe2
  Else If (Sender As TEditFocus).Name = 'edtCodPa1' Then
    Result := edtDesPa1
  Else If (Sender As TEditFocus).Name = 'edtCodPa2' Then
    Result := edtDesPa2
  Else If (Sender As TEditFocus).Name = 'edtCodPj1' Then
    Result := edtDesPj1
  Else If (Sender As TEditFocus).Name = 'edtCodPj2' Then
    Result := edtDesPj2
  Else
    Result := Nil;
end;

procedure TfrmFatAltComissaoManualCTR.pCarregaDados(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    edtCodCli.Text := FieldByName('CODCLI').AsString;
    edtDesCli.Text := FieldByName('NOMCLI').AsString;

    edtCodVe1.Text := FieldByName('CODVEN').AsString;
    edtCodVe2.Text := FieldByName('CODREP').AsString;
    edtCodPa1.Text := FieldByName('CODPA1').AsString;
    edtCodPa2.Text := FieldByName('CODPA2').AsString;
    edtCodPj1.Text := FieldByName('CODPJ1').AsString;
    edtCodPj2.Text := FieldByName('CODPJ2').AsString;

    edtDesVe1.Text := fRetNomVendRep(edtCodVe1.Text);
    edtDesVe2.Text := fRetNomVendRep(edtCodVe2.Text);
    edtDesPa1.Text := fRetNomVendRep(edtCodPa1.Text);
    edtDesPa2.Text := fRetNomVendRep(edtCodPa2.Text);
    edtDesPj1.Text := fRetNomVendRep(edtCodPj1.Text);
    edtDesPj2.Text := fRetNomVendRep(edtCodPj2.Text);

    edtDtaCad.Text := FormatDateTime('DD/MM/YYYY', FieldByName('DTACAD').AsDateTime);
    edtDtaVen.Text := FormatDateTime('DD/MM/YYYY', FieldByName('DTAVEN').AsDateTime);
    edtDtaRec.Text := FormatDateTime('DD/MM/YYYY', FieldByName('DTAREC').AsDateTime);
    
    edtValDup.Text := FormatFloat('##,#0.00', FieldByName('VALDUP').AsFloat);
    edtValSei.Text := FormatFloat('##,#0.00', FieldByName('VALSEI').AsFloat);

    edtTotCo1.Text := fFloatToStrVirgula( (FieldByName('VALSEI').AsFloat * FieldByName('FATCO1').AsFloat), 12, 2);
    edtTotCo2.Text := fFloatToStrVirgula( (FieldByName('VALSEI').AsFloat * FieldByName('FATCO2').AsFloat), 12, 2);
    edtTotPa1.Text := fFloatToStrVirgula( (FieldByName('VALSEI').AsFloat * FieldByName('FATPA1').AsFloat), 12, 2);
    edtTotPa2.Text := fFloatToStrVirgula( (FieldByName('VALSEI').AsFloat * FieldByName('FATPA2').AsFloat), 12, 2);
    edtTotPj1.Text := fFloatToStrVirgula( (FieldByName('VALSEI').AsFloat * FieldByName('FATPJ1').AsFloat), 12, 2);
    edtTotPj2.Text := fFloatToStrVirgula( (FieldByName('VALSEI').AsFloat * FieldByName('FATPJ2').AsFloat), 12, 2);

    If (fFormataFloat(FieldByName('VALSEI').AsFloat, 2) <> 0) Then
    Begin
      edtPerCo1.Text := fFloatToStrVirgula( fFormataFloat((fStrToFloat(edtTotCo1.Text) / FieldByName('VALSEI').AsFloat), 2) * 100, 12, 2);
      edtPerCo2.Text := fFloatToStrVirgula( fFormataFloat((fStrToFloat(edtTotCo2.Text) / FieldByName('VALSEI').AsFloat), 2) * 100, 12, 2);
      edtPerPa1.Text := fFloatToStrVirgula( fFormataFloat((fStrToFloat(edtTotPa1.Text) / FieldByName('VALSEI').AsFloat), 2) * 100, 12, 2);
      edtPerPa2.Text := fFloatToStrVirgula( fFormataFloat((fStrToFloat(edtTotPa2.Text) / FieldByName('VALSEI').AsFloat), 2) * 100, 12, 2);
      edtPerPj1.Text := fFloatToStrVirgula( fFormataFloat((fStrToFloat(edtTotPj1.Text) / FieldByName('VALSEI').AsFloat), 2) * 100, 12, 2);
      edtPerPj2.Text := fFloatToStrVirgula( fFormataFloat((fStrToFloat(edtTotPj2.Text) / FieldByName('VALSEI').AsFloat), 2) * 100, 12, 2);
    End
    Else
    Begin
      edtPerCo1.Text := fFloatToStrVirgula( 0, 12, 2);
      edtPerCo2.Text := fFloatToStrVirgula( 0, 12, 2);
      edtPerPa1.Text := fFloatToStrVirgula( 0, 12, 2);
      edtPerPa2.Text := fFloatToStrVirgula( 0, 12, 2);
      edtPerPj1.Text := fFloatToStrVirgula( 0, 12, 2);
      edtPerPj2.Text := fFloatToStrVirgula( 0, 12, 2);
    End;

    btnConfirma.Enabled := True;
    pHabilitaBusca(False);
  End;
end;

procedure TfrmFatAltComissaoManualCTR.pLimpaTela;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx] Is TEditFocus Then
      (Self.Components[intIdx] As TEditFocus).Clear;
  End;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  
  btnConfirma.Enabled := False;
  pHabilitaBusca(True);

  blnBuscaDoc := True;  

  pSetFocus(edtDocum);
end;

procedure TfrmFatAltComissaoManualCTR.pSetaParametros(qryParam: TUniQuery);
begin
  With qryParam Do
  Begin
    ParamByName('PERCO1').AsFloat  := fStrToFloat(edtPerCo1.Text);
    ParamByName('PERCO2').AsFloat  := fStrToFloat(edtPerCo2.Text);
    ParamByName('PERPA1').AsFloat  := fStrToFloat(edtPerPa1.Text);
    ParamByName('PERPA2').AsFloat  := fStrToFloat(edtPerPa2.Text);
    ParamByName('PERPJ1').AsFloat  := fStrToFloat(edtPerPj1.Text);
    ParamByName('PERPJ2').AsFloat  := fStrToFloat(edtPerPj2.Text);

    ParamByName('TOTCO1').AsFloat  := fStrToFloat(edtTotCo1.Text);
    ParamByName('TOTCO2').AsFloat  := fStrToFloat(edtTotCo2.Text);

    ParamByName('PARCEL').AsString := edtParcel.Text;
    ParamByName('NUMDOC').AsString := edtDocum.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('CODCLI').AsString := edtCodCli.Text;

    If fEmptyStr(edtCodVe1.Text) Then
      ParamByName('CODVEN').Value := Null
    Else
      ParamByName('CODVEN').AsString := edtCodVe1.Text;

    If fEmptyStr(edtCodVe2.Text) Then
      ParamByName('CODREP').Value := Null
    Else
      ParamByName('CODREP').AsString := edtCodVe2.Text;

    If fEmptyStr(edtCodPa1.Text) Then
      ParamByName('CODPA1').Value := Null
    Else
      ParamByName('CODPA1').AsString := edtCodPa1.Text;

    If fEmptyStr(edtCodPa2.Text) Then
      ParamByName('CODPA2').Value := Null
    Else
      ParamByName('CODPA2').AsString := edtCodPa2.Text;

    If fEmptyStr(edtCodPj1.Text) Then
      ParamByName('CODPJ1').Value := Null
    Else
      ParamByName('CODPJ1').AsString := edtCodPj1.Text;

    If fEmptyStr(edtCodPj2.Text) Then
      ParamByName('CODPJ2').Value := Null
    Else
      ParamByName('CODPJ2').AsString := edtCodPj2.Text;
  End;
end;

function TfrmFatAltComissaoManualCTR.fValDup: String;
begin
  Result := ' ( IF(CTR_DTAREC IS NULL, IFNULL(CTR_VALDUP,0), IFNULL(CTR_VALORI,0)) + IFNULL(CTR_JURSUJ, 0) - IFNULL(CTR_DESSUJ, 0) ) ';
end;

function TfrmFatAltComissaoManualCTR.fValDupSemImpostos: String;
begin
  Result := ' ( IF(CTR_DTAREC IS NULL, IFNULL(CTR_VALDUP,0), IFNULL(CTR_VALORI,0)) + IFNULL(CTR_JURSUJ, 0) - IFNULL(CTR_DESSUJ, 0) - IFNULL(CTR_VALIPI, 0) - IFNULL(CTR_VALACE, 0) - IFNULL(CTR_VALRET, 0)' + ' - IFNULL(CTR_VALCBS, 0) - IFNULL(CTR_VALIBS, 0) - IFNULL(CTR_VAL_IS, 0) - IFNULL(CTR_VALFRE, 0) - IFNULL(CTR_VALFCP, 0) ) ';
end;

function TfrmFatAltComissaoManualCTR.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

  function fComplemento(fltPercent: Double; strTipOpe: String): String;
  begin
    If (fltPercent < 0) Then
      Result := 'negativa'
    Else If (fltPercent > 100) Then
      Result := 'maior que 100%'
    Else If (fltPercent = 0) Then
      Result := 'zero quando "' + strTipOpe + '" preenchido.';
  end;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDocum) Then
    Begin
      If fEmptyStr(edtDocum.Text) Then
      Begin
        fMensagem('','Digite o número do documento !',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','Digite a espécie do documento !',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtParcel) Then
    Begin
      If fEmptyStr(edtParcel.Text) Then
      Begin
        fMensagem('','Digite a parcela do documento !',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Digite o código da empresa !',['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&OK']);
          Result := False;
        End
        Else If Not fBuscaDocumento(edtDocum.Text, edtEspDoc.Text, edtCodEmp.Text, edtParcel.Text) Then
        Begin
          fMensagem('','Documento digitado não foi encontrado, verifique !',['&OK']);
          Result := False;
        End
        Else
        Begin
          Sender := edtCodVe1;
        End;
      End;
    End

    Else If (Sender = edtCodVe1) Then
    Begin
      If (Not fEmptyStr(edtCodVe1.Text)) Then
      Begin
        edtPerCo1.Enabled := True;
        edtDesVe1.Text := fRetNomVendRep(edtCodVe1.Text);

        If fEmptyStr(edtDesVe1.Text) Then
        Begin
          fMensagem('','Vendedor 1 incorreto, verifique!',['&OK']);
          Result := False;
        End
        Else If Not fOperadorAtivo(edtCodVe1.Text) Then
        Begin
          fMensagem('','Vendedor 1 inativo, verifique!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesVe1.Text := '';
        edtPerCo1.Text := '0,00';
        edtPerCo1.Enabled := False;
      End;
    End

    Else If (Sender = edtCodVe2) Then
    Begin
      If (Not fEmptyStr(edtCodVe2.Text)) Then
      Begin
        edtPerCo2.Enabled := True;
        edtDesVe2.Text := fRetNomVendRep(edtCodVe2.Text);

        If fEmptyStr(edtDesVe2.Text) Then
        Begin
          fMensagem('','Vendedor 2 incorreto, verifique!',['&OK']);
          Result := False;
        End
        Else If Not fOperadorAtivo(edtCodVe2.Text) Then
        Begin
          fMensagem('','Vendedor 2 inativo, verifique!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesVe2.Text := '';
        edtPerCo2.Text := '0,00';
        edtPerCo2.Enabled := False;
      End;
    End

    Else If (Sender = edtCodPa1) Then
    Begin
      If (Not fEmptyStr(edtCodPa1.Text)) Then
      Begin
        edtPerPa1.Enabled := True;
        edtDesPa1.Text := fRetNomVendRep(edtCodPa1.Text);

        If fEmptyStr(edtDesPa1.Text) Then
        Begin
          fMensagem('','Participante 1 incorreto, verifique!',['&OK']);
          Result := False;
        End
        Else If Not fOperadorAtivo(edtCodPa1.Text) Then
        Begin
          fMensagem('','Participante 1 inativo, verifique!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesPa1.Text := '';
        edtPerPa1.Text := '0,00';
        edtPerPa1.Enabled := False;
      End;
    End

    Else If (Sender = edtCodPa2) Then
    Begin
      If (Not fEmptyStr(edtCodPa2.Text)) Then
      Begin
        edtPerPa2.Enabled := True;
        edtDesPa2.Text := fRetNomVendRep(edtCodPa2.Text);

        If fEmptyStr(edtDesPa2.Text) Then
        Begin
          fMensagem('','Participante 2 incorreto, verifique!',['&OK']);
          Result := False;
        End
        Else If Not fOperadorAtivo(edtCodPa2.Text) Then
        Begin
          fMensagem('','Participante 2 inativo, verifique!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesPa2.Text := '';
        edtPerPa2.Text := '0,00';
        edtPerPa2.Enabled := False;
      End;
    End

    Else If (Sender = edtCodPj1) Then
    Begin
      If (Not fEmptyStr(edtCodPj1.Text)) Then
      Begin
        edtPerPj1.Enabled := True;
        edtDesPj1.Text := fRetNomVendRep(edtCodPj1.Text);

        If fEmptyStr(edtDesPj1.Text) Then
        Begin
          fMensagem('','Projetista 1 incorreto, verifique!',['&OK']);
          Result := False;
        End
        Else If Not fOperadorAtivo(edtCodPj1.Text) Then
        Begin
          fMensagem('','Projetista 1 inativo, verifique!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesPj1.Text := '';
        edtPerPj1.Text := '0,00';
        edtPerPj1.Enabled := False;
      End;
    End

    Else If (Sender = edtCodPj2) Then
    Begin
      If (Not fEmptyStr(edtCodPj2.Text)) Then
      Begin
        edtPerPj2.Enabled := True;
        edtDesPj2.Text := fRetNomVendRep(edtCodPj2.Text);

        If fEmptyStr(edtDesPj2.Text) Then
        Begin
          fMensagem('','Projetista 2 incorreto, verifique!',['&OK']);
          Result := False;
        End
        Else If Not fOperadorAtivo(edtCodPj2.Text) Then
        Begin
          fMensagem('','Projetista 2 inativo, verifique!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesPj2.Text := '';
        edtPerPj2.Text := '0,00';
        edtPerPj2.Enabled := False;
      End;
    End

    Else If (Sender = edtPerCo1) Then
    Begin
      If (fStrToFloat(edtPerCo1.Text) < 0) Or (fStrToFloat(edtPerCo1.Text) > 100) Or ((fStrToFloat(edtPerCo1.Text) < 0) And (Not fEmptyStr(edtCodVe1.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Porcentagem de comissão para Vendedor 1 não pode ser %s', [fComplemento(fStrToFloat(edtPerCo1.Text), 'vendedor 1')]), ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerCo2) Then
    Begin
      If (fStrToFloat(edtPerCo2.Text) < 0) Or (fStrToFloat(edtPerCo2.Text) > 100) Or ((fStrToFloat(edtPerCo2.Text) < 0) And (Not fEmptyStr(edtCodVe2.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Porcentagem de comissão para Vendedor 2 não pode ser %s', [fComplemento(fStrToFloat(edtPerCo2.Text), 'vendedor 2')]), ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerPa1) Then
    Begin
      If (fStrToFloat(edtPerPa1.Text) < 0) Or (fStrToFloat(edtPerPa1.Text) > 100) Or ((fStrToFloat(edtPerPa1.Text) < 0) And (Not fEmptyStr(edtCodPa1.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Porcentagem de comissão para Participante 1 não pode ser %s', [fComplemento(fStrToFloat(edtPerPa1.Text), 'participante 1')]), ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerPa2) Then
    Begin
      If (fStrToFloat(edtPerPa2.Text) < 0) Or (fStrToFloat(edtPerPa2.Text) > 100) Or ((fStrToFloat(edtPerPa2.Text) < 0) And (Not fEmptyStr(edtCodPa2.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Porcentagem de comissão para Participante 2 não pode ser %s', [fComplemento(fStrToFloat(edtPerPa2.Text), 'participante 2')]), ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerPj1) Then
    Begin
      If (fStrToFloat(edtPerPj1.Text) < 0) Or (fStrToFloat(edtPerPj1.Text) > 100) Or ((fStrToFloat(edtPerPj1.Text) < 0) And (Not fEmptyStr(edtCodPj1.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Porcentagem de comissão para Projetista 1 não pode ser %s', [fComplemento(fStrToFloat(edtPerPj1.Text), 'projetista 1')]), ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtPerPj2) Then
    Begin
      If (fStrToFloat(edtPerPj2.Text) < 0) Or (fStrToFloat(edtPerPj2.Text) > 100) Or ((fStrToFloat(edtPerPj2.Text) < 0) And (Not fEmptyStr(edtCodPj2.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Porcentagem de comissão para Projetista 2 não pode ser %s', [fComplemento(fStrToFloat(edtPerPj2.Text), 'projetista 2')]), ['&OK']);
        Result := False;
      End;
    End;

    pAtualizaTotCom;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltComissaoManualCTR.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin

    If (ActiveControl.Parent <> pnlBusca) Then
    Begin
      pLimpaTela;
      pSetFocus(edtDocum);
      Key := 0;
      Exit;
    End;

    Inherited;
  End
  Else
    Inherited;
end;

procedure TfrmFatAltComissaoManualCTR.FormShow(Sender: TObject);
begin
  inherited;
  edtDocum.TamCampo  := fTamDocCadRec;
  edtDocum.MaxLength := fTamDocCadRec;

  pLimpaTela;
end;

procedure TfrmFatAltComissaoManualCTR.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fMensagem('','Confirma alteração da comissão?', ['','']) = 2 Then
    Exit;

  blnBuscaDoc := False;    

  If Not fVerificaCampos Then
    Exit
  Else
  Begin
    pAlteraComissao;
    pLimpaTela;
  End;
end;

procedure TfrmFatAltComissaoManualCTR.pAlteraComissao;
  Var
    strSqlCadRec,
    strSqlCtrCnf,
    strSqlDupAgr : String;
    qryUpdate : TUniQuery;
begin
  strSqlCadRec := '';
  strSqlCadRec := strSqlCadRec + 'UPDATE TABELA ';
  strSqlCadRec := strSqlCadRec + '   SET CTR_FATCOM = ROUND(:PERCO1 / 100, 4), ';
  strSqlCadRec := strSqlCadRec + '       CTR_FATREP = ROUND(:PERCO2 / 100, 4), ';
  strSqlCadRec := strSqlCadRec + '       CTR_FATPA1 = ROUND(:PERPA1 / 100, 4), ';
  strSqlCadRec := strSqlCadRec + '       CTR_FATPA2 = ROUND(:PERPA2 / 100, 4), ';
  strSqlCadRec := strSqlCadRec + '       CTR_FATPJ1 = ROUND(:PERPJ1 / 100, 4), ';
  strSqlCadRec := strSqlCadRec + '       CTR_FATPJ2 = ROUND(:PERPJ2 / 100, 4), ';
  strSqlCadRec := strSqlCadRec + '       CTR_VALCOM = :TOTCO1, ';
  strSqlCadRec := strSqlCadRec + '       CTR_COMREP = :TOTCO2, ';
  strSqlCadRec := strSqlCadRec + '       CTR_CODVEN = :CODVEN, ';
  strSqlCadRec := strSqlCadRec + '       CTR_CODREP = :CODREP, ';
  strSqlCadRec := strSqlCadRec + '       CTR_CODPA1 = :CODPA1, ';
  strSqlCadRec := strSqlCadRec + '       CTR_CODPA2 = :CODPA2, ';
  strSqlCadRec := strSqlCadRec + '       CTR_CODPJ1 = :CODPJ1, ';
  strSqlCadRec := strSqlCadRec + '       CTR_CODPJ2 = :CODPJ2  ';
  strSqlCadRec := strSqlCadRec + ' WHERE CTR_PARCEL = :PARCEL ';
  strSqlCadRec := strSqlCadRec + '   AND CTR_NUMDUP = :NUMDOC ';
  strSqlCadRec := strSqlCadRec + '   AND CTR_ESPDOC = :ESPDOC ';
  strSqlCadRec := strSqlCadRec + '   AND CTR_CODEMP = :CODEMP ';
  strSqlCadRec := strSqlCadRec + '   AND CTR_CODCLI = :CODCLI ';

  qryUpdate := fCriaQuery(Self);

  With qryUpdate Do
  Begin
    strSqlCadRec := AnsiReplaceStr(strSqlCadRec,'TABELA','CADREC');
    strSqlCtrCnf := AnsiReplaceStr(strSqlCadRec,'TABELA','CTRCNF');
    strSqlDupAgr := AnsiReplaceStr(strSqlCadRec,'TABELA','DUPAGR');

    SQL.Clear;
    SQL.Add(strSqlCadRec);
    pSetaParametros(qryUpdate);
    ExecSQL;

    SQL.Clear;
    SQL.Add(strSqlCtrCnf);
    pSetaParametros(qryUpdate);
    ExecSQL;

    SQL.Clear;
    SQL.Add(strSqlDupAgr);
    pSetaParametros(qryUpdate);
    ExecSQL;
  End;

  FreeAndNil(qryUpdate);

  fMensagem('','Alteração da comissão concluída com sucesso!',['&OK']);
end;

procedure TfrmFatAltComissaoManualCTR.pAtualizaTotCom;
  Var
    fltValDup : Double;
begin
  fltValDup := fStrToFloat(edtValSeI.Text);

  edtTotCo1.Text := fFloatToStrVirgula( (fStrToFloat(edtPerCo1.Text) / 100) * fltValDup, 12, 2);
  edtTotCo2.Text := fFloatToStrVirgula( (fStrToFloat(edtPerCo2.Text) / 100) * fltValDup, 12, 2);
  edtTotPa1.Text := fFloatToStrVirgula( (fStrToFloat(edtPerPa1.Text) / 100) * fltValDup, 12, 2);
  edtTotPa2.Text := fFloatToStrVirgula( (fStrToFloat(edtPerPa2.Text) / 100) * fltValDup, 12, 2);
  edtTotPj1.Text := fFloatToStrVirgula( (fStrToFloat(edtPerPj1.Text) / 100) * fltValDup, 12, 2);
  edtTotPj2.Text := fFloatToStrVirgula( (fStrToFloat(edtPerPj2.Text) / 100) * fltValDup, 12, 2);
end;

procedure TfrmFatAltComissaoManualCTR.pHabilitaBusca(blnHabilita: Boolean);
begin
  edtDocum.Enabled  := blnHabilita;
  lblDoc.Enabled    := blnHabilita;
  edtEspDoc.Enabled := blnHabilita;
  lblEsp.Enabled    := blnHabilita;
  edtCodEmp.Enabled := blnHabilita;
  lblEmp.Enabled    := blnHabilita;
  edtDesEmp.Enabled := blnHabilita;
  lblParcel.Enabled := blnHabilita;
  edtParcel.Enabled := blnHabilita;
end;

end.
