unit untPesarProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  CPDrv, Uni, frxClass, frxBarcode, DB, UniClientDataSet, frxDBSet,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, untTypesSistema, untConsultas,
  Datasnap.DBClient;

type
  TfrmPesarProdutos = class(TfrmPai)
    pnlCabecalho: TPanel;
    lbl5: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtDesUni: TEditFocus;
    edtLocFis: TEditFocus;
    pnlRodape: TPanel;
    lblInf1: TLabel;
    lblInf2: TLabel;
    lblInf3: TLabel;
    edtInf1: TStaticText;
    edtInf2: TStaticText;
    edtInf3: TStaticText;
    lblBalanca: TLabel;
    frxEtiqueta: TfrxReport;
    cdsEtiqueta: TUniClientDataSet;
    cdsEtiquetaCODITE: TStringField;
    cdsEtiquetaCODBAR: TStringField;
    cdsEtiquetaDESITE: TStringField;
    cdsEtiquetaREFERE: TStringField;
    frxDataSet: TfrxDBDataset;
    cdsEtiquetaLOCFIS: TStringField;
    fltfldEtiquetaQTDITE: TFloatField;
    cdsEtiquetaDESUNI: TStringField;
    btnBalanca: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    rdgTipoLeitura: TRadioGroup;
    edtInfDig1: TEditFocus;
    edtInfDig2: TEditFocus;
    edtInfDig3: TEditFocus;
    procedure btnBalancaClick(Sender: TObject);
    procedure cpnPortaReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgTipoLeituraClick(Sender: TObject);
    procedure edtInfDig1Change(Sender: TObject);
    procedure edtInfDig2Change(Sender: TObject);
    procedure edtInfDig3Change(Sender: TObject);
  private
    { Private declarations }

    cpnPorta: TCommPortDriver;

    qryConIte: TUniQuery;
    strCodBar: String;
    strDigIni: String;
    strModBal: String;
    blnCalcPecas: Boolean;

    procedure pCarregaItem;
    procedure pTipoLeitura(iIndice: Integer);

    function fUsaMontagemCaixas: Boolean;

    function fRetPorta(Var strPorta: String): TPortNumber;
    function fRetBaudRate(strBaud: String): TBaudRate;
    function fRetDataBits(strData: String): TDataBits;
    function fRetParity(strParity: String): TParity;
    function fRetStopBits(strStop: String): TStopBits;
  protected
    procedure pLimpaEdits;
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  strBuffer : AnsiString;

implementation

uses
  untFuncoesSimples, untCfgRel;

{$R *.dfm}

function TfrmPesarProdutos.fUsaMontagemCaixas: Boolean;
begin
  Result := fCfgSis('MONCAI', varBoolean) And (VS_strTipExp = '3');
end;

procedure TfrmPesarProdutos.btnBalancaClick(Sender: TObject);
begin
  inherited;
  if cpnPorta.Connected then
  begin
    cpnPorta.Disconnect;
    lblBalanca.Caption := 'Desconectado';
  end
  else
  begin
    if not cpnPorta.Connect then
      fMensagem('Erro', 'Não foi possível conectar a porta serial.'#13#10 +
                        'Verifique as configurações e tente novamente...', ['&Ok'])
    else
      lblBalanca.Caption := 'Conectado';
  end;
end;

procedure TfrmPesarProdutos.cpnPortaReceiveData(Sender: TObject;
  DataPtr: Pointer; DataSize: Cardinal);
  Var
    strTmp: AnsiString;
