unit untFatMostraCreditos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, DateUtils, untObservacao,
  untRelFatVendasClienteF9, untModuloSPR, System.Types,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, StrUtils, BitBtnLockedIncrem,
  MemDS, DBAccess, Provider, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  untFuncoes, Datasnap.DBClient, untILiberacao, untMsgLiberacao, untValidacaoCredito;

type
  TfrmFatMostraCreditos = class(TfrmPaiOrdena)
    lblCliente: TLabel;
    btnConfirma: TBitBtnLocked;
    lblQtdSel: TLabel;
    edtQtdSel: TEditFocus;
    lblTotSel: TLabel;
    edtTotSel: TEditFocus;
    lblTotGer: TLabel;
    edtTotGer: TEditFocus;
    btnProdutos: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure btnProdutosClick(Sender: TObject);
  private
    { Private declarations }
    strAcessosOperadorEmpresasContasReceber: String;
    strEmpCod  : String;
    fltTotalSel: Double;
    fltCreSel  : Double;
    stlCreditos: TStringList;
    stlLckDup   : TStringList;
    stlDupPro   : TStringList;
    intColunaButton: integer;
    function fCriaClientCreditos : TUniClientDataSet;
    procedure pLancarCreditosSelecionados(cdsCredit: TUniClientDataSet);
    function  fRetChaveLck: String;
    procedure pDestravaLckTotal;
    procedure pDestravaTodasDuplicatas;
    function fVerificaOperadorTemDireitoAcesso(const pStrCodigoEmpresa: string): Boolean;
    function fUtilizaCredEmpresa(): Boolean;
  public
    { Public declarations }
    blnMostrouTela: Boolean;
    strCodCli: String;
    fltValorTotal: Double;
    dtaDataCorte: TDateTime;
    fncTravaUtiCred: TfncTravaUtiCred;
    fltValorNegociado: Double;
    blnFecharForm: Boolean;
    blnConfirma: Boolean;
    objLiberacao: ILiberacao;
    strOpcDocTrue: String;
    strCrtDevSintetizadasConfDocs: String;
    blnOrcamentos: Boolean;
    blnDescontaCreditoAutomatico: Boolean;
    blnUsaEmpOri : Boolean;
    
    function fGetTotalSel: Double;
    function fGetCreSel : Double;
    function fGetCreditos: TStringList;
    procedure pOnShow;
    procedure pSelecionarDuplicatas(strTabela: String; stlDuplicatas: TStringList; blnTentaAcharTambemPelaDuplicataOriginal: Boolean = False);
    function fGetLckDup: TStringList;
    procedure pVerificaDestravarLckProf;
    function DuplicataDeCreditoLiberada(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;
    procedure pRetornaHistCadRec(atrAutInc, strAutIncOri: string);
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetOrderBy: String; Override;

    procedure pAddListaQuery; Override;
    procedure pAcaoAdd; Override;
    procedure pAcaoDel; Override;

    function fAbreConsulta(blnLike: Boolean = True): Boolean; Override;
    procedure pCalcQtdSelecionados;

  end;

var
  frmFatMostraCreditos: TfrmFatMostraCreditos;

implementation

uses untFuncoesSimples, untConstantes;

{$R *.dfm}

{ TfrmPaiOrdena1 }

function TfrmFatMostraCreditos.fGetOrderBy: String;
begin
  Result := 'ORDER BY 1, 2, 3, 4, 5';

  If blnDescontaCreditoAutomatico Then
     Result := 'ORDER BY 5, 1, 2, 3, 4';
end;

function TfrmFatMostraCreditos.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CTR_NUMDUP, ';
  Result := Result + '  CTR_PARCEL, ';
  Result := Result + '  CTR_ESPDOC, ';
  Result := Result + '  CTR_CODEMP, ';
  Result := Result + '  CTR_DTACAD, ';
  Result := Result + '  CTR_DTAVEN, ';
  Result := Result + '  CTR_VALDUP, ';
  Result := Result + '  CTR_DOCDIV, ';
  Result := Result + '  CTR_CODCLI, ';
  Result := Result + '  CAST(" " AS CHAR(1)) AS BUTTON, ';
  Result := Result + '  CONCAT("CADREC", CADREC.AUTOINCREM) AUTOINCREM,     ';
  Result := Result + '  (SELECT CONCAT("CADREC", ORI.AUTOINCREM)            ';
  Result := Result + '     FROM CADREC ORI                                  ';
  Result := Result + '    WHERE CADREC.CTR_SEQBAI = 0 AND                   ';
  Result := Result + '          ORI.CTR_NUMDUP = CADREC.CTR_NUMDUP AND      ';
  Result := Result + '          ORI.CTR_PARCEL = CADREC.CTR_PARCEL AND      ';
  Result := Result + '          ORI.CTR_ESPDOC = CADREC.CTR_ESPDOC AND      ';
  Result := Result + '          ORI.CTR_CODEMP = CADREC.CTR_CODEMP AND      ';
  Result := Result + '          ORI.CTR_CODCLI = CADREC.CTR_CODCLI AND      ';
  Result := Result + '          ORI.CTR_SEQBAI = 1 LIMIT 1) AUTOINCREM_ORI, ';
  Result := Result + '  "CADREC" AS CTR_TABELA ';
  Result := Result + 'FROM ';
  Result := Result + '  CADREC ';
  Result := Result + 'WHERE ';
  Result := Result + '  CTR_DTAREC IS NULL AND ';
  Result := Result + '  CTR_VALDUP < 0.0 AND ';
  Result := Result + '  CTR_CODCLI = ' + QuotedStr(strCodCli) + ' ';
  If (dtaDataCorte > 0) Then
    Result := Result + '  AND CTR_DTACAD >= ' + QuotedStr(FormatDateTime('yyyy-MM-dd', dtaDataCorte));
  If (Not fEmptyStr(strCrtDevSintetizadasConfDocs)) Then
    Result := Result + '  AND AUTOINCREM NOT IN ('+strCrtDevSintetizadasConfDocs+') ';

  If Not fEmptyStr(fCfgSis('POOCRE', varString)) Then
    Result := Result + ' AND CTR_CODPOR <> '+QuotedStr(fCfgSis('POOCRE', varString))+' ';

  If ((blnUsaEmpOri) And (fCfgSis('EMPORI', varBoolean))) Then
    Result := Result + ' AND CTR_CODEMP = '+QuotedStr(VS_strCodEmp)+' ';
end;

procedure TfrmFatMostraCreditos.pOnShow;
var
  intIndice: integer;
begin
  lblCliente.Caption := 'CLIENTE: ' + strCodCli + ' - ' + fRetNomCliente(strCodCli);

  fAbreConsulta(False);

  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não há créditos disponíveis para esse cliente.', ['&Ok']);
    blnFecharForm := True;
  End;

  intColunaButton := -1;
  for intIndice := 0 to dbgConsulta.Columns.Count - 1 do
  begin
    if dbgConsulta.Columns[intIndice].FieldName = 'BUTTON' then
    begin
      intColunaButton := intIndice + 1;
      Exit;
    end;
  end;
end;

procedure TfrmFatMostraCreditos.pRetornaHistCadRec(atrAutInc,
  strAutIncOri: string);
var
  qryHist: TUniQuery;
  frmObservacao: TfrmObservacao;
begin
  qryHist := fCriaQuery;

  try
    qryHist.Close;
    qryHist.SQL.Clear;
    qryHist.SQL.Add('SELECT CTR_HIST01, CTR_HIST02');
    qryHist.SQL.Add('FROM CADREC');
    qryHist.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryHist.ParamByName('AUTINC').AsString := atrAutInc;

    qryHist.Open;

    if (qryHist.IsEmpty) and (fEmptyStr(strAutIncOri)) then
      Exit;

    if qryHist.IsEmpty then
    begin
      qryHist.Close;
      qryHist.ParamByName('AUTINC').AsString := strAutIncOri;
      qryHist.Open;

      if qryHist.IsEmpty then
        Exit;
    end;

    pCriarFormularios(TfrmObservacao, frmObservacao);

    try
      frmObservacao.lblMensagem.caption := 'Histórico da duplicata';
      frmObservacao.memObs.Lines.Add(qryHist.FieldByName('CTR_HIST01').AsString);
      frmObservacao.memObs.Lines.Add('----------------------------------------------------------');
      frmObservacao.memObs.Lines.Add(qryHist.FieldByName('CTR_HIST02').AsString);
      frmObservacao.ShowModal;
    finally
      pFreeAndNil(frmObservacao);
    end;
  finally
    FreeAndNil(qryHist);
  end;
end;

procedure TfrmFatMostraCreditos.btnConfirmaClick(Sender: TObject);
  Var
    cdsCredit : TUniClientDataSet;
begin

  If stlCreditos.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível confirmar pois não foram selecionadas duplicatas' +
                          IIF(blnMostrouTela,'!',
                              ' automaticamente!' +
                              IIF(strOpcDocTrue='11',#10#13+'Faça o adiantamento antes de carregar o pedido para faturar pela opção "[Ctrl+A] Adiantamento" do "Resumo de Caixa".'+#10#13, #10#13) +
                              'Caso tenha estornado o adiantamento ou usado a duplicata de crédito em outro pedido, ' +
                              'refaça esse pedido informando outras duplicatas de crédito.'), ['&Ok'],
                              1, False, 1, 0, False, 0, False, False, False, 0, 720);
  End
  Else If (fltValorNegociado > 0) And
          (fFormataFloat(fltValorNegociado,2) > fFormataFloat(Abs(fltTotalSel),2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O valor dos créditos ' +
      'selecionados é menor que o valor negociado com o cliente!', ['&Ok']);
  End
  Else If fUtilizaCredEmpresa Then
  Begin
    fMensagem('ATENÇÃO!', 'O(s) crédito(s) selecionado(s) pertence(m) a(s) empresa(s) '+ strEmpCod + #13 +
                          'e o mesmo só poderá ser utilizado na empresa de origem.', ['&OK']);
  End
  Else
  Begin
    If Assigned(fncTravaUtiCred) Then
    Begin
      cdsCredit := fCriaClientCreditos;
      Try
        pLancarCreditosSelecionados(cdsCredit);

        If fncTravaUtiCred(cdsCredit) Then
          Exit;
      Finally
        FreeAndNil(cdsCredit);
      End;
    End;

    inherited;

    blnConfirma := True;
    Self.Close;
  End;
end;

procedure TfrmFatMostraCreditos.pSelecionarDuplicatas(strTabela: String; stlDuplicatas: TStringList; blnTentaAcharTambemPelaDuplicataOriginal: Boolean = False);
  Var
    strAutInc: String;
begin
  For strAutInc In stlDuplicatas Do
  Begin
    If cdsConsulta.Locate('AUTOINCREM', strTabela + strAutInc.DeQuotedString, []) Then
    Begin
      pAcaoAdd
    End
    Else If blnTentaAcharTambemPelaDuplicataOriginal Then
    Begin
      If cdsConsulta.Locate('AUTOINCREM_ORI', strTabela + strAutInc.DeQuotedString, []) Then
      Begin
        pAcaoAdd
      End;
    End;
  End;
end;

procedure TfrmFatMostraCreditos.pAcaoAdd;
begin
  inherited;

  fltTotalSel := fltTotalSel + cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;

  If (Not fEmptyStr(cdsConsulta.FieldByName('CTR_DOCDIV').AsString)) Then
  Begin
    fltCreSel := fltCreSel + cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;
  End;

  stlCreditos.Add(QuotedStr(RightStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, 20)));

  stlLckDup.Add(fRetChaveLck);
end;

procedure TfrmFatMostraCreditos.pAcaoDel;
  Var
    intIndice: Integer;
begin
  inherited;
  fltTotalSel := fltTotalSel - cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;

  If (Not fEmptyStr(cdsConsulta.FieldByName('CTR_DOCDIV').AsString)) Then
  Begin
    fltCreSel := fltCreSel - cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;
    pVerificaDestravarLckProf;
  End;

  intIndice := stlCreditos.IndexOf(QuotedStr(RightStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, 20)));
  stlCreditos.Delete(intIndice);

  intIndice := stlLckDup.IndexOf(fRetChaveLck);
  stlLckDup.Delete(intIndice);

  pDestravaDuplicatas(fRetChaveLck);