begin
  strTmp := AnsiString(StringOfChar(' ', DataSize));
  Move(DataPtr^, PAnsiChar(strTmp)^, DataSize);

  //IMPACTO
  If fUsaMontagemCaixas Then
  Begin
    If SameStr(UpperCase(strModBal), 'MICHELETTI') Then
    Begin
      If (Length(strBuffer) < 37) Then
        strBuffer := strBuffer + strTmp;

      If (Length(strBuffer) >= 37) Then
      begin
        edtInf1.Caption   := Trim(Copy(String(strBuffer), Pos('PB:', String(strBuffer)) + 03, 09));
        edtInf2.Caption   := Trim(Copy(String(strBuffer), Pos('PL:', String(strBuffer)) + 03, 09));
        edtInf3.Caption   := Trim(Copy(String(strBuffer), Pos('T:' , String(strBuffer)) + 02, 09));

        strBuffer := '';
      End;
    End;
  End
  //HIDROMAR
  Else
  Begin
    if (Length(strBuffer) < 36) then
      strBuffer := strBuffer + strTmp;

    if (Length(strBuffer) >= 36) then
    begin
      edtInf1.Caption   := Trim(StringReplace(Copy(String(strBuffer), Pos('kg',  String(strBuffer)) - 07, 09), 'kg',  '', []));
      edtInf2.Caption   := Trim(StringReplace(Copy(String(strBuffer), Pos('PMP', String(strBuffer)) - 13, 10), 'kg',  '', []));
      edtInf3.Caption   := Trim(StringReplace(Copy(String(strBuffer), Pos('PCS', String(strBuffer)) - 08, 11), 'PCS', '', []));

      btnImprimir.Enabled := (StrToIntDef(edtInf3.Caption, 0) > 0);

      strBuffer := '';

      strCodBar := fGeraCodBarraEAN13(strDigIni + '0' + edtCodIte.Text + fStrZero(edtInf3.Caption, 5));

      if btnImprimir.CanFocus then
        pSetFocus(btnImprimir);
    end;
  End;
end;

procedure TfrmPesarProdutos.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If (fEntraCons(Key)) And (Not edtCodIte.ReadOnly) Then
  Begin

    If fPesqItem(conIteCompleta,
                 Self,
                 edtCodIte,
                 edtDesIte,
                 qryConIte,
                 Key,
                 arrSel) Then
    Begin
      edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
      pCarregaItem;

      If rdgTipoLeitura.itemIndex = 0 Then
      Begin
        btnBalanca.Enabled := True;
        pSetFocus(btnBalanca);
      End
      Else
      Begin
        pSetFocus(edtInfDig1);
      End;
    End;

  End;
end;

procedure TfrmPesarProdutos.edtInfDig1Change(Sender: TObject);
begin
  inherited;
  blnCalcPecas := True;
end;

procedure TfrmPesarProdutos.edtInfDig2Change(Sender: TObject);
begin
  inherited;
  blnCalcPecas := True;
end;

procedure TfrmPesarProdutos.edtInfDig3Change(Sender: TObject);
begin
  inherited;
  blnCalcPecas := fStrToFloat(edtinfDig3.Text) = 0;
end;

function TfrmPesarProdutos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin

      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pCarregaItem;
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If rdgTipoLeitura.itemIndex = 0 Then
          Begin
            btnBalanca.Enabled := True;
            btnBalanca.Click;
          End
          Else
          Begin
            pSetfocus(edtInfDig1);
            blnMudarFoco := False;
          End;
        End;

      End;

    End
    Else
    If (Sender = edtInfDig3) And (edtInfDig3.Visible) Then
    Begin
      If fStrToFloat(edtInfDig3.Text) = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Peças" deve ser preenchido!', ['&O K']);
        Result := False;
      End
      Else
      Begin
        strCodBar := fGeraCodBarraEAN13(strDigIni + '0' + edtCodIte.Text + fStrZero(edtInfDig3.Text, 5));
      End;
    End
    Else
    If (Sender = edtInfDig1) Then
    Begin
      If (edtInfDig1.Visible) And (fStrToFloat(edtInfDig1.Text) > 0) And (fStrToFloat(edtInfDig2.Text) > 0) And (blnCalcPecas) Then
      Begin
        edtInfDig3.Text := floatToStr(fStrToFloat(edtInfDig1.Text)/fStrToFloat(edtInfDig2.Text));
      End;
    End
    Else
    If (Sender = edtInfDig2) Then
    Begin
      If (edtInfDig2.Visible) And (fStrToFloat(edtInfDig1.Text) > 0) And (fStrToFloat(edtInfDig2.Text) > 0) And (blnCalcPecas) Then
      Begin
        edtInfDig3.Text := FloatToStr(fFormataFloatInterna(fStrToFloat(edtInfDig1.Text)/fStrToFloat(edtInfDig2.Text),0));
      End;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmPesarProdutos.pCarregaItem;
  Var
    strSQL: String;
    intCont: Integer;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_CODITE AS "ITE_CODITE", ';
  strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU", ';
  strSQL := strSQL + '  P.GRU_DESGRU AS "GRU_DESGRU", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "ITE_DESITE", ';
  strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE", ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI", ';
  strSQL := strSQL + '  U.UNI_DESUNI AS "UNI_DESUNI", ';
  strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR", ';
  strSQL := strSQL + '  M.MAR_DESMAR AS "MAR_DESMAR", ';
  strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR", ';
  strSQL := strSQL + '  F.FOR_NOMFOR AS "FOR_NOMFOR", ';
  strSQL := strSQL + '  G.ITE_SALDOS AS "ITE_SALDOS", ';
  strSQL := strSQL + '  G.ITE_SALBAL AS "ITE_SALBAL", ';
  strSQL := strSQL + '  G.ITE_DTABAL AS "ITE_DTABAL", ';
  strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS", ';
  strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM", ';
  strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01", ';
  strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02", ';
  strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03", ';
  strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04", ';
  strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05", ';
  strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06", ';
  strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT", ';
  strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED", ';
  strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT", ';
  strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT", ';
  strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE", ';
  strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN", ';
  strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI", ';
  strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB", ';
  strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL", ';
  strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED", ';
  strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE", ';
  strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS", ';
  strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI", ';
  strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX", ';
  strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE", ';
  strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU", ';

  For intCont := 1 To Length(VS_strTabPrc) Do
  Begin
    strSQL := strSQL + '  G.ITE_MARBR' + IntToStr(intCont) + ' AS "ITE_MARBR' + IntToStr(intCont) + '", ';
    strSQL := strSQL + '  G.ITE_PREVE' + IntToStr(intCont) + ' AS "ITE_PREVE' + IntToStr(intCont) + '", ';
    strSQL := strSQL + '  G.ITE_COMTB' + IntToStr(intCont) + ' AS "ITE_COMTB' + IntToStr(intCont) + '", ';
  End;

  strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN", ';
  strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS", ';
  strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI"  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  CADUNI U, ';
  strSQL := strSQL + '  CADMAR M, ';
  strSQL := strSQL + '  CADFOR F, ';
  strSQL := strSQL + '  CADGRU P, ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + 'WHERE ';

  If (Length(edtCodIte.Text) <= edtCodIte.TamCampo) Then
  Begin
    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    edtCodIte.Text := fStrZero(edtCodIte.Text, edtCodIte.TamCampo);
  End
  Else
  Begin
    strSQL := strSQL + '  ( (I.ITE_CODBAR = :CODITE ) OR (I.ITE_BAREMB = :CODITE) OR';
    strSQL := strSQL + '    EXISTS(SELECT 1 FROM ITEBAR B WHERE B.BAR_CODITE = I.ITE_CODITE AND B.BAR_CODBAR = :CODITE)';
    strSQL := strSQL + ')  AND '
  End;

  strSQL := strSQL + '  G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP      AND ';
  strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';
  strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
  strSQL := strSQL + '  I.ITE_CODGRU = P.GRU_CODGRU AND ';
  strSQL := strSQL + '  I.ITE_CODFOR = F.FOR_CODFOR ';

  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := edtCodIte.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    edtCodIte.Text := FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    edtRefere.Text := FieldByName('ITE_REFERE').AsString;
    edtDesUni.Text := FieldByName('UNI_DESUNI').AsString;
    edtLocFis.Text := FieldByName('ITE_LOCFIS').AsString;

  End;
end;

procedure TfrmPesarProdutos.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlCabecalho) Then
    inherited
  Else
    pLimpaEdits;
end;

procedure TfrmPesarProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  pSetaCodIte(cdsEtiquetaCODITE);

  edtInfDig3.EditFormat := fMskDigitos(0);
  blnCalcPecas := False;
  strBuffer := '';
  strModBal := fCfgSis('MODBAL');
  strDigIni := fCfgSis('DIGBAL');
  qryConIte := fCriaQuery(Self);
  cpnPorta  := TCommPortDriver.Create(Self);
  cpnPorta.OnReceiveData := cpnPortaReceiveData;
end;

procedure TfrmPesarProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConIte);
end;

procedure TfrmPesarProdutos.pLimpaEdits;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;
  edtDesUni.Clear;
  edtLocFis.Clear;
  strCodBar := '';
  edtInf1.Caption := '';
  edtInf2.Caption := '';
  edtInf3.Caption := '';
  edtInfDig1.Clear;
  edtInfDig2.Clear;
  edtInfDig3.Clear;
  btnImprimir.Enabled := False;
  btnBalanca.Enabled  := False;
  if cpnPorta.Connected then
    cpnPorta.Disconnect;
  if edtCodIte.CanFocus then
    pSetFocus(edtCodIte);
  lblBalanca.Caption  := 'Desconectado';