end;

procedure TfrmFatMostraCreditos.btnProdutosClick(Sender: TObject);
var
  frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;
begin
  inherited;
  if not cdsConsulta.Active then
    Exit;

  if cdsConsulta.IsEmpty then
    Exit;

  if cdsConsulta.RecNo < 1 then
    Exit;

  pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);

  try
    frmRelFatVendasClienteF9.dtsRelVenCli.DataSet := frmModuloSPR.qryRelatorio;
    frmRelFatVendasClienteF9.blnMostraDebCtrChq2 := True;
    frmRelFatVendasClienteF9.blnMosVenMtl := fCfgSis('VENMTL', varBoolean);

    frmRelFatVendasClienteF9.pMostrarProdutos(LeftStr(cdsConsulta.FieldByName('CTR_NUMDUP').AsString + cdsConsulta.FieldByName('CTR_PARCEL').AsString,fTamDocCadRec()),
                                              cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                                              LeftStr(cdsConsulta.FieldByName('CTR_CODEMP').AsString, 3),
                                              False,
                                              cdsConsulta.FieldByName('CTR_CODCLI').AsString);
    frmRelFatVendasClienteF9.ShowModal;
  finally
    FreeAndNil(frmRelFatVendasClienteF9);
  end;
end;

procedure TfrmFatMostraCreditos.dbgConsultaCellClick(Column: TColumn);
begin
  inherited;

  if not cdsConsulta.Active then
    Exit;

  if cdsConsulta.IsEmpty then
    Exit;

  if cdsConsulta.RecNo < 1 then
    Exit;

  if dbgConsulta.SelectedField.FieldName = 'BUTTON' then
  begin


    pRetornaHistCadRec(RightStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, 20),
                       RightStr(cdsConsulta.FieldByName('AUTOINCREM_ORI').AsString, 20));
  end;
end;

procedure TfrmFatMostraCreditos.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  bntButton: Integer;
  RectLocal: TRect;
begin
  inherited;
  if Column.FieldName = 'BUTTON' then
  begin
    dbgConsulta.Canvas.FillRect(Rect);
    bntButton := 0;
    RectLocal := Rect;
    InflateRect(RectLocal, -1, -1);
    DrawFrameControl(dbgConsulta.Canvas.Handle, RectLocal, bntButton, bntButton or bntButton);
    dbgConsulta.Canvas.Brush.Color := clBtnFace;
    DrawText(dbgConsulta.Canvas.Handle, '...', 3, RectLocal, DT_VCENTER or DT_CENTER);
  end;
end;

procedure TfrmFatMostraCreditos.dbgConsultaMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if intColunaButton < 0 then
    Exit;

  if (dbgConsulta.MouseCoord(X, Y).X in [intColunaButton]) then
  begin
    dbgConsulta.ShowHint := True;
    dbgConsulta.Hint := 'Histórico da duplicata';
  end
  else
  begin
    dbgConsulta.ShowHint := False;
    dbgConsulta.Hint := EmptyStr;
  end;
end;

function TfrmFatMostraCreditos.DuplicataDeCreditoLiberada(ANumDup, AParcel,
  AEspDoc, ACodEmp, ACodCli: string): Boolean;