end;

procedure TfrmPesarProdutos.pTipoLeitura(iIndice: Integer);
begin
  rdgTipoLeitura.itemIndex := iIndice;
  edtInfDig1.visible       := iIndice = 1;
  edtInfDig2.visible       := iIndice = 1;
  edtInfDig3.visible       := iIndice = 1;
  btnBalanca.Enabled       := iIndice = 0;
  btnImprimir.Enabled      := iIndice = 1;
  If iIndice = 0 Then
  Begin
    edtInfDig1.Clear;
    edtInfDig2.Clear;
    edtInfDig3.Clear;
  End
  Else
  begin
    edtInf1.Caption := '';
    edtInf2.Caption := '';
    edtInf3.Caption := '';
  End;
end;

procedure TfrmPesarProdutos.rdgTipoLeituraClick(Sender: TObject);
begin
  inherited;
  pTipoLeitura(rdgTipoLeitura.itemIndex);
end;

procedure TfrmPesarProdutos.btnImprimirClick(Sender: TObject);
  Var
    strNomImp: String;
    strTipImp: String;
    strPatEti: String;
begin
  inherited;

  If Not fValidaCampos(edtinfDig3) Then
    Exit;

  If Not btnImprimir.Visible Then
    Exit;

  Try


    pCarregaConfImprRel(self.Name, strNomImp, strTipImp);

    strPatEti := fCfgSis('PATETI');

    If Not fEmptyStr(strNomImp) Then
    Begin
      frxEtiqueta.PrintOptions.Printer    := strNomImp;
      frxEtiqueta.PrintOptions.ShowDialog := False;
    End;

    If FileExists(strPatEti + '\etiqueta_contagem.fr3') Then
      frxEtiqueta.LoadFromFile(strPatEti + '\etiqueta_contagem.fr3');
      
    With cdsEtiqueta Do
    Begin
      CreateDataSet;
      Append;
      FieldByName('CODITE').AsString := edtCodIte.Text;
      FieldByName('DESITE').AsString := edtDesIte.Text;
      FieldByName('CODBAR').AsString := strCodBar;
      FieldByName('REFERE').AsString := edtRefere.Text;
      FieldByName('LOCFIS').AsString := edtLocFis.Text;
      FieldByName('DESUNI').AsString := edtDesUni.Text;
      If rdgTipoLeitura.itemIndex = 0 Then
        FieldByName('QTDITE').AsFloat  := fStrToFloat(edtInf3.Caption)
      Else
        FieldByName('QTDITE').AsFloat  := fStrToFloat(edtInfDig3.Text);
      Post;
      
      If Not fEmptyStr(strNomImp) Then
      Begin
        If frxEtiqueta.PrepareReport Then
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxEtiqueta);
      End
      Else
        pPreviewReport(Self.Name, Self.Caption, frxEtiqueta);

      Close;
    End;

  Except

  End;
end;

procedure TfrmPesarProdutos.FormShow(Sender: TObject);
  Var
    strNomPor: String;
    strBauRat: String;
begin
  inherited;
  strNomPor              := fCfgSisL('PCOBAL');
  strBauRat              := fCfgSisL('RATBAL');
  cpnPorta.Port          := fRetPorta(strNomPor);
  cpnPorta.PortName      := strNomPor;
  cpnPorta.BaudRate      := fRetBaudRate(strBauRat);
  cpnPorta.BaudRateValue := StrToInt(strBauRat);
  cpnPorta.DataBits      := fRetDataBits(fCfgSisL('BITBAL'));
  cpnPorta.Parity        := fRetParity(fCfgSisL('PARBAL'));
  cpnPorta.StopBits      := fRetStopBits(fCfgSisL('STOBAL'));

  If fUsaMontagemCaixas Then
  Begin
    btnImprimir.Visible := False;
    Self.Caption    := 'Pesagem de Produtos';
    lblInf1.Caption := 'Peso Bruto:';
    lblInf2.Caption := 'Peso Líquido:';
    lblInf3.Caption := 'Tara:';
  End;

  pSetFocus(edtCodIte);
end;