var
  FDuplicatas: TArrayDuplicatasCredito;
  FDuplicata: TDuplicatasCredito;
begin
  Result := True;

  if pos(AEspDoc, 'NF_DV') = 0 then
    Exit;

  FDuplicata.NumDup := ANumDup;
  FDuplicata.Parcel := AParcel;
  FDuplicata.EspDoc := AEspDoc;
  FDuplicata.CodEmp := ACodEmp;
  FDuplicata.CodCli := ACodCli;

  SetLength(FDuplicatas, Length(FDuplicatas)+1);

  FDuplicatas[High(FDuplicatas)] := FDuplicata;

  Result := fDuplicataCreditoLiberada(FDuplicatas);

  SetLength(FDuplicatas, 0);
end;

function TfrmFatMostraCreditos.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
  pCalcQtdSelecionados;
end;

function TfrmFatMostraCreditos.fCriaClientCreditos: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMDUP';
    DataType := ftString;
    Size     := 12;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PARCEL';
    DataType := ftString;
    Size     := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ESPDOC';
    DataType := ftString;
    Size     := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODEMP';
    DataType := ftString;
    Size     := 3;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCLI';
    DataType := ftString;
    Size     := 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NOMCLI';
    DataType := ftString;
    Size     := 60;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VLRCRE';
    DataType := ftFloat;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTACAD';
    DataType := ftDate;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAVEN';
    DataType := ftDate;
  End;

  Result.CreateDataSet;
end;

function TfrmFatMostraCreditos.fGetCreditos: TStringList;
begin
  Result := stlCreditos;
end;

function TfrmFatMostraCreditos.fGetTotalSel: Double;
begin
  Result := Abs(fltTotalSel);
end;

procedure TfrmFatMostraCreditos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (strOpcDocTrue = '11') Then
  Begin
    If (Not blnConfirma) Then
      pDestravaLckTotal;
  End
  Else
  Begin
    If (ModalResult <> mrOk) Then
      pDestravaLckTotal;
  End;
end;

procedure TfrmFatMostraCreditos.FormCreate(Sender: TObject);
begin
  inherited;
  strAcessosOperadorEmpresasContasReceber :=
    fCampoTabela('OPE_EMPCTR', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  blnConfirma       := False;
  fltValorTotal     := 0.0;
  blnFecharForm     := False;
  dtaDataCorte      := 0;
  fltValorNegociado := 0;
  stlCreditos       := TStringList.Create;
  stlLckDup         := TStringList.Create;
  stlDupPro         := TStringList.Create;
  fltTotalSel       := 0.0;
  fltCreSel         := 0.0;
  strOpcDocTrue     := '';
  blnMostrouTela    := True;
  blnDescontaCreditoAutomatico := False;
end;

procedure TfrmFatMostraCreditos.pAddListaQuery;
  Var
    strCodDiv: String;
    fltCreUti: Double;
    LstrMensagem : String;

begin
  if (stlCreditos.IndexOf(fQuotedStr(RightStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, 20)))) < 0 then
  begin
    if cdsConsulta.FieldByName('CTR_VALDUP').AsFloat < 0 then
    begin
      if not Self.DuplicataDeCreditoLiberada(
                cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                cdsConsulta.FieldByName('CTR_PARCEL').AsString,
                cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                cdsConsulta.FieldByName('CTR_CODEMP').AsString,
                cdsConsulta.FieldByName('CTR_CODCLI').AsString) then
      begin
        Exit;
      end;
    end;
  end;

  if not fVerificaOperadorTemDireitoAcesso(cdsConsulta.FieldByName('CTR_CODEMP').AsString) then
  begin
    pMensagemOk(Format('Usuário não tem permissão para selecionar Créditos da empresa %s!',
                       [cdsConsulta.FieldByName('CTR_CODEMP').AsString]));
    Exit;
  end;

  if (strOpcDocTrue = '11') And
     (not fValidaRecebimentoDeCreditoPorPortador(cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                                                 cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                                                 cdsConsulta.FieldByName('CTR_CODEMP').AsString,
                                                 LstrMensagem,
                                                 cdsConsulta.FieldByName('CTR_PARCEL').AsString,
                                                 cdsConsulta.FieldByName('CTR_CODCLI').AsString))  then
  Begin
    fMensagem('ATENÇÃO!', LstrMensagem, ['&Ok']);
    Exit;
  End;

  If (Not fInLista) And
     (Not fLock_Unlock(fRetChaveLck,
                       True,
                       False)) Then
  Begin
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                  fGetHostLock(fRetChaveLck)  + '!', ['&Ok']);
    Exit;
  End;

  If fUtilizaTravaMaxUtilCredProfissional(fGetCreSel + cdsConsulta.FieldByName('CTR_VALDUP').AsFloat) And (Not fEmptyStr(cdsConsulta.FieldByName('CTR_DOCDIV').AsString)) And (Not fInLista) Then
  Begin
    pDestravaDupCreditoProf;

    If (Not fTravaDupCreditoProf) Then
    Begin
      pDestravaDuplicatas(fRetChaveLck);
      Exit;
    End;

    stlDupPro.Add(fRetChaveLck);

    If Not fVerificaCredProfissionaisMes(fGetCreSel + cdsConsulta.FieldByName('CTR_VALDUP').AsFloat, fltCreUti) Then
    Begin
      If Assigned(objLiberacao) Then
      Begin
        strCodDiv := fRetClienteProfissional(cdsConsulta.FieldByName('CTR_CODCLI').AsString);

        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('O valor do crédito ultrapassa o máximo de utilização de crédito dentro do mês corrente.');
        objLiberacao.objMsgLibera.pAddTextoCaption('Profissional', strCodDiv + '-' + fRetNomeProfissional(strCodDiv), 12);
        objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'     , VS_strCodEmp + '-' + fRetNomeEmpresa             , 12);

        objLiberacao.strDirAce := 'MAXUCM';
        objLiberacao.strSenLib := fCfgSis('SENUCM');
        objLiberacao.strMsgSen := 'Máximo de utilização de crédito para profissionais';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        If Not objLiberacao.fLibera Then
        Begin
          pDestravaDuplicatas(fRetChaveLck);
          pVerificaDestravarLckProf;
          Exit;
        End;
      End;
    End;
  End;

  If (Abs(fltTotalSel) >= Abs(fltValorTotal)) And (Not fInLista) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foram selecionadas duplicatas suficientes para o valor informado.', ['&Ok']);
    pDestravaDuplicatas(fRetChaveLck);
    pVerificaDestravarLckProf;
  End
  Else
  Begin
    inherited;
    pCalcQtdSelecionados;
  End;