function TfrmPesarProdutos.fRetPorta(Var strPorta: String): TPortNumber;
begin
  if (strPorta = 'COM1') then
  begin
    Result   := pnCOM1;
    strPorta := '\\.\COM1';
  end
  else if (strPorta = 'COM2') then
  begin
    Result   := pnCOM2;
    strPorta := '\\.\COM2';
  end
  else if (strPorta = 'COM3') then
  begin
    Result   := pnCOM3;
    strPorta := '\\.\COM3';
  end
  else if (strPorta = 'COM4') then
  begin
    Result   := pnCOM4;
    strPorta := '\\.\COM4';
  end
  else if (strPorta = 'COM5') then
  begin
    Result   := pnCOM5;
    strPorta := '\\.\COM5';
  end
  else if (strPorta = 'COM6') then
  begin
    Result   := pnCOM6;
    strPorta := '\\.\COM6';
  end
  else if (strPorta = 'COM7') then
  begin
    Result   := pnCOM7;
    strPorta := '\\.\COM7';
  end
  else if (strPorta = 'COM8') then
  begin
    Result   := pnCOM8;
    strPorta := '\\.\COM8';
  end
  else if (strPorta = 'COM9') then
  begin
    Result   := pnCOM9;
    strPorta := '\\.\COM9';
  end
  else if (strPorta = 'COM10') then
  begin
    Result   := pnCOM10;
    strPorta := '\\.\COM10';
  end
  else if (strPorta = 'COM11') then
  begin
    Result   := pnCOM11;
    strPorta := '\\.\COM11';
  end
  else if (strPorta = 'COM12') then
  begin
    Result   := pnCOM12;
    strPorta := '\\.\COM12';
  end
  else if (strPorta = 'COM13') then
  begin
    Result   := pnCOM13;
    strPorta := '\\.\COM13';
  end
  else if (strPorta = 'COM14') then
  begin
    Result   := pnCOM14;
    strPorta := '\\.\COM14';
  end
  else if (strPorta = 'COM15') then
  begin
    Result   := pnCOM15;
    strPorta := '\\.\COM15';
  end
  else if (strPorta = 'COM16') then
  begin
    Result   := pnCOM16;
    strPorta := '\\.\COM16';
  end
  else
  begin
    Result   := pnCustom;
    strPorta := '';
  end;
end;

function TfrmPesarProdutos.fRetBaudRate(strBaud: String): TBaudRate;
begin
  Result  := br110;

  case StrToInt64(strBaud) of
      110:
      begin
        Result  := br110;
        strBaud := '110';
      end;
      300:
      begin
        Result  := br110;
        strBaud := '300';
      end;
      600:
      begin
        Result  := br110;
        strBaud := '600';
      end;
     1200:
      begin
        Result  := br110;
        strBaud := '1200';
      end;
     2400:
      begin
        Result  := br110;
        strBaud := '2400';
      end;
     4800:
      begin
        Result  := br110;
        strBaud := '4800';
      end;
    14400:
      begin
        Result  := br110;
        strBaud := '14400';
      end;
    19200:
      begin
        Result  := br110;
        strBaud := '19200';
      end;
    38400:
      begin
        Result  := br110;
        strBaud := '38400';
      end;
    56000:
      begin
        Result  := br110;
        strBaud := '56000';
      end;
    57600:
      begin
        Result  := br110;
        strBaud := '57600';
      end;
  end;
end;

function TfrmPesarProdutos.fRetDataBits(strData: String): TDataBits;
begin
  Result := db5BITS;
  case StrToInt(strData) of
    5: Result := db5BITS;
    6: Result := db6BITS;
    7: Result := db7BITS;
    8: Result := db8BITS;
  end;
end;

function TfrmPesarProdutos.fRetParity(strParity: String): TParity;
begin
  Result := ptNONE;
  
  if (strParity = 'EVEN') then
    Result := ptEVEN
  else if (strParity = 'MARK') then
    Result := ptMARK
  else if (strParity = 'NONE') then
    Result := ptNONE
  else if (strParity = 'ODD') then
    Result := ptODD
  else if (strParity = 'SPACE') then
    Result := ptSPACE;
end;

function TfrmPesarProdutos.fRetStopBits(strStop: String): TStopBits;
begin
  Result := sb1BITS;

  if (strStop = 'S1') then
    Result := sb1BITS
  else if (strStop = 'S1,5') then
    Result := sb1HALFBITS
  else if (strStop = 'S2') then
    Result := sb2BITS;
end;

end.