end;

procedure TfrmFatMostraCreditos.pCalcQtdSelecionados;
Var
  cdsDados : TUniClientDataSet;
  fltTotSel,
  fltTotGer : Double;
  intQtdSel : Integer;

  Function fRetChaveLista_: String;
  Begin
    Result := cdsDados.Fieldbyname(strCampoLista).AsString;
  End;

  function fInLista_ : Boolean;
  begin
    Result := (stlListselecao.IndexOf('''' + fRetChaveLista_ + '''') > -1) Or (stlListselecao.IndexOf(fRetChaveLista_) > -1);
  end;

begin

  If Not cdsConsulta.IsEmpty Then
  Begin

    cdsDados := TUniClientDataSet.Create(Self);

    Try

      pCloneDataSet(cdsDados, cdsConsulta);

      fltTotSel := 0;
      intQtdSel := 0;
      fltTotGer := 0;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin

        fltTotGer := (fltTotGer + cdsDados.FieldByName('CTR_VALDUP').AsFloat);

        If Assigned(stlListSelecao) And (stlListSelecao.Count > 0) And fInLista_ Then
        Begin
          fltTotSel := (fltTotSel + cdsDados.FieldByName('CTR_VALDUP').AsFloat);
          intQtdSel := (intQtdSel + 1);
        End;

        cdsDados.Next;

      End;

      edtQtdSel.Text := IntToStr(intQtdSel);
      edtTotSel.Text := FormatFloat('#,##0.00', fltTotSel);
      edtTotGer.Text := FormatFloat('#,##0.00', fltTotGer);

    Finally
      FreeAndNil(cdsDados);
    End;

  End;

end;

procedure TfrmFatMostraCreditos.pLancarCreditosSelecionados(cdsCredit: TUniClientDataSet);

  function fSelecionado(strIncrem: String): Boolean;
  begin
    Result := (stlCreditos.IndexOf(strIncrem) >= 0);
  end;

  Var
    strAutInc : String;
begin
  cdsCredit.EmptyDataSet;

  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    strAutInc := fQuotedStr(RightStr(cdsConsulta.FieldByName('AUTOINCREM').AsString, 20));

    If fSelecionado(strAutInc) Then
    Begin
      cdsCredit.Append;
      cdsCredit.FieldByName('NUMDUP').AsString := cdsConsulta.FieldByName('CTR_NUMDUP').AsString;
      cdsCredit.FieldByName('PARCEL').AsString := cdsConsulta.FieldByName('CTR_PARCEL').AsString;
      cdsCredit.FieldByName('ESPDOC').AsString := cdsConsulta.FieldByName('CTR_ESPDOC').AsString;
      cdsCredit.FieldByName('CODEMP').AsString := cdsConsulta.FieldByName('CTR_CODEMP').AsString;
      cdsCredit.FieldByName('CODCLI').AsString := strCodCli;
      cdsCredit.FieldByName('NOMCLI').AsString := fRetNomCliente(strCodCli);
      cdsCredit.FieldByName('DTACAD').AsDateTime := cdsConsulta.FieldByName('CTR_DTACAD').AsDateTime;
      cdsCredit.FieldByName('DTAVEN').AsDateTime := cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime;
      cdsCredit.FieldByName('VLRCRE').AsFloat := cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;
      cdsCredit.Post;
    End;

    cdsConsulta.Next;
  End;
end;

procedure TfrmFatMostraCreditos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End
  Else
  If Key = VK_F7 Then
  Begin
    Key := 0;
    btnProdutos.Click;
  End;
end;

procedure TfrmFatMostraCreditos.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

procedure TfrmFatMostraCreditos.FormShow(Sender: TObject);
begin
  inherited;
  pOnShow;
end;

function TfrmFatMostraCreditos.fGetCreSel: Double;
begin
  Result := fltCreSel;
end;

function TfrmFatMostraCreditos.fGetLckDup: TStringList;
begin
  Result := stlLckDup;
end;

function TfrmFatMostraCreditos.fRetChaveLck: String;
Begin
  Result := cdsConsulta.FieldByName('CTR_TABELA').AsString +
            cdsConsulta.FieldByName('CTR_NUMDUP').AsString +
            cdsConsulta.FieldByName('CTR_ESPDOC').AsString +
            cdsConsulta.FieldByName('CTR_CODEMP').AsString +
            cdsConsulta.FieldByName('CTR_CODCLI').AsString +
            cdsConsulta.FieldByName('CTR_PARCEL').AsString;
End;

function TfrmFatMostraCreditos.fUtilizaCredEmpresa: Boolean;

  function fSelecionado(strIncrem: String): Boolean;
  begin
    Result := (stlCreditos.IndexOf(strIncrem) >= 0);
  end;

  Var
    strAutInc,
    strAuxEmp: String;
    cdsDupSel: TUniClientDataSet;
begin
  Result := False;

  If Not fCfgSis('EMPORI', VarBoolean) Then
    Exit;

  If Not blnOrcamentos Then
    Exit;

  cdsDupSel          := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsDupSel, cdsConsulta);

  Try
    cdsDupSel.IndexFieldNames := 'CTR_CODEMP';
    cdsDupSel.First;

    strEmpCod := '';
    strAuxEmp := '';
    While Not cdsDupSel.Eof Do
    Begin
      strAutInc := fQuotedStr(RightStr(cdsDupSel.FieldByName('AUTOINCREM').AsString, 20));
      If fSelecionado(strAutInc) Then
      Begin
        If ((cdsDupSel.FieldByName('CTR_ESPDOC').AsString = 'CC') Or (cdsDupSel.FieldByName('CTR_VALDUP').AsFloat < 0)) And
           (VS_strCodEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString) Then
        Begin
          Result := True;

          If strAuxEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString Then
          Begin
            strEmpCod := strEmpCod + cdsDupSel.FieldByName('CTR_CODEMP').AsString + ', ';
            strAuxEmp := cdsDupSel.FieldByName('CTR_CODEMP').AsString;
          End;
        End;
      End;

      cdsDupSel.Next;
    End;

    strEmpCod := Copy(strEmpCod, 1, Length(strEmpCod) - 2); // Para remover a vírgula adicional do final

  Finally
    FreeAndNil(cdsDupSel);
  End;
end;

procedure TfrmFatMostraCreditos.pDestravaLckTotal;
begin
  pDestravaDupCreditoProf;
  pDestravaTodasDuplicatas;
end;

procedure TfrmFatMostraCreditos.pDestravaTodasDuplicatas;
Var
  intRecNo: Integer;
Begin

  With cdsConsulta Do
  Begin
    intRecNo := RecNo;
    DisableControls;
    First;

    While Not Eof Do
    Begin
      pDestravaDuplicatas(fRetChaveLck);
      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

End;

procedure TfrmFatMostraCreditos.pVerificaDestravarLckProf;
Var
  intIndice: Integer;
Begin
  If (Not Assigned(stlDupPro)) Or
     (stlDupPro.Count <= 0)    Or
     (fEmptyStr(cdsConsulta.FieldByName('CTR_DOCDIV').AsString)) Then
    Exit;

  intIndice := stlDupPro.IndexOf(fRetChaveLck);

  If (intIndice >= 0) Then
    stlDupPro.Delete(intIndice);

  If (stlDupPro.Count <= 0) Then
    pDestravaDupCreditoProf;
End;

function TfrmFatMostraCreditos.fVerificaOperadorTemDireitoAcesso(
  const pStrCodigoEmpresa: string): Boolean;
Begin
  Result := Pos(LeftStr(pStrCodigoEmpresa,3), strAcessosOperadorEmpresasContasReceber) > 0;
End;

end.
